params [
	["_typeId",0,[123]],
	["_supplementEmpty",true,[true]],
	["_shuffle",false,[true]]
];

/*
	#define DEFAULT_VEHICLE_CLASSES \
		[\
			"B_LSV_01_armed_F",\ 					0 // light car 
			"B_MRAP_01_hmg_F",\ 					1 // heavy car
			"B_APC_Wheeled_01_cannon_F",\ 			2 // light armour
			"B_MBT_01_cannon_F",\ 					3 // heavy armour
			"B_Heli_Transport_01_F",\ 				4 // transport aircraft
			"B_T_VTOL_01_vehicle_F",\ 				5 // cargo aircraft
			"B_Plane_CAS_01_F",\ 					6 // CAS plane 
			"B_Heli_Attack_01_dynamicLoadout_F"\ 	7 // attack helicopter
		]
*/

#define DEFAULT_VEHICLE_CLASSES \
	[\
		"O_LSV_02_armed_F",\
		"O_MRAP_02_hmg_F",\
		"O_APC_Wheeled_02_rcws_v2_F",\
		"O_MBT_02_cannon_F",\
		"O_Heli_Light_02_unarmed_F",\
		"O_Heli_Transport_04_box_F",\
		"O_Plane_CAS_02_dynamicLoadout_F",\
		"O_Heli_Attack_02_dynamicLoadout_F"\
	]

private _availableClasses = [];
private _defaultVehicleClass = DEFAULT_VEHICLE_CLASSES select _typeId;

private _fn_pushVehicleForLevel = {
	params ["_classes"];
	private _class = _classes select _typeId;

	if !(_class isEqualTo "") exitWith {
		_availableClasses pushBackUnique _class;
	};
	
	if (_supplementEmpty) then {
		_availableClasses pushBackUnique _defaultVehicleClass;
	};
};

[BLWK_level1_vehicleClasses] call _fn_pushVehicleForLevel;
if (BLWK_currentWaveNumber > 5) then {
	[BLWK_level2_vehicleClasses] call _fn_pushVehicleForLevel;
};
if (BLWK_currentWaveNumber > 10) then {
	[BLWK_level3_vehicleClasses] call _fn_pushVehicleForLevel;
};
if (BLWK_currentWaveNumber > 15) then {
	[BLWK_level4_vehicleClasses] call _fn_pushVehicleForLevel;
};
if (BLWK_currentWaveNumber > 20) then {
	[BLWK_level5_vehicleClasses] call _fn_pushVehicleForLevel;
};


// check if we only got empty strings
if (_availableClasses isEqualTo []) then {
	_availableClasses = [_defaultVehicleClass];
};

// shuffle
if ((_availableClassesCount > 1) AND {_shuffle}) then {
	_availableClasses = [_availableClasses,false] call CBAP_fnc_shuffle;
};


_availableClasses