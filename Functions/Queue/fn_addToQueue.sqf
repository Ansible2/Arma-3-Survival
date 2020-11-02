/* ----------------------------------------------------------------------------
Function: BLWK_fnc_addToQueue

Description:
	Adds the type and position of a unit to a queue

Parameters:
	0: _queueName : <STRING> - The global var name for the queue you want to add to
	1: _type : <STRING> - The className of the unit you want to add to the queue
	2: _position : <ARRAY OR OBJECT> - The position to spawn the unit at

Returns:
	BOOL

Examples:
    (begin example)

		["BLWK_standardInfantryQueue",_aClassName,[0,0,0]] call BLWK_fnc_addToQueue;

    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
params [
	["_queueName","",[""]],
	["_type","",[""]],
	["_position",[],[objNull,[]]]
];

if (_queueName isEqualTo "" OR {_type isEqualTo ""} OR {_position isEqualTo []}) exitWith {false};

if (isNil _queueName) then {
	missionNamespace setVariable [_queueName,[]];
};

(missionNamespace getVariable _queueName) pushBack [_type,_position];


true