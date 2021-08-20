#define DEFAULT_FALSE 0
#define DEFAULT_TRUE 1


class paramBase
{
	title = ""; // text that shows up next to parameter
	tooltip = ""; // tooltip that will show when hovering over param (also should auto-add configName of param)
	initScript = ""; // This is uncompiled code that will be compiled and run on EVERY MACHINE after the briefing menu is closed
	/*
		Parameters are:
		_this select 0 - The new value
		_this select 1 - <STRING> - The mission parameter's variable name (either the param configName or varName property)
		_this select 2 - <CONFIG> - The param Config path
	*/
	varName = ""; // a global variable name to tie to the parameter, if not defined, the configName will be used
	onChanged = ""; // This is uncompiled code that will be compiled and run on EVERY MACHINE when a change is commited AFTER the briefing menu (Parameters are the same as the initScript property)
	requiresRestart = 0; // if the changed parameter requires a mission restart when changed after the briefing screen; 0 = false, 1 = true. Any parameters that require restart will not have their changes broadcast mid mission
	namespace = 0; // 0 to put variable inside the missionNamespace and 1 to put inside of the localNamespace
};
class sliderParamBase : paramBase
{
	type = TYPE_SLIDER;
	min = 0; // min slider value
	max = 1; // max slider value
	incriment = 1; // amount by which slider can be increased with each step
	default = 0;// default slider position
};
class comboParamBase : paramBase
{
	type = TYPE_COMBO;
	values[] = {}; // opional value array
	texts[] = {}; // optional strings array (what shows up in combo)
	populationScript = ""; // an optional script that can populate the list dynamically, must return either an array of [[strings],[numbers]] (for use with values instead of strings) or an array of strings
	sortList = 0; // 0 for false, 1 for true. Sorts the list alphabetically using sort command.
	// the default property can either be a string or number depending on whether or not you are using values
};
class editParamBase : paramBase
{
	type = TYPE_EDIT;
	default = "";
};
class listParamBase : comboParamBase
{
	type = TYPE_LIST;
};
class yes_no_paramBase : paramBase
{
	type = TYPE_BINARY;
	textTrue = "YES";
	textFalse = "NO";
	isBool = 1; // interpret 0 and 1 directly into boolean values
	default = DEFAULT_TRUE;
};
class on_off_paramBase : yes_no_paramBase
{
	textTrue = "ON";
	textFalse = "OFF";
};


class KISKA_missionParams
{
	ProfileVarName = "BLWK_survivalParamProfiles"; // A profilenamespace variable that will hold mission parameter profiles

	class AI
	{
		title = "Enemy AI";

		class BLWK_doDetectCollision : yes_no_paramBase
		{
			title = "Run Enemy AI Collision Script?";
			tooltip = "This script will run on all enemy AI not in vehicles. It is for the purpose of keeping the AI from being able to walk through built objects (at approximately their eye line). It is NOT guaranteed.";
			default = DEFAULT_TRUE;
		};
		class BLWK_doDetectMines : on_off_paramBase
		{
			title = "Enemy AI Mine Detection";
			default = DEFAULT_TRUE;
		};
		class BLWK_suppressionEnabled : on_off_paramBase
		{
			title = "Enemy AI Suppression";
			tooltip = "AI are less cautious/more agressive with suppression off";
			default = DEFAULT_TRUE;
		};
		class BLWK_autocombatEnabled : on_off_paramBase
		{
			title = "Enemy AI AutoCombat";
			tooltip = "AI that have AutoCombat enabled will be more cautious under fire";
			default = DEFAULT_FALSE;
		};

		class BLWK_baseSkill : sliderParamBase
		{
			title = "Base Skill Level";
			tooltip = "The base skill level is added to the wave incriment number, multiplied by your current wave, to get the AI's skill for that wave.";
			min = 0.01;
			max = 1;
			incriment = 0.01;
			default = 0.2;
		};
		class BLWK_skillIncriment : sliderParamBase
		{
			title = "Skill Level Wave Incriment";
			tooltip = "Each wave will increase the AI's skill by this much.";
			min = 0;
			max = 1;
			incriment = 0.01;
			default = 0.02;
		};
		class BLWK_maxSkill : BLWK_baseSkill
		{
			title = "Max AI Skill Level";
			tooltip = "The max an AI Skill level can be.";
			default = 0.6;
		};

		class BLWK_aimSpeedMod : sliderParamBase
		{
			title = "Aiming Speed Modifier";
			tooltip = "Whatever the outcome is of the AI skill level equation for a wave, it will be multiplied by this to set the AI's 'aimingSpeed' skill. A value of 1 means no change.";
			min = 0.05;
			max = 1;
			incriment = 0.05;
			default = 0.75;
		};

		class BLWK_spotTime : BLWK_baseSkill
		{
			title = "Spot Time";
			tooltip = "A modifier for adjusting how quickly the AI register enemies in their line-of-sight. This is a static value that is unaffected by the wave number or base skill parameter.";
			default = 0.3;
		};
	};

	class WeatherAndTime
	{
		title = "Weather And Time";

		class BLWK_timeOfDay : comboParamBase
		{
			title = "Starting Time Of Day";
			values[] = {0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23};
			texts[] = {
				"0000",
				"0100",
				"0200",
				"0300",
				"0400",
				"0500",
				"0600",
				"0700",
				"0800",
				"0900",
				"1000",
				"1100",
				"1200",
				"1300",
				"1400",
				"1500",
				"1600",
				"1700",
				"1800",
				"1900",
				"2000",
				"2100",
				"2200",
				"2300"
			};
			requiresRestart = 1;
			default = 6;
		};
		class BLWK_daySpeedMultiplier : sliderParamBase
		{
			title = "Day Speed Multiplier";
			tooltip = "(The higher the multiplier, the more impact it has on performance) Quick Values: x1 (24h cycle), x6 (4h cycle), x8 (3h cycle), x12 (2h cycle), x24 (1h cycle), x48 (30m cycle), x72 (20m cycle)";
			min = 1;
			max = 72;
			onChanged = "if (isServer) then {setTimeMultiplier (_this select 0)}";
			initScript = "if (isServer) then {setTimeMultiplier (_this select 0)}";
			default = 8;
		};
		class BLWK_overcast : sliderParamBase
		{
			title = "Weather Overcast";
			tooltip = "Higher the value, the more clouds. 0 is no clouds, 100 is overcast";
			min = 0;
			max = 100;
			default = 25;
			onChanged = "[_this select 0] spawn BIS_fnc_paramWeather";
			initScript = "[_this select 0] spawn BIS_fnc_paramWeather";
		};

		class BLWK_rain : sliderParamBase
		{
			title = "Rain";
			tooltip = "Requires an overcast value of atleast 70";
			min = 0;
			max = 100;
			default = 25;
			onChanged = "if (isServer) then {0 setRain (_this select 0)}";
			initScript = "if (isServer) then {0 setRain (_this select 0)}";
		};
		class BLWK_lightning : sliderParamBase
		{
			title = "Lightning";
			tooltip = "Higher the value, the more lightning.";
			min = 0;
			max = 100;
			default = 25;
			onChanged = "0 setLightnings (_this select 0)";
			initScript = "0 setLightnings (_this select 0)";
		};
	};

	class Area
	{
		title = "Mission Area";

		class BLWK_customPlayLocation : yes_no_paramBase
		{
			title = "Select a custom location to play?";
			tooltip = "After parameters are initialized, the host or first available admin will be given the chance to select an area.";
			requiresRestart = 1;
			default = DEFAULT_FALSE;
		};
		class BLWK_playAreaRadius : sliderParamBase
		{
			title = "Mission Area Radius";
			tooltip = "In meters, this is the size of the area players can move in";
			requiresRestart = 1;
			min = 50;
			max = 250;
			default = 150;
		};
		class BLWK_minNumberOfHousesInArea : sliderParamBase
		{
			title = "Minimum Number of Buildings In The Play Area";
			tooltip = "This setting makes no difference if selecting a custom play area";
			min = 5;
			max = 30;
			default = 15;
		};
	};

	class Loot
	{
		title = "Loot";

		class BLWK_maxLootSpawns_param : sliderParamBase
		{
			title = "Max Number Of Loot Spawns";
			tooltip = "There will not be more loot drops in the area then what is set. Higher values have a large impact on performance.";
			initScript = "if (isServer) then {BLWK_maxLootSpawns = (_this select 0);}";
			onChanged = "if (isServer) then {BLWK_maxLootSpawns = (_this select 0);}";
			min = 0;
			max = 800;
			default = 500;
		};
		class BLWK_loot_whiteListMode : listParamBase
		{
			title = "Loot Whitelist Mode";
			tooltip = "Pick a configured loot list to determine what weapons can spawn on the ground.";
			populationScript = "call BLWK_fnc_KISKAParams_populateLootWhitelists";
			default = "ALL";
		};
		class BLWK_loot_cityDistribution : comboParamBase
		{
			title = "Loot City Distribution";
			tooltip = "Loot will spawn in this number of buildings";
			values[] = {1, 2, 3, 4};
			texts[] = {"Every building", "Every second building", "Every third building", "Every fourth building"};
			default = 1;
		};
		class BLWK_loot_roomDistribution : comboParamBase
		{
			title = "Loot Within Building Distribution";
			tooltip = "Loot will spawn in these places within buildings";
			values[] = {1, 2, 3, 4};
			texts[] = {"Every location", "Every second location", "Every third location", "Every fourth location"};
			default = 2;
		};
	};

	class Factions
	{
		title = "Factions";

		class BLWK_friendlyFaction : comboParamBase
		{
			title = "Friendly Faction";
			populationScript = "call BLWK_fnc_KISKAParams_populateFactionList";
			requiresRestart = 1;
			sortList = 1;
			default = "VANILLA - NATO";
		};


		class BLWK_level1Faction : BLWK_friendlyFaction
		{
			title = "Level 1 Enemy Faction";
			default = "VANILLA - FIA";
		};
		class BLWK_level1Faction_weight : sliderParamBase
		{
			title = "Level 2 Faction Weight";
			tooltip = "The weight of a faction determines how prevelant it is when spawning. e.g. if the weight of level 1 is higher then level 2, you'll see more level 1 enemies.";
			min = 1;
			max = 5;
			default = 1;
		};


		class BLWK_level2Faction : BLWK_friendlyFaction
		{
			title = "Level 2 Enemy Faction";
			default = "VANILLA - AAF";
		};
		class BLWK_level2Faction_weight : BLWK_level1Faction_weight
		{
			title = "Level 2 Faction Weight";
			default = 2;
		};
		class BLWK_level2Faction_startWave : sliderParamBase
		{
			title = "Level 2 Starting Wave";
			tooltip = "At what wave number will level 2 enemies be allowed to spawn?";
			min = 1;
			max = 25;
			default = 6;
		};


		class BLWK_level3Faction : BLWK_friendlyFaction
		{
			title = "Level 3 Enemy Faction";
			default = "VANILLA - CSAT";
		};
		class BLWK_level3Faction_weight : BLWK_level1Faction_weight
		{
			title = "Level 3 Faction Weight";
			default = 3;
		};
		class BLWK_level3Faction_startWave : BLWK_level2Faction_startWave
		{
			title = "Level 3 Starting Wave";
			tooltip = "At what wave number will level 3 enemies be allowed to spawn?";
			default = 11;
		};


		class BLWK_level4Faction : BLWK_friendlyFaction
		{
			title = "Level 4 Enemy Faction";
			default = "VANILLA - CSAT URBAN";
		};
		class BLWK_level4Faction_weight : BLWK_level1Faction_weight
		{
			title = "Level 4 Faction Weight";
			default = 4;
		};
		class BLWK_level4Faction_startWave : BLWK_level2Faction_startWave
		{
			title = "Level 4 Starting Wave";
			tooltip = "At what wave number will level 4 enemies be allowed to spawn?";
			default = 16;
		};


		class BLWK_level5Faction : BLWK_friendlyFaction
		{
			title = "Level 5 Enemy Faction";
			default = "CONTACT - Spetznas";
		};
		class BLWK_level5Faction_weight : BLWK_level1Faction_weight
		{
			title = "Level 5 Faction Weight";
			default = 5;
		};
		class BLWK_level5Faction_startWave : BLWK_level2Faction_startWave
		{
			title = "Level 5 Starting Wave";
			tooltip = "At what wave number will level 5 enemies be allowed to spawn?";
			default = 21;
		};

	};

	class Misc
	{
		title = "Misc";

		class BLWK_multipleLootReveals : yes_no_paramBase
		{
			title = "Use Multiple Loot Reveal Actions";
			tooltip = "To reduce map clutter, there will be multiple actions on the loot reveal box to choose what kind of loot should be highlighted on the map. If OFF, all map loot will be shown when picking up the box.";
			default = DEFAULT_TRUE;
		};
		class BLWK_buildingsNearTheCrateAreIndestructable_radius : sliderParamBase
		{
			title = "Radius of Indestructable Terrain Buildings Near The Crate";
			tooltip = "Buildings that are a part of the map will be indestructable when within this distance (meters) of the Main Crate";
			min = 0;
			max = 30;
			requiresRestart = 1;
			default = 20;
		};
		class BLWK_aircraftGunnerLifetime : sliderParamBase
		{
			title = "How many waves should gunner supports last?";
			tooltip = "Aircraft Gunner supports are those in which the player sits in the turret of an aircraft. Players will be automatically kicked out this many waves after they've started using it.";
			min = 1;
			max = 5;
			default = 2;
		};
		class BLWK_faksToMakeMedkit : sliderParamBase
		{
			title = "FAKs To Make a Medkit";
			tooltip = "Placing a this number of FAKs inside the Main Crate will cause them to turn into a medkit.";
			min = 1;
			max = 15;
			default = 10;
		};
		class BLWK_deleteDroppedItemsEvery : sliderParamBase
		{
			title = "Dropped Items Are Cleared Every ... Rounds";
			tooltip = "Given the potential for clutter after some time, dropped items (items put on the ground by the player) will be periodically cleaned up after this many waves. You will recieve a message the round before a cleanup is to happen.";
			min = 1;
			max = 25;
			default = 3;
		};
		class BLWK_roundsBeforeBodyDeletion : sliderParamBase
		{
			title = "Enemy Body Lifetime (waves)";
			tooltip = "The more dead bodies present will impact perfomance. The vanilla garbage collector is on for extreme cases, but this ensures some degree of cleanup. A value of 0 will delete bodies after every wave.";
			min = 0;
			max = 2;
			default = 2;
		};
	};

	class Players
	{
		title = "Player Settings";

		class BLWK_friendlyFireOn : on_off_paramBase
		{
			title = "Friendly Fire";
			tooltip = "This is not ACE Medical compatible";
			default = 1;
		};

		class BLWK_fallDamageOn : on_off_paramBase
		{
			title = "Fall Damage";
			tooltip = "This is NOT ACE Medical compatabile";
			default = 0;
		};
		class BLWK_magRepackEnabled : yes_no_paramBase
		{
			title = "Enable Vanilla MagRepack";
			tooltip = "Enables players to press (Ctrl + R) to run a mag repack script.";
			requiresRestart = 1;
			default = DEFAULT_TRUE;
		};
		class BLWK_staminaEnabled : yes_no_paramBase
		{
			title = "Enable stamina";
			tooltip = "This is NOT ACE compatabile";
			default = 0;
		};
		class BLWK_weaponSwayCoef : sliderParamBase
		{
			title = "Weaponsway Coefficient";
			tooltip = "Zero means no sway";
			min = 0;
			max = 1;
			incriment = 0.01;
			default = 0.15;
		};
		class BLWK_playersStartWith_map : yes_no_paramBase
		{
			title = "Players Start With Map";
			tooltip = "Players will be given a map intially and after they respawn";
			default = DEFAULT_TRUE;
		};
		class BLWK_playersStartWith_compass : yes_no_paramBase
		{
			title = "Players Start With Compass";
			tooltip = "Players will be given a compass intially and after they respawn";
			default = DEFAULT_TRUE;
		};
		class BLWK_playersStartWith_radio : yes_no_paramBase
		{
			title = "Players Start With A Radio";
			tooltip = "Players will be given a radio intially and after they respawn. If players do not have a radio, they will not here the auto radio calls for supports. This is ACRE & TFAR compatible (343's & 152's respectively)";
			default = DEFAULT_TRUE;
		};
		class BLWK_playersStartWith_mineDetector : yes_no_paramBase
		{
			title = "Players Start With A Mine Detector";
			tooltip = "Players will be given a mine detector intially and after they respawn";
			default = DEFAULT_FALSE;
		};
		class BLWK_playersStartWith_pistol : yes_no_paramBase
		{
			title = "Players Start With A Pistol";
			tooltip = "Players will be given a pistol intially and after they respawn";
			default = DEFAULT_FALSE;
		};
		class BLWK_defaultPistolClass : editParamBase
		{
			title = "Starting Pistol Classname";
			tooltip = "This is the pistol that players will spawn with. It also affects what the AI use during pistol only waves.";
			default = "hgun_P07_F";
		};
		class BLWK_defaultPistolMagClass : editParamBase
		{
			title = "Starting Pistol Magazine Classname";
			tooltip = "This is the pistol that players will spawn with. It also affects what the AI use during pistol only waves.";
			default = "16Rnd_9x21_Mag";
		};
		class BLWK_playersStartWith_NVGs : yes_no_paramBase
		{
			title = "Players Start With NVGs";
			tooltip = "Players will be given a pair of Night-Vision-Goggles intially and after they respawn";
			default = DEFAULT_FALSE;
		};
		class BLWK_defaultVestClass : editParamBase
		{
			title = "Starting Vest Classname";
			tooltip = "This is the class of the vest that players will spawn with.";
			default = "V_RangeMaster_Belt";
		};
	};

	class Points
	{
		title = "Point Settings";

		class BLWK_pointsForKill : sliderParamBase
		{
			title = "Base Points For Kill";
			tooltip = "This is the amount that will be affected by the type multipliers";
			min = 10;
			max = 300;
			default = 100;
		};
		class BLWK_showHitPoints : yes_no_paramBase
		{
			title = "Show Point Hit Markers";
			tooltip = "3D space text will popup when you hit an enemy indicating how many points you've obtained from the hit. The same happens with a kill.";
			default = DEFAULT_TRUE;
		};
		class BLWK_pointsForHit : sliderParamBase
		{
			title = "Base Points per Hit";
			tooltip = "The minimum amount of points you will get for a hit on an enemy";
			min = 0;
			max = 100;
			default = 30;
		};
		class BLWK_pointsMultiForDamage : sliderParamBase
		{
			title = "Damage bonus points";
			tooltip = "An additional amount added on top of hit points based upon damage caused";
			min = 0;
			max = 100;
			default = 20;
		};
		class BLWK_pointsMulti_man_level1 : sliderParamBase
		{
			title = "Level 1 Points Multiplier";
			tooltip = "Killing a level 1 enemy will award you the base points multiplied by this";
			min = 0.05;
			max = 2;
			incriment = 0.05;
			default = 1;
		};
		class BLWK_pointsMulti_man_level2 : BLWK_pointsMulti_man_level1
		{
			title = "Level 2 Points Multiplier";
			tooltip = "Killing a level 2 enemy will award you the base points multiplied by this";
			default = 1.25;
		};
		class BLWK_pointsMulti_man_level3 : BLWK_pointsMulti_man_level1
		{
			title = "Level 3 Points Multiplier";
			tooltip = "Killing a level 3 enemy will award you the base points multiplied by this";
			default = 1.50;
		};
		class BLWK_pointsMulti_man_level4 : BLWK_pointsMulti_man_level1
		{
			title = "Level 4 Points Multiplier";
			tooltip = "Killing a level 4 enemy will award you the base points multiplied by this";
			default = 1.75;
		};
		class BLWK_pointsMulti_man_level5 : BLWK_pointsMulti_man_level1
		{
			title = "Level 5 Points Multiplier";
			tooltip = "Killing a level 5 enemy will award you the base points multiplied by this";
			default = 2;
		};
		class BLWK_pointsMulti_car : sliderParamBase
		{
			title = "Car Multiplier";
			tooltip = "Destroying a car will award you the base points multiplied by this";
			min = 1;
			max = 15;
			default = 5;
		};
		class BLWK_pointsMulti_armour : BLWK_pointsMulti_car
		{
			title = "Armour Multiplier";
			tooltip = "Destroying enemy armour will award you the base points multiplied by this";
			default = 10;
		};
		class BLWK_pointsMulti_heli : BLWK_pointsMulti_car
		{
			title = "Helicopter Multiplier";
			tooltip = "Destroying an enemy helicopter will award you the base points multiplied by this";
			default = 8;
		};
	};

	class Respawn
	{
		title = "Respawn Settings";

		class BLWK_numRespawnTickets : sliderParamBase
		{
			title = "Number of Respawn Tickets";
			min = 0;
			max = 100;
			requiresRestart = 1;
			default = 20;
		};
		class BLWK_saveRespawnLoadout : yes_no_paramBase
		{
			title = "Restore Player Loadout After Respawn";
			default = DEFAULT_FALSE;
		};
	};

	class ItemReclaimer
	{
		title = "Item Reclaimer";

		class BLWK_IRP_weapons : sliderParamBase
		{
			title = "Points For Weapons";
			tooltip = "The amount of points you get from the Item Reclaimer object from each weapon. Points are placed in the community pool.";
			min = 1;
			max = 750;
			default = 250;
		};
		class BLWK_IRP_magazines : BLWK_IRP_weapons
		{
			title = "Points For Magazines";
			tooltip = "The amount of points you get from the Item Reclaimer object from each magazine. Points are placed in the community pool.";
			default = 50;
		};
		class BLWK_IRP_items : BLWK_IRP_weapons
		{
			title = "Points For Items";
			tooltip = "The amount of points you get from the Item Reclaimer object from each item. Points are placed in the community pool.";
			default = 125;
		};
		class BLWK_IRP_backpacks : BLWK_IRP_weapons
		{
			title = "Points For Backpacks";
			tooltip = "The amount of points you get from the Item Reclaimer object from each backpack. Points are placed in the community pool.";
			default = 350;
		};

	};

	class Revive
	{
		title = "Vanilla Revive Settings";

		class BLWK_ReviveMode : comboParamBase
		{
			title = $STR_A3_ReviveMode;

			values[] = {
				//-100,
				0,
				1
			};
			texts[] = {
				//$STR_A3_MissionDefault,
				$STR_A3_Disabled,
				$STR_A3_EnabledForAllPlayers
			};
			default = 1;
			requiresRestart = 1;
			initScript = "(_this select 0) call bis_fnc_paramReviveMode";
		};
		class BLWK_ReviveDuration : sliderParamBase
		{
			title = $STR_A3_ReviveDuration;
			tooltip = "How long one needs to hold the revive action in order to revive another player";
			min = 1;
			max = 30;
			default = 6;

			initScript = "(_this select 0) call bis_fnc_paramReviveDuration";
		};
		class BLWK_ReviveRequiredTrait : comboParamBase
		{
			title = $STR_A3_RequiredTrait;

			values[] = {
				//-100,
				0,
				1
			};
			texts[] = {
				//$STR_A3_MissionDefault,
				$STR_A3_None,
				$STR_A3_Medic
			};
			default = 0;
			sortList = 0;
			initScript = "(_this select 0) call bis_fnc_paramReviveRequiredTrait";
		};
		class BLWK_ReviveMedicSpeedMultiplier : sliderParamBase
		{
			title = $STR_A3_RequiredTrait_MedicSpeedMultiplier;

			min = 1;
			max = 3;
			incriment = 0.1;

			default = 1;

			initScript = "(_this select 0) call bis_fnc_paramReviveMedicSpeedMultiplier";
		};

		class BLWK_ReviveRequiredItems : comboParamBase
		{
			title = $STR_A3_RequiredItems;

			values[] = {
				//-100,
				0,
				1,
				2
			};
			texts[] = {
				//$STR_A3_MissionDefault,
				$STR_A3_None,
				$STR_A3_Medikit,
				$STR_A3_FirstAidKitOrMedikit
			};

			default = 2;
			sortList = 0;
			initScript = "(_this select 0) call bis_fnc_paramReviveRequiredItems";
		};

		class BLWK_UnconsciousStateMode : comboParamBase
		{
			title = $STR_A3_IncapacitationMode;
			tooltip = "In Basic mode players (should) always be incapcitated by lethal damage. Advanced mode tries to calculate player incapacitation differently. Things such as higher caliber bullets or hits to vital areas will be more likely to instantly kill players immediately instead of incapacitating them. Realistic is the same as advanced but players are still yet more likely to instantly die.";
			values[] = {
				//-100,
				0,
				1,
				2
			};
			texts[] = {
				//$STR_A3_MissionDefault,
				$STR_A3_Basic,
				$STR_A3_Advanced,
				$STR_A3_Realistic
			};
			default = 0;
			sortList = 0;
			initScript = "(_this select 0) call bis_fnc_paramReviveUnconsciousStateMode";
		};

		class BLWK_ReviveBleedOutDuration : sliderParamBase
		{
			title = $STR_A3_BleedOutDuration;

			min = 10;
			max = 180;
			default = 120;

			initScript = "(_this select 0) call bis_fnc_paramReviveBleedOutDuration";
		};

		class BLWK_ReviveForceRespawnDuration : sliderParamBase
		{
			title = $STR_A3_ForceRespawnDuration;

			min = 3;
			max = 10;

			default = 6;
			initScript = "(_this select 0) call bis_fnc_paramReviveForceRespawnDuration";
		};
	};

	class Start
	{
		title = "Start Settings";

		class BLWK_startingWaveNumber : sliderParamBase
		{
			title = "Starting Wave Number";
			tooltip = "Ensure that this is less then the max wave number";
			min = 0;
			max = 50;
			requiresRestart = 1;
			default = 0;
		};
		class BLWK_startingKillPoints : sliderParamBase
		{
			title = "Starting Kill Points";
			tooltip = "Each player will start with this amount";
			min = 0;
			max = 15000;
			default = 0;
		};
		class BLWK_startingCommunityKillPoints : sliderParamBase
		{
			title = "Community Starting Points";
			tooltip = "The amount of points that will be in the shop community pool";
			min = 0;
			max = 30000;
			requiresRestart = 1;
			default = 0;
		};
		class BLWK_supportDishFound : yes_no_paramBase
		{
			title = "Supports Unlocked From Start";
			tooltip = "A satellite dish will spawn somewhere in the play area (in a building) and a player must interact with it to unlock the supports portion of the shop";
			requiresRestart = 1;
			default = DEFAULT_TRUE;
		};
		class BLWK_numMedKits : sliderParamBase
		{
			title = "Medkits In The Main Crate";
			tooltip = "The Crate will be filled with these at the start of a mission";
			min = 0;
			max = 8;
			default = 3;
			requiresRestart = 1;
		};


	};

	class VehicleWaves
	{
		title = "Waves (Vehicles)";

		class BLWK_vehicleStartWave : sliderParamBase
		{
			title = "Vehicles can spawn at wave";
			type = TYPE_SLIDER;
			min = 1;
			max = 999;
			default = 5;
		};
		class BLWK_minRoundsSinceVehicleSpawned : sliderParamBase
		{
			title = "The minimum number of waves between vehicle spawns";
			tooltip = "If a vehicle spawns during a wave, this number of waves will have to pass until another vehicle can (possibly) spawn.";
			min = 0;
			max = 2;
			default = 0;
		};

		class BLWK_baseVehicleSpawnLikelihood : sliderParamBase
		{
			title = "Base Vehicle Spawn Likelihood";
			tooltip = "This is the likelihood that any standard wave will have vehicles spawn in. 1 means every wave. The possibility of a spawn will increase by 0.05 with every standard wave";
			min = 0;
			max = 1;
			incriment = 0.05;
			default = 0.6;
		};
		class BLWK_lightCarLikelihood : BLWK_baseVehicleSpawnLikelihood
		{
			title = "Enemy Light Car Likelihood";
			tooltip = "This likelihood is weighted against the other vehicle type likelihoods. Light cars are typically unarmoured wheeled vehicles (trucks & buggies)";
			default = 0.4;
		};
		class BLWK_heavyCarLikelihood : BLWK_baseVehicleSpawnLikelihood
		{
			title = "Enemy Heavy Car Likelihood";
			tooltip = "This likelihood is weighted against the other vehicle type likelihoods. Heavy cars are typically armoured wheeled vehicles (MRAPs)";
			default = 0.5;
		};
		class BLWK_lightArmorLikelihood : BLWK_baseVehicleSpawnLikelihood
		{
			title = "Enemy Light Armor Likelihood";
			tooltip = "This likelihood is weighted against the other vehicle type likelihoods. Light Armor is typically APCs or IFVs";
			default = 0.5;
		};
		class BLWK_heavyArmorLikelihood : BLWK_baseVehicleSpawnLikelihood
		{
			title = "Enemy Heavy Armor Likelihood";
			tooltip = "This likelihood is weighted against the other vehicle type likelihoods. Heavy Armor is typically tanks";
			default = 0.4;
		};
	};

	class SpecialWaves
	{
		title = "Waves (Special)";

		class BLWK_specialWavesStartAt : sliderParamBase
		{
			title = "Special Can Start At Wave";
			min = 1;
			max = 999;
			default = 7;
		};
		class BLWK_specialWaveLikelihood : sliderParamBase
		{
			title = "Special Wave Likelihood Ratio";
			tooltip = "This is the likelihood out of 1 for a special wave to happen. A value of 1 will make every wave a special wave, while 0.1 will make it very rare, or 0 outright impossible.";
			min = 0;
			max = 1;
			incriment = 0.1;
			default = 0.5;
		};

		class BLWK_allowCivWave : on_off_paramBase
		{
			title = "Civilian Wave";
			tooltip = "The Civilian Wave will spawn in civilians that if killed by a player will dock 1000 points per for that players.";
			default = DEFAULT_TRUE;
		};
		class BLWK_allowDroneWave : BLWK_allowCivWave
		{
			title = "Drone Wave";
			tooltip = "Drones will spawn in the air and attempt to drop bombs on your heads. Shoot them down for a good amount of points.";
		};
		class BLWK_allowHeliWave : BLWK_allowCivWave
		{
			title = "Helicopter Wave";
			tooltip = "An enemy attack and transport helicopter will spawn and try to gun you down. Best to stay in doors and pick your moments to move.";
		};
		class BLWK_allowMortarWave : BLWK_allowCivWave
		{
			title = "Mortar Wave";
			tooltip = "An enemy mortar spawns on the edge of the play area and will shell player areas periodically until killed";
		};
		class BLWK_allowOverrunWave : BLWK_allowCivWave
		{
			title = "Overrun Wave";
			tooltip = "Players will be teleported outside the play area to one side (all together with the Crate) and AI placed inside. Any new spawing AI will be spawned directly on the opposite side of the play area from where the players were placed.";
		};
		class BLWK_allowSuicideWave : BLWK_allowCivWave
		{
			title = "Suicide Bomber Wave";
			tooltip = "Suicide Bombers will rush players and will explode when in range. They will also explode when killed.";
		};
	};

	class NormalWaves
	{
		title = "Waves (Normal)";

		class BLWK_normalWavesStartAt : sliderParamBase
		{
			title = "Normal Waves Can Start At Wave";
			tooltip = "Normal waves aren't quite 'special' but just a minor change. Normal waves are weighed against the standard wave (infantry and possibly vehicles) to see what happens when a Normal Wave is selected. Until this wave is reached, for normal waves, only the standard wave will be used. The standard wave has a weight of 1.";
			min = 1;
			max = 999;
			default = 5;
		};
		class BLWK_paratrooperWaveWeight : sliderParamBase
		{
			title = "Paratrooper Wave Weight";
			tooltip = "Paratroopers will be dropped near player positions in addition to ground troops.";
			min = 0;
			max = 1;
			incriment = 0.05;
			default = 0.6;
		};
		class BLWK_defectorWaveWeight : BLWK_paratrooperWaveWeight
		{
			title = "Defector Wave Weight";
			tooltip = "The friendly faction will spawn as enemies during the wave. The wave weight is considered against other normal wave weights.";
			default = 0.6;
		};
		class BLWK_standardWaveWeight : BLWK_paratrooperWaveWeight
		{
			title = "Standard Wave Weight";
			tooltip = "Typical enemy infantry wave with a possibility of vehicles to spawn";
			default = 1;
		};
	};

	class Waves
	{
		title = "Waves (General)";

		class BLWK_maxNumWaves : sliderParamBase
		{
			title = "Number of Waves";
			min = 1;
			max = 999;
			default = 25;
		};
		class BLWK_timeBetweenRounds : sliderParamBase
		{
			title = "Time between rounds";
			tooltip = "Time is in seconds";
			min = 1;
			max = 300;
			default = 60;
		};

		class BLWK_maxEnemyInfantryAtOnce : sliderParamBase
		{
			title = "Max Enemy Infantry";
			tooltip = "This is the maximum spawned enemy infantry at any one time. Units will be queued to spawn in once there is a free space (another unit dies). This has a large impact on perfomance.";
			min = 1;
			max = 75;
			default = 30;
		};
		class BLWK_randomizeEnemyWeapons : yes_no_paramBase
		{
			title = "Randomize Hostile Weapons";
			default = DEFAULT_FALSE;
		};
		class BLWK_maxPistolOnlyWaves : sliderParamBase
		{
			title = "Hostiles only use pistols until wave";
			tooltip = "Enemy units will spawn with pistols (and possibly first-aid-kits) until the given wave. If 0, enemies will have full equipment from the start.";
			min = 0;
			max = 999;
			default = 3;
		};
		class BLWK_enemiesPerWaveMultiplier : sliderParamBase
		{
			title = "Enemies Per Wave Multiplier";
			tooltip = "A simple multiplier to increase the number of enemy units that will spawn during a given wave.";
			min = 0.5;
			max = 3;
			incriment = 0.5;
			default = 1;
		};
		class BLWK_enemiesPerPlayerMultiplier : sliderParamBase
		{
			title = "Enemies Per Player Multiplier";
			tooltip = "A simple multiplier to increase the number of enemy units that will spawn during a given wave depending on the number of players present.";
			min = 0.5;
			max = 2;
			incriment = 0.5;
			default = 1;
		};

	};

};
