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
	BOOL

Examples:
    (begin example)

		["BLWK_standardInfantryQueue","",OPFOR] call BLWK_fnc_createFromQueue;

    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
diag_log "Killed Event";

params [
	["_queueName","",[""]],
	["_codeToRun","",[""]],
	["_side",OPFOR],
	["_group",grpNull,[grpNull]]
];

private _queueReady = _queueName + "_ready";
if !(isNil _queueReady) then {
	waitUntil {
		if (missionNamespace getVariable [_queueReady,false]) exitWith {true};
		sleep 0.1;
		false
	};
};
missionNamespace setVariable [_queueReady,false];

if (_queueName isEqualTo "") exitWith {objNull};
diag_log "queue";
diag_log _queueName;

private _queueArray = missionNamespace getVariable [_queueName,[]];
if (_queueArray isEqualTo []) exitWith {
	missionNamespace setVariable [_queueReady,true];
	objNull
};
diag_log _queueArray;

// get the first available unit in the queue
(_queueArray deleteAt 0) params ["_type","_position"];
missionNamespace setVariable [_queueName,_queueArray];
missionNamespace setVariable [_queueReady,true];

diag_log _type;
diag_log _position;


if (isNull _group) then {
	_group = createGroup _side;
};
private _unit = _group createUnit [_type, _position, [], 0, "NONE"];
[_unit] joinSilent _group;
_group deleteGroupWhenEmpty true;

diag_log "created unit from queue";
diag_log _unit;
diag_log _group;

if !(_codeToRun isEqualTo "") then {
	[_unit,_queueName,_group] call (compileFinal _codeToRun);
};


_unit