/* ----------------------------------------------------------------------------
Function: BLWK_fnc_removePickedUpObjectActions

Description:
	Removes all the actions from the player that are used for manipulating objects in hand.

	Executed from "BLWK_fnc_sellObject"

Parameters:
	NONE

Returns:
	BOOL

Examples:
    (begin example)

		call BLWK_fnc_removePickedUpObjectActions;

    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
if !(hasInterface) exitWith {false};

BLWK_heldObjectActionIDs apply {
	// accounts for actions such as selling action not being added
	if (_x isNotEqualTo -1) then {
		player removeAction _x;
	};
};

missionNamespace setVariable ["BLWK_heldObjectActionIDs",nil];


true