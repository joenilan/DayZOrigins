/*
Created by =BTC= Giallustio
Version: 0.52
Date: 05/02/2012
Visit us at: http://www.blacktemplars.altervista.org/
You are not allowed to modify this file and redistribute it without permission given by me (Giallustio).
*/
_veh    = _this select 0;
_id     = _this select 2;
_height = getPos _veh select 2;
if (vehicle player == player && player distance _veh > 6) exitWith {_hint = ["You are too distance from the vehicle to unload the object!",2] spawn BTC_Hint;};
if (vehicle player != player && driver _veh != player) exitWith {_hint = ["Only the driver of the vehicle can unload the object from inside!",2] spawn BTC_Hint;};
if (speed _veh > 1 && _height < 2) exitWith {_hint = ["Stop the vehicle to unload the object!",2] spawn BTC_Hint;};
_veh setVehicleInit format ["this removeAction %1",_id];ProcessInitCommands;
if (getdammage _veh == 1) exitWith {_hint = ["The object has been destroyed!",2] spawn BTC_Hint;};
_type        = _veh getVariable "BTC_Veh_contenent";
_ammo_cont   = _veh getVariable "BTC_Veh_ammo";
_weapon_cont = _veh getVariable "BTC_Veh_weapon";
_obj = _type createVehicle [0,0,0];
switch (true) do
{
	case (_height >= 20):
	{
		_obj_para = [_veh,_obj,"ParachuteMediumWest_EP1"] spawn BTC_Paradrop;
		WaitUntil {ScriptDone _obj_para};
	};
	case ((_height < 20) && (_height >= 2)):
	{
		_obj setPos [getpos _veh select 0,getpos _veh select 1,(getpos _veh select 2) -1];
		sleep 0.1;
		_obj_fall = [_obj] spawn BTC_Obj_Fall;
		WaitUntil {ScriptDone _obj_fall};
	};
	case (_height < 2):
	{
		if (vehicle player != player) then {_obj attachTo [vehicle player,[-2.5,0,0]];} else {_obj attachTo [vehicle player,[2,0,0]];};
		sleep 0.1;
		detach _obj;
		_obj setPosATL [getpos _obj select 0,getpos _obj select 1,0];
	};
};

clearMagazineCargoGlobal _obj;
clearWeaponCargoGlobal _obj;
if ((count (_ammo_cont select 0)) > 0) then 
{
	for "_i" from 0 to (count (_ammo_cont select 0) - 1) do
	{
		_obj addMagazineCargoGlobal [(_ammo_cont select 0) select _i,(_ammo_cont select 1) select _i];
	};
};
if ((count (_weapon_cont select 0)) > 0) then 
{
	for "_i" from 0 to (count (_weapon_cont select 0) - 1) do
	{
		_obj addweaponCargoGlobal [(_weapon_cont select 0) select _i,(_weapon_cont select 1) select _i];
	};
};
_veh setVariable ["BTC_Veh_contenent","",true];
_veh setVariable ["BTC_Veh_ammo",[],true];
_veh setVariable ["BTC_Veh_weapon",[],true];
_veh setVariable ["BTC_Veh_Full",0,true];
_name = getText (configFile >> "cfgVehicles" >> typeof _obj >> "displayName");
_text_action = "this addAction [" + """" + "<t color=""""#ED2744"""">" + "Drag " + (_name) + "</t>" + """" + ",""=BTC=_Logistic\=BTC=_Cargo_System\=BTC=_Drag.sqf"", """", 7, true, true]";
_obj setVehicleInit _text_action;ProcessInitCommands;