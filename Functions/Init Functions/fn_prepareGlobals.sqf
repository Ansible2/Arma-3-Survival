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
// cipher comment: this needs to be organized the same way it shows up in the params menu in the lobby
/// which itself may need to be reorganized


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

    // AI unit classes
    private _unitTypeInfo = call BLWK_fnc_prepareUnitClasses;
    BLWK_friendly_menClasses = _unitTypeInfo select 0;
    BLWK_friendly_vehicleClasses = _unitTypeInfo select 1;
    BLWK_level1_menClasses = _unitTypeInfo select 2;
    BLWK_level1_vehicleClasses = _unitTypeInfo select 3;
    BLWK_level2_menClasses = _unitTypeInfo select 4;
    BLWK_level2_vehicleClasses = _unitTypeInfo select 5;
    BLWK_level3_menClasses = _unitTypeInfo select 6;
    BLWK_level3_vehicleClasses = _unitTypeInfo select 7;
    BLWK_level4_menClasses = _unitTypeInfo select 8;
    BLWK_level4_vehicleClasses = _unitTypeInfo select 9;
    BLWK_level5_menClasses = _unitTypeInfo select 10;
    BLWK_level5_vehicleClasses = _unitTypeInfo select 11;

    BLWK_enemiesPerWaveMultiplier = ("BLWK_enemiesPerWaveMultiplier" call BIS_fnc_getParamValue);  // How many hostiles per wave (waveCount x BLWK_enemiesPerWaveMultiplier)
    BLWK_enemiesPerPlayerMultiplier = ("BLWK_enemiesPerPlayerMultiplier" call BIS_fnc_getParamValue);   // How many extra units are added per player
    BLWK_maxPistolOnlyWaves = ("BLWK_maxPistolOnlyWaves" call BIS_fnc_getParamValue);  //What wave enemies stop only using pistols
    BLWK_randomizeEnemyWeapons = [false,true] select ("BLWK_randomizeEnemyWeapons" call BIS_fnc_getParamValue);

    BLWK_vehicleStartWave = ("BLWK_vehicleStartWave" call BIS_fnc_getParamValue);
    BLWK_specialWavesStartAt = ("BLWK_specialWavesStartAt" call BIS_fnc_getParamValue);


    BLWK_infantrySpawnPositions = [];
    BLWK_vehicleSpawnPositions = [];

    // this is used to only allow so many AI to be active at any time
    BLWK_maxEnemyInfantryAtOnce = ("BLWK_maxEnemyInfantryAtOnce" call BIS_fnc_getParamValue);
};
if (isServer) then {
    // We don't need to constantly check if the server is dedicated, and we only want to run things like
    /// playSound and hud updates on a server with an interface (0) or just clients (-2)
    BLWK_allClientsTargetID = [0,-2] select isDedicated;
    publicVariable "BLWK_allClientsTargetID";

    // check if headless client is loaded
    // CIPHER COMMENT: may want to add an owner param too for use with setVariable
    private _headless = call BLWK_fnc_getHeadless;
    private _logicCenter = createCenter sideLogic;
    private _logicGroup = createGroup _logicCenter;
    private _serverlogic = _logicGroup createUnit ["Logic", [0,0,0], [], 0, "NONE"];
    BLWK_theAIHandlerEntity = [_headless,_serverlogic] select (isNull _headless);
    publicVariable "BLWK_theAIHandlerEntity";
    BLWK_theAIHandlerOwnerID = owner BLWK_theAIHandlerEntity;

    /* Whitelist Loot Modes */
    /* 0 = Off */
    /* 1 = Only Whitelist Items will spawn as loot */
    /* 2 = Whitelist items get added to existing loot (increases the chance of loot spawning */
    BLWK_loot_whiteListMode = 0;

    // loot classes
    private _lootClasses = call BLWK_fnc_prepareLootClasses;

    BLWK_loot_weaponClasses = []; // for spawning loot
    BLWK_loot_primaryWeapons = _lootClasses select 0; // for use with BLWK_fnc_randomizeWeapons
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

    /* LOCATION LIST OPTIONS */
    BLWK_locations = nearestlocations [[0,0,0],["nameVillage","nameCity","nameCityCapital","nameMarine","Airport"],worldsize * sqrt 2]; 
    BLWK_playAreaRadius = ("BLWK_playAreaRadius" call BIS_fnc_getParamValue); // Total play area radius in meters
    BLWK_minNumberOfHousesInArea = ("BLWK_minNumberOfHousesInArea" call BIS_fnc_getParamValue);

    /* Respawn */
    BLWK_respawnTime = ("BLWK_respawnTime" call BIS_fnc_getParamValue);
    BLWK_numRespawnTickets = ("BLWK_numRespawnTickets" call BIS_fnc_getParamValue);

    /* Random Loot */
    BLWK_loot_cityDistribution = ("BLWK_loot_cityDistribution" call BIS_fnc_getParamValue);  // decides how many buildings will be marked as having loot in a city
    BLWK_loot_roomDistribution = ("BLWK_loot_roomDistribution" call BIS_fnc_getParamValue);  // decides how much loot will be in a building if it has any at all

    /* Supports */
    BLWK_supplyDropRadius = ("BLWK_supplyDropRadius" call BIS_fnc_getParamValue);            // Radius of supply drop // CIPHER COMMENT: Not implimented
    BLWK_paratrooperCount = ("BLWK_paratrooperCount" call BIS_fnc_getParamValue);

    /* Time of Day*/
    BLWK_timeOfDay = ("BLWK_timeOfDay" call BIS_fnc_getParamValue);

    /* Starter MediKits */
    BLWK_numMedKits = ("BLWK_numMedKits" call BIS_fnc_getParamValue);
    BLWK_faksToMakeMedkit = ("BLWK_faksToMakeMedkit" call BIS_fnc_getParamValue);

    BLWK_timeBetweenRounds = ("BLWK_timeBetweenRounds" call BIS_fnc_getParamValue);
    BLWK_maxNumWaves = ("BLWK_maxNumWaves" call BIS_fnc_getParamValue);

    BLWK_buildingsNearBulwarkAreIndestructable_radius = ("BLWK_buildingsNearBulwarkAreIndestructable_radius" call BIS_fnc_getParamValue);

    // for revealing loot and deleteing it at the end of the round
    BLWK_lootMarkers = [];
    BLWK_spawnedLoot = [];

    // the marker that denotes the play area on the map
    BLWK_playAreaMarker = "";

    // used to delete dead bodies after the parameter set amount of time
    BLWK_deadBodies = [[],[]];
    BLWK_roundsBeforeBodyDeletion = ("BLWK_roundsBeforeBodyDeletion" call BIS_fnc_getParamValue);
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
    BLWK_showHitPoints = [false,true] select ("BLWK_showHitPoints" call BIS_fnc_getParamValue);

    BLWK_saveRespawnLoadout = [false,true] select ("BLWK_saveRespawnLoadout" call BIS_fnc_getParamValue);
    BLWK_magRepackEnabled = [false,true] select ("BLWK_magRepackEnabled" call BIS_fnc_getParamValue);
    BLWK_dontUseRevive = (("ReviveMode" call BIS_fnc_getParamValue) isEqualTo 0);

    BLWK_ACELoaded = ["ACE_Medical_StateMachine"] call BLWK_fnc_isPatchLoaded;

    // this is to have potential supports that put the player outside the immediate radius
    // it is false until the play area is established
    BLWK_enforceArea = false;

    // used for queing up kill points since two events can simaltaneously add points
    BLWK_killPointsQue = [];
};

BLWK_currentWaveNumber = 0;

/* Points */
BLWK_pointsForKill = ("BLWK_pointsForKill" call BIS_fnc_getParamValue);                 // Base Points for a kill
BLWK_pointsForHit = ("BLWK_pointsForHit" call BIS_fnc_getParamValue);                   // Every Bullet hit that doesn't result in a kill
BLWK_pointsMultiForDamage = ("BLWK_pointsMultiForDamage" call BIS_fnc_getParamValue);   // Extra points awarded for damage. 100% = BLWK_pointsMultiForDamage. 50% = BLWK_pointsMultiForDamage/2
BLWK_costToSpinRandomBox = 950;  // Cost to spin the box
BLWK_supportDishFound = [false,true] select ("BLWK_supportDishFound" call BIS_fnc_getParamValue);
BLWK_randomWeaponBoxFound = false;

// Point multipliers of BLWK_pointsForKill for different waves
BLWK_pointsMulti_man_level1 = 0.75;
BLWK_pointsMulti_man_level2 = 1;
BLWK_pointsMulti_man_level3 = 1.25;
BLWK_pointsMulti_man_level4 = 1.50;
BLWK_pointsMulti_man_level5 = 1.50;
BLWK_pointsMulti_car = 2;
BLWK_pointsMulti_armour = 4;

/* Supports */
BLWK_supports_array = [
	//1. Price //2. Displayed Name //3. className
    [800,  "Recon UAV",             "reconUAV"],
    [1680, "Emergency Teleport",   "telePlode"],
    [1950, "Paratroopers",          "paraDrop"],
    [3850, "Missile CAS",          "airStrike"],
    [4220, "Mine Cluster Shell",   "mineField"],
    [4690, "Rage Stimpack",         "ragePack"],
    [5930, "Mind Control Gas",    "mindConGas"],
    [6666, "ARMAKART TM",           "armaKart"],
    [7500, "Predator Drone",    "droneControl"]
];

/* Build Objects */
BLWK_buildableObjects_array = [
	//1. Price //2. ClassName //3. Does it have AI? //4. attachment info (when you buy an object) [defaultRotation,attachToArray]
	//Cipher Comment The object radius is used to prevent AI from glitching through and triggers suicide bombers.......that seems dumb
    [25,   "Land_Plank_01_8m_F",                false, [0, [0,6,1]]],
    [25,   "Land_BagFence_End_F",                false, [0, [0,3,1]]],
    [50,   "Land_Barricade_01_4m_F",            false, [0, [0,4,0.5]]],
    [50,   "Land_BagFence_Short_F",              false, [0, [0,3,1]]],
    [50,   "Land_BagFence_Corner_F",             false, [0, [0,3,1]]],
    [75,   "Land_Obstacle_Ramp_F",              false, [180, [0,3,1]]],
    [80,   "Land_BagFence_Round_F",              false, [0, [0,3,1]]],
    [80,   "Land_BagFence_Long_F",               false, [0, [0,3,1]]],
    [85,   "Land_DomeDebris_01_hex_green_F",    false, [180, [0,3,0.75]]],
    [100,  "Land_SandbagBarricade_01_half_F",   false, [0, [0,3,1]]],
    [150,  "Land_SandbagBarricade_01_hole_F",   false, [0, [0,3,1.5]]],
    [180,  "Land_CncShelter_F",                 false, [0, [0,3,1.5]]],
    [200,  "Land_GH_Platform_F",                false, [0, [0,6,0.75]]],
    [250,  "Land_Mil_WallBig_4m_F",             false, [180, [0,4,2]]],
    [260,  "Land_PortableLight_double_F",       false, [180, [0,3,1.1]]],
    [300,  "Land_CncBarrierMedium4_F",          false, [0, [0.25,5,1.2]]],
    [400,  "Land_VR_Slope_01_F",                false, [0, [0,9,2.25]]],
    [500,  "Land_Bunker_01_blocks_3_F",         false, [0, [0,3,0.5]]], 
    [500,  "Land_HBarrier_3_F",                 false, [0, [0,4,1]]],
    [750,  "Land_PierLadder_F",                 false, [0, [0.15,2.5,1]]],
    [800,  "Box_NATO_Support_F",                false, [90, [0,2,1]]],    
    [950,  "Land_GH_Stairs_F",                  false, [180, [0,5,1]]],
    [1000, "Land_LampHalogen_F",                false, [90, [0.2,2,2.75]]],
    [1000, "Land_HBarrierWall4_F",              false, [0, [0,5,1]]],   
    [1000, "BlockConcrete_F",                   false, [0, [0,8,0.5]]],
    [1200, "Box_NATO_AmmoVeh_F",                false, [0, [0,3,1]]],
    [2500, "B_HMG_01_high_F",                   false, [0, [0.25,2,2]]],
    [3000, "Land_BagBunker_Small_F",            false, [180, [0,4,1]]],
    [4500, "Land_PillboxBunker_01_hex_F",       false, [90, [0,4,1]]],
    [6000, "Land_Cargo_Patrol_V3_F",            false, [180, [0,6,5]]],
    [7500, "B_HMG_01_A_F",                      true, [180, [0.25,2,2]]],
    [9500, "Land_Bunker_01_Small_F",            false, [180, [0.5,6,0]]]
];

if (isServer) then {
    missionNamespace setVariable ["BLWK_serverGlobalsInitialized",true,true];
};