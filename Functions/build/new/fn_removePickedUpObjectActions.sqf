/* ----------------------------------------------------------------------------
Function: BLWK_fnc_removePickedUpObjectActions

Description:
	Removes all the actions from the player that are used for manipulating objects in hand

	Executed from ""

Parameters:
	NONE

Returns:
	BOOL

Examples:
    (begin example)

		call BLWK_fnc_removePickedUpObjectActions;

    (end)

Author:
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
if !(hasInterface) exitWith {false};

BLWK_heldObjectActionIDs apply {
	player removeAction _x;
};

true