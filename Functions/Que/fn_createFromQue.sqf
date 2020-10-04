/* ----------------------------------------------------------------------------
Function: BLWK_fnc_addToQue

Description:
	Spawns the first available unit in the specified que 

Parameters:
	0: _queName : <STRING> - The name of the que from which to spawn
	1: _codeToRun : <CODE> - What code should run when the unit is created (passed args are [_unit,_queName,_group])
	2: _side : <SIDE> - The side the unit will be on
	3: _group : <GROUP> - The group the unit can be in; if empty, a new one is made

Returns:
	BOOL

Examples:
    (begin example)

		["BLWK_standardInfantryQue",{},OPFOR] call BLWK_fnc_addToQue;

    (end)

Author:
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
params [
	["_queName","",[""]],
	["_codeToRun",{},[{}]],
	["_side",OPFOR,[BLUFOR]],
	["_group",grpNull,[grpNull]]
];

if (_queName isEqualTo "") exitWith {objNull};

private _queArray = missionNamespace getVariable [_queName,[]];
if (_queArray isEqualTo []) exitWith {objNull};


// get the first available unit in the que
diag_log (_queArray select 0);
(_queArray deleteAt 0) params ["_position","_type"];


if (isNull _group) then {
	_group = createGroup _side;
};
private _unit = _type createVehicle _position;
[_unit] joinSilent _group;
_group deleteGroupWhenEmpty true;


if !(_codeToRun isEqualTo {}) then {
	[_unit,_queName,_group] call _codeToRun;
};


_unit