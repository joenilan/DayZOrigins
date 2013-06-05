// =========================================================================================================
//  SAR_AI - DayZ AI library
//  Version: 1.5.2
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
//   SAR_setup_AI_patrol_heli.sqf
//   last modified: 28.5.2013
// ---------------------------------------------------------------------------------------------------------


private ["_ai_type","_riflemenlist","_side","_leader_group","_initstring","_patrol_area_name","_rndpos","_groupheli","_heli","_leader","_man2heli","_man3heli","_argc","_grouptype","_respawn","_leader_weapon_names","_leader_items","_leader_tools","_soldier_weapon_names","_soldier_items","_soldier_tools","_leaderskills","_sniperskills","_ups_para_list","_type","_error","_respawn_time","_leadername"];

if(!isServer) exitWith {};

_argc = count _this;

_error = false;

_patrol_area_name = _this select 0;

// type of soldier list

if (_argc >1) then {

    _grouptype = _this select 1;

    switch (_grouptype) do
    {
        case 1: // military
        {
            _side = SAR_AI_friendly_side;
            _type="sold";
            _ai_type = "AI Military";
            _initstring = "[this] spawn SAR_AI_trace_veh;this setIdentity 'id_SAR_sold_man';[this] spawn SAR_AI_reammo;";
            
        };
        case 2: // survivors
        {
            _side = SAR_AI_friendly_side;
            _type="surv";
            _ai_type = "AI Survivor";            
            _initstring = "[this] spawn SAR_AI_trace_veh;this setIdentity 'id_SAR_surv_lead';[this] spawn SAR_AI_reammo;";
            
        };
        case 3: // bandits
        {
            _side = SAR_AI_unfriendly_side;
            _type="band";
            _ai_type = "AI Bandit";            
            _initstring = "[this] spawn SAR_AI_trace_veh;this setIdentity 'id_SAR_band';[this] spawn SAR_AI_reammo;";
            
        };
    };

    _leader_group = call compile format ["SAR_leader_%1_list",_type] call SAR_fnc_selectRandom;
    _riflemenlist = call compile format ["SAR_soldier_%1_list",_type];

    _leaderskills = call compile format ["SAR_leader_%1_skills",_type];

    _sniperskills = call compile format ["SAR_sniper_%1_skills",_type];

    _leader_weapon_names = ["leader",_type] call SAR_unit_loadout_weapons;
    _leader_items = ["leader",_type] call SAR_unit_loadout_items;
    _leader_tools = ["leader",_type] call SAR_unit_loadout_tools;
    
} else {
    _error = true;
};


// respawn parameter
if (_argc >2) then {
    _respawn = _this select 2;
} else {
    _respawn = false;
};

// respawn time
if(_argc>3) then {
    _respawn_time = _this select 3;
}else {
    _respawn_time = SAR_respawn_waittime;
};


if(_error) exitWith {diag_log "SAR_AI: Heli patrol setup failed, wrong parameters passed!";};


// get a random starting position, UPSMON will handle the rest
_rndpos = [_patrol_area_name] call SHK_pos;

//diag_log _rndpos;

_groupheli = createGroup _side;

// protect group from being deleted by DayZ
_groupheli setVariable ["SAR_protect",true,true];

// create the vehicle
_heli = createVehicle [(SAR_heli_type call SAR_fnc_selectRandom), [(_rndpos select 0) + 10, _rndpos select 1, 80], [], 0, "FLY"];
_heli setFuel 1;
_heli setVariable ["Sarge",1,true];
_heli engineon true; 
//_heli allowDamage false;
_heli setVehicleAmmo 1;


if(SAR_heli_shield) then {
    _heli addEventHandler ["HandleDamage", {returnvalue = _this spawn SAR_AI_VEH_HIT;}];  
}else {
    _heli addEventHandler ["HandleDamage", {_this spawn SAR_AI_VEH_HIT;_this select 2;}];  
};

[_heli] joinSilent _groupheli;

//
// Get turret config ... this is mega buggy from a BI side - might use it later if we generalize the vehicles used
//

/* diag_log typeof _heli;

_cfg = [configFile >> "CfgVehicles" >> typeOf _heli >> "turrets"] call SAR_fnc_returnVehicleTurrets;

_cfg = getArray (configFile >> "CfgVehicles" >> typeof _heli >> "Turrets");
_tc = count _cfg;

{ diag_log format["SAR_DEBUG: %1",_cfg select _forEachIndex];}foreach _cfg;

diag_log "_____________";

for [{_i=0}, {_i < _tc}, {_i=_i+1}] do
{
    diag_log format["SAR_DEBUG: Array %1: %2",_i, _cfg select _i];
};

if (_tc>0) then {
    _mtc = count _cfg; // number of main turrets
    _out = _out + format["Main Turrets: %1\n",count _cfg];
    
    for "_mti" from 0 to _mtc-1 do {
        _mt = (_cfg select _mti);
        _st = _mt >> "turrets";
        _stc = count _st; // sub-turrets in current main one
        _out = _out + format["Turret #%1, %2: [%1]\n",_mti,configName(_mt)];
        _weaps = getArray(_mt >> "weapons");
        _out = _out + format[" Weapons:\n"];
        {_out = _out + format["  %1\n",_x]}forEach _weaps;
        for "_sti" from 0 to _stc-1 do {
            _stp = (_st select _sti);
            _out = _out + format["Turret #%1, %2: [%1,%3]\n",_mti,configName(_stp),_sti];
            _weaps = getArray(_stp >> "weapons");
            _out = _out + format[" Weapons:\n"];
            {_out = _out + format["  %1\n",_x]}forEach _weaps;
        };
    };
} else {
    _out = "SAR_DEBUG: Turret config not found";
};

diag_log format["SAR_DEBUG: Turrets: %1, _tc=%2",_out,_tc];
 */
//
//
//


// create ppl in it
_leader = _groupheli createunit [_leader_group, [(_rndpos select 0) + 10, _rndpos select 1, 0], [], 0.5, "NONE"];

[_leader,_leader_weapon_names,_leader_items,_leader_tools] call SAR_unit_loadout;

_leader setVehicleInit _initstring;
_leader addMPEventHandler ["MPkilled", {Null = _this spawn SAR_AI_killed;}];
_leader addMPEventHandler ["MPHit", {Null = _this spawn SAR_AI_hit;}];  
_leader addEventHandler ["HandleDamage",{if (_this select 1!="") then {_unit=_this select 0;damage _unit+((_this select 2)-damage _unit)*SAR_leader_health_factor}}];

_leader moveInDriver _heli;
_leader assignAsDriver _heli;

[_leader] joinSilent _groupheli;

// set skills of the leader
{
    _leader setskill [_x select 0,(_x select 1 +(floor(random 2) * (_x select 2)))];
} foreach _leaderskills;

SAR_leader_number = SAR_leader_number + 1;
_leadername = format["SAR_leader_%1",SAR_leader_number];

_leader setVehicleVarname _leadername;
_leader setVariable ["SAR_leader_name",_leadername,false];

// create global variable for this group
call compile format ["KRON_UPS_%1=1",_leadername];

// store AI type on the AI
_leader setVariable ["SAR_AI_type",_ai_type + " Leader",false];

// store experience value on AI
_leader setVariable ["SAR_AI_experience",0,false];



// set behaviour & speedmode
_leader setspeedmode "FULL";
_leader setBehaviour "AWARE"; 


// SARGE - include loop for available turret positions

// Gunner 1


_man2heli = _groupheli createunit [_riflemenlist call SAR_fnc_selectRandom, [(_rndpos select 0) - 30, _rndpos select 1, 0], [], 0.5, "NONE"];

_soldier_weapon_names = ["rifleman",_type] call SAR_unit_loadout_weapons;
_soldier_items = ["rifleman",_type] call SAR_unit_loadout_items;
_soldier_tools = ["rifleman",_type] call SAR_unit_loadout_tools;
[_man2heli,_soldier_weapon_names,_soldier_items,_soldier_tools] call SAR_unit_loadout;

//_man2heli action ["getInTurret", _heli,[0]];
_man2heli moveInTurret [_heli,[0]];

_man2heli setVehicleInit _initstring;
_man2heli addMPEventHandler ["MPkilled", {Null = _this spawn SAR_AI_killed;}];
_man2heli addMPEventHandler ["MPHit", {Null = _this spawn SAR_AI_hit;}];  
[_man2heli] joinSilent _groupheli;

// set skills 
{
    _man2heli setskill [_x select 0,(_x select 1 +(floor(random 2) * (_x select 2)))];
} foreach _sniperskills;

// store AI type on the AI
_man2heli setVariable ["SAR_AI_type",_ai_type,false];

// store experience value on AI
_man2heli setVariable ["SAR_AI_experience",0,false];




//Gunner 2
_man3heli = _groupheli createunit [_riflemenlist call SAR_fnc_selectRandom, [_rndpos select 0, (_rndpos select 1) + 30, 0], [], 0.5, "NONE"];

_soldier_weapon_names = ["rifleman",_type] call SAR_unit_loadout_weapons;
_soldier_items = ["rifleman",_type] call SAR_unit_loadout_items;
_soldier_tools = ["rifleman",_type] call SAR_unit_loadout_tools;

[_man3heli,_soldier_weapon_names,_soldier_items,_soldier_tools] call SAR_unit_loadout;

_man3heli setVehicleInit _initstring;

//_man3heli action ["getInTurret", _heli,[1]];
_man3heli moveInTurret [_heli,[1]];

_man3heli addMPEventHandler ["MPkilled", {Null = _this spawn SAR_AI_killed;}];
_man3heli addMPEventHandler ["MPHit", {Null = _this spawn SAR_AI_hit;}];  
[_man3heli] joinSilent _groupheli;

// set skills 
{
    _man3heli setskill [_x select 0,(_x select 1 +(floor(random 2) * (_x select 2)))];
} foreach _sniperskills;

// store AI type on the AI
_man3heli setVariable ["SAR_AI_type",_ai_type,false];

// store experience value on AI
_man3heli setVariable ["SAR_AI_experience",0,false];


// initialize upsmon for the group

_leader = leader _groupheli;

_ups_para_list = [_leader,_patrol_area_name,'nowait','nofollow','aware','showmarker','spawned','delete:',SAR_DELETE_TIMEOUT];

if (_respawn) then {
    _ups_para_list = _ups_para_list + ['respawn'];
    _ups_para_list set [count _ups_para_list,'respawntime:'];
    _ups_para_list set [count _ups_para_list,_respawn_time];
};

_ups_para_list spawn SAR_AI_UPSMON;

processInitCommands;

if(SAR_EXTREME_DEBUG) then {
    diag_log format["SAR_EXTREME_DEBUG: AI Heli patrol (%2) spawned in: %1.",_patrol_area_name,_groupheli];
};

_groupheli;