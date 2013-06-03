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
//  UPSMon  (special SARGE version)
//  SHK_pos 
//  
// ---------------------------------------------------------------------------------------------------------
//   SAR_trace_from_vehicle.sqf
//   last modified: 28.5.2013
// ---------------------------------------------------------------------------------------------------------

// Traces only from vehicles and traces only players which are not in a vehicle, so NO ZED tracing, should not be used for infantry. 

private ["_ai","_entity_array","_humanity","_humanitylimit","_sleeptime","_detectrange","_tracewhat","_player_rating","_clientmachine"];

if (!isServer) exitWith {}; // only run this on the server

_ai = _this select 0;
_tracewhat = "CAManBase";

_detectrange = SAR_DETECT_HOSTILE_FROM_VEHICLE;
_humanitylimit = SAR_HUMANITY_HOSTILE_LIMIT;
_humanity = 0;
_sleeptime = SAR_DETECT_FROM_VEHICLE_INTERVAL;
    
while {alive _ai} do {
    
    _entity_array = (position _ai) nearEntities [_tracewhat, _detectrange];
    
    {
        if(isPlayer _x && {vehicle _x == _x}) then { // only do that for players that are not in a vehicle

            _humanity= _x getVariable ["humanity",0];
            _player_rating = rating _x;
            
            If (_humanity < _humanitylimit && {_player_rating > -10000}) then {

                if(SAR_EXTREME_DEBUG) then {
                    diag_log format["SAR EXTREME DEBUG: reducing rating (trace_from_vehicle) for player: %1", _x];
                };
                
                //define global variable
                adjustrating = [_x,(0 - (10000+_player_rating))];
            
                // get the players machine ID
                _clientmachine = owner _x;
            
                // transmit the global variable to this client machine
                _clientmachine publicVariableClient "adjustrating";
                
                // reveal player to vehicle group
                _ai reveal [_x,4];
                
            };
        };
        
    } forEach _entity_array;

    sleep _sleeptime;
};