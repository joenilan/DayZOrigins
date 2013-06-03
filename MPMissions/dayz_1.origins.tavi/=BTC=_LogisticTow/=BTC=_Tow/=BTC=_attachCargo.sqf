/*
Created by =BTC= Giallustio
Version: 0.52
Date: 05/02/2012
Visit us at: http://www.blacktemplars.altervista.org/
You are not allowed to modify this file and redistribute it without permission given by me (Giallustio).
*/
_LandVehicle = vehicle player;
_LandVehicle removeAction BTC_towActionId;
BTC_towed    = 1;
BTC_dropcargo = 0;
_cargo_pos    = getPosATL BTC_cargo_towed;
_rel_pos      = _LandVehicle worldToModel _cargo_pos;
_height       = (_rel_pos select 2) + 2.5;
BTC_cargo_towed attachTo [_LandVehicle, [0,-12,.15]];
_name_cargo  = getText (configFile >> "cfgVehicles" >> typeof BTC_cargo_towed >> "displayName");
vehicle player vehicleChat format ["%1 towed", _name_cargo];
_text_action = ("<t color=""#ED2744"">" + "Drop " + (_name_cargo) + "</t>");
BTC_SganciaActionId = _LandVehicle addAction [_text_action,"=BTC=_LogisticTow\=BTC=_tow\=BTC=_detachCargo.sqf", "", 7, false, false];
if (true) exitWith {}; 