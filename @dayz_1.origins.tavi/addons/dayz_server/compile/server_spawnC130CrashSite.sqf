//TO SET THIS UP FOLLOW MY INSTRUCTIONS ON OPEN DAYZ
private["_useStatic","_crashDamage","_lootRadius","_preWaypoints","_preWaypointPos","_endTime","_startTime","_safetyPoint","_heliStart","_deadBody","_exploRange","_heliModel","_lootPos","_list","_craters","_dummy","_wp2","_wp3","_landingzone","_aigroup","_wp","_helipilot","_crash","_crashwreck","_smokerand","_staticcoords","_pos","_dir","_position","_num","_config","_itemType","_itemChance","_weights","_index","_iArray","_crashModel","_lootTable","_guaranteedLoot","_randomizedLoot","_frequency","_variance","_spawnChance","_spawnMarker","_spawnRadius","_spawnFire","_permanentFire","_crashName"];

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

if(count _this > 9) then {
	_useStatic = _this select 9;
} else {
	_useStatic = false;
};

if(count _this > 10) then {
	_preWaypoints	= _this select 10;
} else {
	_preWaypoints = 1;
};

if(count _this > 11) then {
	_crashDamage = _this select 11;
} else {
	_crashDamage = 1;
};

diag_log(format["C130CRASHSPAWNER: Starting spawn logic for animated helicrashs - written by Grafzahl [SC:%1||PW:%2||CD:%3]", str(_useStatic), str(_preWaypoints), _crashDamage]);

while {true} do {
	private["_timeAdjust","_timeToSpawn","_spawnRoll","_crash","_hasAdjustment","_newHeight","_adjustedPos"];
	// Allows the variance to act as +/- from the spawn frequency timer
	_timeAdjust = round(random(_variance * 2) - _variance);
	_timeToSpawn = time + _frequency + _timeAdjust;

	//Random Heli-Type
	_heliModel = ["AN2_DZ"] call BIS_fnc_selectRandom;

	//Random-Startpositions, Adjust this for other Maps then Chernarus
	_heliStart = [[6993.7007,173.05298,300],[1623.715,218.18848,300]] call BIS_fnc_selectRandom;

	//A Backup Waypoint, if not Chernarus, set some Coordinates far up in the north (behind all possible Crashsites)
	_safetyPoint = [7492.6675, 15263.042];

	//Settings for the Standard UH1H_DZ
	_crashModel = "AN2Wreck";
	_exploRange = 195;
	_lootRadius = 0.55;

	//Adjust Wreck and Range of Explosion if its a Mi17_DZ
	if(_heliModel == "Mi17_DZ") then {
		_crashModel = "Mi8Wreck";
		_exploRange = 285;
		_lootRadius = 0.3;
	};

	//Crash loot - just uncomment the one you wish to use by default with 50cals is enabled.
	//Table including 50 cals
	_lootTable = ["HeliCrash"] call BIS_fnc_selectRandom;

	//Table without 50 cals
	//_lootTable = ["Military","HeliCrash_No50s","MilitarySpecial"] call BIS_fnc_selectRandom;

	_crashName	= getText (configFile >> "CfgVehicles" >> _heliModel >> "displayName");

	diag_log(format["C130CRASHSPAWNER: %1%2 chance to start a crashing %3 with loot table '%4' at %5", round(_spawnChance * 100), '%', _crashName, _lootTable, _timeToSpawn]);

	// Apprehensive about using one giant long sleep here given server time variances over the life of the server daemon
	while {time < _timeToSpawn} do {
		sleep 5;
	};

	_spawnRoll = random 1;

	// Percentage roll
	if (_spawnRoll <= _spawnChance) then {

/*
==================================================================================================
		_staticcoords give you the possibility to organize your crashsites!

		IT IS RECOMENDED THAT YOU USE STATIC - CO-ORDS, AND KEEP THEM A GOOD DISTANCE FROM WATER, OTHERWISE YOUR C130 COULD
		END UP UNDER THE WATER
		
		SET AS MANY AS YOU WANT, THESE WONT BE ACCURATE, BUT CLOSE
==================================================================================================
*/

		_staticcoords =	[
											[4516.49,3296.73,3.68049],
											[4921.93,5148.96,31.5836],
											[6457.06,5190.83,114.982],
											[6909.84,3491.64,71.644],
											[5263.36,6200.04,106.836],
											[5191.33,4356.68,131.633]
										];

		if(_useStatic) then {
			_position = _staticcoords call BIS_fnc_selectRandom;
		} else {
			_position = [getMarkerPos _spawnMarker,0,_spawnRadius,10,0,2000,0] call BIS_fnc_findSafePos;
		};
		//DEFAULT: GET COORDS FROM BIS_fnc_findSafePos, COMMENT OUT IF YOU USE _STATICCOORDS

		diag_log(format["C130StartCRASHSPAWNER: %1 started flying from %2 to %3 NOW!(TIME:%4||LT:%5)", _crashName,  str(_heliStart), str(_position), round(time), _lootTable]);

		//Spawn the AI-Heli flying in the air
		_startTime = time;
		_crashwreck = createVehicle [_heliModel,_heliStart, [], 0, "FLY"];

		//Make sure its not destroyed by the Hacker-Killing-Cleanup (Thanks to Sarge for the hint)
		_crashwreck setVariable["Sarge",1];

		_crashwreck engineOn true;
		_crashwreck flyInHeight 120;
		_crashwreck forceSpeed 140;
		_crashwreck setspeedmode "LIMITED";

		//Create an Invisibile Landingpad at the Crashside-Coordinates
		_landingzone = createVehicle ["HeliHEmpty", [_position select 0, _position select 1,0], [], 0, "CAN_COLLIDE"];
		_landingzone setVariable["Sarge",1];

		//Only a Woman could crash a Heli this way...
		_aigroup = creategroup civilian;
		_helipilot = _aigroup createUnit ["SurvivorW2_DZ",getPos _crashwreck,[],0,"FORM"];
		_helipilot moveindriver _crashwreck;
		_helipilot assignAsDriver _crashwreck;

		sleep 0.5;

		if(_preWaypoints > 0) then {
			for "_x" from 1 to _preWaypoints do {
				if(_useStatic) then {
					_preWaypointPos = _staticcoords call BIS_fnc_selectRandom;
				} else {
					_preWaypointPos = [getMarkerPos _spawnMarker,0,_spawnRadius,10,0,2000,0] call BIS_fnc_findSafePos;
				};
				diag_log(format["C130CRASHSPAWNER: Adding Pre-POC-Waypoint #%1 on %2", _x,str(_preWaypointPos)]);
				_wp = _aigroup addWaypoint [_preWaypointPos, 0];
				_wp setWaypointType "MOVE";
				_wp setWaypointBehaviour "CARELESS";
			};
		};

		_wp2 = _aigroup addWaypoint [position _landingzone, 0];
		_wp2 setWaypointType "MOVE";
		_wp2 setWaypointBehaviour "CARELESS";

		//Even when the Heli flys to high, it will burn when reaching its Waypoint
		_wp2 setWaypointStatements ["true", "_crashwreck setdamage 1;"];

		//Adding a last Waypoint up in the North, so the Heli doesnt Hover at WP1 (OR2)
		//and would also come back to WP1 if somehow it doesnt explode.
		_wp3 = _aigroup addWaypoint [_safetyPoint, 0];
		_wp3 setWaypointType "CYCLE";
		_wp3 setWaypointBehaviour "CARELESS";

		//Get some more Speed when close to the Crashpoint and go on even if Heli died or hit the ground
		waituntil {(_crashwreck distance _position) <= 1000 || not alive _crashwreck || (getPosATL _crashwreck select 2) < 5 || (damage _crashwreck) >= _crashDamage};
			_crashwreck flyInHeight 95;
			_crashwreck forceSpeed 80;
			_crashwreck setspeedmode "NORMAL";

		//BOOOOOOM!
		waituntil {(_crashwreck distance _position) <= _exploRange || not alive _crashwreck || (getPosATL _crashwreck select 2) < 5 || (damage _crashwreck) >= _crashDamage};
			//Taking out the Tailrotor would be more realistic, but makes the POC not controllable
			//_crashwreck setHit ["mala vrtule", 1];
			_crashwreck setdamage 1;
			_crashwreck setfuel 0;
			diag_log(format["C130EndCRASHSPAWNER: %1 just exploded at %2!, ", _crashName, str(getPosATL _crashwreck)]);

			//She cant survive this :(
			_helipilot setdamage 1;

			//Giving the crashed Heli some time to find its "Parkingposition"
			sleep 13;

		//Get position of the helis wreck, but make sure its on the ground;
		_pos = [getpos _crashwreck select 0, getpos _crashwreck select 1,0];
    _landedPos = [getpos _crashwreck select 0, getpos _crashwreck select 1];

		//saving the direction of the wreck(not used right now)
		_dir = getdir _crashwreck; 

		//Send Public Variable so every client can delete the craters around the new Wreck (musst be added in init.sqf)
		heliCrash = _pos;
		publicVariable "heliCrash";
		
		//Clean Up the Crashsite
		deletevehicle _crashwreck;
		deletevehicle _helipilot;
		deletevehicle _landingzone;

		//Animation is done, lets create the actual Crashside
		_crash = createVehicle [_crashModel, _pos, [], 0, "CAN_COLLIDE"];
		_crash setVariable["Sarge",1];

		//If you want all Grass around the crashsite to be cutted: Uncomment the next Line (Noobmode)
		//_crashcleaner = createVehicle ["ClutterCutter_EP1", _pos, [], 0, "CAN_COLLIDE"];

		//Setting the Direction would add realism, but it sucks because of the bugged model when not on plane ground.
		//If you want it anyways, just uncomment the next line
		//_crash setDir _dir;

		// I don't think this is needed (you can't get "in" a crash), but it was in the original DayZ Crash logic
		dayz_serverObjectMonitor set [count dayz_serverObjectMonitor,_crash];

		_crash setVariable ["ObjectID",1,true];

		//Make it burn (or not)
		if (_spawnFire) then {
			//["dayzFire",[_crash,2,time,false,_fadeFire]] call broadcastRpcCallAll;
			dayzFire = [_crash,2,time,false,_fadeFire];
			publicVariable "dayzFire";
			_crash setvariable ["fadeFire",_fadeFire,true];
		};

		_num		= round(random _randomizedLoot) + _guaranteedLoot;
		
		_config = 		configFile >> "CfgBuildingLoot" >> _lootTable;
		_itemTypes =	[] + getArray (_config >> "itemType");
		_cntItems = count _itemTypes;        
    diag_log(format["C130CRASHSPAWNER: numLoot: '%1', _index: '%2', _weights: '%3', _cntItemTypes: '%4', config: '%5'", str(_num), str(_index), str(_weights), str(_cntItems), str(_config)]);

		for "_x" from 1 to _num do {
			//create loot
			_index = floor(random _cntItems);			             
			_itemType = _itemTypes select _index;
			[_itemType select 0, _itemType select 1, _landedPos, 5] call spawn_loot;

			diag_log(format["CRASHSPAWNER: Loot Table: '%1', ItemTypes: '%2', Index: '%3', ItemType: '%4', Item: '%5'", _lootTable, str(_itemTypes), str(_index), str(_itemType), str(_itemType select 0)]); 

			// ReammoBox is preferred parent class here, as WeaponHolder wouldn't match MedBox0 and other such items.
			_nearby = _landedPos nearObjects ["ReammoBox", sizeOf(_crashModel)];
			{
				_x setVariable ["permaLoot",true];
			} forEach _nearBy;
		};

		//Adding 5 dead soldiers around the wreck, poor guys
		for "_x" from 1 to 5 do {
			_lootPos = [_pos, ((random 4)+3), random 360] call BIS_fnc_relPos;
			_deadBody = createVehicle[["Body1","Body2"] call BIS_fnc_selectRandom,_lootPos,[], 0, "CAN_COLLIDE"];
			_deadBody setDir (random 360);
		};

		_endTime = time - _startTime;
		diag_log(format["C130CRASHSPAWNER: Crash completed! Wreck at: %2 - Runtime: %1 Seconds || Distance from calculated POC: %3 meters", round(_endTime), str(getPos _crash), round(_position distance _crash)]); 

	
	};
};