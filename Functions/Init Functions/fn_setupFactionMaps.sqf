#include "..\..\Headers\Faction Map Ids.hpp"
/* ----------------------------------------------------------------------------
Function: BLWK_fnc_setupFactionMaps

Description:
	Gets the user selected unit class tables used for spawning AI
	 and returns the desired on in the form of a hashmap.

	Executed from "BLWK_fnc_prepareGlobals"

Parameters:
	NONE

Returns:
	NOTHING

Examples:
    (begin example)
		call BLWK_fnc_setupFactionMaps;
    (end)

Author(s):
	Ansible2 // Cipher,
	Hilltop(Willtop) & omNomios
---------------------------------------------------------------------------- */
scriptName "BLWK_fnc_setupFactionMaps";

[
    "BLWK_friendlyFaction",
    "BLWK_level1Faction",
    "BLWK_level2Faction",
    "BLWK_level3Faction",
    "BLWK_level4Faction",
    "BLWK_level5Faction"
] apply {
    private _map = [_x] call BLWK_fnc_prepareFactionMap;
    missionNamespace setVariable [_x + "_map",_map];
    missionNamespace setVariable [_x + "_menClasses",_map get INFANTRY_FACTION_MAP_ID];

    if (isServer) then {
        missionNamespace setVariable [_x + "_current",_x];
    };
};
