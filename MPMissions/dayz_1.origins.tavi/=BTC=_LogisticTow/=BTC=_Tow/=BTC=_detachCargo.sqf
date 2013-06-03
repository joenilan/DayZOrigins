/*
Created by =BTC= Giallustio
Version: 0.52
Date: 05/02/2012
Visit us at: http://www.blacktemplars.altervista.org/
You are not allowed to modify this file and redistribute it without permission given by me (Giallustio).
*/
BTC_towed = 0;
_LandVehicle   = vehicle player;
_cargo     = (nearestObjects [_LandVehicle, BTC_towable, 50]) select 1;
_LandVehicle removeAction BTC_SganciaActionId;
detach _cargo;
_name_cargo  = getText (configFile >> "cfgVehicles" >> typeof _cargo >> "displayName");
vehicle player vehicleChat format ["%1 dropped", _name_cargo];
if (_cargo isKindOf "ReammoBox" || _cargo isKindOf "Static" || _cargo isKindOf "StaticWeapon" || _cargo isKindOf "Strategic" || _cargo isKindOf "Land_HBarrier_large") then {_obj_fall = [_cargo] spawn BTC_Obj_Fall;};
if (true) exitWith {}; 