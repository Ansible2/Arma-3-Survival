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

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
params ["_unit","_queueName","_group"];

// hit and killed events
[_unit] call BLWK_fnc_addStdEnemyManEHs;

[_unit] call BLWK_fnc_setSkill;

if (isNil "_group") then {
	_group = group _unit
};

[_group] spawn BLWK_fnc_pathing_mainLoop;

[_unit] spawn BLWK_fnc_pathing_collisionLoop;

[_group] spawn BLWK_fnc_startStalkingPlayers;


// add to server's list of units that must be dead before the round can end
[_unit] remoteExecCall ["BLWK_fnc_addToMustKillArray",2];
[BLWK_zeus, [[_unit],false]] remoteExecCall ["addCuratorEditableObjects",2];


// keep items (maps, nvgs, binoculars, etc.) so that they can just be loot drops
removeAllAssignedItems _unit;

// for pistol only waves and randomized weapons
[_unit] call BLWK_fnc_handleEnemyWeapons;

if !(BLWK_autocombatEnabled) then {
	_unit disableAI "AUTOCOMBAT";
};
if !(BLWK_suppressionEnabled) then {
	_unit disableAI "SUPPRESSION";
};
if !(BLWK_doDetectMines) then {
	_unit disableAI "MINEDETECTION";
};