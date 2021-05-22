// set up MACRO vars that can be used between files and make changes easier
#include "..\..\Headers\descriptionEXT\Faction Headers\Define Factions.hpp"
/* ----------------------------------------------------------------------------
Function: BLWK_fnc_prepareUnitClasses

Description:
	Gets the user selected unit class tables to use for each level
	 and returns them in several arrays within a master.
	Also handles DLC exclusion.

	Executed from "BLWK_fnc_prepareGlobals"

Parameters:
	NONE

Returns:
	ARRAY - Formatted as: (these are arrays)
		- friendly men classes
		- friendly vehicle classes
		- level 1 enemy man classes
		- level 1 enemy vehicle classes
		- level 2 enemy man classes
		- level 2 enemy vehicle classes
		- level 3 enemy man classes
		- level 3 enemy vehicle classes
		- level 4 enemy man classes
		- level 4 enemy vehicle classes
		- level 5 enemy man classes
		- level 5 enemy vehicle classes

Examples:
    (begin example)

		_classes = call BLWK_fnc_prepareUnitClasses;

    (end)

Author(s):
	Ansible2 // Cipher,
	Hilltop(Willtop) & omNomios
---------------------------------------------------------------------------- */
#define SCRIPT_NAME "BLWK_fnc_prepareUnitClasses"
scriptName SCRIPT_NAME;

// to save on allocation time for memory, we are going to use temp values
private _factionClasses = "true" configClasses (missionConfigFile >> "BLWK_factions");

private _fn_exitForUndefinedDefault = {
	[] spawn {
		["A default faction appears to be empty, the mission will now end to reconfigure parameters",true] remoteExecCall ["KISKA_fnc_log",0];
		sleep 20;
		["UnitClassesErrorEnd"] call BIS_fnc_endMissionServer;
	};
};


private [
	"_sortArray",
	"_infantryClasses",
	"_lighCarClasses",
	"_heavyCarClasses",
	"_heavyArmorClasses",
	"_transportHelicopterClasses",
	"_cargoAircraftClasses",
	"_casAircraftClasses",
	"_attackHelicopterClasses",
	"_heavyGunshipClasses"
];
// Sort a faction's units based upon what DLC is excluded and whether or not a unit class exists
private _vehicleConfig = configFile >> "cfgVehicles";
private _fn_sortFactionClasses = {
	params ["_configToCheck"];

	private _vehicleTypes = [];
	private _fn_sortArray = {
		params ["_arrayToPushTo",["_pushToVehicle",true]];

		if (_sortArray isNotEqualTo []) then {
			_sortArray apply {
				if (isClass (_vehicleConfig >> _x)) then {
					_arrayToPushTo pushBack (toLowerANSI _x);
				};
			};
		};

		if (_pushToVehicle) then {
			_vehicleTypes pushBack _arrayToPushTo;
		};
	};


	_infantryClasses = [];
	_sortArray = [_configToCheck >> "infantry"] call BIS_fnc_getCfgDataArray;
	[_infantryClasses,false] call _fn_sortArray;
	// exit if no infantry
	if (_infantryClasses isEqualTo []) exitWith {
		[["Found no infantry classes in config ",_configToCheck],true] call KISKA_fnc_log;
		[]
	};

	_lighCarClasses = [];
	_sortArray = [_configToCheck >> "lightCars"] call BIS_fnc_getCfgDataArray;
	[_lighCarClasses] call _fn_sortArray;

	_heavyCarClasses = [];
	_sortArray = [_configToCheck >> "heavyCars"] call BIS_fnc_getCfgDataArray;
	[_heavyCarClasses] call _fn_sortArray;

	_lightArmorClasses = [];
	_sortArray = [_configToCheck >> "lightArmor"] call BIS_fnc_getCfgDataArray;
	[_lightArmorClasses] call _fn_sortArray;

	_heavyArmorClasses = [];
	_sortArray = [_configToCheck >> "heavyArmor"] call BIS_fnc_getCfgDataArray;
	[_heavyArmorClasses] call _fn_sortArray;

	_transportHelicopterClasses = [];
	_sortArray = [_configToCheck >> "transportHelicopters"] call BIS_fnc_getCfgDataArray;
	[_transportHelicopterClasses] call _fn_sortArray;

	_cargoAircraftClasses = [];
	_sortArray = [_configToCheck >> "cargoAircraft"] call BIS_fnc_getCfgDataArray;
	[_cargoAircraftClasses] call _fn_sortArray;

	_casAircraftClasses = [];
	_sortArray = [_configToCheck >> "casAircraft"] call BIS_fnc_getCfgDataArray;
	[_casAircraftClasses] call _fn_sortArray;

	_attackHelicopterClasses = [];
	_sortArray = [_configToCheck >> "attackHelicopters"] call BIS_fnc_getCfgDataArray;
	[_attackHelicopterClasses] call _fn_sortArray;

	_heavyGunshipClasses = [];
	_sortArray = [_configToCheck >> "heavyGunships"] call BIS_fnc_getCfgDataArray;
	[_heavyGunshipClasses] call _fn_sortArray;


	[_infantryClasses,_vehicleTypes]
};

private _fn_getSelectedClasses = {
	params ["_factionString","_defaultFactionString"];

	private "_factionArray";
	private _goToDefaultFaction = false;
	private _factionIndex = _factionClasses findIf {getText(_x >> "displayName") == _factionString};
	// if a faction was found for the string
	if (_factionIndex != -1) then {
		_factionArray = [_factionClasses select _factionIndex] call _fn_sortFactionClasses;
		if (_factionArray isEqualTo []) then {
			[["Faction ",_factionString," returned empty array, going to faction ",_defaultFactionString],true] call KISKA_fnc_log;
			_goToDefaultFaction = true
		};
	} else {
		[["Faction ",_factionString," was not found, going to default faction ",_defaultFactionString],true] call KISKA_fnc_log;
		_goToDefaultFaction = true
	};

	// default fall through faction if the selected is unavailable
	if (_goToDefaultFaction) then {
		private _doExit = false;
		_factionIndex = _factionClasses findIf {getText(_x >> "displayName") == _defaultFactionString};
		// if a faction is found
		if (_factionIndex != -1) then {
			_factionArray = [_factionClasses select _factionIndex] call _fn_sortFactionClasses;
			// if faction still came up empty
			if (_factionArray isEqualTo []) then {
				_doExit = true;
			};
		} else {
			_doExit = true;
		};

		if (_doExit AND {isServer}) then {
			call _fn_exitForUndefinedDefault
		};
	};

	_factionArray
};

private _fn_getFactionString = {
	params ["_missionParamValue"];
	[FACTION_STRINGS] select _missionParamValue;
};


// get faction classes
private _index_temp = "BLWK_friendlyFaction" call BIS_fnc_getParamValue;
private _selectedClassString_friendly = [_index_temp] call _fn_getFactionString;
private _friendlyClasses = [_selectedClassString_friendly,"VANILLA - NATO"] call _fn_getSelectedClasses;

_index_temp = "BLWK_level1Faction" call BIS_fnc_getParamValue;
private _selectedClassString_level_1 = [_index_temp] call _fn_getFactionString;
private _level1Classes = [_selectedClassString_level_1,"VANILLA - FIA"] call _fn_getSelectedClasses;

_index_temp = "BLWK_level2Faction" call BIS_fnc_getParamValue;
private _selectedClassString_level_2 = [_index_temp] call _fn_getFactionString;
private _level2Classes = [_selectedClassString_level_2,"VANILLA - AAF"] call _fn_getSelectedClasses;

_index_temp = "BLWK_level3Faction" call BIS_fnc_getParamValue;
private _selectedClassString_level_3 = [_index_temp] call _fn_getFactionString;
private _level3Classes = [_selectedClassString_level_3,"VANILLA - CSAT"] call _fn_getSelectedClasses;

_index_temp = "BLWK_level4Faction" call BIS_fnc_getParamValue;
private _selectedClassString_level_4 = [_index_temp] call _fn_getFactionString;
private _level4Classes = [_selectedClassString_level_4,"VANILLA - CSAT URBAN"] call _fn_getSelectedClasses;

_index_temp = "BLWK_level5Faction" call BIS_fnc_getParamValue;
private _selectedClassString_level_5 = [_index_temp] call _fn_getFactionString;
private _level5Classes = [_selectedClassString_level_5,"APEX - VIPER"] call _fn_getSelectedClasses;


// return for global var definition
[
	_friendlyClasses select 0, // men
	_friendlyClasses select 1, // vehicles
	_level1Classes select 0,
	_level1Classes select 1,
	_level2Classes select 0,
	_level2Classes select 1,
	_level3Classes select 0,
	_level3Classes select 1,
	_level4Classes select 0,
	_level4Classes select 1,
	_level5Classes select 0,
	_level5Classes select 1
]
