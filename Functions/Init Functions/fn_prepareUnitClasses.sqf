// set up MACRO vars that can be used between files and make changes easier
#include "..\..\Headers\Faction Headers\Define Factions.hpp"
#include "..\..\Headers\Faction Headers\Unit Tables\vanillaUnitTables.hpp"
#include "..\..\Headers\Faction Headers\Unit Tables\optreUnitTables.hpp"
#include "..\..\Headers\Faction Headers\Unit Tables\opcanUnitTables.hpp"
#include "..\..\Headers\Faction Headers\Unit Tables\RHS_AFRF Unit Tables.hpp"
#include "..\..\Headers\Faction Headers\Unit Tables\RHS_USAF Unit Tables.hpp"
#include "..\..\Headers\Faction Headers\Unit Tables\Z&DUnitTables.hpp"
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
private "_defaultFactionClasses";
private _tempUnitClass = "";


// check if a unit is an actual class and if they are dependent on exluded DLC
private _fn_checkTempClass = {
	if (isClass (configFile >> "CfgVehicles" >> _tempUnitClass) /*AND {[_tempUnitClass,"CfgVehicles"] call BLWK_fnc_checkDLC}*/) then {
		true;
	} else {
		false;
	};
};


// Sort a faction's units based upon what DLC is excluded and whether or not a unit class exists
private _fn_sortFactionClasses = {
	params ["_unitClassesToCheck"];
	
	private _allowedUnitClasses = [];
	_unitClassesToCheck apply {
		_tempUnitClass = _x;
		// exclude the vehicle array and make sure unit actual exists
		if (_tempUnitClass isEqualType "" AND {call _fn_checkTempClass}) then {
			_allowedUnitClasses pushBack _tempUnitClass;
		};
	};

	if (_allowedUnitClasses isEqualTo []) exitWith {
		// if the faction turns up empty based upon sorting, AND it is the default
		// exit the mission
		if (_unitClassesToCheck isEqualTo _defaultFactionClasses) then {
			null = [] spawn {
				null = ["A default faction appears to be empty, the mission will now end to reconfigure parameters"] remoteExec ["hint",0,true];
				sleep 20;
				call BIS_fnc_endMissionServer;
			};
		} else {
		// else, just load the default faction for that level
			["A faction you selected does not have any of units available. It may not be loaded on the server. The mission will use that level's default faction instead"] remoteExecCall ["hint",0,true];
			[_defaultFactionClasses] call _fn_sortFactionClasses
		};
	};

	// seperate vehicle types
	private _vehicleArrayIndex = _unitClassesToCheck findIf {_x isEqualType []};
	private _vehicleTypes = [];
	// if the vehicle array is found
	if !(_vehicleArrayIndex isEqualTo -1) then {
		_vehicleTypes = _unitClassesToCheck select _vehicleArrayIndex;
	};

	[_allowedUnitClasses,_vehicleTypes];
};

private _fn_getSelectedClasses = {
	params ["_factionString","_defaultFactionString"];

	// get faction to check
	private _index = [FACTION_STRINGS] findIf {_x == _factionString};
	private _classes = FACTION_VARS select _index;

	// setup default fall through faction
	_index = [FACTION_STRINGS] findIf {_x == _defaultFactionString};
	_defaultFactionClasses = FACTION_VARS select _index;

	private _return = [_classes] call _fn_sortFactionClasses;
	
	_return
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