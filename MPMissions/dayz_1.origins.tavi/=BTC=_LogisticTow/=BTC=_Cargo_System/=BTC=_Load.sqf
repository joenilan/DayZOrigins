/*
Created by =BTC= Giallustio
Version: 0.52
Date: 05/02/2012
Visit us at: http://www.blacktemplars.altervista.org/
You are not allowed to modify this file and redistribute it without permission given by me (Giallustio).
*/
_id = _this select 2;
_array = nearestObjects [player, BTC_Load_In_Vehicles, 5];
_veh   = _array select 0;
if (format ["%1", _veh getVariable "BTC_Veh_Full"] == "1") exitWith {_hint = ["An object is already loaded in that vehicle!",3] spawn BTC_Hint;};
player removeAction _id;
player playMove "acinpknlmstpsraswrfldnon_amovpknlmstpsraswrfldnon";
BTC_Dragging = false;
_type_obj = typeOf BTC_Obj_Dragged;
_ammo     = getMagazineCargo BTC_Obj_Dragged;
_weapon   = getWeaponCargo BTC_Obj_Dragged; 
_name_obj        = getText (configFile >> "cfgVehicles" >> typeof BTC_Obj_Dragged >> "displayName");
_text_action     = "this addAction [" + """" + "<t color=""""#ED2744"""">" + "Unload " + (_name_obj) + "</t>" + """" + ",""=BTC=_Logistic\=BTC=_Cargo_System\=BTC=_Unload.sqf"", """", 0, true, true]";
deleteVehicle BTC_Obj_Dragged;
BTC_Obj_Dragged = ObjNull;
_veh setVariable ["BTC_Veh_contenent",_type_obj,true];
_veh setVariable ["BTC_Veh_ammo",_ammo,true];
_veh setVariable ["BTC_Veh_weapon",_weapon,true];
_veh setVariable ["BTC_Veh_Full",1,true];
_veh setVehicleInit _text_action;ProcessInitCommands;