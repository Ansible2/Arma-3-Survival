class HOSTILE_LABEL
{
	title = "======= Wave Settings =======";
	values[] = {0};
	texts[] = {""};
	default = 0;
};

class BLWK_enemiesPerWaveMultiplier
{
	title = "Number of hostiles per wave";
	values[] = {0.5,1,2,3};
	texts[] = {"Low (Easiest)", "Normal", "Double", "Tripple (Hardest)"};
	default = 1;
};

class BLWK_enemiesPerPlayerMultiplier
{
	title = "Extra hostiles per player";
	values[] = {50, 100, 150, 200};
	texts[] = {"0.5", "1", "1.5", "2"};
	default = 50;
};

class BLWK_maxPistolOnlyWaves
{
	title = "Hostiles only use pistols until wave";
	values[] = {0, 1, 2, 3, 4, 5, 10, 15, 25, 30};
	texts[] = {"Start Fully Armed", "One", "Two", "Three", "Four", "Five", "Ten", "Fifteen", "Twenty", "Twenty Five", "Thirty"};
	default = 3;
};

class BLWK_roundsBeforeBodyDeletion
{
	title = "Dead bodies remain for how many waves (dead bodies impact perfomance)";
	values[] = {0, 1, 2};
	texts[] = {"0 (until next round begins)", "1", "2"};
	default = 0;
};

class BLWK_timeBetweenRounds
{
	title = "Time between rounds";
	values[] = {0, 15, 30, 60, 90, 120, 180, 240, 300};
	texts[] = {"0", "15 Seconds", "30 Seconds", "1 Minute", "1 Minute 30 Seconds", "2 Minutes", "3 Minutes", "4 Minutes", "5 Minutes"};
	default = 60;
};

class BLWK_maxNumWaves
{
	title = "How Many Waves";
	values[] = {"infinite", 20, 30, 40};
	texts[] = {"Infinite", "20", "30", "40"};
	default = "infinite";
};

class BLWK_numMedKits
{
	title = "Medikits in Bulwark";
	values[] = {0, 1, 2, 3, 4, 5, 6, 7, 8};
	texts[] = {"None", "One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight"};
	default = 3;
};

class BLWK_playersStartWith_map
{
	title = "Start with map";
	values[] = {0, 1};
	texts[] = {"No", "Yes"};
	default = 1;
};

class BLWK_playersStartWith_pistol
{
	title = "Players start with pistol";
	values[] = {0, 1};
	texts[] = {"No", "Yes"};
	default = 0;
};

class BLWK_playersStartWith_NVGs
{
	title = "Players start with NVG";
	values[] = {0, 1};
	texts[] = {"No", "Yes"};
	default = 0;
};

class BLWK_useSpecialWaves
{
	title = "Special Waves - suicide bombers, etc";
	values[] = {0, 1};
	texts[] = {"No", "Yes"};
	default = 1;
};

class BLWK_vehicleStartWave
{
	title = "Vehicles can spawn after wave";
	values[] = {5, 10, 15, 20, 25, 9999};
	texts[] = {"5", "10", "15", "20", "25", "Never"};
	default = 5;
};

class BLWK_randomizeHostileWeapons
{
	title = "Randomize Hostile Weapons";
	values[] = {0, 1};
	texts[] = {"No", "Yes"};
	default = 0;
};

class BLWK_showHitPoints
{
	title = "Point Hitmarkers on HUD";
	values[] = {0, 1};
	texts[] = {"No", "Yes"};
	default = 1;
};

class BULWARK_LABEL_SPACE
{
	title = " ";
	values[] = {0};
	texts[] = {""};
	default = 0;
};

class BULWARK_LABEL
{
	title = "===== Bulwark Settings ======";
	values[] = {0};
	texts[] = {""};
	default = 0;
};

class BLWK_playAreaRadius
{
	title = "Mission area size";
	values[] = {50, 100, 150, 200, 250};
	texts[] = {"(50m) Tiny", "(100m) Small", "(150m) Normal", "(200m) Large", "(250m) Huge"};
	default = 150;
};

class BLWK_minSpawnRoomSize
{
	title = "Minimum spawn room size";
	values[] = {10, 13, 15, 18, 20};
	texts[] = {"10m²", "13m²", "15m²", "18m²", "20m²"};
	default = 13;
};

class BLWK_minLandToWaterRatio
{
	title = "Minimum land area (To avoid spawning on a dock)";
	values[] = {60, 70, 80, 90, 100};
	texts[] = {"60%","70%","80%","90%","100%"};
	default = 80;
};

class BLWK_loot_houseDensity
{
	title = "Minimum number of buildings in Bulwark radius";
	values[] = {5, 10, 15, 20, 30};
	texts[] = {"5","10","15","20","30"};
	default = 10;
};

class BLWK_loot_cityDistribution
{
	title = "Loot distribution";
	values[] = {1, 2, 3, 4};
	texts[] = {"Every building", "Every second building", "Every third building", "Every fourth building"};
	default = 2;
};

class BLWK_loot_roomDistribution
{
	title = "Loot density";
	values[] = {1, 2, 3, 4};
	texts[] = {"Every location", "Every second location", "Every third location", "Every fourth location"};
	default = 2;
};

class BLWK_supplyDropRadius
{
	title = "Supply drop distance from centre";
	values[] = {0, 25, 50, 75};
	texts[] = {"Dead centre", "25%", "50%", "75%"};
	default = 25;
};

class BLWK_timeOfDayMin
{
	title = "Earliest time of day";
	values[] = {2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22};
	texts[] = {"2am","4am","6am","8am","10am","Midday", "2pm", "4pm", "6pm", "8pm", "10pm"};
	default = 8;
};

class BLWK_timeOfDayMax
{
	title = "Latest time of day";
	values[] = {2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22};
	texts[] = {"2am","4am","6am","8am","10am","Midday", "2pm", "4pm", "6pm", "8pm", "10pm"};
	default = 16;
};

class POWERUP_LABEL_SPACE
{
	title = " ";
	values[] = {0};
	texts[] = {""};
	default = 0;
};

class POWERUP_LABEL
{
	title = "====== Powerup Settings =====";
	values[] = {0};
	texts[] = {""};
	default = 0;
};

class BLWK_startingKillPoints
{
	title = "Kill points players start with";
	values[] = {0, 250, 500, 1000, 2500, 5000, 10000};
	texts[] = {"0", "250", "500", "1000", "2500", "5000", "10000"};
	default = 0;
};

class BLWK_supportMenuAllowed
{
	title = "Find Satellite Dish to Unlock Supports";
	values[] = {0, 1};
	texts[] = {"No, Supports are available from the begining of the mission", "Yes, find the Satellite Dish to unlock the Support Menu"};
	default = 1;
};

class BLWK_pointsForKill
{
	title = "Points per kill";
	values[] = {10, 50, 100, 150, 200, 300};
	texts[] = {"10","50","100","150","200","300"};
	default = 100;
};

class BLWK_pointsForHit
{
	title = "Points per hit";
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

class BLWK_paratrooperCount
{
	title = "Paratrooper count";
	values[] = {1, 2, 3, 4, 5, 6};
	texts[] = {"1","2","3","4","5","6"};
	default = 3;
};

class REVIVE_LABEL_SPACE
{
	title = "";
	values[] = {0};
	texts[] = {""};
	default = 0;
};

class REVIVE_LABEL
{
	title = "===== Revive Settings ======";
	values[] = {0};
	texts[] = {""};
	default = 0;
};

class BLWK_reviveRequiredItems
{
	title = "Required items";
	isGlobal = 1;

	values[] = {
		0,
		1,
		2
	};
	texts[] = {
		"None",
		"Medikit",
		"First Aid Kit / Medikit"
	};
	default = 2;
	function = "bis_fnc_paramReviveRequiredItems";
};

class BLWK_numRespawnTickets
{
	title = "Tickets";
	values[] = {0, 5, 10, 15, 20};
	texts[] = {"0", "5", "10", "15", "20"};
	default = 0;
};

class BLWK_respawnTime
{
	title = "Respawn Time";
	values[] = {0, 5, 10, 20, 30};
	texts[] = {"0", "5", "10", "20", "30"};
	default = 10;
};

class BLWK_saveRespawnLoadout
{
	title = "Players Get Their Loadout If They Respawn";
	values[] = {0, 1};
	texts[] = {"Off", "On"};
	default = 0;
};

class BLWK_friendlyFireOn
{
	title = "Freindly Fire";
	values[] = {0, 1};
	texts[] = {"Off", "On"};
	default = 1;
};

class BLWK_buildingsNearBulwarkAreIndestructable
{
	title = "Buildings Near Bulwark Are Indestructable";
	values[] = {0, 1};
	texts[] = {"Off", "On"};
	default = 0;
};