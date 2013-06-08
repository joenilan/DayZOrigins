//_chutetype, _boxtype, _helistart, _crashwreck
private["_chutetype", "_boxtype", "_helistart", "_crashwreck", "_randomizedLoot", "_guaranteedLoot", "_chute", "_chutetype", "_helistart", "_crashwreck", "_box", "_boxtype", "_num", "_weights", "_index", "_aaa", "_itemType", "_lootRadius", "_lootPos", "_pos", "_bam"];

_chutetype = _this select 0;
_boxtype = _this select 1;
_helistart	= _this select 2;
_crashwreck	= _this select 3;
_randomizedLoot = _this select 4;
_guaranteedLoot = _this select 5;

_lootRadius = 1;
//_lootTable = ["Military","HeliCrash","MilitarySpecial"] call BIS_fnc_selectRandom;

	_chute = createVehicle [_chutetype,_helistart,[],0,"CAN_COLLIDE"];
	_chute setVariable["Sarge",1];
	_chute setPos [(getpos _crashwreck select 0), (getPos _crashwreck select 1), (getPos _crashwreck select 2)-10];
	
	_box = createVehicle [_boxtype,_helistart,[],0,"CAN_COLLIDE"];
	_box setVariable["Sarge",1];
	_box setPos [(getpos _crashwreck select 0), (getPos _crashwreck select 1), (getPos _crashwreck select 2)-10];
	
	_box attachto [_chute, [0, 0, 0]];
	
	_i = 0;


	while {_i < 45} do {
	scopeName "loop1";
    if (((getPos _box) select 2) < 1) then {breakOut "loop1"};

    sleep 0.1;
    _i=_i+0.1;
	};  


	switch (true) do {
	  case not (alive _box): {detach _box;_box setpos [(getpos _box select 0), (getpos _box select 1), 0];};
	  case alive _box: {detach _box;_box setpos [(getpos _box select 0), (getpos _box select 1), 0];_bam = _boxtype createVehicle [(getpos _box select 0),(getpos _box select 1),(getpos _box select 2)+0];deletevehicle _box;};
	};
	_bam setVariable["Sarge",1];
	deletevehicle _chute;
	
	sleep 2;
	
	_pos = [getpos _bam select 0, getpos _bam select 1,0];
	
	
	_smoke = createVehicle ["SmokeShellred",_pos,[],0,"CAN_COLLIDE"];
	_smoke setVariable["Sarge",1];
	
	_flare = "F_40mm_white" createVehicle [getPos _bam select 0, getPos _bam select 1, (getPos _bam select 2) +150];
	_flare setVariable["Sarge",1];
	
	
	
	_num		= round(random _randomizedLoot) + _guaranteedLoot;

              //_config = configFile >> "CfgBuildingLoot" >> _lootTable;
              _itemTypes = [["ItemSodaMdew","magazine"] ,["ItemGPS","weapon"] ,["huntingrifle","weapon"] ,["Skin_Camo1_DZ","magazine"] ,["M16A2","weapon"] ,["AK_74","weapon"] ,["AKS_74_U","weapon"] ,["AK_47_M","weapon"] ,["M4A1","weapon"] ,["Sa58P_EP1","weapon"] ,["Sa58V_EP1","weapon"] ,["DZ_British_ACU","object"] ,["Remington870_lamp","weapon"] ,["MP5A5","weapon"] ,["MedBox0","object"] ,["DZ_ALICE_Pack_EP1","object"] ,["DZ_TK_Assault_Pack_EP1","object"] ,["WeaponHolder_ItemTent","object"] ,["M9","weapon"] ,["UZI_EP1","weapon"] ,["glock17_EP1","weapon"] ,["LeeEnfield","weapon"] ,["Winchester1866","weapon"] ,["WeaponHolder_ItemMachete","object"] ,["ItemCompass","generic"] ,["ItemKnife","generic"] ,["ItemMatchbox","generic"] ,["ItemFlashlightRed","military"] ,["Binocular","weapon"] ,["ItemMap","weapon"] ,["Colt1911","weapon"] ,["revolver_EP1","weapon"] ,["Makarov","weapon"] ,["","food"] ,["","medical"]];
              _itemChance = [0.01 ,0.01 ,0.01 ,0.03 ,0.03 ,0.03 ,0.03 ,0.03 ,0.03 ,0.03 ,0.03 ,0.06 ,0.06 ,0.06 ,0.1 ,0.1 ,0.1 ,0.1 ,0.12 ,0.12 ,0.12 ,0.15 ,0.15 ,0.15 ,0.18 ,0.18 ,0.18 ,0.18 ,0.18 ,0.18 ,0.2 ,0.2 ,0.2 ,0.25 ,0.25];
 
              _weights = [];
              _weights = [_itemType,_itemChance] call fnc_buildWeightedArray;
              _cntWeights = count _weights;