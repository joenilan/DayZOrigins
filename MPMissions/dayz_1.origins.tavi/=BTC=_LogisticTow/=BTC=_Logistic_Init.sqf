/*
Created by =BTC= Giallustio
Version: 0.52
Date: 05/02/2012
Visit us at: http://www.blacktemplars.altervista.org/
You are not allowed to modify this file and redistribute it without permission given by me (Giallustio).
*/
//tow
BTC_tow_driver   = ["US_Soldier_driver_EP1"];
BTC_tow         = 1;
BTC_towed       = 0;
BTC_tow_min_h   = 7;
BTC_tow_max_h   = 12;
BTC_tow_radius  = 2;
BTC_cargo_towed = objNull;
BTC_towable     = ["LandVehicle","car","Air","Ship","Motorcycle","Helicopter","Chopper"];
BTC_Hud_Cond     = false;
BTC_HUD_x        = (SafeZoneW+2*SafeZoneX) + 0.045;
BTC_HUD_y        = (SafeZoneH+2*SafeZoneY) + 0.045;
_tow = [] execVM "=BTC=_LogisticTow\=BTC=_tow\=BTC=_towInit.sqf";
//Cargo System
BTC_Obj_Dragged      = objNull;
BTC_Veh_Selected     = objNull;
BTC_Dragging         = false;
BTC_Draggable        = ["ReammoBox"];
BTC_Load_In_Vehicles = ["Tank","Wheeled_APC","Truck","Car","Helicopter","C130J","C130J_US_EP1"];
{if (format ["%1", _x getVariable "BTC_Cannot_Drag"] != "1") then {_name = getText (configFile >> "cfgVehicles" >> typeof _x >> "displayName");_x addAction [("<t color=""#ED2744"">" + "Drag " + (_name) + "</t>"),"=BTC=_Logistic\=BTC=_Cargo_System\=BTC=_Drag.sqf", "", 7, true, true];};} foreach (nearestObjects [player, BTC_Draggable, 50000]);
//Functions
BTC_get_towable_array =
{
	_LandVehicle = _this select 0;
	_array   = [];
	switch (typeOf _LandVehicle) do
	{
	 case "UAZ_Unarmed_TK_EP1"    : {_array = ["Air","LandVehicle","car","AH64D_EP1","Mi24_D","Mi24_P","Mi24_V","AH6X_DZ","UH1H_DZ","Ship","Motorcycle","A10_US_EP1","AH1Z","MH60S","A10","AV8B2","Su39","kh_maule_m7_white","AN2_DZ","Su34","Su34"];};
     case "UAZ_Unarmed_TK_CIV_EP1"    : {_array = ["Air","LandVehicle","car","AH64D_EP1","Mi24_D","Mi24_P","Mi24_V","AH6X_DZ","UH1H_DZ","Ship","Motorcycle","A10_US_EP1","AH1Z","MH60S","A10","AV8B2","Su39","kh_maule_m7_white","AN2_DZ","Su34"];};
     case "UAZ_Unarmed_UN_EP1"    : {_array = ["Air","LandVehicle","car","AH64D_EP1","Mi24_D","Mi24_P","Mi24_V","AH6X_DZ","UH1H_DZ","Ship","Motorcycle","A10_US_EP1","AH1Z","MH60S","A10","AV8B2","Su39","kh_maule_m7_white","AN2_DZ","Su34"];};
     case "UAZ_RU"    : {_array = ["Air","LandVehicle","car","AH64D_EP1","Mi24_D","Mi24_P","Mi24_V","AH6X_DZ","UH1H_DZ","Ship","Motorcycle","A10_US_EP1","AH1Z","MH60S","A10","AV8B2","Su39","kh_maule_m7_white","AN2_DZ","Su34"];};
     case "ATV_US_EP1"    : {_array = ["Air","LandVehicle","car","AH64D_EP1","Mi24_D","Mi24_P","Mi24_V","AH6X_DZ","UH1H_DZ","Ship","Motorcycle","A10_US_EP1","AH1Z","MH60S","A10","AV8B2","Su39","kh_maule_m7_white","AN2_DZ","Su34"];};
	 case "rth_copter_green"    : {_array = ["Air","LandVehicle","car","AH64D_EP1","Mi24_D","Mi24_P","Mi24_V","AH6X_DZ","UH1H_DZ","Ship","Motorcycle","A10_US_EP1","AH1Z","MH60S","A10","AV8B2","Su39","kh_maule_m7_white","AN2_DZ","Su34","Su34"];};
	 case "rth_copter_yellow"    : {_array = ["Air","LandVehicle","car","AH64D_EP1","Mi24_D","Mi24_P","Mi24_V","AH6X_DZ","UH1H_DZ","Ship","Motorcycle","A10_US_EP1","AH1Z","MH60S","A10","AV8B2","Su39","kh_maule_m7_white","AN2_DZ","Su34","Su34"];};
	};
	_array
};
BTC_obj_fall =
{
	_obj    = _this select 0;
	_height = getPos _obj select 2;
	_fall   = 0.09;
	while {(getPos _obj select 2) > 1} do 
	{

		_fall = (_fall * 1.1);
		_obj setPos [getPos _obj select 0, getPos _obj select 1, _height];
		_height = _height - _fall;
		sleep 0.01;
	};
	_obj setPos [getPos _obj select 0, getPos _obj select 1, 0];
};
BTC_paradrop =
{
	_Veh          = _this select 0;
	_dropped      = _this select 1;
	_chute_type   = _this select 2;
	private ["_chute"];
	_dropped_type = typeOf _dropped;
	if (typeOf _Veh == "MH6J_EP1") then {_chute = createVehicle [_chute_type, [((position _Veh) select 0) - 5,((position _Veh) select 1) - 10,((position _Veh) select 2)- 4], [], 0, "NONE"];} else {_chute = createVehicle [_chute_type, [((position _Veh) select 0) - 5,((position _Veh) select 1) - 3,((position _Veh) select 2)- 4], [], 0, "NONE"];};
	_smoke        = "SmokeshellGreen" createVehicle position _Veh;
    _smoke attachto [_dropped,[0,0,0]]; 
	_dropped attachTo [_chute,[0,0,0]];
	while {getPos _chute select 2 > 2} do {sleep 1;};
	detach _dropped;
	if (_dropped_type isKindOf "ReammoBox") then {_dropped setPosATL [getpos _dropped select 0, getpos _dropped select 1, 0];};
};
BTC_hint = {_text  = _this select 0;_sleep = _this select 1;hintSilent _text;sleep _sleep;hintSilent "";};