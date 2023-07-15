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
// JIP players have wave number synced already
if (isNil "BLWK_currentWaveNumber") then {
    // BLWK_startingWaveNumber is a seperate variable to avoid having saves of mission params mid-mission affected by BLWK_currentWaveNumber being increased
    BLWK_currentWaveNumber = BLWK_startingWaveNumber;
};

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

    private _sortedMusicClasses = [
        "true" configClasses (configFile >> "CfgMusic"),
        [],
        { 
            private _songDisplayName = getText(_x >> "name");
            if (_songDisplayName isEqualTo "") then {
                _songDisplayName = configName _x;
            };
            _songDisplayName
        }
    ] call BIS_fnc_sortBy;
    missionNamespace setVariable ["BLWK_sortedServerMusicConfigs",_sortedMusicClasses,true];


    // number should never be zero, but it can be for some time until the server has initialized
    waitUntil {
        if ((owner BLWK_theAIHandlerEntity) isNotEqualTo 0) exitWith {true};
        sleep 1;
        false
    };
    BLWK_theAIHandlerOwnerID = owner BLWK_theAIHandlerEntity;
    // having an owner id for the AI handler makes using setVariable remotely possible
    publicVariable "BLWK_theAIHandlerOwnerID";
    [["Found AI Handler with Owner ID of ",BLWK_theAIHandlerOwnerID],false] call KISKA_fnc_log;


    BLWK_locations = nearestlocations [
        [0,0,0],
        ["nameVillage","nameCity","nameCityCapital","nameMarine","Airport"],
        worldsize * sqrt 2
    ];

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

    BLWK_startingFromWaveNumber = BLWK_currentWaveNumber + 1;

    BLWK_specialWaveConfigs = "true" configClasses (missionConfigFile >> "BLWK_waveTypes" >> "specialWaves");
    BLWK_normalWaveConfigs = "true" configClasses (missionConfigFile >> "BLWK_waveTypes" >> "normalWaves");    
};

if (isServer OR (!hasInterface)) then {
    // used for chaning medical items of OPTRE units (biofoam to FAKs)
    BLWK_isOptreLoaded = ["OPTRE_core"] call KISKA_fnc_ispatchLoaded;
};


[
    false,
    [
        "BLWK_friendlyFaction",
        "BLWK_level1Faction",
        "BLWK_level2Faction",
        "BLWK_level3Faction",
        "BLWK_level4Faction",
        "BLWK_level5Faction"
    ]
] call BLWK_fnc_setupFactionMaps;


private _uniformClass = "";
BLWK_friendlyFaction_menClasses apply {
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
