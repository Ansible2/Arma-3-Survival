#include "..\..\Headers\descriptionEXT\supportDefines.hpp"
#include "..\..\Headers\descriptionEXT\GUI\shopGUICommonDefines.hpp"
#include "..\..\Headers\Faction Map Ids.hpp"
/* ----------------------------------------------------------------------------
Function: BLWK_fnc_prepareGlobals

Description:
	Does exactly what it says. Most globals in the scenario are initialized here.

	It is executed from the "initPlayerLocal.sqf & initServer.sqf".

Parameters:
	NONE

Returns:
	Nothing

Examples:
    (begin example)
		call BLWK_fnc_prepareGlobals
    (end)
---------------------------------------------------------------------------- */
// BLWK_startingWaveNumber is a seperate variable to avoid having saves of mission params mid-mission affected by BLWK_currentWaveNumber being increased
BLWK_currentWaveNumber = BLWK_startingWaveNumber;

if (isServer) then {
    // We don't need to constantly check if the server is dedicated, and we only want to run things like
    /// playSound and hud updates on a server with an interface (0) or just clients (-2)
    BLWK_allClientsTargetID = [0,-2] select isDedicated;
    publicVariable "BLWK_allClientsTargetID";

    BLWK_logicCenter = createCenter sideLogic;

    // check if headless client is loaded
    if (isNil "BLWK_headlessClient") then {
        private _logicGroup = createGroup BLWK_logicCenter;
        _aiHandlerEntity = _logicGroup createUnit ["Logic", [0,0,0], [], 0, "NONE"];
        BLWK_theAIHandlerEntity = _aiHandlerEntity;
    } else {
        BLWK_theAIHandlerEntity = BLWK_headlessClient;
    };
    publicVariable "BLWK_theAIHandlerEntity";

    // number should never be zero, but it can be for some time until the server has initialized
    waitUntil {
        if (owner BLWK_theAIHandlerEntity isNotEqualTo 0) exitWith {true};
        sleep 1;
        false
    };
    BLWK_theAIHandlerOwnerID = owner BLWK_theAIHandlerEntity;
    // having an owner id for the AI handler makes using setVariable remotely possible
    publicVariable "BLWK_theAIHandlerOwnerID";


    // LOCATION LIST OPTIONS
    BLWK_locations = nearestlocations [[0,0,0],["nameVillage","nameCity","nameCityCapital","nameMarine","Airport"],worldsize * sqrt 2];

    // for revealing loot and deleteing it at the end of the round
    BLWK_lootMarkers = [];
    BLWK_lootHolders = [];

    // the marker that denotes the play area on the map
    BLWK_playAreaMarker = "";

    // used to delete dead bodies after the parameter set amount of time
    BLWK_deadBodies_1 = [];
    BLWK_deadBodies_2 = [];

    // keeping players in the same group upon respawn
    createCenter BLUFOR;
    BLWK_playerGroup = createGroup [BLUFOR,false];
    publicVariable "BLWK_playerGroup";

    if (BLWK_currentWaveNumber isEqualTo 0) then {
        BLWK_startingFromWaveNumber = BLWK_currentWaveNumber + 1;
    } else {
        BLWK_startingFromWaveNumber = BLWK_currentWaveNumber;
    };

    BLWK_specialWaveConfigs = "true" configClasses (missionConfigFile >> "BLWK_waveTypes" >> "specialWaves");
    BLWK_normalWaveConfigs = "true" configClasses (missionConfigFile >> "BLWK_waveTypes" >> "normalWaves");
};
if (isServer OR {!hasInterface}) then {
    if (isServer) then {
        ["<t size = '.5'>Preparing Loot Class Vars...<br/>Please wait...</t>", 0, 0, 10, 0] remoteExec ["BIS_fnc_dynamicText", BLWK_allClientsTargetID];
    };

    private _serverExit = {
        params ["_message"];

        [_message,true] remoteExecCall ["KISKA_fnc_log",0];
		sleep 10;
		["LootListErrorEnd"] call BIS_fnc_endMissionServer;
    };

    // loot classes
    private _lootClasses = call BLWK_fnc_prepareLootClasses;
    // the headless client needs this for weapon randomization
    BLWK_loot_weaponClasses = []; // for getting all weapons into the same pool for spawning loot
    BLWK_loot_primaryWeapons = _lootClasses select 0; // the individual split ups are for use with BLWK_fnc_randomizeWeapons
    BLWK_loot_weaponClasses append BLWK_loot_primaryWeapons;
    BLWK_loot_handgunWeapons = _lootClasses select 1;
    BLWK_loot_weaponClasses append BLWK_loot_handgunWeapons;
    BLWK_loot_launchers = _lootClasses select 2;
    BLWK_loot_weaponClasses append BLWK_loot_launchers;

    BLWK_loot_backpackClasses = _lootClasses select 3;
    BLWK_loot_vestClasses = _lootClasses select 4;
    BLWK_loot_uniformClasses = _lootClasses select 5;
    BLWK_loot_headGearClasses = _lootClasses select 6;
    BLWK_loot_itemClasses = _lootClasses select 7;
    BLWK_loot_explosiveClasses = _lootClasses select 8;

    if (isServer) then {
        private _emptyIndex = [
            BLWK_loot_weaponClasses,
            BLWK_loot_backpackClasses,
            BLWK_loot_vestClasses,
            BLWK_loot_uniformClasses,
            BLWK_loot_headGearClasses,
            BLWK_loot_itemClasses,
            BLWK_loot_explosiveClasses
        ] find [];

        switch (_emptyIndex) do {
            case 0: {
                ["There are no weapon classes loaded in the current list (handgun, primaries, and/or launchers), mission will be aborted"] spawn _serverExit;
            };
            case 1: {
                ["There are no backpack classes loaded in the current list, mission will be aborted"] spawn _serverExit;
            };
            case 2: {
                ["There are no vest classes loaded in the current list, mission will be aborted"] spawn _serverExit;
            };
            case 3: {
                ["There are no uniform classes loaded in the current list, mission will be aborted"] spawn _serverExit;
            };
            case 4: {
                ["There are no headgear classes loaded in the current list, mission will be aborted"] spawn _serverExit;
            };
            case 5: {
                ["There are no item classes loaded in the current list, mission will be aborted"] spawn _serverExit;
            };
            case 6: {
                ["There are no explosive classes loaded in the current list, mission will be aborted"] spawn _serverExit;
            };
        };
    };

    BLWK_infantrySpawnPositions = [];
    BLWK_vehicleSpawnPositions = [];

    // used for chaning medical items of OPTRE units (biofoam to FAKs)
    BLWK_isOptreLoaded = ["OPTRE_core"] call KISKA_fnc_ispatchLoaded;

};




// AI unit classes
private _unitTypeInfo = call BLWK_fnc_prepareUnitClasses;

// friendly
BLWK_friendlyFactionMap = _unitTypeInfo select 0;
BLWK_friendly_menClasses = BLWK_friendlyFactionMap get INFANTRY_FACTION_MAP_ID;
//BLWK_friendly_vehicleClasses = ;

// level 1
BLWK_level1_factionMap = _unitTypeInfo select 1;
BLWK_level1_menClasses = BLWK_level1_factionMap get INFANTRY_FACTION_MAP_ID;
// level 2
BLWK_level2_factionMap = _unitTypeInfo select 2;
BLWK_level2_menClasses = BLWK_level2_factionMap get INFANTRY_FACTION_MAP_ID;
// level 3
BLWK_level3_factionMap = _unitTypeInfo select 3;
BLWK_level3_menClasses = BLWK_level3_factionMap get INFANTRY_FACTION_MAP_ID;
// level 4
BLWK_level4_factionMap = _unitTypeInfo select 4;
BLWK_level4_menClasses = BLWK_level4_factionMap get INFANTRY_FACTION_MAP_ID;
// level 5
BLWK_level5_factionMap = _unitTypeInfo select 5;
BLWK_level5_menClasses = BLWK_level5_factionMap get INFANTRY_FACTION_MAP_ID;



private _uniformClass = "";
BLWK_friendly_menClasses apply {
    _uniformClass = getText(configfile >> "CfgVehicles" >> _x >> "uniformClass");
    if (_uniformClass isNotEqualTo "") then {
        break;
    };
};
BLWK_uniformClass = _uniformClass;


// keep track of a satellite shop being out or not
if (isNil "BLWK_satShopOut") then {
    BLWK_satShopOut = false;
};

if (isNil "BLWK_inBetweenWaves") then {
    BLWK_inBetweenWaves = true;
};


// Points
BLWK_pointsForHeal = 15 * BLWK_pointsForKill; // points to heal player at bulwark
BLWK_maxPointsForDamage = BLWK_pointsForHit * 2; // There are certain weapons that cause extreme amounts of damage that will give an immense amount of points, so this caps it

// check if vanilla revive is on
BLWK_dontUseRevive = BLWK_ReviveMode isEqualTo 0;

BLWK_ACELoaded = ["ace_common"] call KISKA_fnc_ispatchLoaded;


BLWK_costToSpinRandomBox = 950;

if (isNil "BLWK_randomWeaponBoxFound") then {
    BLWK_randomWeaponBoxFound = false;
};

if (isNil"BLWK_communityKillPoints") then {
    BLWK_communityKillPoints = BLWK_startingCommunityKillPoints;
};

// shop arrays
BLWK_supports_array = [missionConfigFile >> "CfgCommunicationMenu"] call BLWK_fnc_createSupportsArray;
BLWK_supports_array sort true; // will sort by the price

BLWK_buildableObjectsHash = [missionConfigFile >> "BLWK_buildableItems"] call BLWK_fnc_createBuildObjectsHash;


if (isServer) then {
    missionNamespace setVariable ["BLWK_serverGlobalsInitialized",true,true];
};
