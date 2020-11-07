/* ----------------------------------------------------------------------------
Function: BLWK_fnc_addToGlobalArray

Description:
	Pushes back a value to a global array.

	This was used in lieu of creating a public variable to sync the array.
	In order to keep network traffic lower if the array becomes large.

Parameters:
	0: _globalArrayString : <STRING> - The global array in string format
	1: _entryToAdd : <ANY> - The calue to pushBack

Returns:
	BOOL

Examples:
    (begin example)

		["myGlobalArrayVar",someInfoHere] call BLWK_fnc_addToGlobalArray;

    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
if (!hasInterface) exitWith {false};

params ["_globalArrayString","_entryToAdd"];

// CIPHER COMMENT: needs to be tested to ensure that public array that doesn't exit will after doing the pushBack
(missionNamespace getVariable [_globalArrayString,[]]) pushBack _entryToAdd;

true