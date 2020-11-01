/* ----------------------------------------------------------------------------
Function: BLWK_fnc_stdEnemyManCreateCode

Description:
	The code to run on units created for the standard library.

Parameters:
	0: _unit : <OBJECT> - The actual unit
	1: _queueName : <STRING> - The name of the queue the unit belongs to (used for spawning a new unit in queue)
	2: _group : <GROUP> - The group the unit belongs to (OPTIONAL)

Returns:
	NOTHING

Examples:
    (begin example)
		[aUnit,"myQueue",group aUnit] call BLWK_fnc_stdEnemyManCreateCode;
    (end)

Author:
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
params ["_unit","_queueName","_group"];

[_unit] call BLWK_fnc_setSkill;

if (isNil "_group") then {
	_group = group _unit
};

null = [_group] spawn BLWK_fnc_pathingLoop;

null = [_group] spawn BLWK_fnc_startStalkingPlayers;


// add to server's list of units that must be dead before the round can end
null = [_unit] remoteExec ["BLWK_fnc_addToMustKillArray",2];
null = [BLWK_zeus, [[_unit],false]] remoteExec ["addCuratorEditableObjects",2];


// keep items (maps, nvgs, binoculars, etc.) so that they can just be loot drops
removeAllAssignedItems _unit;

// hit and killed events
[_unit] call BLWK_fnc_addStdEnemyManEHs;

// for pistol only waves and randomized weapons
[_unit] call BLWK_fnc_handleEnemyWeapons;