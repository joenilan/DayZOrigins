/*
Created by =BTC= Giallustio
Version: 0.52
Date: 05/02/2012
Visit us at: http://www.blacktemplars.altervista.org/
You are not allowed to modify this file and redistribute it without permission given by me (Giallustio).
*/
BTC_Obj_Dragged = _this select 0;
if (BTC_Obj_Dragged distance player > 3) exitWith {_hint = ["Too distance from the object!",2] spawn BTC_Hint;BTC_Obj_Dragged = objNull;};
if (BTC_Dragging) exitWith {_hint = ["You can't drag more than one object!",2] spawn BTC_Hint;};
if (format ["%1", BTC_Obj_Dragged getVariable "BTC_Being_Drag"] == "1") exitWith {_hint = ["You can't drag this object! it's being dragged!",2] spawn BTC_Hint;};
BTC_Dragging = true;
BTC_Obj_Dragged setvariable ["BTC_Being_Drag",1,true];
player playMove "acinpknlmstpsraswrfldnon";
BTC_Obj_Dragged attachto [player,[0,1,0.2]];
sleep 0.1;
if ((position BTC_Obj_Dragged select 2) < - 0.5) then {BTC_Obj_Dragged attachto [player,[0,1,1.2]];};
_hint = ["Press X to release!",2] spawn BTC_Hint;
WaitUntil {!Alive player || ((animationstate player == "acinpknlmstpsraswrfldnon") || (animationstate player == "acinpknlmwlksraswrfldb"))};
_act  = 0;
While {BTC_Dragging && vehicle player == player && Alive player && (animationstate player == "acinpknlmstpsraswrfldnon") || (animationstate player == "acinpknlmwlksraswrfldb")} do
{
	_array = nearestObjects [player, BTC_Load_In_Vehicles, 5];
	if (count _array == 0) then {BTC_Veh_Selected = objNull;};
	if (count _array > 0 && BTC_Veh_Selected != _array select 0) then 
	{
		BTC_Veh_Selected = _array select 0;
		_name_veh        = getText (configFile >> "cfgVehicles" >> typeof BTC_Veh_Selected >> "displayName");
		_text_action     = ("<t color=""#ED2744"">" + "Load in " + (_name_veh) + "</t>");
		BTC_loadActionId = player addAction [_text_action,"=BTC=_Logistic\=BTC=_Cargo_System\=BTC=_Load.sqf", "", 7, true, true];
		_act  = 1;
	};
	if (count _array == 0 && _act == 1) then {player removeAction BTC_loadActionId;_act = 0;};
	sleep 0.1;
};
if (_act == 1) then {player removeAction BTC_loadActionId;_act = 0;BTC_Veh_Selected = objNull;};
if !(isNull BTC_Obj_Dragged) then 
{
	detach BTC_Obj_Dragged;
	_rel_pos = player modelToWorld [0,1,0];
	BTC_Obj_Dragged setpos _rel_pos;
	BTC_Obj_Dragged setvariable ["BTC_Being_Drag",0,true];
	BTC_Obj_Dragged = objNull;
};
hintSilent "";
BTC_Dragging = false;