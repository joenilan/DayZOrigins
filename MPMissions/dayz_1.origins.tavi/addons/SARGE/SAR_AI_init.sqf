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
// SAR_AI_init.sqf - main init and control file of the framework 
// last modified: 28.5.2013 
// ---------------------------------------------------------------------------------------------------------

private ["_worldname","_startx","_starty","_gridsize_x","_gridsize_y","_gridwidth","_markername","_triggername","_trig_act_stmnt","_trig_deact_stmnt","_trig_cond","_check","_script_handler","_legendname"];

SAR_version = "1.5.0";
SAR_environment = "dedicated Server";

// establish PvEH on all clients

if (!isServer) then { // only run this on the connected clients
    
    "adjustrating" addPublicVariableEventHandler {((_this select 1) select 0) addRating ((_this select 1) select 1);	};

}; 

// preprocessing relevant clientside scripts
SAR_AI_trace                      = compile preprocessFileLineNumbers "addons\SARGE\SAR_trace_entities.sqf";
SAR_AI_trace_veh                  = compile preprocessFileLineNumbers "addons\SARGE\SAR_trace_from_vehicle.sqf";
SAR_AI_hit                        = compile preprocessFileLineNumbers "addons\SARGE\SAR_aihit.sqf";


if (!isServer) exitWith {}; // only run this on the server

diag_log "----------------------------------------";
diag_log format["Starting SAR_AI version %1 on a %2",SAR_version,SAR_environment];
diag_log "----------------------------------------";

// activate functions library
call compile preprocessFileLineNumbers "addons\SARGE\SAR_functions.sqf";


// preprocessing relevant serverside scripts
SAR_AI                      = compile preprocessFileLineNumbers "addons\SARGE\SAR_setup_AI_patrol.sqf";
SAR_AI_heli                 = compile preprocessFileLineNumbers "addons\SARGE\SAR_setup_AI_patrol_heli.sqf";
SAR_AI_land                 = compile preprocessFileLineNumbers "addons\SARGE\SAR_setup_AI_patrol_land.sqf";
SAR_AI_reammo               = compile preprocessFileLineNumbers "addons\SARGE\SAR_reammo_refuel_AI.sqf";
SAR_AI_spawn                = compile preprocessFileLineNumbers "addons\SARGE\SAR_AI_spawn.sqf";
SAR_AI_despawn              = compile preprocessFileLineNumbers "addons\SARGE\SAR_AI_despawn.sqf";
SAR_AI_killed               = compile preprocessFileLineNumbers "addons\SARGE\SAR_aikilled.sqf";
SAR_AI_UPSMON               = compile preprocessFileLineNumbers "addons\UPSMON\scripts\upsmon.sqf";
SAR_AI_VEH_HIT              = compile preprocessFileLineNumbers "addons\SARGE\SAR_ai_vehicle_hit.sqf";
SAR_AI_GROUP_MONITOR        = compile preprocessFileLineNumbers "addons\SARGE\SAR_group_monitor.sqf";
SAR_AI_VEH_FIX              = compile preprocessFileLineNumbers "addons\SARGE\SAR_vehicle_fix.sqf";


// Public Eventhandlers

"doMedicAnim" addPublicVariableEventHandler {((_this select 1) select 0) playActionNow ((_this select 1) select 1);	};

//---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

//
// include user config values
//

#include "SAR_config.sqf"

//
// make some config variables public
//

publicvariable "SAR_surv_kill_value";
publicvariable "SAR_band_kill_value";
publicvariable "SAR_DEBUG";
publicvariable "SAR_EXTREME_DEBUG";
publicvariable "SAR_DETECT_HOSTILE";
publicvariable "SAR_DETECT_INTERVAL";
publicvariable "SAR_HUMANITY_HOSTILE_LIMIT";

//---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

// side definitions
createCenter east;
createCenter resistance;

// unfriendly AI bandits
EAST setFriend [WEST, 0]; 
EAST setFriend [RESISTANCE, 0];

// Players 
WEST setFriend [EAST, 0];
WEST setFriend [RESISTANCE, 1];

// friendly AI 
RESISTANCE setFriend [EAST, 0];
RESISTANCE setFriend [WEST, 1];

SAR_AI_friendly_side = resistance;
SAR_AI_unfriendly_side = east;

SAR_leader_number = 0;

// Declaring AI monitor array

SAR_AI_monitor = [];

_worldname= toLower format["%1",worldName];

diag_log format["Setting up SAR_AI for : %1",_worldname];

if (SAR_dynamic_spawning) then {

    diag_log format["SAR_AI: dynamic Area & Trigger definition Started"];

    // 
    // Setup aremarker & trigger grid - DO NOT CHANGE
    //

    // default gridvalues
    _startx=2500;
    _starty=2800;
    _gridsize_x=6;
    _gridsize_y=6;
    _gridwidth = 1000;

    //
    // get grid configuration for the different maps
    //

    switch (_worldname) do {
        case "chernarus":
        {
            #include "map_config\SAR_cfg_grid_chernarus.sqf"
        };
        case "tavi":
        {
            #include "map_config\SAR_cfg_grid_tavi.sqf"
        };
        case "namalsk":
        {
            #include "map_config\SAR_cfg_grid_namalsk.sqf"
        };
        case "lingor":
        {
            #include "map_config\SAR_cfg_grid_lingor.sqf"
        };
        case "mbg_celle2":
        {
            #include "map_config\SAR_cfg_grid_mbg_celle2.sqf"
        };
        case "takistan":
        {
            #include "map_config\SAR_cfg_grid_takistan.sqf"
        };
        case "fallujah":
        {
            #include "map_config\SAR_cfg_grid_fallujah.sqf"
        };
        case "panthera2":
        {
            #include "map_config\SAR_cfg_grid_panthera.sqf"
        };

    };

    //
    // Generate marker & trigger grid & activate it
    //

    SAR_area_ = text format ["SAR_area_%1","x"];

    for "_i" from 0 to (_gridsize_y - 1) do
    {
        for "_ii" from 0 to (_gridsize_x - 1) do
        {
            //
            // Define marker area
            //
            
            _markername = format["SAR_area_%1_%2",_ii,_i];
            _legendname = format["SAR_area_legend_%1_%2",_ii,_i];
            
            _this = createMarker[_markername,[_startx + (_ii * _gridwidth * 2),_starty + (_i * _gridwidth * 2)]];
            if(SAR_DEBUG || {SAR_EXTREME_DEBUG}) then {
                _this setMarkerAlpha 1;
            } else {
                _this setMarkerAlpha 0;
            };
            _this setMarkerShape "RECTANGLE";
            _this setMarkerType "Flag";
            _this setMarkerBrush "BORDER";
            _this setMarkerSize [_gridwidth, _gridwidth];
                    
            Call Compile Format ["SAR_area_%1_%2 = _this",_ii,_i]; 

            _this = createMarker[_legendname,[_startx + (_ii * _gridwidth * 2) + (_gridwidth - (_gridwidth/2)),_starty + (_i * _gridwidth * 2) - (_gridwidth - (_gridwidth/10))]];
            if(SAR_DEBUG || {SAR_EXTREME_DEBUG}) then {
                _this setMarkerAlpha 1;
            } else {
                _this setMarkerAlpha 0;
            };
            

            _this setMarkerShape "ICON";
            _this setMarkerType "Flag";
            _this setMarkerColor "ColorBlack";
            
            _this setMarkerText format["%1/%2",_ii,_i];
            _this setMarkerSize [.1, .1];            
            

            //
            // Define trigger area & conditions & actions
            //

            _triggername = format["SAR_trig_%1_%2",_ii,_i];
            
            _this = createTrigger ["EmptyDetector", [_startx + (_ii * _gridwidth * 2),_starty + (_i * _gridwidth * 2)]];
            _this setTriggerArea [_gridwidth, _gridwidth, 0, true];
            _this setTriggerActivation ["ANY", "PRESENT", true];
            
            Call Compile Format ["SAR_trig_%1_%2 = _this",_ii,_i]; 

            _trig_act_stmnt = format["if (SAR_DEBUG) then {diag_log 'SAR DEBUG: trigger on in %1';};[thislist,'%1'] spawn SAR_AI_spawn;",_triggername];
            _trig_deact_stmnt = format["if (SAR_DEBUG) then {diag_log 'SAR DEBUG: trigger off in %1';};[thislist,thisTrigger,'%1'] spawn SAR_AI_despawn;",_triggername];
            
            _trig_cond = "{isPlayer _x} count thisList > 0;";
            
            Call Compile Format ["SAR_trig_%1_%2 ",_ii,_i] setTriggerStatements [_trig_cond,_trig_act_stmnt , _trig_deact_stmnt];

            // standard grid definition - maxgroups (ba,so,su) - probability (ba,so,su) - max group members (ba,so,su)
            SAR_AI_monitor set[count SAR_AI_monitor, [_markername,[SAR_max_grps_bandits,SAR_max_grps_soldiers,SAR_max_grps_survivors],[SAR_chance_bandits,SAR_chance_soldiers,SAR_chance_survivors],[SAR_max_grpsize_bandits,SAR_max_grpsize_soldiers,SAR_max_grpsize_survivors],[],[],[]]];

        };
    };

    diag_log format["SAR_AI: Area & Trigger definition finished"];
};
// ----------------------------------------------------------------------------
// end of Setup aremarker & trigger grid
// ----------------------------------------------------------------------------

//
//  Enable the SAR garbage collector & watchdog
//
    
    
[] spawn SAR_AI_GROUP_MONITOR;
    

//
// include group & spawn definitions for automatic & static vehicle and infantry spawns
//

diag_log format["SAR_AI: Dynamic and static spawning Started"];

switch (_worldname) do {
    case "chernarus":
    {
        #include "map_config\SAR_cfg_grps_chernarus.sqf"
    };
    case "tavi":
    {
        #include "map_config\SAR_cfg_grps_tavi.sqf"
    };
    case "namalsk":
    {
        #include "map_config\SAR_cfg_grps_namalsk.sqf"
    };
    case "lingor":
    {
        #include "map_config\SAR_cfg_grps_lingor.sqf"
    };
    case "mbg_celle2":
    {
        #include "map_config\SAR_cfg_grps_mbg_celle2.sqf"
    };
    case "takistan":
    {
        #include "map_config\SAR_cfg_grps_takistan.sqf"
    };
    case "fallujah":
    {
        #include "map_config\SAR_cfg_grps_fallujah.sqf"
    };
    case "panthera2":
    {
        #include "map_config\SAR_cfg_grps_panthera.sqf"
    };
    
};

diag_log format["SAR_AI: Dynamic and static spawning finished"];

//
// initialize the fix for sharing vehicles between survivors and bandits
//

if(SAR_FIX_VEHICLE_ISSUE) then {

    diag_log "SAR_AI: applying vehicle fix ...";

    _script_handler = [] spawn SAR_AI_VEH_FIX;
    waitUntil {scriptDone _script_handler};
    
    diag_log "SAR_AI: ... vehicle fix applied";
};

//[] call SAR_commentator;
