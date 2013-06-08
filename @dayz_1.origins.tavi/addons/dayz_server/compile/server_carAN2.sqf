//Animated Helicrashs for DayZ 1.7.6.1
//Version 0.2
//Release Date: 05. April 2013
//Author: Grafzahl
//Thread-URL: http://opendayz.net/threads/animated-helicrashs-0-1-release.9084/

private["_useStatic","_crashDamage","_lootRadius","_preWaypoints","_preWaypointPos","_endTime","_startTime","_heliStart","_deadBody","_exploRange","_heliModel","_lootPos","_list","_craters","_dummy","_wp2","_wp3","_landingzone","_aigroup","_wp","_helipilot","_crash","_crashwreck","_smokerand","_staticcoords","_pos","_dir","_position","_num","_config","_itemType","_itemChance","_weights","_index","_iArray","_crashModel","_lootTable","_guaranteedLoot","_randomizedLoot","_frequency","_variance","_spawnChance","_spawnMarker","_spawnRadius","_spawnFire","_permanentFire","_crashName", "_aaa", "_blacklist"];

//_crashModel	= _this select 0;
//_lootTable	= _this select 1;
_guaranteedLoot = _this select 0;
_randomizedLoot = _this select 1;
_frequency	= _this select 2;
_variance	= _this select 3;
_spawnChance	= _this select 4;
_spawnMarker	= _this select 5;
_spawnRadius	= _this select 6;
_spawnFire	= _this select 7;
_fadeFire	= _this select 8;
_randomizedWP	= _this select 9;
_guaranteedWP	= _this select 10;

_chutetype = "ParachuteMediumEast";
_boxtype = "hilux1_civil_2_covered";
_useStatic = false;





if(count _this > 11) then {
	_crashDamage = _this select 11;
} else {
	_crashDamage = 1;
};


diag_log(format["CARDROP: Starting spawn logic for animated AN2 Carepackage drops - written by Grafzahl, modded by fofinho [CD:%1]", _crashDamage]);

while {true} do {

	_preWaypoints = round(random _randomizedWP) + _guaranteedWP;
	
	private["_timeAdjust","_timeToSpawn","_spawnRoll","_crash","_hasAdjustment","_newHeight","_adjustedPos"];
	// Allows the variance to act as +/- from the spawn frequency timer
	_timeAdjust = round(random(_variance * 2) - _variance);
	_timeToSpawn = time + _frequency + _timeAdjust;

	//Random Heli-Type
	_heliModel = "AN2_DZ";

	//Random-Startpositions, Adjust this for other Maps then Chernarus
	_heliStart = [[6993.7007,173.05298,300],[1623.715,218.18848,300]] call BIS_fnc_selectRandom;


	_crashName	= getText (configFile >> "CfgVehicles" >> _heliModel >> "displayName");

	diag_log(format["CARDROP: %1%2 chance to start a %3 Carepackagedrop at %4 with %5 drop points", round(_spawnChance * 100), '%', _crashName, _timeToSpawn, _preWaypoints]);

	// Apprehensive about using one giant long sleep here given server time variances over the life of the server daemon
	while {time < _timeToSpawn} do {
		sleep 5;
	};

	_spawnRoll = random 1;

	// Percentage roll
	if (_spawnRoll <= _spawnChance) then {

		//Spawn the AI-Heli flying in the air
		_startTime = time;
		_crashwreck = createVehicle [_heliModel,_heliStart, [], 0, "FLY"];

		//Make sure its not destroyed by the Hacker-Killing-Cleanup (Thanks to Sarge for the hint)
		_crashwreck setVariable["Sarge",1];

		_crashwreck engineOn true;
		_crashwreck flyInHeight 100;
		_crashwreck forceSpeed 160;
		_crashwreck setspeedmode "NORMAL";

		/*
		//Create an Invisibile Landingpad at the Crashside-Coordinates
		_landingzone = createVehicle ["HeliHEmpty", [_position select 0, _position select 1], [], 0, "CAN_COLLIDE"];
		_landingzone setVariable["Sarge",1];
		*/
		
		//Only a Woman could crash a Heli this way...
		_aigroup = creategroup civilian;
		_helipilot = _aigroup createUnit ["SurvivorW2_DZ",getPos _crashwreck,[],0,"FORM"];
		_helipilot moveindriver _crashwreck;
		_helipilot assignAsDriver _crashwreck;

		sleep 0.5;

		
		_unsorted = [];
		
		for "_x" from 1 to _preWaypoints do {
			
			_preWaypointPos = [[1015.44,6694.44],  [1281.59,6564.56], [1655.04,6473.23], [1909.17,6435.87], [2320.25,6400.45],  [2619.6,6451.87],  [3128.14,6451.45],  [3788.26,6369.15],  [4295.05,6237.96],  [4812.73,5968.21],  [5598.54,5381.35],  [5919.54,5111.3],  [6593.32,4619.41],  [7174.71,4055.25],  [7634.55,3476.98],  [8269.64,2835.1]] call BIS_fnc_selectRandom;
			_unsorted = _unsorted + [_preWaypointPos];
			};


			
			
		_sorted = [];
		_pos = [800,2400];

	{
     _closest = _unsorted select 0;
     {if ((_x distance _pos) <= (_closest distance _pos)) then {_closest = _x}} forEach _unsorted;
	 
     _sorted = _sorted + [_closest];

	_helper = [];
	_i=0;
	while {!([_helper, _closest] call BIS_fnc_areEqual)} do { 
		_helper = _unsorted select _i;
		_i=_i+1;
		};

	_unsorted set [(_i-1),"delete_me"];
	_unsorted = _unsorted - ["delete_me"];
	} forEach _unsorted;
			
	diag_log(format["CARDROP: %1 started flying from %2 to first waypoint NOW!(TIME:%3)", _crashName,  str(_heliStart), round(time)]);
		

		
		for "_x" from 0 to ((count _sorted)-1) do {
		
			
			//_preWaypointPos = [_spawnMarker,0,8000,10,0,1000,0,_blacklist] call BIS_fnc_findSafePos;
			diag_log(format["CARDROP: Adding DROPWaypoint #%1 on %2", (_x+1),str(_sorted select _x)]);
			_wp = _aigroup addWaypoint [(_sorted select _x), 0];
			_wp setWaypointType "MOVE";
			_wp setWaypointBehaviour "CARELESS";
			
			
			waituntil {(_crashwreck distance (_sorted select _x)) <= 250 || not alive _crashwreck || (getPosATL _crashwreck select 2) < 5 || (damage _crashwreck) >= _crashDamage};	
			
			diag_log(format["CARDROP IS AT DROPWAYPOINT #%1 on %2", (_x+1),str(getpos _crashwreck)]);
			sleep 2;
			nul = [_chutetype, _boxtype, _helistart, _crashwreck, _randomizedLoot, _guaranteedLoot] spawn server_cardrop;
			
			if (not alive _crashwreck || (damage _crashwreck) >= _crashDamage || (getPosATL _crashwreck select 2) < 5 ) exitWith {diag_log(format["DROPPED 1 LAST CAR WHILE GETTING SHOT DOWN #%1 on %2", _x,str(getpos _crashwreck)]); };
			
		};
		
		
		_wp2 = _aigroup addWaypoint [_heliStart, 0];
		_wp2 setWaypointType "MOVE";
		_wp2 setWaypointBehaviour "CARELESS";
		diag_log(format["CARDROP IS AT END WAYPOINT on %1",str(_heliStart)]);
		waituntil {(_crashwreck distance _heliStart) <= 1000 || not alive _crashwreck || (getPosATL _crashwreck select 2) < 5 || (damage _crashwreck) >= _crashDamage};
		
		sleep 5;	
		
		//Clean Up the Crashsite
		deletevehicle _crashwreck;
		deletevehicle _helipilot;
		diag_log(format["CARDROP DELETED"]);
	
		
		
		_endTime = time - _startTime;
		diag_log(format["CARDROP: %2 Cardrops completed! Runtime: %1 Seconds", round(_endTime), _preWaypoints]);
		
	
	};
		

};