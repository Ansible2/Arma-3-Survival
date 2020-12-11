// set up MACRO vars that can be used between files and make changes easier
#include "..\..\Headers\Faction Headers\Define Factions.hpp"
#include "..\..\Headers\Faction Headers\Unit Tables\Master Unit Table.hpp"
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
// to save on allocation time for memory, we are going to use temp values
private _tempUnitClass = "";
private _factionClasses = "true" configClasses (missionConfigFile >> "BLWK_factions");

// check if a unit is an actual class and if they are dependent on exluded DLC
private _fn_checkTempClass = {
	if (isClass (configFile >> "CfgVehicles" >> _tempUnitClass) /*AND {[_tempUnitClass,"CfgVehicles"] call BLWK_fnc_checkDLC}*/) then {
		true;
	} else {
		false;
	};
};


private _fn_exitForUndefinedDefault = {
	null = [] spawn {
		null = ["A default faction appears to be empty, the mission will now end to reconfigure parameters"] remoteExecCall ["BIS_fnc_error",0];
		sleep 20;
		call BIS_fnc_endMissionServer;
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
private _fn_sortFactionClasses = {
	params ["_configToCheck"];

	private _vehicleTypes = [];
	private _fn_sortArray = {
		params ["_arrayToPushTo",["_pushToVehicle",true]];
		_sortArray apply {
			if (isClass (configFile >> "cfgVehicles" >> _x)) then {
				_arrayToPushTo pushBack _x;
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
		["Found no infantry classes in %1 config",_configToCheck] call BIS_fnc_error;
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
	[_heavyArmorClasses] call _fn_sortArray;

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
	private _factionIndex = _factionClasses findIf {(_x >> "displayName") == _factionString};
	// if a faction was found for the string
	if (_factionIndex != -1) then {
		_factionArray = [_factionClasses select _factionIndex] call _fn_sortFactionClasses;
		if (_factionArray isEqualTo []) then {
			_goToDefaultFaction = true
		};
	} else {
		_goToDefaultFaction = true
	};
	
	// default fall through faction if the selected is unavailable
	if (_goToDefaultFaction) then {
		private _doExit = false;
		_factionIndex = _factionClasses findIf {(_x >> "displayName") == _defaultFactionString};
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

		if (_doExit) then {
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
private _selectedClassString_friendly = ["BLWK_friendlyFaction" call BIS_fnc_getParamValue] call _fn_getFactionString;
private _friendlyClasses = [_selectedClassString_friendly,"VANILLA - NATO"] call _fn_getSelectedClasses;

private _selectedClassString_level_1 = ["BLWK_level1Faction" call BIS_fnc_getParamValue] call _fn_getFactionString;
private _level1Classes = [_selectedClassString_level_1,"VANILLA - FIA"] call _fn_getSelectedClasses;

private _selectedClassString_level_2 = ["BLWK_level2Faction" call BIS_fnc_getParamValue] call _fn_getFactionString;
private _level2Classes = [_selectedClassString_level_2,"VANILLA - AAF"] call _fn_getSelectedClasses;

private _selectedClassString_level_3 = ["BLWK_level3Faction" call BIS_fnc_getParamValue] call _fn_getFactionString;
private _level3Classes = [_selectedClassString_level_3,"VANILLA - CSAT"] call _fn_getSelectedClasses;

private _selectedClassString_level_4 = ["BLWK_level4Faction" call BIS_fnc_getParamValue] call _fn_getFactionString;
private _level4Classes = [_selectedClassString_level_4,"VANILLA - CSAT URBAN"] call _fn_getSelectedClasses;

private _selectedClassString_level_5 = ["BLWK_level5Faction" call BIS_fnc_getParamValue] call _fn_getFactionString;
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