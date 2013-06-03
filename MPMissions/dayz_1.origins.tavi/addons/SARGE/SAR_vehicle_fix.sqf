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
//   SAR_vehicle_fix.sqf
//   last modified: 28.5.2013
// ---------------------------------------------------------------------------------------------------------

    private ["_loop","_chk_count","_i","_gridwidth","_markername","_triggername","_trig_act_stmnt","_trig_deact_stmnt","_trig_cond","_pos","_tmp","_sphere_alpha","_sphere_red","_sphere_green","_sphere_blue","_obj_text_string"];

    if (!isServer) exitWith {}; // only run this on the server
    
    // wait until the server has spawned all the vehicles ... might take a while
    
    sleep 15;
  
    _loop = true;
    _chk_count = 0;
    
    while {_loop} do {

        _chk_count = count dayz_serverObjectMonitor;
        
        sleep 5;
    
        if ((_chk_count != 0) && {count dayz_serverObjectMonitor == _chk_count} ) then {
        
            _loop = false;
            
        };

    };
    
    
//    [dayz_serverObjectMonitor] call SAR_debug_array;
    
    _i=0;
    _gridwidth = 5;
         
    {
    
        if (_x isKindOf "AllVehicles") then { // just do this for vehicles, not other objects like tents
        
            _triggername = format["SAR_veh_trig_%1",_i];

            _this = createTrigger ["EmptyDetector", [0,0]];
            _this setTriggerArea [_gridwidth,_gridwidth, 0, false];
            _this setTriggerActivation ["ANY", "PRESENT", true];
            _this setVariable ["unitlist",[],true];
            
            _this setVariable ["SAR_trig_veh",_x,true];

            Call Compile Format ["SAR_veh_trig_%1 = _this",_i]; 
            
            _trig_act_stmnt = format["[thislist,thisTrigger,'%1'] spawn SAR_AI_veh_trig_on_static;",_triggername];
            _trig_deact_stmnt = format["[thislist,thisTrigger,'%1'] spawn SAR_AI_veh_trig_off;",_triggername];

            _trig_cond = "{(isPlayer _x) && (vehicle _x == _x) } count thisList != count (thisTrigger getVariable['unitlist',[]]);";

            Call Compile Format ["SAR_veh_trig_%1",_i] setTriggerStatements [_trig_cond,_trig_act_stmnt , _trig_deact_stmnt];

            Call Compile Format ["SAR_veh_name_%1 = _x",_i]; 
            Call Compile Format ["SAR_veh_trig_%1",_i] attachTo [Call Compile Format ["SAR_veh_name_%1",_i],[0,0,0]];
            
            
            if(SAR_EXTREME_DEBUG) then { // show areamarkers around vehicles and add a sphere on top of it

                _markername = format["SAR_mar_trig_%1",_i];

                _pos = getPosASL _x;
                _this = createMarker[_markername,_pos];

                _this setMarkerAlpha 1;
                if (_x isKindOf "Air") then {
                    _this setMarkerShape "ELLIPSE";
                } else {
                    _this setMarkerShape "RECTANGLE";
                };
                _this setMarkerType "Flag";
                _this setMarkerBrush "BORDER";
                _this setMarkerSize [_gridwidth, _gridwidth];
                        
                Call Compile Format ["SAR_testarea_%1 = _this",_i]; 
                
                
                // adding a sphere on top of the vehicle, to show if trigger activated or not
                
                _tmp = createvehicle ["Sign_sphere25cm_EP1",_pos,[],0,"NONE"];
                
                _sphere_alpha = 1;
                _sphere_red = 0;
                _sphere_green= 1;
                _sphere_blue=0;
                
                _obj_text_string = format["#(argb,8,8,3)color(%1,%2,%3,%4,ca)",_sphere_red,_sphere_green,_sphere_blue,_sphere_alpha];
                
                //_tmp setObjectTexture [0,_obj_text_string];
                
                [nil,nil,rSETOBJECTTEXTURE,_tmp,0,_obj_text_string] call RE;
                
                _tmp allowDamage false;
                
                _tmp attachTo [_x,[0,0,2]];
                
                _x setVariable ["SAR_sphere_id",_tmp,true];


                // adding a sphere on top back of the vehicle, to show side of the vehicle
                
                _tmp = createvehicle ["Sign_sphere25cm_EP1",_pos,[],0,"NONE"];
                
                _sphere_alpha = 1;
                _sphere_red = 0;
                _sphere_green= 0;
                _sphere_blue=0;
                
                _obj_text_string = format["#(argb,8,8,3)color(%1,%2,%3,%4,ca)",_sphere_red,_sphere_green,_sphere_blue,_sphere_alpha];

                
                [nil,nil,rSETOBJECTTEXTURE,_tmp,0,_obj_text_string] call RE;
                
                _tmp allowDamage false;
                
                _tmp attachTo [_x,[0,2,2]];
                
                _x setVariable ["SAR_sphere_side_id",_tmp,true];

                [_x] spawn SAR_veh_side_debug;

                

            };
            
            _i = _i + 1;
        
        };
    
    } foreach dayz_serverObjectMonitor;
    
