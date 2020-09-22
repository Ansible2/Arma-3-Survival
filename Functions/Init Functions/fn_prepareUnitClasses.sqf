/*
	It will be replaced by a GUI in the future in all likelihood that dynamically gets all loaded factions on the server
*/

// set up MACRO vars that can be used between files and make changes easier
#include "..\..\Headers\Faction Headers\Define Factions.hpp"
#include "..\..\Headers\Faction Headers\Unit Tables\vanillaUnitTables.hpp"


// to save on allocation time for memory, we are going to use temp values
private "_defaultFactionTypeClasses";
private _tempUnitClass = "";
private _unitClassAvailable = true;


// check if a unit is an actual class and if they are dependent on exluded DLC
private _fn_checkTempClass = {

	if (isClass (configFile >> "CfgVehicles" >> _tempUnitClass)) then {
		_unitClassAvailable = [_tempUnitClass,"CfgVehicles"] call BLWK_fnc_checkDLC;
	} else {
		_unitClassAvailable = false;
	};

	_unitClassAvailable
};


// Sort a faction's units based upon what DLC is excluded and whether or not a unit class exists
private _fn_sortFactionClasses = {
	params ["_unitClassesToCheck"];
	
	private _allowedUnitClasses = [];
	_unitClassesToCheck apply {
		_tempUnitClass = _x;
		if (_tempUnitClass isEqualType "" AND {call _fn_checkTempClass}) then {
			_allowedUnitClasses pushBack _tempUnitClass;
		};
	};

	if (_allowedUnitClasses isEqualTo []) exitWith {
		// if the faction turns up empty based upon sorting, AND it is the default
		// exit the mission
		if (_unitClassesToCheck isEqualTo _defaultFactionTypeClasses) then {
			null = [] spawn {
				["One of the selected factions unfortunately came up empty, the mission will end to allow you to reconfigure params"] remoteExecCall ["hint",0,true];
				sleep 20;
				call BIS_fnc_endMissionServer;
			};
		} else {
		// else, just load the default faction for that section
			[_defaultFactionTypeClasses] call _fn_sortFactionClasses
		};
	};

	// seperate vehicle types
	private _vehicleTypes = _unitClassesToCheck select (_unitClassesToCheck findIf {_x isEqualType []});

	[_allowedUnitClasses,_vehicleTypes];
};


private _fn_getSelectedClasses = {
	params ["_factionString","_defaultFactionString"];

	// get faction to check
	private _index = FACTION_STRINGS findIf {_x == _factionString};
	private _classes = FACTION_VARS select _index;

	// setup default fall through faction
	_index = FACTION_STRINGS findIf {_x == _defaultFactionString};
	_defaultFactionTypeClasses = FACTION_VARS select _index;

	private _return = [_classes] call _fn_sortFactionClasses;
	
	_return
};



// get faction classes
private _friendlyClasses = [("BLWK_friendlyFaction" call BIS_fnc_getParamValue),"NATO"] call _fn_getFactionClasses;
private _level1Classes = [("BLWK_level1Faction" call BIS_fnc_getParamValue),"FIA"] call _fn_getFactionClasses;
private _level2Classes = [("BLWK_level2Faction" call BIS_fnc_getParamValue),"AAF"] call _fn_getFactionClasses;
private _level3Classes = [("BLWK_level3Faction" call BIS_fnc_getParamValue),"CSAT"] call _fn_getFactionClasses;
private _level4Classes = [("BLWK_level4Faction" call BIS_fnc_getParamValue),"CSAT URBAN"] call _fn_getFactionClasses;
private _level5Classes = [("BLWK_level5Faction" call BIS_fnc_getParamValue),"VIPER"] call _fn_getFactionClasses;

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