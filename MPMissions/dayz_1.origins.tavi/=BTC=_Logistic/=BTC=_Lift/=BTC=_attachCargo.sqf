/*
Created by =BTC= Giallustio
Version: 0.52
Date: 05/02/2012
Visit us at: http://www.blacktemplars.altervista.org/
You are not allowed to modify this file and redistribute it without permission given by me (Giallustio).
*/
_chopper = vehicle player;
_chopper removeAction BTC_liftActionId;
BTC_lifted    = 1;
BTC_dropcargo = 0;
_cargo_pos    = getPosATL BTC_cargo_lifted;
_rel_pos      = _chopper worldToModel _cargo_pos;
_height       = (_rel_pos select 2) + 2.5;
BTC_cargo_lifted attachTo [_chopper, [0,0,_height]];
_name_cargo  = getText (configFile >> "cfgVehicles" >> typeof BTC_cargo_lifted >> "displayName");
vehicle player vehicleChat format ["%1 lifted", _name_cargo];
_text_action = ("<t color=""#ED2744"">" + "Drop " + (_name_cargo) + "</t>");
BTC_SganciaActionId = _chopper addAction [_text_action,"=BTC=_Logistic\=BTC=_Lift\=BTC=_detachCargo.sqf", "", 7, false, false];
if (true) exitWith {}; 