#include "..\..\Headers\Faction Map Ids.hpp"
/* ----------------------------------------------------------------------------
Function: BLWK_fnc_prepareUnitClasses

Description:
	Gets the user selected unit class tables used for spawning AI
	 and returns the desired on in the form of a hashmap.

	Executed from "BLWK_fnc_prepareGlobals"

Parameters:
	0: _factionParamConfig : <CONFIG or STRING> - The config of the corresponding mission parameter for this faction
        e.g."BLWK_friendlyFaction" for the friendly faction mission parameter or
        missionConfigFile >> "KISKA_missionParams" >> "Factions" >> "BLWK_friendlyFaction"

Returns:
	HASHMAP - A map of the unit classes from the faction config.

Examples:
    (begin example)
		BLWK_level1_factionMap = ["BLWK_level1Faction"] call BLWK_fnc_prepareUnitClasses;
    (end)

Author(s):
	Ansible2 // Cipher,
	Hilltop(Willtop) & omNomios
---------------------------------------------------------------------------- */
scriptName "BLWK_fnc_prepareUnitClasses";

params [
	["_factionParamConfig",configNull,["",configNull]]
];

if (_factionParamConfig isEqualType "") then {
    _factionParamConfig = missionConfigFile >> "KISKA_missionParams" >> "Factions" >> _factionParamConfig;
};

if (isNull _factionParamConfig) exitWith {
    ["A null config was passed!",true] call KISKA_fnc_log;
    createHashMap;
};

/* ----------------------------------------------------------------------------
    _fn_exitForUndefinedDefault
    // if a default faction is invoked and undefined, the mission is improperly configured
---------------------------------------------------------------------------- */
private _fn_exitForUndefinedDefault = {
	[] spawn {
		["A default faction appears to be empty, the mission will now end to reconfigure parameters",true] remoteExecCall ["KISKA_fnc_log",0];
		sleep 20;
		["UnitClassesErrorEnd"] call BIS_fnc_endMissionServer;
	};
};


/* ----------------------------------------------------------------------------
    _fn_sortFactionClasses
    // Sort a faction's units based upon whether or not the unit classes provided exist
---------------------------------------------------------------------------- */
private _vehicleConfig = configFile >> "cfgVehicles";
private _fn_sortFactionClasses = {
	params ["_configToCheck"];

	private _factionClassesHashMap = createHashMap;

    /* ----------------------------------------------------------------------------
        _fn_sortArray
        // check which classes exist in this particulary part of the faction table
    ---------------------------------------------------------------------------- */
	private _fn_sortArray = {
		params ["_id","_sortArray"];

		private _availableClasses = [];
		if (_sortArray isNotEqualTo []) then {
			_sortArray apply {
				if (isClass (_vehicleConfig >> _x)) then {
					_availableClasses pushBack (toLowerANSI _x);

				};
			};
		};

		_factionClassesHashMap set [_id,_availableClasses];
	};


	[
		INFANTRY_FACTION_MAP_ID,
		[_configToCheck >> "infantry"] call BIS_fnc_getCfgDataArray
	] call _fn_sortArray;

	// exit if no infantry
	if ((_factionClassesHashMap get INFANTRY_FACTION_MAP_ID) isEqualTo []) exitWith {
		[["Found no infantry classes in config ",_configToCheck],true] call KISKA_fnc_log;
		[]
	};


	[
		[
			LIGHT_CAR_FACTION_MAP_ID,
			[_configToCheck >> "lightCars"] call BIS_fnc_getCfgDataArray
		],
		[
			HEAVY_CAR_FACTION_MAP_ID,
			[_configToCheck >> "heavyCars"] call BIS_fnc_getCfgDataArray
		],
		[
			LIGHT_ARMOR_FACTION_MAP_ID,
			[_configToCheck >> "lightArmor"] call BIS_fnc_getCfgDataArray
		],
		[
			HEAVY_ARMOR_FACTION_MAP_ID,
			[_configToCheck >> "heavyArmor"] call BIS_fnc_getCfgDataArray
		],
		[
			TRANSPORT_HELI_FACTION_MAP_ID,
			[_configToCheck >> "transportHelicopters"] call BIS_fnc_getCfgDataArray
		],
		[
			CARGO_ACFT_FACTION_MAP_ID,
			[_configToCheck >> "cargoAircraft"] call BIS_fnc_getCfgDataArray
		],
		[
			CAS_ACFT_FACTION_MAP_ID,
			[_configToCheck >> "casAircraft"] call BIS_fnc_getCfgDataArray
		],
		[
			ATTACK_HELI_FACTION_MAP_ID,
			[_configToCheck >> "attackHelicopters"] call BIS_fnc_getCfgDataArray
		],
		[
			HEAVY_GUNSHIP_FACTION_MAP_ID,
			[_configToCheck >> "heavyGunships"] call BIS_fnc_getCfgDataArray
		]
	] apply {
		_x call _fn_sortArray;
	};


	_factionClassesHashMap
};



/* ----------------------------------------------------------------------------

    Main Body

---------------------------------------------------------------------------- */
private _factionNames = call BLWK_fnc_KISKAParams_populateFactionList;
private _everyFactionConfigHashMap = _factionNames createHashMapFromArray (localNamespace getVariable "BLWK_factionConfigs");

private _factionString = [_factionParamConfig,false] call KISKA_fnc_paramsMenu_getCurrentParamValue;
private _defaultFactionString = [_factionParamConfig] call KISKA_fnc_paramsMenu_getDefaultParamValue;

private _factionMap = [];
private _goToDefaultFaction = false;

private _factionConfigPath = _everyFactionConfigHashMap getOrDefault [_factionString,configNull];
// if a faction was found for the string
if !(isNull _factionConfigPath) then {
	_factionMap = [_factionConfigPath] call _fn_sortFactionClasses;

	if (_factionMap isEqualTo []) then {
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
	_factionConfigPath = _everyFactionConfigHashMap getOrDefault [_defaultFactionString,configNull];

	// clients run BLWK_fnc_prepareUnitClasses after the server
	// this handles a faction not being present on the server but is present on the client
	// in which case the server will update all other machines (including JIP) to the default faction for the level
	private _serialConfig = [_factionParamConfig] call KISKA_fnc_paramsMenu_serializeConfig;
	private _JIP_id = [_serialConfig] call KISKA_fnc_paramsMenu_getJIPQueueId;
	[_serialConfig,_defaultFactionString,false] remoteExecCall ["KISKA_fnc_paramsMenu_paramChanged", 0, _JIP_id];


	if !(isNull _factionConfigPath) then {
		_factionMap = [_factionConfigPath] call _fn_sortFactionClasses;

		// if faction still came up empty
		if (_factionMap isEqualTo []) then {
			_doExit = true;
		};

	} else {
		_doExit = true;

	};


	if (_doExit AND {isServer}) then {
		call _fn_exitForUndefinedDefault
	};
};


_factionMap
