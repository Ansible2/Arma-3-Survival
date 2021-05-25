#include "..\..\Headers\descriptionEXT\supportDefines.hpp"
#include "..\..\Headers\descriptionEXT\GUI\shopGUICommonDefines.hpp"
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
        if (owner BLWK_theAIHandlerEntity != 0) exitWith {true};
        sleep 1;
        false
    };
    BLWK_theAIHandlerOwnerID = owner BLWK_theAIHandlerEntity;
    // having an owner id for the AI handler makes using setVariable remotely possible
    publicVariable "BLWK_theAIHandlerOwnerID";


    BLWK_loot_whiteListMode = ("BLWK_loot_whiteListMode" call BIS_fnc_getParamValue);

    /* LOCATION LIST OPTIONS */
    BLWK_locations = nearestlocations [[0,0,0],["nameVillage","nameCity","nameCityCapital","nameMarine","Airport"],worldsize * sqrt 2];
    BLWK_minNumberOfHousesInArea = ("BLWK_minNumberOfHousesInArea" call BIS_fnc_getParamValue);

    /* Random Loot */
    BLWK_loot_cityDistribution = ("BLWK_loot_cityDistribution" call BIS_fnc_getParamValue);  // decides how many buildings will be marked as having loot in a city
    BLWK_loot_roomDistribution = ("BLWK_loot_roomDistribution" call BIS_fnc_getParamValue);  // decides how much loot will be in a building if it has any at all
    BLWK_maxLootSpawns = "BLWK_maxLootSpawns" call BIS_fnc_getParamValue;

    /* Time of Day*/
    BLWK_timeOfDay = ("BLWK_timeOfDay" call BIS_fnc_getParamValue);
	BLWK_daySpeedMultiplier = ("BLWK_daySpeedMultiplier" call BIS_fnc_getParamValue);

    /* Starter MediKits */
    BLWK_numMedKits = ("BLWK_numMedKits" call BIS_fnc_getParamValue);

    BLWK_timeBetweenRounds = ("BLWK_timeBetweenRounds" call BIS_fnc_getParamValue);
    BLWK_maxNumWaves = ("BLWK_maxNumWaves" call BIS_fnc_getParamValue);

    BLWK_buildingsNearTheCrateAreIndestructable_radius = ("BLWK_buildingsNearTheCrateAreIndestructable_radius" call BIS_fnc_getParamValue);

    // for revealing loot and deleteing it at the end of the round
    BLWK_lootMarkers = [];
    BLWK_lootHolders = [];

    // the marker that denotes the play area on the map
    BLWK_playAreaMarker = "";

    // used to determine if players will select a custom location to defend at
    BLWK_customPlayLocation = [false,true] select ("BLWK_customPlayLocation" call BIS_fnc_getParamValue);

    // used to delete dead bodies after the parameter set amount of time
    BLWK_deadBodies_1 = [];
    BLWK_deadBodies_2 = [];
    BLWK_roundsBeforeBodyDeletion = "BLWK_roundsBeforeBodyDeletion" call BIS_fnc_getParamValue;

    // deletion for dropped items
    BLWK_deleteDroppedItemsEvery = "BLWK_deleteDroppedItemsEvery" call BIS_fnc_getParamValue;

    BLWK_specialWaveLikelihood = ("BLWK_specialWaveLikelihood" call BIS_fnc_getParamValue) / 10;

    // keeping players in the same group upon respawn
    createCenter BLUFOR;
    BLWK_playerGroup = createGroup [BLUFOR,false];
    publicVariable "BLWK_playerGroup";
};
if (isServer OR {!hasInterface}) then {
    /* DLC exclusion */
/*
    // all of theses still need to be added to missionParams

    // need to get the DLC strigs returned by getAssetDLCInfo when 2.00 comes out
    BLWK_useableDLCs = [];

    BLWK_canUseApexDLC = [false,true] select ("BLWK_canUseApexDLC" call BIS_fnc_getParamValue);
    if (BLWK_canUseApexDLC) then {BLWK_useableDLCs pushBack ""};

    BLWK_canUseLOWDLC = [false,true] select ("BLWK_canUseLOWDLC" call BIS_fnc_getParamValue);
    if (BLWK_canUseLOWDLC) then {BLWK_useableDLCs pushBack ""};

    BLWK_canUseMarksmanDLC = [false,true] select ("BLWK_canUseMarksmanDLC" call BIS_fnc_getParamValue);
    if (BLWK_canUseMarksmanDLC) then {BLWK_useableDLCs pushBack ""};

    BLWK_canUseContactDLC = [false,true] select ("BLWK_canUseContactDLC" call BIS_fnc_getParamValue);
    if (BLWK_canUseContactDLC) then {BLWK_useableDLCs pushBack ""};

    BLWK_canUseTankstDLC = [false,true] select ("BLWK_canUseTankstDLC" call BIS_fnc_getParamValue);
    if (BLWK_canUseTankstDLC) then {BLWK_useableDLCs pushBack ""};
*/

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

    // How many hostiles per wave (waveCount x BLWK_enemiesPerWaveMultiplier)
    BLWK_enemiesPerWaveMultiplier = ("BLWK_enemiesPerWaveMultiplier" call BIS_fnc_getParamValue) / 10;
    // How many extra units are added per player
    BLWK_enemiesPerPlayerMultiplier = ("BLWK_enemiesPerPlayerMultiplier" call BIS_fnc_getParamValue) / 10;
    // What wave enemies stop only using pistols
    BLWK_maxPistolOnlyWaves = ("BLWK_maxPistolOnlyWaves" call BIS_fnc_getParamValue);
    BLWK_randomizeEnemyWeapons = [false,true] select ("BLWK_randomizeEnemyWeapons" call BIS_fnc_getParamValue);

    BLWK_vehicleStartWave = ("BLWK_vehicleStartWave" call BIS_fnc_getParamValue);
    BLWK_specialWavesStartAt = ("BLWK_specialWavesStartAt" call BIS_fnc_getParamValue);

    // vehicle spawns
    BLWK_lightCarLikelihood = ("BLWK_lightCarLikelihood" call BIS_fnc_getParamValue);
    BLWK_heavyCarLikelihood = ("BLWK_heavyCarLikelihood" call BIS_fnc_getParamValue);
    BLWK_lightArmorLikelihood = ("BLWK_lightArmorLikelihood" call BIS_fnc_getParamValue);
    BLWK_heavyArmorLikelihood = ("BLWK_heavyArmorLikelihood" call BIS_fnc_getParamValue);
    BLWK_baseVehicleSpawnLikelihood = ("BLWK_baseVehicleSpawnLikelihood" call BIS_fnc_getParamValue);

    BLWK_infantrySpawnPositions = [];
    BLWK_vehicleSpawnPositions = [];

    // this is used to only allow only so many AI to be active at any time
    BLWK_maxEnemyInfantryAtOnce = ("BLWK_maxEnemyInfantryAtOnce" call BIS_fnc_getParamValue);

    // used for chaning medical items of OPTRE units (biofoam to FAKs)
    BLWK_isOptreLoaded = ["OPTRE_core"] call KISKA_fnc_ispatchLoaded;

    // Enemy AI
    BLWK_doDetectCollision = [false,true] select ("BLWK_doDetectCollision" call BIS_fnc_getParamValue);
    BLWK_doDetectMines = [false,true] select ("BLWK_doDetectMines" call BIS_fnc_getParamValue);
    BLWK_suppressionEnabled = [false,true] select ("BLWK_suppressionEnabled" call BIS_fnc_getParamValue);
    BLWK_autocombatEnabled = [false,true] select ("BLWK_autocombatEnabled" call BIS_fnc_getParamValue);

    // Minimum amount of waves between vehicles
    BLWK_minRoundsSinceVehicleSpawned = "BLWK_minRoundsSinceVehicleSpawned" call BIS_fnc_getParamValue;
};
if (hasInterface) then {
    /* Starting Items */
    BLWK_playersStartWith_pistol = [false,true] select ("BLWK_playersStartWith_pistol" call BIS_fnc_getParamValue);
    BLWK_playersStartWith_compass = [false,true] select ("BLWK_playersStartWith_compass" call BIS_fnc_getParamValue);
    BLWK_playersStartWith_mineDetector = [false,true] select ("BLWK_playersStartWith_mineDetector" call BIS_fnc_getParamValue);
    BLWK_playersStartWith_radio = [false,true] select ("BLWK_playersStartWith_radio" call BIS_fnc_getParamValue);
    BLWK_playersStartWith_map = [false,true] select ("BLWK_playersStartWith_map" call BIS_fnc_getParamValue);
    BLWK_playersStartWith_NVGs = [false,true] select ("BLWK_playersStartWith_NVGs" call BIS_fnc_getParamValue);

    BLWK_friendlyFireOn = [false,true] select ("BLWK_friendlyFireOn" call BIS_fnc_getParamValue);
    BLWK_fallDamageOn = [false,true] select ("BLWK_fallDamageOn" call BIS_fnc_getParamValue);
    BLWK_showHitPoints = [false,true] select ("BLWK_showHitPoints" call BIS_fnc_getParamValue);

    BLWK_saveRespawnLoadout = [false,true] select ("BLWK_saveRespawnLoadout" call BIS_fnc_getParamValue);
    BLWK_magRepackEnabled = [false,true] select ("BLWK_magRepackEnabled" call BIS_fnc_getParamValue);

    BLWK_staminaEnabled = [false,true] select ("BLWK_staminaEnabled" call BIS_fnc_getParamValue);
    BLWK_weaponSwayCoef = ("BLWK_weaponSwayCoef" call BIS_fnc_getParamValue) / 100;

    BLWK_multipleLootReveals = [false,true] select ("BLWK_multipleLootReveals" call BIS_fnc_getParamValue);
    BLWK_aircraftGunnerLifetime = "BLWK_aircraftGunnerLifetime" call BIS_fnc_getParamValue;

    if (isNil "BLWK_communityKillPoints") then {
       BLWK_communityKillPoints = "BLWK_startingCommunityKillPoints" call BIS_fnc_getParamValue;
    };
};

// keep track of a satellite shop being out or not
if (isNil "BLWK_satShopOut") then {
    BLWK_satShopOut = false;
};


// AI unit classes
private _unitTypeInfo = call BLWK_fnc_prepareUnitClasses;

// friendly
BLWK_friendly_menClasses = _unitTypeInfo select 0;
BLWK_friendly_vehicleClasses = _unitTypeInfo select 1;


private _uniformClass = "";
BLWK_friendly_menClasses apply {
    _uniformClass = getText(configfile >> "CfgVehicles" >> _x >> "uniformClass");
    if (_uniformClass isNotEqualTo "") then {
        break;
    };
};
BLWK_uniformClass = _uniformClass;


// level 1
BLWK_level1_menClasses = _unitTypeInfo select 2;
BLWK_level1_vehicleClasses = _unitTypeInfo select 3;
// level 2
BLWK_level2_menClasses = _unitTypeInfo select 4;
BLWK_level2_vehicleClasses = _unitTypeInfo select 5;
// level 3
BLWK_level3_menClasses = _unitTypeInfo select 6;
BLWK_level3_vehicleClasses = _unitTypeInfo select 7;
// level 4
BLWK_level4_menClasses = _unitTypeInfo select 8;
BLWK_level4_vehicleClasses = _unitTypeInfo select 9;
// level 5
BLWK_level5_menClasses = _unitTypeInfo select 10;
BLWK_level5_vehicleClasses = _unitTypeInfo select 11;

if (isNil "BLWK_currentWaveNumber") then {
    BLWK_currentWaveNumber = "BLWK_startingWaveNumber" call BIS_fnc_getParamValue;
    BLWK_startingFromWaveNumber = BLWK_currentWaveNumber + 1;
};
if (isNil "BLWK_inBetweenWaves") then {
    BLWK_inBetweenWaves = true;
};
if (isNil "BLWK_numRespawnTickets") then {
    BLWK_numRespawnTickets = "BLWK_numRespawnTickets" call BIS_fnc_getParamValue;
};
if (isNil "BLWK_playAreaRadius") then {
    BLWK_playAreaRadius = "BLWK_playAreaRadius" call BIS_fnc_getParamValue; // Total play area radius in meters
};
if (isNil "BLWK_faksToMakeMedkit") then {
    BLWK_faksToMakeMedkit = "BLWK_faksToMakeMedkit" call BIS_fnc_getParamValue;
};

/* Points */
BLWK_pointsForKill = "BLWK_pointsForKill" call BIS_fnc_getParamValue;
BLWK_pointsForHeal = 15 * BLWK_pointsForKill; // points to heal player at bulwark
BLWK_pointsForHit = "BLWK_pointsForHit" call BIS_fnc_getParamValue;                   // Every Bullet hit
BLWK_pointsMultiForDamage = "BLWK_pointsMultiForDamage" call BIS_fnc_getParamValue;   // Extra points awarded for damage. 100% = BLWK_pointsMultiForDamage. 50% = BLWK_pointsMultiForDamage/2
BLWK_maxPointsForDamage = BLWK_pointsForHit * 2; // There are certain weapons that cause extreme amounts of damage that will give an immense amount of points, so this caps it

// check if vanilla revive is on
BLWK_dontUseRevive = (("ReviveMode" call BIS_fnc_getParamValue) isEqualTo 0);

BLWK_ACELoaded = ["ace_common"] call KISKA_fnc_ispatchLoaded;


BLWK_costToSpinRandomBox = 950;
if (isNil "BLWK_supportDishFound") then {
    BLWK_supportDishFound = [false,true] select ("BLWK_supportDishFound" call BIS_fnc_getParamValue);
};
if (isNil "BLWK_randomWeaponBoxFound") then {
    BLWK_randomWeaponBoxFound = false;
};


// Point multipliers of BLWK_pointsForKill for different waves
BLWK_pointsMulti_man_level1 = 0.75;
BLWK_pointsMulti_man_level2 = 1;
BLWK_pointsMulti_man_level3 = 1.25;
BLWK_pointsMulti_man_level4 = 1.50;
BLWK_pointsMulti_man_level5 = 1.75;
BLWK_pointsMulti_car = 5;
BLWK_pointsMulti_armour = 10;



// shop arrays
BLWK_supports_array = [missionConfigFile >> "CfgCommunicationMenu"] call BLWK_fnc_createSupportsArray;
BLWK_supports_array sort true; // will sort by the price

BLWK_buildableObjectsHash = [missionConfigFile >> "BLWK_buildableItems"] call BLWK_fnc_createBuildObjectsHash;



if (isServer) then {
    missionNamespace setVariable ["BLWK_serverGlobalsInitialized",true,true];
};
