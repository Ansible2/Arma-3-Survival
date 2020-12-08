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

#include "..\Faction Headers\Define Factions.hpp"

// waves
A_SECTION_HEADER(WAVE);

class BLWK_maxNumWaves
{
	title = "How Many Waves";
	values[] = {10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 125, 150, 999999};
	texts[] = {"10", "20", "30", "40","50","60","70","80","90","100", "125", "150", "Infinite"};
	default = 100;
};
class BLWK_timeBetweenRounds
{
	title = "Time between rounds";
	values[] = {0, 15, 30, 60, 90, 120, 180, 240, 300};
	texts[] = {"0", "15 Seconds", "30 Seconds", "1 Minute", "1 Minute 30 Seconds", "2 Minutes", "3 Minutes", "4 Minutes", "5 Minutes"};
	default = 60;
};
class BLWK_vehicleStartWave
{
	title = "Vehicles can spawn after wave";
	values[] = {5, 10, 15, 20, 25, 9999};
	texts[] = {"5", "10", "15", "20", "25", "Never"};
	default = 10;
};
class BLWK_specialWavesStartAt
{
	title = "Special Wave Possibility Starts At Wave";
	values[] = {5, 10, 15, 20, 25, 9999};
	texts[] = {"5", "10", "15", "20", "25", "Never"};
	default = 15;
};
class BLWK_maxEnemyInfantryAtOnce
{
	title = "Max Enemy Infantry At Once (AI will wait in a queue until there is room)";
	values[] = {10,15,20,25,30,35,40,45,50};
	texts[] = {"10","15","20","25","30","35","40","45","50"};
	default = 30;
};
class BLWK_randomizeEnemyWeapons
{
	title = "Randomize Hostile Weapons";
	values[] = ZERO_OR_ONE;
	texts[] = NO_OR_YES;
	default = 0;
};
class BLWK_maxPistolOnlyWaves
{
	title = "Hostiles only use pistols until wave";
	values[] = {0, 1, 2, 3, 4, 5};
	texts[] = {"Start Fully Armed", "One", "Two", "Three", "Four", "Five"};
	default = 3;
};
class BLWK_enemiesPerWaveMultiplier
{
	title = "Enemies Per Wave Multiplier";
	values[] = {0.5,1,1.5,2,2.5,3};
	texts[] = {"0.5","1","1.5","2","2.5","3"};
	default = 1;
};
// CIPHER COMMENT: The utility of this value should be replaced with a simple: add this number of enemies per round per player in addition to the number already spawned
class BLWK_enemiesPerPlayerMultiplier
{
	title = "Extra Enemies Per Player";
	values[] = {0.5, 1, 1.5, 2};
	texts[] = {"0.5", "1", "1.5", "2"};
	default = 1;
};
class BLWK_roundsBeforeBodyDeletion
{
	title = "Dead bodies remain for how many waves (dead bodies impact perfomance)";
	values[] = {0, 1, 2};
	texts[] = {"0 (until next round begins)", "1", "2"};
	default = 1;
};


// Players
A_SPACE(Player);
A_SECTION_HEADER(Player);
class BLWK_friendlyFireOn
{
	title = "Friendly Fire";
	values[] = ZERO_OR_ONE;
	texts[] = OFF_OR_ON;
	default = 1;
};
class BLWK_fallDamageOn
{
	title = "Fall Damage (Not ACE Medical Compatabile)";
	values[] = ZERO_OR_ONE;
	texts[] = OFF_OR_ON;
	default = 0;
};
class BLWK_staminaEnabled
{
	title = "Enable stamina";
	values[] = ZERO_OR_ONE;
	texts[] = NO_OR_YES;
	default = 0;
};
class BLWK_weaponSwayCoef
{
	title = "Weaponsway coefficient (zero means no sway)";
	values[] = {0, 0.1, 0.15, 0.2, 0.25, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1};
	texts[] = {"0", "0.1", "0.15", "0.2", "0.25", "0.3", "0.4", "0.5", "0.6", "0.7", "0.8", "0.9", "1"};
	default = 0;
};



// start
A_SPACE(Start);
A_SECTION_HEADER(Start);

class BLWK_startingWaveNumber
{
	title = "Start from wave number (should be less then max wave)";
	values[] = {0, 5, 10, 15, 20, 25, 30, 35, 40, 45, 50};
	texts[] = {"0", "5", "10", "15", "20", "25", "30", "35", "40", "45", "50"};
	default = 0;
};
class BLWK_startingKillPoints
{
	title = "Kill points players start with";
	values[] = {0, 250, 500, 1000, 2500, 5000, 10000};
	texts[] = {"0", "250", "500", "1000", "2500", "5000", "10000"};
	default = 0;
};
class BLWK_startingCommunityKillPoints
{
	title = "Community starting points";
	values[] = {0, 250, 500, 1000, 2500, 5000, 10000, 15000, 20000};
	texts[] = {"0", "250", "500", "1000", "2500", "5000", "10000", "15000", "20000"};
	default = 0;
};
class BLWK_supportDishFound
{
	title = "Find Satellite Dish to Unlock Supports";
	values[] = ZERO_OR_ONE;
	texts[] = {"Yes, find the Satellite Dish to unlock the Support Menu", "No, Supports are available from the begining of the mission"};
	default = 1;
};
class BLWK_numMedKits
{
	title = "Medikits in The Crate";
	values[] = {0, 1, 2, 3, 4, 5, 6, 7, 8};
	texts[] = {"None", "One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight"};
	default = 3;
};
class BLWK_playersStartWith_map
{
	title = "Start with map";
	values[] = ZERO_OR_ONE;
	texts[] = NO_OR_YES;
	default = 1;
};
class BLWK_playersStartWith_compass
{
	title = "Start with compass";
	values[] = ZERO_OR_ONE;
	texts[] = NO_OR_YES;
	default = 1;
};
class BLWK_playersStartWith_radio
{
	title = "Start with a radio (TFAR Compatabile) (You must have one to get support radio messages)";
	values[] = ZERO_OR_ONE;
	texts[] = NO_OR_YES;
	default = 1;
};
class BLWK_playersStartWith_mineDetector
{
	title = "Start with a mine detector";
	values[] = ZERO_OR_ONE;
	texts[] = NO_OR_YES;
	default = 0;
};
class BLWK_playersStartWith_pistol
{
	title = "Start with a pistol";
	values[] = ZERO_OR_ONE;
	texts[] = NO_OR_YES;
	default = 0;
};
class BLWK_playersStartWith_NVGs
{
	title = "Start with NVGs";
	values[] = ZERO_OR_ONE;
	texts[] = NO_OR_YES;
	default = 0;
};



// area
A_SPACE(Area);
A_SECTION_HEADER(Area);

class BLWK_customPlayLocation
{
	title = "Would you like to select a custom location to play?";
	values[] = ZERO_OR_ONE;
	texts[] = NO_OR_YES;
	default = 0;
};
class BLWK_playAreaRadius
{
	title = "Mission area size";
	values[] = {50, 100, 150, 200, 250};
	texts[] = {"(50m) Tiny", "(100m) Small", "(150m) Normal", "(200m) Large", "(250m) Huge"};
	default = 150;
};
class BLWK_minNumberOfHousesInArea
{
	title = "Minimum number of buildings in the play area radius";
	values[] = {5, 10, 15, 20, 30};
	texts[] = {"5","10","15","20","30"};
	default = 20;
};
class BLWK_loot_cityDistribution
{
	title = "Loot City distribution";
	values[] = {1, 2, 3, 4};
	texts[] = {"Every building", "Every second building", "Every third building", "Every fourth building"};
	default = 1;
};
class BLWK_loot_roomDistribution
{
	title = "Loot Within Building Distribution";
	values[] = {1, 2, 3, 4};
	texts[] = {"Every location", "Every second location", "Every third location", "Every fourth location"};
	default = 2;
};
class BLWK_buildingsNearTheCrateAreIndestructable_radius
{
	title = "The radius of indestructable buildings around The Crate";
	values[] = {0,5,10,15,20,25,30};
	texts[] = {"OFF","5m","10m","15m","20m","25m","30m"};
	default = 10;
};



// ambient
A_SPACE(Ambient);
A_SECTION_HEADER(Ambient);
class BLWK_timeOfDay
{
	title = "The Time Of Day";
	values[] = {2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22};
	texts[] = {"0200","0400","0600","0800","1000","1200", "1400", "1600", "1800", "2000", "2200"};
	default = 12;
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
	default = 1;
};
class BLWK_pointsForKill
{
	title = "Base Points For Kill";
	values[] = {10, 50, 100, 150, 200, 300};
	texts[] = {"10","50","100","150","200","300"};
	default = 100;
};
class BLWK_pointsForHit
{
	title = "Base Points per Hit";
	values[] = {0, 10, 20, 50, 100};
	texts[] = {"0","10","20","50","100"};
	default = 20;
};
class BLWK_pointsMultiForDamage
{
	title = "Damage bonus points";
	values[] = {0, 10, 20, 50, 100};
	texts[] = {"0","10","20","50","100"};
	default = 20;
};


// respawn
A_SPACE(Respawn);
A_SECTION_HEADER(Respawn);
class BLWK_numRespawnTickets
{
	title = "Respawn Tickets";
	values[] = {0, 5, 10, 15, 20};
	texts[] = {"0", "5", "10", "15", "20"};
	default = 10;
};

class BLWK_saveRespawnLoadout
{
	title = "Players Get Their Loadout If They Respawn";
	values[] = ZERO_OR_ONE;
	texts[] = OFF_OR_ON;
	default = 0;
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
class BLWK_lightCarLikelihood
{
	title = "Enemy Light Car Likelihood";
	values[] = ZERO_TO_TEN;
	texts[] = ZERO_TO_TEN_STRINGS;
	default = 5;
};
class BLWK_heavyCarLikelihood
{
	title = "Enemy Heavy Car Likelihood";
	values[] = ZERO_TO_TEN;
	texts[] = ZERO_TO_TEN_STRINGS;
	default = 3;
};
class BLWK_lightArmorLikelihood
{
	title = "Enemy Light Armor Likelihood";
	values[] = ZERO_TO_TEN;
	texts[] = ZERO_TO_TEN_STRINGS;
	default = 2;
};
class BLWK_heavyArmorLikelihood
{
	title = "Enemy Heavy Armor Likelihood";
	values[] = ZERO_TO_TEN;
	texts[] = ZERO_TO_TEN_STRINGS;
	default = 1;
};

// Other
A_SPACE(Other);
A_SECTION_HEADER(Other);

class BLWK_multipleLootReveals
{
	title = "Show all loot with reveal?";
	values[] = ZERO_OR_ONE;
	texts[] = {"Show all","Choose what type to show"};
	default = 1;
};
class BLWK_aircraftGunnerLifetime
{
	title = "How many waves should gunner supports last?";
	values[] = {1,2,3,4,5};
	texts[] = {"1","2","3","4","5"};
	default = 2;
};
class BLWK_magRepackEnabled
{
	title = "Enable Vanilla QS MagRepack Rewrite (Ctrl + R)";
	values[] = ZERO_OR_ONE;
	texts[] = NO_OR_YES;
	default = 1;
};
class BLWK_faksToMakeMedkit
{
	title = "How many FAKs make a Medkit?";
	values[] = {5, 10, 15};
	texts[] = {"5", "10", "15"};
	default = 10;
};
class BLWK_deleteDroppedItemsEvery
{
	title = "How often should dropped items cleared?";
	values[] = {1, 2, 3, 4, 5, 999999};
	texts[] = {"Every Round", "Every 2 Rounds", "Every 3 Rounds", "Every 4 Rounds", "Every 5 Rounds", "NEVER"};
	default = 3;
};