/*
Created by =BTC= Giallustio
Version: 0.52
Date: 05/02/2012
Visit us at: http://www.blacktemplars.altervista.org/
You are not allowed to modify this file and redistribute it without permission given by me (Giallustio).
*/
if (isDedicated) exitwith {};
_cond = true;
if ((count BTC_lift_pilot) > 0) then 
{
	if ((BTC_lift_pilot find (typeof player)) == - 1) exitWith {hint "No lift";_cond = false;};
};
if !(_cond) exitWith {hint "No lift";};
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
_chopper = objNull;_cargo_pos = [];_rel_pos = [];_cargo_x = 0;_cargo_y = 0;_cargo_z = 0;
while {true} do 
{
	if (!Alive player) then {{_x ctrlShow false} foreach _array_hud;};
	if (BTC_Hud_Cond) then {{_x ctrlShow false} foreach _array_hud;BTC_Hud_Cond = false;};
	waitUntil {sleep 1; (vehicle player != player && vehicle player iskindof "Helicopter" && ((count([vehicle player] call BTC_Get_liftable_array)) > 0))};
	if (!(vehicle player == player) && driver vehicle player == player) then {_chopper = vehicle player;BTC_liftHudId = _chopper addAction [("<t color=""#ED2744"">" + ("Hud On\Off") + "</t>"),"=BTC=_Logistic\=BTC=_Lift\=BTC=_Hud.sqf", "", 0, false, false];};
	_array = [vehicle player] call BTC_get_liftable_array;
	while {!(vehicle player == player) && driver vehicle player == player} do
	{
		_chopper  = vehicle player;
		_can_lift = false;
		_cargo_array = nearestObjects [_chopper, BTC_Liftable, 50];
		if (count _cargo_array > 1) then {_cargo = _cargo_array select 1;} else {_cargo = objNull;};
		if (({_cargo isKindOf _x} count _array) > 0) then {_can_lift = true;};
		if (!BTC_Hud_Cond && BTC_Hud_Shown) then {{_x ctrlShow false} foreach _array_hud;BTC_Hud_Shown = false;};
		if (_cargo isKindOf "Air" && getdammage _cargo != 1) then {_can_lift = false;};
		if (!isNull _cargo && _can_lift) then
		{
			_cargo_pos = getPosATL _cargo;
			_rel_pos   = _chopper worldToModel _cargo_pos;
			_cargo_x   = _rel_pos select 0;
			_cargo_y   = _rel_pos select 1;
			_cargo_z   = _rel_pos select 2;
		};
		if (!isNull _cargo && BTC_Hud_Cond) then
		{
			if !(BTC_Hud_Shown) then {{_x ctrlShow true} foreach _array_hud;BTC_Hud_Shown = true;};
			if (_can_lift) then 
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
			if ((abs _cargo_z) > BTC_lift_max_h) then {_arrow ctrlSetText "\ca\ui\data\arrow_down_ca.paa";};
			if ((abs _cargo_z) < BTC_lift_min_h) then {_arrow ctrlSetText "\ca\ui\data\arrow_up_ca.paa";};
			if ((abs _cargo_z) > BTC_lift_min_h && (abs _cargo_z) < BTC_lift_max_h) then {_arrow ctrlSetText "\ca\ui\data\objective_complete_ca.paa";};
			if (!_can_lift && BTC_Hud_Cond) then {_arrow ctrlSetText "\ca\ui\data\objective_incomplete_ca.paa";};
		} else {{_x ctrlShow false} foreach _array_hud;BTC_Hud_Shown = false;};		
		if (!isNull _cargo && BTC_lifted == 0 && _can_lift && format ["%1", _cargo getVariable "BTC_Cannot_Lift"] != "1") then 
		{
			if (((abs _cargo_z) < BTC_lift_max_h) && ((abs _cargo_z) > BTC_lift_min_h) && ((abs _cargo_x) < BTC_lift_radius) && ((abs _cargo_y) < BTC_lift_radius)) then
			{
				BTC_cargo_lifted = _cargo;
				_name_cargo  = getText (configFile >> "cfgVehicles" >> typeof _cargo >> "displayName");
				_text_action = ("<t color=""#ED2744"">" + "Lift " + (_name_cargo) + "</t>");
				if (BTC_lifted == 1) then {_chopper removeAction BTC_liftActionId;};
				if (BTC_lifted == 0 && BTC_lift == 1) then
				{
					BTC_liftActionId = _chopper addAction [_text_action,"=BTC=_Logistic\=BTC=_Lift\=BTC=_attachCargo.sqf", "", 7, true, true];
					BTC_lift = 0;
				};
			};
			if (BTC_lift == 0 && (((abs _cargo_z) > BTC_lift_max_h) || ((abs _cargo_z) < BTC_lift_min_h) || ((abs _cargo_x) > BTC_lift_radius) || ((abs _cargo_y) > BTC_lift_radius))) then 
			{
				_chopper removeAction BTC_liftActionId;
				BTC_lift = 1;
			};
		};
		sleep 0.1;
	};
	_chopper removeAction BTC_liftHudId;
	if (BTC_lift == 0) then {_chopper removeAction BTC_liftActionId;BTC_lift = 1;};
};

if (true) exitWith {}; 