/* ----------------------------------------------------------------------------
Function: BLWK_fnc_createFromQueue

Description:
	Spawns the first available unit in the specified queue 

Parameters:
	0: _queueName : <STRING> - The name of the queue from which to spawn
	1: _codeToRun : <STRING> - What code should run when the unit is created (passed args are [_unit,_queueName,_group])
	2: _side : <SIDE> - The side the unit will be on
	3: _group : <GROUP> - The group the unit can be in; if empty, a new one is made

Returns:
	OBJECT - The created unit

Examples:
    (begin example)

		["BLWK_standardInfantryQueue","",OPFOR] call BLWK_fnc_createFromQueue;

    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
params [
	["_queueName","",[""]],
	["_codeToRun","",[""]],
	["_side",OPFOR],
	["_group",grpNull,[grpNull]]
];

if (_queueName isEqualTo "") exitWith {
	["_queueName is empty string ''",true] call KISKA_fnc_log;
	objNull
};

// check if queue is empty
private _queueArray = missionNamespace getVariable [_queueName,[]];
if (_queueArray isEqualTo []) exitWith {objNull};


// get the first available unit in the queue
(_queueArray deleteAt 0) params ["_type","_position"];
missionNamespace setVariable [_queueName,_queueArray];


// create unit
if (isNull _group) then {
	_group = createGroup _side;
};
private _unit = _group createUnit [_type, _position, [], 0, "NONE"];
[_unit] joinSilent _group;
_group deleteGroupWhenEmpty true;

// run code on the unit
if !(_codeToRun isEqualTo "") then {
	[_unit,_queueName,_group] call (compile _codeToRun);
};


_unit