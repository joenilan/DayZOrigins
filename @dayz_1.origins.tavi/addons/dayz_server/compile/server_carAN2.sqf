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
			
			_preWaypointPos = [[4495.56,7601.14],  [3985.08,8360.66], [3374.86,8048.15], [616,811,8318.86], [2777.43,8114.92],  [6795.64,7271.39],  [7807.35,6560.44],  [8290.61,5934.69],  [8290.61,5934.69],  [8329,5150.43],  [5570.28,6703.41],  [4202.54,6843.45],  [4081.19,5942.29],  [3875.53,5044.26],  [5467.5,5785.49],  [5292.21,5279.04],   [5518.68,5020.6],   [5127,4608.67],   [2284.61,4870.5],   [2247.89,3777.36],   [2459.01,3437.4],   [3088.65,3028.54],   [5045.92,3429.64],   [6386.93,3229.54],   [7683.39,3267.47],   [8386.07,2474.11],   [8653.95,2219.55],   [8306.53,2163.7],   [8067.11,1977.19],   [7687.68,2312.87],  [7266.68,1763.59],  [6901,1245.19], [6558.8,875.422]] call BIS_fnc_selectRandom;
			
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