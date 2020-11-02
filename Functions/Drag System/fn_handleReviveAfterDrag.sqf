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

		null = [] spawn BLWK_fnc_handleReviveAfterDrag;

    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
if (!hasInterface OR {BLWK_handleReviveLoopRunning}) exitWith {};

BLWK_handleReviveLoopRunning = true;

params [
	["_draggedUnit",player,[objNull]]
];

waitUntil {
	if (incapacitatedState _draggedUnit isEqualTo "") exitWith {
		// reset animation if revived
		[_draggedUnit,""] remoteExecCall ["switchMove",0,true];
		true
	};
	if (!alive _draggedUnit) exitWith {true};

	sleep 1;

	false
};

BLWK_fnc_handleReviveAfterDrag = false;