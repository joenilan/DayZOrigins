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
//   SAR_aikilled.sqf
//   last modified: 28.5.2013
// ---------------------------------------------------------------------------------------------------------
//  Parameters:
//  [ _ai (AI unit that was killed, 
//    _aikiller (unit that killed the AI)  
//   ]
// ------------------------------------------------------------------------------------------------------------


private ["_message","_ai","_aikiller","_aikilled_type","_aikilled_side","_aikilled_group_side","_aikiller_group_side","_aikiller_type","_aikiller_name","_aikiller_side","_humanity","_humankills","_banditkills","_ai_xp_type","_xp_gain","_tmp","_sphere_alpha","_sphere_red","_sphere_green","_sphere_blue","_obj_text_string","_ai_killer_xp","_ai_killer_xp_new","_ai_type","_ai_xp","_ai_killer_xp_type","_ai_killer_type"];

if (!isServer) exitWith {}; // only run this on the server

_ai = _this select 0;
_aikiller = _this select 1;

_aikilled_type = typeof _ai;
_aikilled_side = side _ai;
_aikilled_group_side = side (group _ai);

_aikiller_type = typeof _aikiller;

if (!(_aikiller_type in SAR_heli_type) && alive _aikiller && !("LandVehicle" countType [vehicle _aikiller]>0)) then {
    _aikiller_name = name _aikiller;
}else{
    _aikiller_name = _aikiller_type;
};



_aikiller_side = side _aikiller;
_aikiller_group_side = side (group _aikiller);

// retrieve AI type from the killed AI
_ai_type = _ai getVariable ["SAR_AI_type",""];

// retrieve AI type from the killer AI
_ai_killer_type = _aikiller getVariable ["SAR_AI_type",""];


// retrieve experience value from the killed AI
_ai_xp = _ai getVariable["SAR_AI_experience",0];

// retrieve experience value from the killing AI
_ai_killer_xp = _aikiller getVariable["SAR_AI_experience",0];



if (_ai_xp < SAR_AI_XP_LVL_2) then {
    _ai_xp_type = SAR_AI_XP_NAME_1;
};
if (_ai_xp >= SAR_AI_XP_LVL_2 && _ai_xp < SAR_AI_XP_LVL_3) then {
    _ai_xp_type = SAR_AI_XP_NAME_2;
};
if (_ai_xp >= SAR_AI_XP_LVL_3) then {
    _ai_xp_type = SAR_AI_XP_NAME_3;
};

if (_ai_killer_xp < SAR_AI_XP_LVL_2) then {
    _ai_killer_xp_type = SAR_AI_XP_NAME_1;
};
if (_ai_killer_xp >= SAR_AI_XP_LVL_2 && _ai_killer_xp < SAR_AI_XP_LVL_3) then {
    _ai_killer_xp_type = SAR_AI_XP_NAME_2;
};
if (_ai_killer_xp >= SAR_AI_XP_LVL_3) then {
    _ai_killer_xp_type = SAR_AI_XP_NAME_3;
};




if (SAR_KILL_MSG) then {

    if(isPlayer _aikiller) then {
        _message = format["A %3 %2 was killed by Player: %1",_aikiller_name,_ai_type,_ai_xp_type];
        diag_log _message;
        
        [nil, nil, rspawn, [[West,"airbase"], _message], { (_this select 0) sideChat (_this select 1) }] call RE;
        
    };

    if(!isPlayer _aikiller && !(isNull _aikiller)) then {
        
        if (_ai_xp >=SAR_AI_XP_LVL_2) then {
            _message = format["A %1 %2 was killed by a %3 %4!",_ai_xp_type,_ai_type,_ai_killer_xp_type,_ai_killer_type];
            diag_log _message;
            [nil, nil, rspawn, [[West,"airbase"], _message], { (_this select 0) sideChat (_this select 1) }] call RE;
        };
    };
};


if (SAR_HITKILL_DEBUG) then {
    diag_log format["SAR_HITKILL_DEBUG: AI killed - Type: %1 Side: %2 Group Side: %3",_aikilled_type, _aikilled_side,_aikilled_group_side];
    diag_log format["SAR_HITKILL_DEBUG: AI Killer - Type: %1 Name: %2 Side: %3 Group Side: %4",_aikiller_type,_aikiller_name, _aikiller_side,_aikiller_group_side];
};


if(isPlayer _aikiller) then {
    
    if (_aikilled_group_side == SAR_AI_friendly_side) then {
        if(SAR_DEBUG)then{diag_log format["SAR_DEBUG: Adjusting humanity for survivor or soldier kill by %2 for %1",_aikiller,SAR_surv_kill_value];};
        _humanity = _aikiller getVariable ["humanity",0];
        _humanity = _humanity - SAR_surv_kill_value;
        _aikiller setVariable["humanity", _humanity,true];
        if(SAR_log_AI_kills) then {
            _humankills = _aikiller getVariable["humanKills",0];
            _aikiller setVariable["humanKills",_humankills+1,true];        
        };
        if ((random 100) < 3) then {
            _message = format["%1 killed a friendly AI - sending reinforcements!",_aikiller_name];
            [nil, nil, rspawn, [[West,"airbase"], _message], { (_this select 0) sideChat (_this select 1) }] call RE;
        } else {
            if ((random 100) < 3) then {
                _message = format["Tango down ... we offer a decent reward for the head of %1!",_aikiller_name];
                [nil, nil, rspawn, [[West,"airbase"], _message], { (_this select 0) sideChat (_this select 1) }] call RE;
            };
        };
        if ((random 100) < 2) then {
            _message = "NO CAPS in sidechat !!!";
            [nil, nil, rspawn, [[West,"airbase"], _message], { (_this select 0) sideChat (_this select 1) }] call RE;
        };

    };
    if (_aikilled_group_side == SAR_AI_unfriendly_side) then {
        if(SAR_DEBUG)then{diag_log format["SAR_DEBUG: Adjusting humanity for bandit kill by %2 for %1",_aikiller,SAR_band_kill_value];};
        _humanity = _aikiller getVariable ["humanity",0];
        _humanity = _humanity + SAR_band_kill_value;
        _aikiller setVariable["humanity", _humanity,true];
        if(SAR_log_AI_kills) then {
            _banditkills = _aikiller getVariable["banditKills",0];
            _aikiller setVariable["banditKills",_banditkills+1,true];        
        };
        
        if ((random 100) < 3) then {
            _message = format["nice bandit kill %1!",_aikiller_name];
            [nil, nil, rspawn, [[West,"airbase"], _message], { (_this select 0) sideChat (_this select 1) }] call RE;
        } else {
            if ((random 100) < 3) then {
                _message = format["another bandit down ... %1 is going to be the root cause of bandit extinction :-)",_aikiller_name];
                [nil, nil, rspawn, [[West,"airbase"], _message], { (_this select 0) sideChat (_this select 1) }] call RE;
            };
        };
        if ((random 100) < 2) then {
            _message = "SRY CAPS ...";
            [nil, nil, rspawn, [[West,"airbase"], _message], { (_this select 0) sideChat (_this select 1) }] call RE;
        };
        
    };

} else {

    if(SAR_AI_XP_SYSTEM) then {
    
        if(!isNull _aikiller) then { // check if AI was killed by an AI, and not driven over / fallen to death etc
            
            // get xp from the victim
            _xp_gain = _ai_xp;

            if(_xp_gain == 0) then {
                _xp_gain=1;
            };
        
            // get old xp
            _ai_killer_xp = _aikiller getVariable["SAR_AI_experience",0];
            
            // calculate new xp
            _ai_killer_xp_new = _ai_killer_xp + _xp_gain;
            
            if(_ai_killer_xp < SAR_AI_XP_LVL_3) then {
            
                if(_ai_killer_xp < SAR_AI_XP_LVL_2 && _ai_killer_xp_new >= SAR_AI_XP_LVL_2 ) then { // from level 1 to level 2
                
                    if(SAR_SHOW_XP_LVL) then { diag_log format["Level up from 1 -> 2 for %1",_aikiller];};

                    _message = format["A %1 %2 was promoted!",_ai_killer_xp_type,_ai_killer_type];
                    [nil, nil, rspawn, [[West,"airbase"], _message], { (_this select 0) sideChat (_this select 1) }] call RE;

                    
                    // restore health to full
                    _aikiller setDamage 0;

                    // upgrades for the next level

                    // medium armor
                    _aikiller removeEventHandler ["HandleDamage",0];
                    _aikiller addEventHandler ["HandleDamage",{if (_this select 1!="") then {_unit=_this select 0;damage _unit+((_this select 2)-damage _unit)*SAR_AI_XP_ARMOR_2}}];

                    //debug
                    if(SAR_SHOW_XP_LVL) then {
                    
                        _tmp = createvehicle ["Sign_sphere25cm_EP1",getPos _aikiller,[],0,"NONE"];
                        sleep 0.5;
                        
                        _sphere_alpha = 1;
                        _sphere_red = 1;
                        _sphere_green= 1;
                        _sphere_blue=0;
                        
                        _obj_text_string = format["#(argb,8,8,3)color(%1,%2,%3,%4,ca)",_sphere_red,_sphere_green,_sphere_blue,_sphere_alpha];
                        
                        [nil,nil,rSETOBJECTTEXTURE,_tmp,0,_obj_text_string] call RE;
                        
                        _tmp allowDamage false;
                        
                        _tmp attachTo [_aikiller,[0,0,2]];
                        
                        _aikiller setVariable ["SAR_sphere_id",_tmp,true];
                    
                    };
                    
                };
                
                if(_ai_killer_xp < SAR_AI_XP_LVL_3 && _ai_killer_xp_new >= SAR_AI_XP_LVL_3 ) then { // from level 2 to level 3


                    if(SAR_SHOW_XP_LVL) then { diag_log format["Level up from 2 -> 3 for %1",_aikiller];};

                    _message = format["A %1 %2 was promoted!",_ai_killer_xp_type,_ai_killer_type];
                    [nil, nil, rspawn, [[West,"airbase"], _message], { (_this select 0) sideChat (_this select 1) }] call RE;

                    
                    // restore health to full
                    _aikiller setDamage 0;

                    // upgrades for the next level
                    
                    // highest armor
                    _aikiller removeEventHandler ["HandleDamage",0];
                    _aikiller addEventHandler ["HandleDamage",{if (_this select 1!="") then {_unit=_this select 0;damage _unit+((_this select 2)-damage _unit)*SAR_AI_XP_ARMOR_3}}];
                    
                    // skill array
                    
                    
                    // debug
                    
                    if(SAR_SHOW_XP_LVL) then {
                    
                        _tmp = _aikiller getVariable ["SAR_sphere_id",objNull];
                        
                        _sphere_alpha = 1;
                        _sphere_red = 1;
                        _sphere_green= 0;
                        _sphere_blue=0;
                        
                        _obj_text_string = format["#(argb,8,8,3)color(%1,%2,%3,%4,ca)",_sphere_red,_sphere_green,_sphere_blue,_sphere_alpha];
                        
                        [nil,nil,rSETOBJECTTEXTURE,_tmp,0,_obj_text_string] call RE;
                    
                    };
                    
                };
            
            };
            
            //diag_log format["Start XP: %1, End XP: %2",_ai_killer_xp,_ai_killer_xp+_xp_gain];
                        
            // set new xp value for AI that killed the other AI
            _ai_killer_xp = _ai_killer_xp + _xp_gain;
            _aikiller setVariable["SAR_AI_experience",_ai_killer_xp];
            
        };    

    };

};