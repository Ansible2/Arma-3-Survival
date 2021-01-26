#include "..\..\..\Headers\civilianGearTables.hpp"
/* ----------------------------------------------------------------------------
Function: BLWK_fnc_civRandomGear

Description:
	Randomizes gear based upon global arrays. Designed with civilians in mind.

Parameters:
	0: _unit : <OBJECT> - The unit to randomize gear

Returns:
	BOOL

Examples:
    (begin example)

		[_unit] call BLWK_fnc_civRandomGear;

    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
scriptName "BLWK_fnc_civRandomGear";

params [
	["_unit",objNull,[objNull]]
];

if (isNull _unit) exitWith {
	["_unit is a null object, exiting...",true] call KISKA_fnc_log;
	false
};

if (!local _unit) exitWith {
	[[_unit," is not local to your machine, exiting..."],true] call KISKA_fnc_log;
	false
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


private _fn_chooseGear = {
	params ["_gearArray"];

	private "_selectedGear";

	// if is weighted array
	if (_gearArray isEqualTypeParams ["",123]) then {
		_selectedGear = selectRandomWeighted _gearArray;
	} else {
		_selectedGear = selectRandom _gearArray;
	};

	_selectedGear
};


// assign stuff

// uniform
if !(CIV_UNIFORMS isEqualTo []) then {
	private _chosen_uniform = [CIV_UNIFORMS] call _fn_chooseGear;
	
	// adding "none" to the selection array will add the possibility of nothing at all being added
	if !(_chosen_uniform == "NONE") then {
		_unit forceAddUniform _chosen_uniform;
	};
};
// headgear
if !(CIV_HEADGEAR isEqualTo []) then {
	private _chosen_headgear = [CIV_HEADGEAR] call _fn_chooseGear;

	if !(_chosen_headgear == "NONE") then {
		_unit addHeadgear _chosen_headgear;
	};
};
// facewear
if !(CIV_FACEWEAR isEqualTo []) then {
	private _chosen_facewear = [CIV_FACEWEAR] call _fn_chooseGear;
	
	if !(_chosen_facewear == "NONE") then {
		_unit addGoggles _chosen_facewear;
	};
};
// vest
if !(CIV_VESTS isEqualTo []) then {
	private _chosen_vest = [CIV_VESTS] call _fn_chooseGear;

	if !(_chosen_vest == "NONE") then {
		_unit addVest _chosen_vest;
	};
};

true