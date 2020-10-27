params ["_typeId"];

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
			"B_Heli_Attack_01_dynamicLoadout_F",\ 	7 // attack helicopter
			"B_T_VTOL_01_armed_F"\ 					8 // gunship (ac130 type aircraft)
		]
*/
#define DEFAULT_VEHICLE_CLASSES \
	[\
		"B_LSV_01_armed_F",\
		"B_MRAP_01_hmg_F",\
		"B_APC_Wheeled_01_cannon_F",\
		"B_MBT_01_cannon_F",\
		"B_Heli_Transport_01_F",\
		"B_T_VTOL_01_vehicle_F",\
		"B_Plane_CAS_01_F",\
		"B_Heli_Attack_01_dynamicLoadout_F",\
		"B_T_VTOL_01_armed_F"\
	]


private _returnVehicleClass = "";
private _numFriendlyClasses = count BLWK_friendly_vehicleClasses;
// check if BLWK_friendly_vehicleClasses array will even have the required entries 
if (_numFriendlyClasses - 1 >= _typeId) then {
	// check that custom class is actually configed
	private _testClass = BLWK_friendly_vehicleClasses select _typeId;
	if (isClass (configFile >> "CfgVehicles" >> _testClass)) then {
		_returnVehicleClass = _testClass;
	};
};

// if entry did not exist or was empty string
if (_returnVehicleClass isEqualTo "") then {
	_returnVehicleClass = DEFAULT_VEHICLE_CLASSES select _typeId
};

_returnVehicleClass