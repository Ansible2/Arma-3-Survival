/*
	This file is going to be bloated in all honesty. 
	It will be replaced by a GUI in the future in all likelihood that dynamically gets all loaded factions on the server
*/



#include "headers/vanillaUnitTables.hpp"

// prepare default factions just in case selected factions don't work
private _defaultFactionClasses_friendly = _unitsNATO;
private _defaultFactionClasses_level1 = _unitsFIA;
private _defaultFactionClasses_level2 = _unitsAAF;
private _defaultFactionClasses_level3 = _unitsCSAT;
private _defaultFactionClasses_level4 = _untisCSATUrban;
private _defaultFactionClasses_level5 = _untisViper;
// this is for storing the current default faction that we are checking for
// e.g. we set this to _defaultFactionClasses_friendly when we are checking the friendly faction
// we set it to _defaultFactionClasses_level2 when checking the level 2 faction
// this is in an effort to cut down on unique functions for each faction type (level 1, level 2, friendly, etc.)
private "_defaultFactionTypeClasses";

// get selected factions from mission params
private _selectedFriendlyFaction = ("BLWK_friendlyFaction" call BIS_fnc_getParamValue);
private _selectedLevel1Faction = ("BLWK_level1Faction" call BIS_fnc_getParamValue);
private _selectedLevel2Faction = ("BLWK_level2Faction" call BIS_fnc_getParamValue);
private _selectedLevel3Faction = ("BLWK_level3Faction" call BIS_fnc_getParamValue);
private _selectedLevel4Faction = ("BLWK_level4Faction" call BIS_fnc_getParamValue);
private _selectedLevel5Faction = ("BLWK_level5Faction" call BIS_fnc_getParamValue);

// to save on allocation time for memory, we are going to use temp values
private _tempUnitClass = "";
private _unitClassAvailable = true;





////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////// Functions /////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////

// check if a unit is an actual class and if they are dependent on exluded DLC
private _fn_checkTempClass = {

	if (isClass (configFile >> "CfgVehicles" >> _tempUnitClass)) then {
		_unitClassAvailable = [_tempUnitClass,"CfgVehicles"] call BLWK_fnc_checkDLC;
	} else {
		_unitClassAvailable = false;
	};

	_unitClassAvailable
};


// Sort a faction's units based upon what DLC is excluded and whether or not a unit class exists
private _fn_sortFactionClasses = {
	params ["_unitClassesToCheck"];
	
	private _allowedUnitClasses = [];
	_unitClassesToCheck apply {

		_tempUnitClass = _x;
		if (call _fn_checkTempClass) then {
			_allowedUnitClasses pushBack _tempUnitClass;
		};

	};

	if (_allowedUnitClasses isEqualTo []) exitWith {
		// if the faction turns up empty based upon sorting, AND it is the default
		// exit the mission
		if (_unitClassesToCheck isEqualTo _defaultFactionTypeClasses) then {
			null = [] spawn {
				["One of the selected factions unfortunately came up empty, the mission will end to allow you to reconfigure params"] remoteExecCall ["hint",0,true];
				sleep 20;
				call BIS_fnc_endMissionServer;
			};
		} else {
		// else, just load the default faction for that section
			[_defaultFactionTypeClasses] call _fn_sortFactionClasses
		};
		
	};

	_allowedUnitClasses
};

////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////// Friendly Factions //////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////
private _fn_friendlyFaction = {
	_defaultFactionTypeClasses = _defaultFactionClasses_friendly;

	if (_selectedFriendlyFaction == "NATO") exitWith {
		[_unitsNATO] call _fn_sortFactionClasses;
	};
	if (_selectedFriendlyFaction == "NATO_PACIFIC") exitWith {
		[_unitsNATOPacific] call _fn_sortFactionClasses;
	};
	if (_selectedFriendlyFaction == "NATO_WOODLAND") exitWith {
		[_unitsNATOWoodland] call _fn_sortFactionClasses;
	};
	if (_selectedFriendlyFaction == "CTRG_PACIFIC") exitWith {
		[_unitsCTRGPacific] call _fn_sortFactionClasses;
	};
	if (_selectedFriendlyFaction == "CSAT") exitWith {
		[_unitsCSAT] call _fn_sortFactionClasses;
	};
	if (_selectedFriendlyFaction == "CSAT_PACIFIC") exitWith {
		[_unitsCSATPacific] call _fn_sortFactionClasses;
	};
	if (_selectedFriendlyFaction == "CSAT_URBAN") exitWith {
		[_untisCSATUrban] call _fn_sortFactionClasses;
	};
	if (_selectedFriendlyFaction == "VIPER") exitWith {
		[_untisViper] call _fn_sortFactionClasses;
	};
	if (_selectedFriendlyFaction == "VIPER_PACIFIC") exitWith {
		[_unitsViperPacific] call _fn_sortFactionClasses;
	};
	if (_selectedFriendlyFaction == "FIA") exitWith {
		[_unitsFIA] call _fn_sortFactionClasses;
	};
	if (_selectedFriendlyFaction == "Syndikat") exitWith {
		[_unitsSyndikat] call _fn_sortFactionClasses;
	};
	if (_selectedFriendlyFaction == "AAF") exitWith {
		[_unitsAAF] call _fn_sortFactionClasses;
	};
	if (_selectedFriendlyFaction == "LDF") exitWith {
		[_unitsLDF] call _fn_sortFactionClasses;
	};
	if (_selectedFriendlyFaction == "SPETSNAZ_VANILLA") exitWith {
		[_unitsSpetsnaz] call _fn_sortFactionClasses;
	};
/*
	if (_selectedFriendlyFaction == "") exitWith {
		
	};
*/
};

////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////// level 1 Factions ///////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////
private _fn_level1Faction = {
	_defaultFactionTypeClasses = _defaultFactionClasses_level1;

	if (_selectedLevel1Faction == "NATO") exitWith {
		[_unitsNATO] call _fn_sortFactionClasses;
	};
	if (_selectedLevel1Faction == "NATO_PACIFIC") exitWith {
		[_unitsNATOPacific] call _fn_sortFactionClasses;
	};
	if (_selectedLevel1Faction == "NATO_WOODLAND") exitWith {
		[_unitsNATOWoodland] call _fn_sortFactionClasses;
	};
	if (_selectedLevel1Faction == "CTRG_PACIFIC") exitWith {
		[_unitsCTRGPacific] call _fn_sortFactionClasses;
	};
	if (_selectedLevel1Faction == "CSAT") exitWith {
		[_unitsCSAT] call _fn_sortFactionClasses;
	};
	if (_selectedLevel1Faction == "CSAT_PACIFIC") exitWith {
		[_unitsCSATPacific] call _fn_sortFactionClasses;
	};
	if (_selectedLevel1Faction == "CSAT_URBAN") exitWith {
		[_untisCSATUrban] call _fn_sortFactionClasses;
	};
	if (_selectedLevel1Faction == "VIPER") exitWith {
		[_untisViper] call _fn_sortFactionClasses;
	};
	if (_selectedLevel1Faction == "VIPER_PACIFIC") exitWith {
		[_unitsViperPacific] call _fn_sortFactionClasses;
	};
	if (_selectedLevel1Faction == "FIA") exitWith {
		[_unitsFIA] call _fn_sortFactionClasses;
	};
	if (_selectedLevel1Faction == "Syndikat") exitWith {
		[_unitsSyndikat] call _fn_sortFactionClasses;
	};
	if (_selectedLevel1Faction == "AAF") exitWith {
		[_unitsAAF] call _fn_sortFactionClasses;
	};
	if (_selectedLevel1Faction == "LDF") exitWith {
		[_unitsLDF] call _fn_sortFactionClasses;
	};
	if (_selectedLevel1Faction == "SPETSNAZ_VANILLA") exitWith {
		[_unitsSpetsnaz] call _fn_sortFactionClasses;
	};
/*
	if (_selectedLevel1Faction == "") exitWith {
		
	};
*/
};

////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////// level 2 Factions ///////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////
private _fn_level2Faction = {
	_defaultFactionTypeClasses = _defaultFactionClasses_level2;

	if (_selectedLevel2Faction == "NATO") exitWith {
		[_unitsNATO] call _fn_sortFactionClasses;
	};
	if (_selectedLevel2Faction == "NATO_PACIFIC") exitWith {
		[_unitsNATOPacific] call _fn_sortFactionClasses;
	};
	if (_selectedLevel2Faction == "NATO_WOODLAND") exitWith {
		[_unitsNATOWoodland] call _fn_sortFactionClasses;
	};
	if (_selectedLevel2Faction == "CTRG_PACIFIC") exitWith {
		[_unitsCTRGPacific] call _fn_sortFactionClasses;
	};
	if (_selectedLevel2Faction == "CSAT") exitWith {
		[_unitsCSAT] call _fn_sortFactionClasses;
	};
	if (_selectedLevel2Faction == "CSAT_PACIFIC") exitWith {
		[_unitsCSATPacific] call _fn_sortFactionClasses;
	};
	if (_selectedLevel2Faction == "CSAT_URBAN") exitWith {
		[_untisCSATUrban] call _fn_sortFactionClasses;
	};
	if (_selectedLevel2Faction == "VIPER") exitWith {
		[_untisViper] call _fn_sortFactionClasses;
	};
	if (_selectedLevel2Faction == "VIPER_PACIFIC") exitWith {
		[_unitsViperPacific] call _fn_sortFactionClasses;
	};
	if (_selectedLevel2Faction == "FIA") exitWith {
		[_unitsFIA] call _fn_sortFactionClasses;
	};
	if (_selectedLevel2Faction == "Syndikat") exitWith {
		[_unitsSyndikat] call _fn_sortFactionClasses;
	};
	if (_selectedLevel2Faction == "AAF") exitWith {
		[_unitsAAF] call _fn_sortFactionClasses;
	};
	if (_selectedLevel2Faction == "LDF") exitWith {
		[_unitsLDF] call _fn_sortFactionClasses;
	};
	if (_selectedLevel2Faction == "SPETSNAZ_VANILLA") exitWith {
		[_unitsSpetsnaz] call _fn_sortFactionClasses;
	};
/*
	if (_selectedLevel2Faction == "") exitWith {
		
	};
*/
};

////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////// level 3 Factions ///////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////
private _fn_level3Faction = {
	_defaultFactionTypeClasses = _defaultFactionClasses_level3;

	if (_selectedLevel3Faction == "NATO") exitWith {
		[_unitsNATO] call _fn_sortFactionClasses;
	};
	if (_selectedLevel3Faction == "NATO_PACIFIC") exitWith {
		[_unitsNATOPacific] call _fn_sortFactionClasses;
	};
	if (_selectedLevel3Faction == "NATO_WOODLAND") exitWith {
		[_unitsNATOWoodland] call _fn_sortFactionClasses;
	};
	if (_selectedLevel3Faction == "CTRG_PACIFIC") exitWith {
		[_unitsCTRGPacific] call _fn_sortFactionClasses;
	};
	if (_selectedLevel3Faction == "CSAT") exitWith {
		[_unitsCSAT] call _fn_sortFactionClasses;
	};
	if (_selectedLevel3Faction == "CSAT_PACIFIC") exitWith {
		[_unitsCSATPacific] call _fn_sortFactionClasses;
	};
	if (_selectedLevel3Faction == "CSAT_URBAN") exitWith {
		[_untisCSATUrban] call _fn_sortFactionClasses;
	};
	if (_selectedLevel3Faction == "VIPER") exitWith {
		[_untisViper] call _fn_sortFactionClasses;
	};
	if (_selectedLevel3Faction == "VIPER_PACIFIC") exitWith {
		[_unitsViperPacific] call _fn_sortFactionClasses;
	};
	if (_selectedLevel3Faction == "FIA") exitWith {
		[_unitsFIA] call _fn_sortFactionClasses;
	};
	if (_selectedLevel3Faction == "Syndikat") exitWith {
		[_unitsSyndikat] call _fn_sortFactionClasses;
	};
	if (_selectedLevel3Faction == "AAF") exitWith {
		[_unitsAAF] call _fn_sortFactionClasses;
	};
	if (_selectedLevel3Faction == "LDF") exitWith {
		[_unitsLDF] call _fn_sortFactionClasses;
	};
	if (_selectedLevel3Faction == "SPETSNAZ_VANILLA") exitWith {
		[_unitsSpetsnaz] call _fn_sortFactionClasses;
	};
/*
	if (_selectedLevel3Faction == "") exitWith {
		
	};
*/
};

////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////// level 4 Factions ///////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////
private _fn_level4Faction = {
	_defaultFactionTypeClasses = _defaultFactionClasses_level4;

	if (_selectedLevel4Faction == "NATO") exitWith {
		[_unitsNATO] call _fn_sortFactionClasses;
	};
	if (_selectedLevel4Faction == "NATO_PACIFIC") exitWith {
		[_unitsNATOPacific] call _fn_sortFactionClasses;
	};
	if (_selectedLevel4Faction == "NATO_WOODLAND") exitWith {
		[_unitsNATOWoodland] call _fn_sortFactionClasses;
	};
	if (_selectedLevel4Faction == "CTRG_PACIFIC") exitWith {
		[_unitsCTRGPacific] call _fn_sortFactionClasses;
	};
	if (_selectedLevel4Faction == "CSAT") exitWith {
		[_unitsCSAT] call _fn_sortFactionClasses;
	};
	if (_selectedLevel4Faction == "CSAT_PACIFIC") exitWith {
		[_unitsCSATPacific] call _fn_sortFactionClasses;
	};
	if (_selectedLevel4Faction == "CSAT_URBAN") exitWith {
		[_untisCSATUrban] call _fn_sortFactionClasses;
	};
	if (_selectedLevel4Faction == "VIPER") exitWith {
		[_untisViper] call _fn_sortFactionClasses;
	};
	if (_selectedLevel4Faction == "VIPER_PACIFIC") exitWith {
		[_unitsViperPacific] call _fn_sortFactionClasses;
	};
	if (_selectedLevel4Faction == "FIA") exitWith {
		[_unitsFIA] call _fn_sortFactionClasses;
	};
	if (_selectedLevel4Faction == "Syndikat") exitWith {
		[_unitsSyndikat] call _fn_sortFactionClasses;
	};
	if (_selectedLevel4Faction == "AAF") exitWith {
		[_unitsAAF] call _fn_sortFactionClasses;
	};
	if (_selectedLevel4Faction == "LDF") exitWith {
		[_unitsLDF] call _fn_sortFactionClasses;
	};
	if (_selectedLevel4Faction == "SPETSNAZ_VANILLA") exitWith {
		[_unitsSpetsnaz] call _fn_sortFactionClasses;
	};
/*
	if (_selectedLevel4Faction == "") exitWith {
		
	};
*/
};

////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////// level 5 Factions ///////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////
private _fn_level5Faction = {
	_defaultFactionTypeClasses = _defaultFactionClasses_level5;

	if (_selectedLevel5Faction == "NATO") exitWith {
		[_unitsNATO] call _fn_sortFactionClasses;
	};
	if (_selectedLevel5Faction == "NATO_PACIFIC") exitWith {
		[_unitsNATOPacific] call _fn_sortFactionClasses;
	};
	if (_selectedLevel5Faction == "NATO_WOODLAND") exitWith {
		[_unitsNATOWoodland] call _fn_sortFactionClasses;
	};
	if (_selectedLevel5Faction == "CTRG_PACIFIC") exitWith {
		[_unitsCTRGPacific] call _fn_sortFactionClasses;
	};
	if (_selectedLevel5Faction == "CSAT") exitWith {
		[_unitsCSAT] call _fn_sortFactionClasses;
	};
	if (_selectedLevel5Faction == "CSAT_PACIFIC") exitWith {
		[_unitsCSATPacific] call _fn_sortFactionClasses;
	};
	if (_selectedLevel5Faction == "CSAT_URBAN") exitWith {
		[_untisCSATUrban] call _fn_sortFactionClasses;
	};
	if (_selectedLevel5Faction == "VIPER") exitWith {
		[_untisViper] call _fn_sortFactionClasses;
	};
	if (_selectedLevel5Faction == "VIPER_PACIFIC") exitWith {
		[_unitsViperPacific] call _fn_sortFactionClasses;
	};
	if (_selectedLevel5Faction == "FIA") exitWith {
		[_unitsFIA] call _fn_sortFactionClasses;
	};
	if (_selectedLevel5Faction == "Syndikat") exitWith {
		[_unitsSyndikat] call _fn_sortFactionClasses;
	};
	if (_selectedLevel5Faction == "AAF") exitWith {
		[_unitsAAF] call _fn_sortFactionClasses;
	};
	if (_selectedLevel5Faction == "LDF") exitWith {
		[_unitsLDF] call _fn_sortFactionClasses;
	};
	if (_selectedLevel5Faction == "SPETSNAZ_VANILLA") exitWith {
		[_unitsSpetsnaz] call _fn_sortFactionClasses;
	};
/*
	if (_selectedLevel5Faction == "") exitWith {
		
	};
*/
};

BLWK_enemyClasses_level_1 = List_Bandits;  // Wave 0 >
BLWK_enemyClasses_level_2 = List_OPFOR;    // Wave 5 >
BLWK_enemyClasses_level_3 = List_Viper;    // Wave 10 >
BLWK_enemyClasses_armor = List_Armour;      //expects vehicles
BLWK_enemyClasses_armedCars = List_ArmedCars; //expects vehicles

BLWK_paratroopClasses = List_NATO;
BLWK_defectorClasses = List_NATO;


// switch between based upon param values
// need to seperate units dependent on dlc
// need to verify all units using isClass
// needs to default back to CSAT, NATO, and bandits should passed params not exist
// need to change defector Name too (possibly, might just make it into a generic "defectors")
private _friendlyUnits = call _fn_callDecideFriendlyFaction;
private _level_1_units = call _fn_callDecideLevel_1_Faction;