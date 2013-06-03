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
//  UPSMon  (specific SARGE version)
//  SHK_pos 
//  
// ---------------------------------------------------------------------------------------------------------
//   SAR_trace_entities.sqf
//   last modified: 28.5.2013
// ---------------------------------------------------------------------------------------------------------

private ["_ai","_entity_array","_humanity","_humanitylimit","_sleeptime","_detectrange"];

if (isServer) exitWith {}; // only run this on the client

_ai = _this select 0;

_detectrange = SAR_DETECT_HOSTILE;
_humanitylimit=SAR_HUMANITY_HOSTILE_LIMIT;
_humanity = 0;
_sleeptime = SAR_DETECT_INTERVAL;
    
while {alive _ai} do {
        
    _entity_array = (position _ai) nearEntities ["CAManBase",_detectrange];
    {
        if(vehicle _ai == _ai) then { // AI is not in a vehicle, so we trace Zeds

            if (_x isKindof "zZombie_Base") then {
        
                if(rating _x > -10000) then {
                    _x addrating -10000;
                    if(SAR_EXTREME_DEBUG) then {
                        diag_log "SAR EXTREME DEBUG: Zombie rated down";
                    };
                };
            };
        };
        if(isPlayer _x && {vehicle _x == _x}) then { // only do this for players not in vehicles
            
            _humanity= _x getVariable ["humanity",0];

            If (_humanity < _humanitylimit && {rating _x > -10000}) then {
                if(SAR_EXTREME_DEBUG) then {
                    diag_log format["SAR EXTREME DEBUG: reducing rating (trace_entities) for player: %1", _x];
                };
                _x addrating -10000;
            };
        };
    
    } forEach _entity_array;

    sleep _sleeptime;
};