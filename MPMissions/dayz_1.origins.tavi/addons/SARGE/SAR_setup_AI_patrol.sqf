// =========================================================================================================
//  SAR_AI - DayZ AI library
//  Version: 1.5.0 
//  Author: Sarge (sarge@krumeich.ch) 
//
//		Wiki: to come
//		Forum: http://opendayz.net/#sarge-ai.131
//		
// ---------------------------------------------------------------------------------------------------------
//  Required:
//  UPSMon  
//  SHK_pos 
//  
// ---------------------------------------------------------------------------------------------------------
//   SAR_setup_AI_patrol.sqf
//   last modified: 28.5.2013
// ---------------------------------------------------------------------------------------------------------
//  Parameters:
//  [ _patrol_area_name (Markername of area to patrol), 
//    grouptype (numeric -> 1=military, 2=survivor, 3=bandits),  
//    number_of_snipers (numeric),
//    number of riflemen (numeric),
//    behaviour (string -> "patrol", "fortify", "ambush", "noUpsmon") 
//    respawn (boolean, -> true,false)
//    respawn time (numeric -> seconds)
//   ]
// ------------------------------------------------------------------------------------------------------------


private ["_leadername","_type","_patrol_area_name","_grouptype","_snipers","_riflemen","_action","_side","_leader_group","_riflemenlist","_sniperlist","_rndpos","_group","_leader","_cond","_respawn","_leader_weapon_names","_leader_items","_leader_tools","_soldier_weapon_names","_soldier_items","_soldier_tools","_sniper_weapon_names","_sniper_items","_sniper_tools","_leaderskills","_riflemanskills","_sniperskills","_ups_para_list","_respawn_time","_argc","_ai_type"];

if(!isServer) exitWith {};

_argc = count _this;

_patrol_area_name = _this select 0;
_grouptype = _this select 1;
_snipers = _this select 2;
_riflemen = _this select 3;
_action = tolower (_this select 4);
_respawn = _this select 5;

if(_argc>6) then {
    _respawn_time = _this select 6;
}else {
    _respawn_time = SAR_respawn_waittime;
};

switch (_grouptype) do
{
    case 1: // military
    {
        _side = SAR_AI_friendly_side;
        _type = "sold";
        _ai_type = "AI Military";
    };
    case 2: // survivors
    {
        _side = SAR_AI_friendly_side;
        _type = "surv";
        _ai_type = "AI Survivor";
    };
    case 3: // bandits
    {
        _side = SAR_AI_unfriendly_side;
        _type = "band";
        _ai_type = "AI Bandit";
    };
};

_leader_group = call compile format ["SAR_leader_%1_list",_type] call SAR_fnc_selectRandom;

_riflemenlist = call compile format ["SAR_soldier_%1_list",_type];
_sniperlist = call compile format ["SAR_sniper_%1_list",_type];

_leaderskills = call compile format ["SAR_leader_%1_skills",_type];
_riflemanskills = call compile format ["SAR_soldier_%1_skills",_type];
_sniperskills = call compile format ["SAR_sniper_%1_skills",_type];


// get a random starting position that is on land
_rndpos = [_patrol_area_name] call SHK_pos;

//_rndpos = [0,0];

_group = createGroup _side;

// protect group from being deleted by DayZ
_group setVariable ["SAR_protect",true,true];

// create leader of the group
_leader = _group createunit [_leader_group, [(_rndpos select 0) , _rndpos select 1, 0], [], 0.5, "NONE"];

_leader_weapon_names = ["leader",_type] call SAR_unit_loadout_weapons;
_leader_items = ["leader",_type] call SAR_unit_loadout_items;
_leader_tools = ["leader",_type] call SAR_unit_loadout_tools;

[_leader,_leader_weapon_names,_leader_items,_leader_tools] call SAR_unit_loadout;

_leader setVehicleInit "[this] spawn SAR_AI_trace;this setIdentity 'id_SAR_sold_lead';[this] spawn SAR_AI_reammo;";
_leader addMPEventHandler ["MPkilled", {Null = _this spawn  SAR_AI_killed;}]; 
_leader addMPEventHandler ["MPHit", {Null = _this spawn SAR_AI_hit;}];

_leader addEventHandler ["HandleDamage",{if (_this select 1!="") then {_unit=_this select 0;damage _unit+((_this select 2)-damage _unit)*SAR_leader_health_factor}}];

_cond="(side _this == west) && (side _target == resistance) && ('ItemBloodbag' in magazines _this)";

[nil,_leader,rADDACTION,"Give me a blood transfusion!", "addons\SARGE\SAR_interact.sqf","",1,true,true,"",_cond] call RE;
 
[_leader] joinSilent _group;

// set skills of the leader
{
    _leader setskill [_x select 0,(_x select 1 +(floor(random 2) * (_x select 2)))];
} foreach _leaderskills;



// define and store the leadername

SAR_leader_number = SAR_leader_number + 1;
_leadername = format["SAR_leader_%1",SAR_leader_number];

_leader setVehicleVarname _leadername;
_leader setVariable ["SAR_leader_name",_leadername,false];

// store AI type on the AI
_leader setVariable ["SAR_AI_type",_ai_type + " Leader",false];

// store experience value on AI
_leader setVariable ["SAR_AI_experience",0,false];

// set behaviour & speedmode
_leader setspeedmode "FULL";
_leader setBehaviour "AWARE"; 


if(SAR_DEBUG) then {
    // activate AI debug
    [_leader] spawn SAR_AI_debug;
};

// SARGE - do i need this name on the clientside ???

// create global variable for this group
call compile format ["KRON_UPS_%1=1",_leadername];

// if needed broadcast to the clients
//_leader Call Compile Format ["%1=_This ; PublicVariable ""%1""",_leadername];

// create crew
for "_i" from 0 to (_snipers - 1) do
{
    _this = _group createunit [_sniperlist call SAR_fnc_selectRandom, [(_rndpos select 0), _rndpos select 1, 0], [], 0.5, "NONE"];

    _sniper_weapon_names = ["sniper",_type] call SAR_unit_loadout_weapons;
    _sniper_items = ["sniper",_type] call SAR_unit_loadout_items;
    _sniper_tools = ["sniper",_type] call SAR_unit_loadout_tools;
    
    [_this,_sniper_weapon_names,_sniper_items,_sniper_tools] call SAR_unit_loadout;
    
    _this setVehicleInit "[this] spawn SAR_AI_trace;this setIdentity 'id_SAR';[this] spawn SAR_AI_reammo;";
    _this addMPEventHandler ["MPkilled", {Null = _this spawn SAR_AI_killed;}]; 
    _this addMPEventHandler ["MPHit", {Null = _this spawn SAR_AI_hit;}]; 
    _this addEventHandler ["HandleDamage",{if (_this select 1!="") then {_unit=_this select 0;damage _unit+((_this select 2)-damage _unit)*1}}];    
    
    [_this] joinSilent _group;
    // set skills 
    {
        _this setskill [_x select 0,(_x select 1 +(floor(random 2) * (_x select 2)))];
    } foreach _sniperskills;

    // store AI type on the AI
    _this setVariable ["SAR_AI_type",_ai_type,false];

    // store experience value on AI
    _this setVariable ["SAR_AI_experience",0,false];
    
};

for "_i" from 0 to (_riflemen - 1) do
{
    _this = _group createunit [_riflemenlist call SAR_fnc_selectRandom, [(_rndpos select 0) , _rndpos select 1, 0], [], 0.5, "NONE"];

    _soldier_items = ["rifleman",_type] call SAR_unit_loadout_items;
    _soldier_tools = ["rifleman",_type] call SAR_unit_loadout_tools;
    _soldier_weapon_names = ["rifleman",_type] call SAR_unit_loadout_weapons;
    
    [_this,_soldier_weapon_names,_soldier_items,_soldier_tools] call SAR_unit_loadout;
    
    _this setVehicleInit "[this] spawn SAR_AI_trace;this setIdentity 'id_SAR_sold_man';[this] spawn SAR_AI_reammo;";    
    _this addMPEventHandler ["MPkilled", {Null = _this spawn SAR_AI_killed;}]; 
    _this addMPEventHandler ["MPHit", {Null = _this spawn SAR_AI_hit;}];     
    _this addEventHandler ["HandleDamage",{if (_this select 1!="") then {_unit=_this select 0;damage _unit+((_this select 2)-damage _unit)*1}}];    
    
    [_this] joinSilent _group;

    // set skills 
    {
        _this setskill [_x select 0,(_x select 1 +(floor(random 2) * (_x select 2)))];
    } foreach _riflemanskills;

    // store AI type on the AI
    _this setVariable ["SAR_AI_type",_ai_type,false];

    // store experience value on AI
    _this setVariable ["SAR_AI_experience",0,false];
    
};

_leader = leader _group;

// initialize upsmon for the group

_ups_para_list = [_leader,_patrol_area_name,'wait','nofollow','noslow','notrigger','aware','showmarker','spawned','delete:',SAR_DELETE_TIMEOUT];


if(!SAR_AI_STEAL_VEHICLE) then {
    _ups_para_list set [count _ups_para_list,'noveh'];
};

if(SAR_AI_disable_UPSMON_AI) then {
    _ups_para_list set [count _ups_para_list,'noai'];
};

if (_respawn) then {
    _ups_para_list set [count _ups_para_list,'respawn'];
    _ups_para_list set [count _ups_para_list,'respawntime:'];
    _ups_para_list set [count _ups_para_list,_respawn_time];
};

if(_action == "") then {_action = "patrol";};

switch (_action) do {

    case "noupsmon":
    {
    };
    case "circledefend":
    {
        _ups_para_list set [count _ups_para_list,'nowp3'];
        _ups_para_list set [count _ups_para_list,'circledefend'];
        //_ups_para_list spawn  SAR_AI_UPSMON;
        
        [_leader,"defend",15] spawn SAR_circle_static;
        
    };
    case "fortify":
    {
        _ups_para_list set [count _ups_para_list,'fortify'];
        _ups_para_list spawn SAR_AI_UPSMON;
    };
    case "fortify_nochase":
    {
        _ups_para_list set [count _ups_para_list,'fortify_nochase'];
        _ups_para_list spawn SAR_AI_UPSMON;
    };
    case "patrol":
    {
        _ups_para_list spawn SAR_AI_UPSMON;
    };
    case "ambush":
    {
        _ups_para_list set [count _ups_para_list,'ambush'];
        _ups_para_list spawn SAR_AI_UPSMON;
    };
};
    
    
processInitCommands;

if(SAR_EXTREME_DEBUG) then {
    diag_log format["SAR_EXTREME_DEBUG: Infantry group (%3) spawned in: %1 with action: %2",_patrol_area_name,_action,_group];
};
_group;