/*
Created by =BTC= Giallustio
Version: 0.52
Date: 05/02/2012
Visit us at: http://www.blacktemplars.altervista.org/
You are not allowed to modify this file and redistribute it without permission given by me (Giallustio).
*/
if (isDedicated) exitwith {};
_cond = true;
if ((count BTC_tow_driver) > 0) then 
{
	if ((BTC_tow_driver find (typeof player)) == - 1) exitWith {hint "No tow";_cond = false;};
};
if !(_cond) exitWith {hint "No tow";};
disableSerialization;
_cargo = objNull;
BTC_Hud_Shown = false;
cutRsc ["BTC_Hud","PLAIN"];
_ui        = uiNamespace getVariable "HUD";
_radar     = _ui displayCtrl 1001;
_obj_img   = _ui displayCtrl 1002;
_obj_pic   = _ui displayCtrl 1003;
_arrow     = _ui displayCtrl 1004;
_obj_name  = _ui displayCtrl 1005;
_array_hud = [_radar,_obj_img,_obj_pic,_arrow,_obj_name];
{_x ctrlShow false} foreach _array_hud;
_LandVehicle = objNull;_cargo_pos = [];_rel_pos = [];_cargo_x = 0;_cargo_y = 0;_cargo_z = 0;
while {true} do 
{
	if (!Alive player) then {{_x ctrlShow false} foreach _array_hud;};
	if (BTC_Hud_Cond) then {{_x ctrlShow false} foreach _array_hud;BTC_Hud_Cond = false;};
	waitUntil {sleep 1; (vehicle player != player && vehicle player iskindof "LandVehicle" && ((count([vehicle player] call BTC_Get_towable_array)) > 0))};
	if (!(vehicle player == player) && driver vehicle player == player) then {_LandVehicle = vehicle player;BTC_towHudId = _LandVehicle addAction [("<t color=""#ED2744"">" + ("Hud On\Off") + "</t>"),"=BTC=_LogisticTow\=BTC=_tow\=BTC=_Hud.sqf", "", 0, false, false];};
	_array = [vehicle player] call BTC_get_towable_array;
	while {!(vehicle player == player) && driver vehicle player == player} do
	{
		_LandVehicle  = vehicle player;
		_can_tow = false;
		_cargo_array = nearestObjects [_LandVehicle, BTC_towable, 50];
		if (count _cargo_array > 1) then {_cargo = _cargo_array select 1;} else {_cargo = objNull;};
		if (({_cargo isKindOf _x} count _array) > 0) then {_can_tow = true;};
		if (!BTC_Hud_Cond && BTC_Hud_Shown) then {{_x ctrlShow false} foreach _array_hud;BTC_Hud_Shown = false;};
		if (_cargo isKindOf "StaticWeapon" && getdammage _cargo != 1) then {_can_tow = false;};
		if (!isNull _cargo && _can_tow) then
		{
			_cargo_pos = getPosATL _cargo;
			_rel_pos   = _LandVehicle worldToModel _cargo_pos;
			_cargo_x   = _rel_pos select 0;
			_cargo_y   = _rel_pos select 1;
			_cargo_z   = _rel_pos select 2;
		};
		if (!isNull _cargo && BTC_Hud_Cond) then
		{
			if !(BTC_Hud_Shown) then {{_x ctrlShow true} foreach _array_hud;BTC_Hud_Shown = true;};
			if (_can_tow) then 
			{
				_obj_img ctrlShow true;
				_hud_x   = (_rel_pos select 0) / 100;
				_rel_y   = (_rel_pos select 1);
				_hud_y   = 0;
				switch (true) do
				{
					case (_rel_y < 0): {_hud_y = (abs _rel_y) / 100};
					case (_rel_y > 0): {_hud_y = (0 - _rel_y) / 100};
				};
				_hud_x_1 = BTC_HUD_x + _hud_x;
				_hud_y_1 = BTC_HUD_y + _hud_y;
				_obj_img ctrlsetposition [_hud_x_1, _hud_y_1];
				_obj_img ctrlCommit 0;
			} else {_obj_img ctrlShow false;};
			_pic_cargo = "";
			if (_cargo isKindOf "LandVehicle") then {_pic_cargo = getText (configFile >> "cfgVehicles" >> typeof _cargo >> "picture");} else {_pic_cargo = "";};
			_name_cargo = getText (configFile >> "cfgVehicles" >> typeof _cargo >> "displayName");
			_obj_pic ctrlSetText _pic_cargo;
			_obj_name ctrlSetText _name_cargo;
			if ((abs _cargo_z) > BTC_tow_max_h) then {_arrow ctrlSetText "\ca\ui\data\arrow_down_ca.paa";};
			if ((abs _cargo_z) < BTC_tow_min_h) then {_arrow ctrlSetText "\ca\ui\data\arrow_up_ca.paa";};
			if ((abs _cargo_z) > BTC_tow_min_h && (abs _cargo_z) < BTC_tow_max_h) then {_arrow ctrlSetText "\ca\ui\data\objective_complete_ca.paa";};
			if (!_can_tow && BTC_Hud_Cond) then {_arrow ctrlSetText "\ca\ui\data\objective_incomplete_ca.paa";};
		} else {{_x ctrlShow false} foreach _array_hud;BTC_Hud_Shown = false;};		
		if (!isNull _cargo && BTC_towed == 0 && _can_tow && format ["%1", _cargo getVariable "BTC_Cannot_tow"] != "1") then 
		{
			if (((abs _cargo_z) < BTC_tow_max_h) && ((abs _cargo_z) > BTC_tow_min_h) && ((abs _cargo_x) < BTC_tow_radius) && ((abs _cargo_y) < BTC_tow_radius)) then
			{
				BTC_cargo_towed = _cargo;
				_name_cargo  = getText (configFile >> "cfgVehicles" >> typeof _cargo >> "displayName");
				_text_action = ("<t color=""#ED2744"">" + "tow " + (_name_cargo) + "</t>");
				if (BTC_towed == 1) then {_LandVehicle removeAction BTC_towActionId;};
				if (BTC_towed == 0 && BTC_tow == 1) then
				{
					BTC_towActionId = _LandVehicle addAction [_text_action,"=BTC=_LogisticTow\=BTC=_tow\=BTC=_attachCargo.sqf", "", 7, true, true];
					BTC_tow = 0;
				};
			};
			if (BTC_tow == 0 && (((abs _cargo_z) > BTC_tow_max_h) || ((abs _cargo_z) < BTC_tow_min_h) || ((abs _cargo_x) > BTC_tow_radius) || ((abs _cargo_y) > BTC_tow_radius))) then 
			{
				_LandVehicle removeAction BTC_towActionId;
				BTC_tow = 1;
			};
		};
		sleep 0.1;
	};
	_LandVehicle removeAction BTC_towHudId;
	if (BTC_tow == 0) then {_LandVehicle removeAction BTC_towActionId;BTC_tow = 1;};
};

if (true) exitWith {}; 