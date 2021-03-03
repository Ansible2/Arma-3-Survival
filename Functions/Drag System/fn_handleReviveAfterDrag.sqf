/* ----------------------------------------------------------------------------
Function: BLWK_fnc_handleReviveAfterDrag

Description:
	Adds a loop to the player after being dragged to ensure their animations 
	 are reset after a revive.

	Executed from "BLWK_fnc_dragUnitEvent"

Parameters:
	0: _draggedUnit : <OBJECT> - The unit being dragged

Returns:
	NOTHING

Examples:
    (begin example)

		[] spawn BLWK_fnc_handleReviveAfterDrag;

    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
if (!hasInterface OR {BLWK_handleReviveLoopRunning}) exitWith {};

// stop loop from running multiple times if dragged by different people
BLWK_handleReviveLoopRunning = true;

params [
	["_draggedUnit",player,[objNull]]
];

waitUntil {
	if (incapacitatedState _draggedUnit isEqualTo "") exitWith {
		// reset animation if revived
		// this does need to be JIP and on all machines due to some animation bugs
		[_draggedUnit,""] remoteExecCall ["switchMove",0,_draggedUnit];
		true
	};
	if (!alive _draggedUnit) exitWith {true};

	sleep 1;

	false
};

BLWK_handleReviveLoopRunning = false;