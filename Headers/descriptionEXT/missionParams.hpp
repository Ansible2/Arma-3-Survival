#define OFF_OR_ON {"OFF","ON"}
#define NO_OR_YES {"NO","YES"}
#define ZERO_OR_ONE {0,1}

#define ZERO_TO_TEN {0,1,2,3,4,5,6,7,8,9,10}
#define ZERO_TO_TEN_STRINGS {"0","1","2","3","4","5","6","7","8","9","10"}

#define A_SECTION_HEADER(NAME)\
	class NAME##_LABEL \
	{ \
		title = ======= ##NAME## Settings =======; \
		values[] = {0}; \
		texts[] = {""}; \
		default = 0; \
	};
#define A_SPACE(NAME)\
	class NAME##_SPACE \
	{ \
		title = " "; \
		values[] = {0}; \
		texts[] = {""}; \
		default = 0; \
	};

#include "Faction Headers\Define Factions.hpp"
#include "Loot Lists\Define Loot Lists.hpp"


/* // prior to 0.8 parameter getting
__EXEC(_savedParams = profileNamespace getVariable ["BLWK_savedMissionParameters",[]]);
#define FIND_CODE(PARAM) __EXEC(_findParamCode = compile "_x select 0 == "#PARAM"");
#define GET_PARAM_INDEX __EXEC(_paramIndex = _savedParams findIf _findParamCode);
#define FOUND_COMPILE call compile (["(_savedParams select _paramIndex) select 1","-1"] select (_savedParams isEqualTo []))
#define GET_PARAM_VALUE(DEFAULT_VALUE) __EVAL([FOUND_COMPILE,DEFAULT_VALUE] select (_paramIndex isEqualTo -1));

#define GET_DEFAULT_PARAM(NAME,DEFAULT_VALUE) \
	FIND_CODE(NAME)\
	GET_PARAM_INDEX\
	default = GET_PARAM_VALUE(DEFAULT_VALUE)\
*/


// prior to 0.9, used arrays instead of hashes. Since params are auto loaded, in order to avoid errors on previous parameter saves,
/// this will create an empty hash if an array is present in BLWK_savedMissionParameters or if nothing has been saved yet.
/// ultimately allowing the use of the getOrDefault command for hashes
__EXEC(_savedParams = [profileNamespace getVariable "BLWK_savedMissionParameters",createHashMap] select call compile "profileNamespace getVariable ['BLWK_savedMissionParameters',[]] isEqualType []");
#define GET_DEFAULT_PARAM(NAME,DEFAULT_VALUE) default = __EVAL(_savedParams getOrDefault [#NAME,DEFAULT_VALUE]);


#define WAVE_STEPS_VALUES values[] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 20, 25, 9999};
#define WAVE_STEPS_TEXTS texts[] = {"1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "20", "25", "Never"};

// waves
A_SECTION_HEADER(WAVE);

class BLWK_maxNumWaves
{
	title = "How Many Waves";
	values[] = {10, 20, 25, 30, 40, 50, 60, 70, 80, 90, 100, 125, 150, 999999};
	texts[] = {"10", "20", "25", "30", "40","50","60","70","80","90","100", "125", "150", "Infinite"};
	GET_DEFAULT_PARAM(BLWK_maxNumWaves,25)
};
class BLWK_timeBetweenRounds
{
	title = "Time between rounds";
	values[] = {0, 15, 30, 60, 90, 120, 180, 240, 300};
	texts[] = {"0", "15 Seconds", "30 Seconds", "1 Minute", "1 Minute 30 Seconds", "2 Minutes", "3 Minutes", "4 Minutes", "5 Minutes"};
	GET_DEFAULT_PARAM(BLWK_timeBetweenRounds,60)
};
class BLWK_vehicleStartWave
{
	title = "Vehicles can spawn after wave";
	WAVE_STEPS_VALUES
	WAVE_STEPS_TEXTS
	GET_DEFAULT_PARAM(BLWK_vehicleStartWave,5)
};
class BLWK_specialWavesStartAt
{
	title = "Special Wave Possibility Starts At Wave";
	WAVE_STEPS_VALUES
	WAVE_STEPS_TEXTS
	GET_DEFAULT_PARAM(BLWK_specialWavesStartAt,7)
};
class BLWK_specialWaveLikelihood
{
	title = "Special Wave Likelihood (Ratio is against special waves: e.g. if 0.9, standard waves will have a likelihood of 0.1)";
	values[] = {1,2,3,4,5,6,7,8,9,10};
	texts[] = {"0.1","0.2","0.3","0.4","0.5","0.6","0.7","0.8","0.9","1"};
	GET_DEFAULT_PARAM(BLWK_specialWaveLikelihood,5)
};
class BLWK_maxEnemyInfantryAtOnce
{
	title = "Max Enemy Infantry At Once (AI will wait in a queue until there is room)";
	values[] = {10,15,20,25,30,35,40,45,50};
	texts[] = {"10","15","20","25","30","35","40","45","50"};
	GET_DEFAULT_PARAM(BLWK_maxEnemyInfantryAtOnce,30)
};
class BLWK_randomizeEnemyWeapons
{
	title = "Randomize Hostile Weapons";
	values[] = ZERO_OR_ONE;
	texts[] = NO_OR_YES;
	GET_DEFAULT_PARAM(BLWK_randomizeEnemyWeapons,0)
};
class BLWK_maxPistolOnlyWaves
{
	title = "Hostiles only use pistols until wave";
	values[] = {0, 1, 2, 3, 4, 5};
	texts[] = {"Start Fully Armed", "One", "Two", "Three", "Four", "Five"};
	GET_DEFAULT_PARAM(BLWK_maxPistolOnlyWaves,3)
};
class BLWK_enemiesPerWaveMultiplier
{
	title = "Enemies Per Wave Multiplier";
	values[] = {5,10,15,20,25,30};
	texts[] = {"0.5","1","1.5","2","2.5","3"};
	GET_DEFAULT_PARAM(BLWK_enemiesPerWaveMultiplier,10)
};
// CIPHER COMMENT: The utility of this value should be replaced with a simple: add this number of enemies per round per player in addition to the number already spawned
class BLWK_enemiesPerPlayerMultiplier
{
	title = "Extra Enemies Per Player";
	values[] = {5, 10, 15, 20};
	texts[] = {"0.5", "1", "1.5", "2"};
	GET_DEFAULT_PARAM(BLWK_enemiesPerPlayerMultiplier,10)
};
class BLWK_roundsBeforeBodyDeletion
{
	title = "Dead bodies remain for how many waves (dead bodies impact perfomance)";
	values[] = {0, 1, 2};
	texts[] = {"0 (until next round begins)", "1", "2"};
	GET_DEFAULT_PARAM(BLWK_roundsBeforeBodyDeletion,1)
};
class BLWK_minRoundsSinceVehicleSpawned
{
	title = "The minimum number of waves between vehicle spawns";
	values[] = {0, 1, 2};
	texts[] = {"0", "1", "2"};
	GET_DEFAULT_PARAM(BLWK_minRoundsSinceVehicleSpawned,0)
};


// Players
A_SPACE(Player);
A_SECTION_HEADER(Player);
class BLWK_friendlyFireOn
{
	title = "Friendly Fire";
	values[] = ZERO_OR_ONE;
	texts[] = OFF_OR_ON;
	GET_DEFAULT_PARAM(BLWK_friendlyFireOn,1)
};
class BLWK_fallDamageOn
{
	title = "Fall Damage (Not ACE Medical Compatabile)";
	values[] = ZERO_OR_ONE;
	texts[] = OFF_OR_ON;
	GET_DEFAULT_PARAM(BLWK_fallDamageOn,0)
};
class BLWK_staminaEnabled
{
	title = "Enable stamina (Not ACE Compatabile)";
	values[] = ZERO_OR_ONE;
	texts[] = NO_OR_YES;
	GET_DEFAULT_PARAM(BLWK_staminaEnabled,0)
};
class BLWK_weaponSwayCoef
{
	title = "Weaponsway coefficient (zero means no sway)";
	values[] = {0, 10, 15, 20, 25, 30, 40, 50, 60, 70, 80, 90, 100};
	texts[] = {"0", "0.1", "0.15", "0.2", "0.25", "0.3", "0.4", "0.5", "0.6", "0.7", "0.8", "0.9", "1"};
	GET_DEFAULT_PARAM(BLWK_weaponSwayCoef,15)
};



// start
A_SPACE(Start);
A_SECTION_HEADER(Start);

class BLWK_startingWaveNumber
{
	title = "Start from wave number (should be less then max wave)";
	values[] = {0, 5, 10, 15, 20, 25, 30, 35, 40, 45, 50};
	texts[] = {"0", "5", "10", "15", "20", "25", "30", "35", "40", "45", "50"};
	GET_DEFAULT_PARAM(BLWK_startingWaveNumber,0)
};
class BLWK_startingKillPoints
{
	title = "Kill points players start with";
	values[] = {0, 250, 500, 1000, 2500, 5000, 10000};
	texts[] = {"0", "250", "500", "1000", "2500", "5000", "10000"};
	GET_DEFAULT_PARAM(BLWK_startingKillPoints,0)
};
class BLWK_startingCommunityKillPoints
{
	title = "Community starting points";
	values[] = {0, 250, 500, 1000, 2500, 5000, 10000, 15000, 20000};
	texts[] = {"0", "250", "500", "1000", "2500", "5000", "10000", "15000", "20000"};
	GET_DEFAULT_PARAM(BLWK_startingCommunityKillPoints,0)
};
class BLWK_supportDishFound
{
	title = "Find Satellite Dish to Unlock Supports";
	values[] = ZERO_OR_ONE;
	texts[] = {"Yes, find the Satellite Dish to unlock the Support Menu", "No, Supports are available from the begining of the mission"};
	GET_DEFAULT_PARAM(BLWK_supportDishFound,1)
};
class BLWK_numMedKits
{
	title = "Medikits in The Crate";
	values[] = {0, 1, 2, 3, 4, 5, 6, 7, 8};
	texts[] = {"None", "One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight"};
	GET_DEFAULT_PARAM(BLWK_numMedKits,3)
};
class BLWK_playersStartWith_map
{
	title = "Start with map";
	values[] = ZERO_OR_ONE;
	texts[] = NO_OR_YES;
	GET_DEFAULT_PARAM(BLWK_playersStartWith_map,1)
};
class BLWK_playersStartWith_compass
{
	title = "Start with compass";
	values[] = ZERO_OR_ONE;
	texts[] = NO_OR_YES;
	GET_DEFAULT_PARAM(BLWK_playersStartWith_compass,1)
};
class BLWK_playersStartWith_radio
{
	title = "Start with a radio (TFAR & ACRE Compatabile) (You must have one to get support radio messages)";
	values[] = ZERO_OR_ONE;
	texts[] = NO_OR_YES;
	GET_DEFAULT_PARAM(BLWK_playersStartWith_radio,1)
};
class BLWK_playersStartWith_mineDetector
{
	title = "Start with a mine detector";
	values[] = ZERO_OR_ONE;
	texts[] = NO_OR_YES;
	GET_DEFAULT_PARAM(BLWK_playersStartWith_radio,0)
};
class BLWK_playersStartWith_pistol
{
	title = "Start with a pistol";
	values[] = ZERO_OR_ONE;
	texts[] = NO_OR_YES;
	GET_DEFAULT_PARAM(BLWK_playersStartWith_pistol,0)
};
class BLWK_playersStartWith_NVGs
{
	title = "Start with NVGs";
	values[] = ZERO_OR_ONE;
	texts[] = NO_OR_YES;
	GET_DEFAULT_PARAM(BLWK_playersStartWith_NVGs,0)
};



// area
A_SPACE(Area);
A_SECTION_HEADER(Area);

class BLWK_customPlayLocation
{
	title = "Would you like to select a custom location to play?";
	values[] = ZERO_OR_ONE;
	texts[] = NO_OR_YES;
	GET_DEFAULT_PARAM(BLWK_customPlayLocation,0)
};
class BLWK_playAreaRadius
{
	title = "Mission area size";
	values[] = {50, 100, 150, 200, 250};
	texts[] = {"(50m) Tiny", "(100m) Small", "(150m) Normal", "(200m) Large", "(250m) Huge"};
	GET_DEFAULT_PARAM(BLWK_playAreaRadius,150)
};
class BLWK_maxLootSpawns
{
	title = "Max Number Of Loot Spawns";
	values[] = {100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600, 1700, 1800, 1900, 2000};
	texts[] = {"100","200","300","400","500","600","700","800","900","1000","1100","1200", "1300", "1400", "1500", "1600", "1700", "1800", "1900", "2000"};
	GET_DEFAULT_PARAM(BLWK_maxLootSpawns,1000)
};
class BLWK_minNumberOfHousesInArea
{
	title = "Minimum number of buildings in the play area radius";
	values[] = {5, 10, 15, 20, 30};
	texts[] = {"5","10","15","20","30"};
	GET_DEFAULT_PARAM(BLWK_minNumberOfHousesInArea,15)
};
class BLWK_loot_cityDistribution
{
	title = "Loot City distribution";
	values[] = {1, 2, 3, 4};
	texts[] = {"Every building", "Every second building", "Every third building", "Every fourth building"};
	GET_DEFAULT_PARAM(BLWK_loot_cityDistribution,1)
};
class BLWK_loot_roomDistribution
{
	title = "Loot Within Building Distribution";
	values[] = {1, 2, 3, 4};
	texts[] = {"Every location", "Every second location", "Every third location", "Every fourth location"};
	GET_DEFAULT_PARAM(BLWK_loot_roomDistribution,2)
};
class BLWK_loot_whiteListMode
{
	title = "Loot Whitelist Mode";
	values[] = {LOOT_LIST_VALUES};
	texts[] = {LOOT_LIST_STRINGS};
	GET_DEFAULT_PARAM(BLWK_loot_whiteListMode,0)
};
class BLWK_buildingsNearTheCrateAreIndestructable_radius
{
	title = "The radius of indestructable buildings around The Crate";
	values[] = {0,5,10,15,20,25,30};
	texts[] = {"OFF","5m","10m","15m","20m","25m","30m"};
	GET_DEFAULT_PARAM(BLWK_buildingsNearTheCrateAreIndestructable_radius,20)
};



// ambient
A_SPACE(Ambient);
A_SECTION_HEADER(Ambient);
class BLWK_timeOfDay
{
	title = "The Time Of Day";
	values[] = {2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22};
	texts[] = {"0200","0400","0600","0800","1000","1200", "1400", "1600", "1800", "2000", "2200"};
	GET_DEFAULT_PARAM(BLWK_timeOfDay,6)
};

class BLWK_daySpeedMultiplier
{
	title = "Day Speed Multiplier";
	values[] = {1, 6, 8, 12, 24, 48, 72};
	texts[] = {"x1 (24h cycle)","x6 (4h cycle)","x8 (3h cycle)","x12 (2h cycle)","x24 (1h cycle)","x48 (30m cycle)","x72 (20m cycle)"};
	GET_DEFAULT_PARAM(BLWK_daySpeedMultiplier,8)
};


// weather
#include "paramWeather.hpp"



// Points
A_SPACE(Points);
A_SECTION_HEADER(Points);
class BLWK_showHitPoints
{
	title = "Point Hitmarkers on HUD";
	values[] = ZERO_OR_ONE;
	texts[] = NO_OR_YES;
	GET_DEFAULT_PARAM(BLWK_showHitPoints,1)
};
class BLWK_pointsForKill
{
	title = "Base Points For Kill";
	values[] = {10, 50, 100, 125, 150, 200, 300};
	texts[] = {"10","50","100","125","150","200","300"};
	GET_DEFAULT_PARAM(BLWK_pointsForKill,125)
};
class BLWK_pointsForHit
{
	title = "Base Points per Hit";
	values[] = {0, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100};
	texts[] = {"0","10","20","30","40","50","60","70","80","90","100"};
	GET_DEFAULT_PARAM(BLWK_pointsForHit,30)
};
class BLWK_pointsMultiForDamage
{
	title = "Damage bonus points";
	values[] = {0, 10, 20, 50, 100};
	texts[] = {"0","10","20","50","100"};
	GET_DEFAULT_PARAM(BLWK_pointsMultiForDamage,20)
};


// respawn
A_SPACE(Respawn);
A_SECTION_HEADER(Respawn);
class BLWK_numRespawnTickets
{
	title = "Respawn Tickets";
	values[] = {0, 5, 10, 15, 20};
	texts[] = {"0", "5", "10", "15", "20"};
	GET_DEFAULT_PARAM(BLWK_numRespawnTickets,10)
};

class BLWK_saveRespawnLoadout
{
	title = "Players Get Their Loadout If They Respawn";
	values[] = ZERO_OR_ONE;
	texts[] = OFF_OR_ON;
	GET_DEFAULT_PARAM(BLWK_saveRespawnLoadout,0)
};


A_SPACE(Revive);
A_SECTION_HEADER(Revive);
#include "reviveParams.hpp"



// FACTIONS
A_SPACE(Faction);
A_SECTION_HEADER(Faction);
class BLWK_friendlyFaction
{
	title = "Friendly Faction";
	values[] = {FACTION_COUNT};
	texts[] = {FACTION_STRINGS};
	default = 0; // NATO
};

class BLWK_level1Faction
{
	title = "Level 1 Enemy Faction";
	values[] = {FACTION_COUNT};
	texts[] = {FACTION_STRINGS};
	default = 2; // FIA
};

class BLWK_level2Faction
{
	title = "Level 2 Enemy Faction";
	values[] = {FACTION_COUNT};
	texts[] = {FACTION_STRINGS};
	default = 1; // AAF
};

class BLWK_level3Faction
{
	title = "Level 3 Enemy Faction";
	values[] = {FACTION_COUNT};
	texts[] = {FACTION_STRINGS};
	default = 3; // CSAT
};

class BLWK_level4Faction
{
	title = "Level 4 Enemy Faction";
	values[] = {FACTION_COUNT};
	texts[] = {FACTION_STRINGS};
	default = 4; // CSAT Urban
};

class BLWK_level5Faction
{
	title = "Level 5 Enemy Faction";
	values[] = {FACTION_COUNT};
	texts[] = {FACTION_STRINGS};
	default = 13; // Contact Spetsnaz
};


A_SPACE(Vehicle);
A_SECTION_HEADER(Vehicle);
class BLWK_baseVehicleSpawnLikelihood
{
	title = "Base Vehicle Spawn Likelihood";
	values[] = ZERO_TO_TEN;
	texts[] = ZERO_TO_TEN_STRINGS;
	GET_DEFAULT_PARAM(BLWK_baseVehicleSpawnLikelihood,6)
};
class BLWK_lightCarLikelihood
{
	title = "Enemy Light Car Likelihood";
	values[] = ZERO_TO_TEN;
	texts[] = ZERO_TO_TEN_STRINGS;
	GET_DEFAULT_PARAM(BLWK_lightCarLikelihood,4)
};
class BLWK_heavyCarLikelihood
{
	title = "Enemy Heavy Car Likelihood";
	values[] = ZERO_TO_TEN;
	texts[] = ZERO_TO_TEN_STRINGS;
	GET_DEFAULT_PARAM(BLWK_heavyCarLikelihood,5)
};
class BLWK_lightArmorLikelihood
{
	title = "Enemy Light Armor Likelihood";
	values[] = ZERO_TO_TEN;
	texts[] = ZERO_TO_TEN_STRINGS;
	GET_DEFAULT_PARAM(BLWK_lightArmorLikelihood,5)
};
class BLWK_heavyArmorLikelihood
{
	title = "Enemy Heavy Armor Likelihood";
	values[] = ZERO_TO_TEN;
	texts[] = ZERO_TO_TEN_STRINGS;
	GET_DEFAULT_PARAM(BLWK_heavyArmorLikelihood,4)
};


// AI
A_SPACE(AI);
A_SECTION_HEADER(AI);

class BLWK_doDetectCollision
{
	title = "Run Enemy AI Collision Script? (If you plan to be in a mostly rural environment, possibly turn off)";
	values[] = ZERO_OR_ONE;
	texts[] = NO_OR_YES;
	GET_DEFAULT_PARAM(BLWK_doDetectCollision,1)
};
class BLWK_doDetectMines
{
	title = "Enemy AI Mine Detection";
	values[] = ZERO_OR_ONE;
	texts[] = OFF_OR_ON;
	GET_DEFAULT_PARAM(BLWK_doDetectMines,1)
};
class BLWK_suppressionEnabled
{
	title = "Enemy AI Suppression (OFF for more aggressive/less cautious AI)";
	values[] = ZERO_OR_ONE;
	texts[] = OFF_OR_ON;
	GET_DEFAULT_PARAM(BLWK_suppressionEnabled,0)
};
class BLWK_autocombatEnabled
{
	title = "Enemy AI AutoCombat (OFF for more aggressive/less cautious AI)";
	values[] = ZERO_OR_ONE;
	texts[] = OFF_OR_ON;
	GET_DEFAULT_PARAM(BLWK_autocombatEnabled,0)
};


// Other
A_SPACE(Other);
A_SECTION_HEADER(Other);

class BLWK_multipleLootReveals
{
	title = "Show all loot with reveal?";
	values[] = ZERO_OR_ONE;
	texts[] = {"Show all","Choose what type to show"};
	GET_DEFAULT_PARAM(BLWK_multipleLootReveals,1)
};
class BLWK_aircraftGunnerLifetime
{
	title = "How many waves should gunner supports last?";
	values[] = {1,2,3,4,5};
	texts[] = {"1","2","3","4","5"};
	GET_DEFAULT_PARAM(BLWK_aircraftGunnerLifetime,2)
};
class BLWK_magRepackEnabled
{
	title = "Enable Vanilla QS MagRepack Rewrite (Ctrl + R)";
	values[] = ZERO_OR_ONE;
	texts[] = NO_OR_YES;
	GET_DEFAULT_PARAM(BLWK_magRepackEnabled,1)
};
class BLWK_faksToMakeMedkit
{
	title = "How many FAKs make a Medkit?";
	values[] = {5, 10, 15};
	texts[] = {"5", "10", "15"};
	GET_DEFAULT_PARAM(BLWK_faksToMakeMedkit,10)
};
class BLWK_deleteDroppedItemsEvery
{
	title = "How often should dropped items cleared?";
	values[] = {1, 2, 3, 4, 5, 999999};
	texts[] = {"Every Round", "Every 2 Rounds", "Every 3 Rounds", "Every 4 Rounds", "Every 5 Rounds", "NEVER"};
	GET_DEFAULT_PARAM(BLWK_deleteDroppedItemsEvery,3)
};
