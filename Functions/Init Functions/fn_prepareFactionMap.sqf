#include "..\..\Headers\Faction Map Ids.hpp"
/* ----------------------------------------------------------------------------
Function: BLWK_fnc_prepareFactionMap

Description:
	Gets the user selected unit class tables used for spawning AI
	 and returns the desired on in the form of a hashmap.

	Executed from "BLWK_fnc_setupFactionMaps"

Parameters:
	0: _factionParamConfig : <CONFIG> - The config of the corresponding mission parameter for this faction
	1: _changingDuringMission : <BOOL> - Is this being run during the mission (not part of initialization)

Returns:
	HASHMAP - A map of the unit classes from the faction config.

Examples:
    (begin example)
		BLWK_level1Faction_map = [missionConfigFile >> "KISKA_missionParams" >> "Factions" >> "BLWK_friendlyFaction"] call BLWK_fnc_prepareFactionMap;
    (end)

Author(s):
	Ansible2 // Cipher,
	Hilltop(Willtop) & omNomios
---------------------------------------------------------------------------- */
scriptName "BLWK_fnc_prepareFactionMap";

params [
	["_factionParamConfig",configNull,[configNull]],
	["_changingDuringMission",false,[true]]
];

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
private _factionString = [_factionParamConfig,false] call KISKA_fnc_paramsMenu_getCurrentParamValue;
// this ensures that the JIP players are syncing on the factions that are current for the wave
// and not factions that are queued for a change
if (!_changingDuringMission AND !(localNamespace getVariable ["BLWK_intialFactionsInitDone",false])) then {
	_factionString = missionNamespace getVariable [[_factionParamConfig] call KISKA_fnc_paramsMenu_getParamVarName + "_current",_factionString];
};

private _defaultFactionString = [_factionParamConfig] call KISKA_fnc_paramsMenu_getDefaultParamValue;


private _factionMap = [];
private _goToDefaultFaction = false;

private _everyFactionConfigHashMap = localNamespace getVariable "BLWK_factionConfigsMap";
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
