/* ----------------------------------------------------------------------------
Function: BLWK_fnc_getFriendlyVehicleClass

Description:
	Gets a vehicle classes based on a typeId. If no classes are available 
	 for a type, a default class if provided.

Parameters:
	0: _typeId : <NUMBER> - The type of vehicle requested (see below for numbers)
	1: _randomIndex : <BOOL> - Select a random entry in the vehicle class list (0 index is default) 

Returns:
	<STRING> -  A class for the requested type

Examples:
    (begin example)

		_lightCarClass = [0] call BLWK_fnc_getFriendlyVehicleClass;

    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
scriptName "BLWK_fnc_getFriendlyVehicleClasses";

params [
	"_typeId",
	["_randomIndex",true]
];

/*
	#define DEFAULT_VEHICLE_CLASSES \
		[\
			["B_LSV_01_armed_F"],\ 						0 // light car 
			["B_MRAP_01_hmg_F"],\ 						1 // heavy car
			["B_APC_Wheeled_01_cannon_F"],\ 			2 // light armour
			["B_MBT_01_cannon_F"],\ 					3 // heavy armour
			["B_Heli_Transport_01_F"],\ 				4 // transport aircraft
			["B_T_VTOL_01_vehicle_F"],\ 				5 // cargo aircraft
			["B_Plane_CAS_01_dynamicLoadout_F"],\ 		6 // CAS plane 
			["B_Heli_Attack_01_dynamicLoadout_F"],\ 	7 // attack helicopter
			["B_T_VTOL_01_armed_F"]\ 					8 // gunship (ac130 type aircraft)
		]
*/
#define DEFAULT_VEHICLE_CLASSES \
	[\
		["B_LSV_01_armed_F"],\
		["B_MRAP_01_hmg_F"],\
		["B_APC_Wheeled_01_cannon_F"],\
		["B_MBT_01_cannon_F"],\
		["B_Heli_Transport_01_F"],\
		["B_T_VTOL_01_vehicle_F"],\
		["B_Plane_CAS_01_dynamicLoadout_F"],\
		["B_Heli_Attack_01_dynamicLoadout_F"],\
		["B_T_VTOL_01_armed_F"]\
	]


private _returnVehicleClass = "";
private _numFriendlyClasses = count BLWK_friendly_vehicleClasses;
// check if BLWK_friendly_vehicleClasses array will even have the required entries 
if (_numFriendlyClasses - 1 >= _typeId) then {
	// check that custom class is actually configed
	private _vehicleTypeArray = BLWK_friendly_vehicleClasses select _typeId;
	if !(_vehicleTypeArray isEqualTo []) then {
		if (_randomIndex) then {
			_returnVehicleClass = selectRandom _vehicleTypeArray;
		} else {
			_returnVehicleClass = _vehicleTypeArray select 0;
		};
	};
};

// if entry did not exist or was empty string
if (_returnVehicleClass isEqualTo "") then {
	_returnVehicleClass = (DEFAULT_VEHICLE_CLASSES select _typeId) select 0;
};


_returnVehicleClass