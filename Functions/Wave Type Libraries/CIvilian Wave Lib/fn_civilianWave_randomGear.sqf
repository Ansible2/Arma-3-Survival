#include "..\..\..\Headers\civilianGearTables.hpp"
/* ----------------------------------------------------------------------------
Function: BLWK_fnc_civilianWave_randomGear

Description:
	Randomizes gear based upon global arrays. Designed with civilians in mind.

Parameters:
	0: _unit : <OBJECT> - The unit to randomize gear

Returns:
	NOTHING

Examples:
    (begin example)
		[_unit] call BLWK_fnc_civilianWave_randomGear;
    (end)

Author(s):
	Ansible2
---------------------------------------------------------------------------- */
scriptName "BLWK_fnc_civilianWave_randomGear";

params [
	["_unit",objNull,[objNull]]
];

if (isNull _unit) exitWith {
	["_unit is a null object, exiting...",true] call KISKA_fnc_log;
	nil
};

if (!local _unit) exitWith {
	[[_unit," is not local to your machine, exiting..."],true] call KISKA_fnc_log;
	nil
};

// remove all existing stuff
removeAllWeapons _unit;
removeAllItems _unit;
removeAllAssignedItems _unit;
removeUniform _unit;
removeVest _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeGoggles _unit;

// uniform
if (CIV_UNIFORMS isNotEqualTo []) then {
	private _chosen_uniform = [CIV_UNIFORMS,""] call KISKA_fnc_selectRandom;
	
	// adding "none" to the selection array will add the possibility of nothing at all being added
	if !(_chosen_uniform == "NONE") then {
		_unit forceAddUniform _chosen_uniform;
	};
};
// headgear
if (CIV_HEADGEAR isNotEqualTo []) then {
	private _chosen_headgear = [CIV_HEADGEAR,""] call KISKA_fnc_selectRandom;

	if !(_chosen_headgear == "NONE") then {
		_unit addHeadgear _chosen_headgear;
	};
};
// facewear
if (CIV_FACEWEAR isNotEqualTo []) then {
	private _chosen_facewear = [CIV_FACEWEAR,""] call KISKA_fnc_selectRandom;
	
	if !(_chosen_facewear == "NONE") then {
		_unit addGoggles _chosen_facewear;
	};
};
// vest
if (CIV_VESTS isNotEqualTo []) then {
	private _chosen_vest = [CIV_VESTS,""] call KISKA_fnc_selectRandom;

	if !(_chosen_vest == "NONE") then {
		_unit addVest _chosen_vest;
	};
};


nil
