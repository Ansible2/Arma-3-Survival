/**
*  editMe
*
*  Defines all global config for the mission
*
*  Domain: Client, Server
**/

/* Attacker Waves */
// cipher comment: this needs to be organized the same way it shows up in the params menu in the lobby
/// which itself may need to be reorganized

// We don't need to constantly check if the server is dedicated, and we only want to run things like
/// playSound and hud updates on a server with an interface (0) or just clients (-2)
BLWK_allPlayersTargetID = [0,-2] select isDedicated;

// List_Bandits, List_ParaBandits, List_OPFOR, List_INDEP, List_NATO, List_Viper
// cipher comment: why the fuck use global vars to initialize global vars and then not clear the memory?
/// PS, none of these are used, they only used the first ones (e.g. list_bandits,list_opfor)
BLWK_enemyClasses_level_1 = List_Bandits;  // Wave 0 >
BLWK_enemyClasses_level_2 = List_OPFOR;    // Wave 5 >
BLWK_enemyClasses_level_3 = List_Viper;    // Wave 10 >
BLWK_enemyClasses_armor = List_Armour;      //expects vehicles
BLWK_enemyClasses_armedCars = List_ArmedCars; //expects vehicles

BLWK_enemiesPerWaveMultiplier = ("BLWK_enemiesPerWaveMultiplier" call BIS_fnc_getParamValue);  // How many hostiles per wave (waveCount x BLWK_enemiesPerWaveMultiplier)
BLWK_enemiesPerPlayerMultiplier = ("BLWK_enemiesPerPlayerMultiplier" call BIS_fnc_getParamValue) / 100;   // How many extra units are added per player
BLWK_maxPistolOnlyWaves = ("BLWK_maxPistolOnlyWaves" call BIS_fnc_getParamValue);  //What wave enemies stop only using pistols

/* LOCATION LIST OPTIONS */
// List_AllCities - for any random City
// List_SpecificPoint - will start the mission on the "Specific Bulwark Pos" marker (move with mission editor). Location must meet BLWK_minLandToWaterRatio and BLWK_loot_houseDensity, BLWK_minSpawnRoomSize, etc requirements
// List_LocationMarkers - for a location selected randomly from the Bulwark Zones in editor (Currently broken)
// *IMPORTANT* If you get an error using List_SpecificPoint it means that there isn't a building that qualifies. Turning down the "Minimum spawn room size" parameter might help.
BLWK_locations = List_AllCities;

BLWK_playAreaRadius = ("BLWK_playAreaRadius" call BIS_fnc_getParamValue); //Cipher Comment: Total play area radius in meters
BLWK_minSpawnRoomSize = ("BLWK_minSpawnRoomSize" call BIS_fnc_getParamValue);   // Spawn room must be bigger than x square metres
BLWK_minLandToWaterRatio = ("BLWK_minLandToWaterRatio" call BIS_fnc_getParamValue); //Cipher Comment: The ratio to ensure there isn't too much water.
BLWK_loot_houseDensity = ("BLWK_loot_houseDensity" call BIS_fnc_getParamValue);

BLWK_playersStartWith_pistol = [false,true] select ("BLWK_playersStartWith_pistol" call BIS_fnc_getParamValue);
BLWK_playersStartWith_map    = [false,true] select ("BLWK_playersStartWith_map" call BIS_fnc_getParamValue); 
BLWK_playersStartWith_NVGs   = [false,true] select ("BLWK_playersStartWith_NVGs" call BIS_fnc_getParamValue);

/* Respawn */
BLWK_respawnTime = ("BLWK_respawnTime" call BIS_fnc_getParamValue);
BLWK_numRespawnTickets = ("BLWK_numRespawnTickets" call BIS_fnc_getParamValue);

/* Loot Blacklist */
BLWK_blacklist = [
    "O_Static_Designator_02_weapon_F", // If players find and place CSAT UAVs they count as hostile units and round will not progress
    "O_UAV_06_backpack_F",
    "O_UAV_06_medical_backpack_F",
    "O_UAV_01_backpack_F",
    "B_IR_Grenade",
    "O_IR_Grenade",
    "I_IR_Grenade"
];

/* Whitelist modes */
/* 0 = Off */
/* 1 = Only Whitelist Items will spawn as loot */
/* 2 = Whitelist items get added to existing loot (increases the chance of loot spawning */
BLWK_loot_whiteListMode = 0;

/* Loot Whitelists */
/* Fill with classname arrays: ["example_item_1", "example_item_2"] */
/* To use Whitelisting there MUST be at least one applicaple item in each LOOT_WHITELIST array*/
BLWK_whitelist_weaponClasses = [];
BLWK_whitelist_vests = [];
BLWK_whitelist_clothingClasses = [];
BLWK_whitelist_itemClasses = [];
BLWK_whitelist_explosiveClasses = [];
BLWK_whitelist_backpackClasses = [];

/* Loot Spawn */
BLWK_loot_weaponClasses    = List_AllWeapons - BLWK_blacklist;   
BLWK_loot_vestClasses = List_Vests; //Cipher Comment: not used yet, need to implement intead of having it added to the clothing pool
BLWK_loot_clothingClasses   = List_AllClothes + List_Vests - BLWK_blacklist;
BLWK_loot_itemClasses      = List_Optics + List_Items - BLWK_blacklist;
BLWK_loot_explosiveClasses = List_Mines + List_Grenades + List_Charges - BLWK_blacklist;
BLWK_loot_backpackClasses   = List_Backpacks - BLWK_blacklist;

/* Random Loot */
BLWK_loot_cityDistribution = ("BLWK_loot_cityDistribution" call BIS_fnc_getParamValue);  // decides how many buildings will be marked as having loot in a city
BLWK_loot_roomDistribution = ("BLWK_loot_roomDistribution" call BIS_fnc_getParamValue);   // decides how much loot will be in a building if it has any 
BLWK_distributionOffset = 0; // Offset the position by this number. //Cipher Comment not used
BLWK_supplyDropRadius = ("BLWK_supplyDropRadius" call BIS_fnc_getParamValue) / 100;        // Radius of supply drop
BLWK_paratrooperCount = ("BLWK_paratrooperCount" call BIS_fnc_getParamValue);
BLWK_paratroopClasses = List_NATO;
BLWK_defectorClasses = List_NATO;

/* Points */
BLWK_pointsForKill = ("BLWK_pointsForKill" call BIS_fnc_getParamValue);                 // Base Points for a kill
BLWK_pointsForHit = ("BLWK_pointsForHit" call BIS_fnc_getParamValue);                   // Every Bullet hit that doesn't result in a kill
BLWK_pointsMultiForDamage = ("BLWK_pointsMultiForDamage" call BIS_fnc_getParamValue);   // Extra points awarded for damage. 100% = BLWK_pointsMultiForDamage. 50% = BLWK_pointsMultiForDamage/2
BLWK_costToSpinRandomBox = 950;  // Cost to spin the box

/*Point multipliers of BLWK_pointsForKill for different waves */
BLWK_pointMulti_men_level1 = 0.75;
BLWK_pointMulti_men_level2 = 1;
BLWK_pointMulti_men_level3 = 1.50;
BLWK_pointMulti_car = 2;
BLWK_pointMulti_armour = 4;


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

// default objects players can purchase
BLWK_buildableObjects_array = [
	//1. Price //2. Displayed Name //3. ClassName //4. Default rotation //5. Object Radius (meters) //6. Has AI
	//Cipher Comment The object radius is used to prevent AI from glitching through and triggers suicide bombers.......that seems dumb
    [25,   "Long Plank (8m)",      "Land_Plank_01_8m_F",                0,   4, false],
    [50,   "Junk Barricade",       "Land_Barricade_01_4m_F",            0, 1.5, false],
    [75,   "Small Ramp (1m)",      "Land_Obstacle_Ramp_F",            180, 1.5, false],
    [85,   "Flat Triangle (1m)",   "Land_DomeDebris_01_hex_green_F",  180, 1.5, false],
    [100,  "Short Sandbag Wall",   "Land_SandbagBarricade_01_half_F",   0, 1.5, false],
    [150,  "Sandbag Barricade",    "Land_SandbagBarricade_01_hole_F",   0, 1.5, false],
    [180,  "Concrete Shelter",     "Land_CncShelter_F",                 0,   1, false],
    [200,  "Concrete Walkway",     "Land_GH_Platform_F",                0, 3.5, false],
    [250,  "Tall Concrete Wall",   "Land_Mil_WallBig_4m_F",             0,   2, false],
    [260,  "Portable Light",       "Land_PortableLight_double_F",     180,   1, false],
    [300,  "Long Concrete Wall",   "Land_CncBarrierMedium4_F",          0,   3, false],
    [400,  "Large Ramp",           "Land_VR_Slope_01_F",                0,   4, false],
    [500,  "Bunker Block",         "Land_Bunker_01_blocks_3_F",         0,   2, false],
    [500,  "H Barrier",            "Land_HBarrier_3_F",                 0,   2, false],
    [750,  "Ladder",               "Land_PierLadder_F",                 0,   1, false],
    [800,  "Storage box small",    "Box_NATO_Support_F",                0,   1, false],
    [950,  "Stairs",               "Land_GH_Stairs_F",                180,   4, false],
    [1000, "Hallogen Lamp",        "Land_LampHalogen_F",               90,   1, false],
    [1000, "Double H Barrier",     "Land_HBarrierWall4_F",              0,   4, false],
    [1000, "Concrete Platform",    "BlockConcrete_F",                   0, 3.5, false],
    [1200, "Storage box large",    "Box_NATO_AmmoVeh_F",                0,   1, false],
    [2500, "Static HMG",           "B_HMG_01_high_F",                   0,   1, false],
    [3000, "Small Bunker",         "Land_BagBunker_Small_F",          180,   3, false],
    [4500, "Pillbox",              "Land_PillboxBunker_01_hex_F",      90, 2.5, false],
    [6000, "Guard Tower",          "Land_Cargo_Patrol_V3_F",            0, 3.5, false],
    [7500, "Autonomous HMG",       "B_HMG_01_A_F",                    180, 3.5,  true],
    [9500, "Modular Bunker",       "Land_Bunker_01_Small_F",          180, 3.5, false]
];

/* Time of Day*/
BLWK_timeOfDayMin = ("BLWK_timeOfDayMin" call BIS_fnc_getParamValue);
BLWK_timeOfDayMax = ("BLWK_timeOfDayMax" call BIS_fnc_getParamValue);

// Check for sneaky inverted configuration. FROM should always be before TO.
if (BLWK_timeOfDayMin > BLWK_timeOfDayMax) then {
    BLWK_timeOfDayMin = BLWK_timeOfDayMax - 2;
};

/* Starter MediKits */
BLWK_numMedKits = ("BLWK_numMedKits" call BIS_fnc_getParamValue);

BLWK_timeBetweenRounds = ("BLWK_timeBetweenRounds" call BIS_fnc_getParamValue);
BLWK_useSpecialWaves = ("BLWK_useSpecialWaves" call BIS_fnc_getParamValue);
BLWK_maxNumWaves = ("BLWK_maxNumWaves" call BIS_fnc_getParamValue);

BLWK_supportMenuAllowed = [false,true] select ("BLWK_supportMenuAllowed" call BIS_fnc_getParamValue);

BLWK_friendlyFireOn = [false,true] select ("BLWK_friendlyFireOn" call BIS_fnc_getParamValue);

BLWK_hitPointsShown = [false,true] select ("BLWK_hitPointsShown" call BIS_fnc_getParamValue);