#include "..\..\Headers\Faction Map Ids.hpp"
/* ----------------------------------------------------------------------------
Function: BLWK_fnc_setupFactionMaps

Description:
	Creates all the hashmaps used for selecting classes to create units during
     the mission.

	Executed from "BLWK_fnc_prepareGlobals" and "BLWK_fnc_endWave"

Parameters:
	0: _changingDuringMission : <BOOL> - Is this being run during the mission (not part of initialization)

Returns:
	NOTHING

Examples:
    (begin example)
		call BLWK_fnc_setupFactionMaps;
    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
scriptName "BLWK_fnc_setupFactionMaps";

params [
    ["_executedDuringMission",false,[true]]
];

if (isServer) then {
    localNamespace setVariable ["BLWK_factionChangeQueued",false];
};

if (isNil {localNamespace getVariable "BLWK_factionConfigsMap"}) then {
	private _factionNames = call BLWK_fnc_KISKAParams_populateFactionList;
	private _everyFactionConfigHashMap = _factionNames createHashMapFromArray (localNamespace getVariable "BLWK_factionConfigs");

	localNamespace setVariable ["BLWK_factionConfigsMap",_everyFactionConfigHashMap];
};


[
    "BLWK_friendlyFaction",
    "BLWK_level1Faction",
    "BLWK_level2Faction",
    "BLWK_level3Faction",
    "BLWK_level4Faction",
    "BLWK_level5Faction"
] apply {
    private _paramConfig = missionConfigFile >> "KISKA_missionParams" >> "Factions" >> _x;
    private _map = [_paramConfig,_executedDuringMission] call BLWK_fnc_prepareFactionMap;
    missionNamespace setVariable [_x + "_map",_map];
    missionNamespace setVariable [_x + "_menClasses",_map get INFANTRY_FACTION_MAP_ID];
    // updating from the server here as public var because a JIP player may not have the correct mission param value
    /// when joining and being synced. The mission param value will reflect a potentially queued change and not what
    /// is actually current for the wave. This casuses point awarding to be incorrect values as players need to know each unit table for the levels.
    if (isServer) then {
        missionNamespace setVariable [
            _x + "_current",
            [_paramConfig] call KISKA_fnc_paramsMenu_getCurrentParamValue,
            true
        ];
    };

};

if !(_executedDuringMission) then {
    localNamespace setVariable ["BLWK_intialFactionsInitDone",true];
};
