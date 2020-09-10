/* ----------------------------------------------------------------------------
Function: BLWK_fnc_civRandomGear

Description:
	Randomizes gear based upon global arrays. Designed with civillians in mind.

Parameters:
	0: _unit : <OBJECT> - The unit to randomize gear

Returns:
	BOOL

Examples:
    (begin example)

		[_unit] call BLWK_fnc_civRandomGear;

    (end)

Author:
	Ansible2 // Cipher
---------------------------------------------------------------------------- */

params [
	["_unit",objNull,[objNull]]
];

if (isNull _unit) exitWith {false};

if (!local _unit) exitWith {false};

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
if !((missionNamespace getVariable ["BLWK_civUniforms",[]]) isEqualTo []) then {
	private _chosen_uniform = [BLWK_civUniforms] call _fn_chooseGear;
	
	// adding "none" to the selection array will add the possibility of nothing at all being added
	if (_chosen_uniform == "NONE") then {
		_unit forceAddUniform _chosen_uniform;
	};
};
// headgear
if !((missionNamespace getVariable ["BLWK_civHeadgear",[]]) isEqualTo []) then {
	private _chosen_headgear = [BLWK_civHeadgear] call _fn_chooseGear;

	if (_chosen_headgear == "NONE") then {
		_unit addHeadgear _chosen_headgear;
	};
};
// facewear
if !((missionNamespace getVariable ["BLWK_civFaceWear",[]]) isEqualTo []) then {
	private _chosen_facewear = [BLWK_civFaceWear] call _fn_chooseGear;
	
	if (_chosen_facewear == "NONE") then {
		_unit addGoggles _chosen_facewear;
	};
};
// vest
if !((missionNamespace getVariable ["BLWK_civVests",[]]) isEqualTo []) then {
	private _chosen_vest = [BLWK_civVests] call _fn_chooseGear;

	if (_chosen_vest == "NONE") then {
		_unit addVest _chosen_vest;
	};
};

true