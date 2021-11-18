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

// friendly
BLWK_friendlyFactionMap = ["BLWK_friendlyFaction"] call BLWK_fnc_prepareFactionMap;
BLWK_friendly_menClasses = BLWK_friendlyFactionMap get INFANTRY_FACTION_MAP_ID;
// level 1
BLWK_level1_factionMap = ["BLWK_level1Faction"] call BLWK_fnc_prepareFactionMap;
BLWK_level1_menClasses = BLWK_level1_factionMap get INFANTRY_FACTION_MAP_ID;
// level 2
BLWK_level2_factionMap = ["BLWK_level2Faction"] call BLWK_fnc_prepareFactionMap;
BLWK_level2_menClasses = BLWK_level2_factionMap get INFANTRY_FACTION_MAP_ID;
// level 3
BLWK_level3_factionMap = ["BLWK_level3Faction"] call BLWK_fnc_prepareFactionMap;
BLWK_level3_menClasses = BLWK_level3_factionMap get INFANTRY_FACTION_MAP_ID;
// level 4
BLWK_level4_factionMap = ["BLWK_level4Faction"] call BLWK_fnc_prepareFactionMap;
BLWK_level4_menClasses = BLWK_level4_factionMap get INFANTRY_FACTION_MAP_ID;
// level 5
BLWK_level5_factionMap = ["BLWK_level5Faction"] call BLWK_fnc_prepareFactionMap;
BLWK_level5_menClasses = BLWK_level5_factionMap get INFANTRY_FACTION_MAP_ID;
