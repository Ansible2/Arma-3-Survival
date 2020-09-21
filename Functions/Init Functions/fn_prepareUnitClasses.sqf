#include "headers/vanillaUnitTables.hpp"

private _friendlyFaction = ("BLWK_friendlyFaction" call BIS_fnc_getParamValue);
private _level1Faction = ("BLWK_level1Faction" call BIS_fnc_getParamValue);
private _level2Faction = ("BLWK_level2Faction" call BIS_fnc_getParamValue);
private _level3Faction = ("BLWK_level3Faction" call BIS_fnc_getParamValue);
private _level4Faction = ("BLWK_level4Faction" call BIS_fnc_getParamValue);
private _level5Faction = ("BLWK_level5Faction" call BIS_fnc_getParamValue);


private _tempUnitClass = "";
private _unitClassAvailable = true;

// check if a unit is dependent on exluded DLC and if they are an actual class 
private _fn_checkTempClass = {
	if (isClass (configFile >> "CfgVehicles" >> _tempUnitClass)) then {
		_unitClassAvailable = [_tempUnitClass,"CfgVehicles"] call BLWK_fnc_checkDLC;
	} else {
		_unitClassAvailable = false;
	};

	_unitClassAvailable
};

private _fn_checkFaction = {
	params ["_unitClasses"];

	_unitClasses apply {
		_tempUnitClass = _x;
		call _fn_checkTempClass
	};
};

private _fn_friendlyFaction = {
	if (_friendlyFaction == "") exitWith {
		BLWK_friendlyClasses = _unitsNATO;
	};
	if (_friendlyFaction == "") exitWith {
		BLWK_friendlyClasses = _unitsNATOPacific;
	};
	if (_friendlyFaction == "") exitWith {
		BLWK_friendlyClasses = _unitsNATOWoodland;
	};
	if (_friendlyFaction == "") exitWith {
		BLWK_friendlyClasses = _unitsCTRGPacific;
	};
	if (_friendlyFaction == "") exitWith {
		BLWK_friendlyClasses = _unitsCSAT;
	};
	if (_friendlyFaction == "") exitWith {
		BLWK_friendlyClasses = ;
	};
	if (_friendlyFaction == "") exitWith {
		BLWK_friendlyClasses = ;
	};
	if (_friendlyFaction == "") exitWith {
		BLWK_friendlyClasses = ;
	};
	if (_friendlyFaction == "") exitWith {
		BLWK_friendlyClasses = ;
	};
	if (_friendlyFaction == "") exitWith {
		BLWK_friendlyClasses = ;
	};
	if (_friendlyFaction == "") exitWith {
		BLWK_friendlyClasses = ;
	};
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