/* ----------------------------------------------------------------------------
Function: BLWK_fnc_hintDroppedDelete

Description:
	A network friendly function used to tell players when dropped items will be
	 deleted. Used as to not have to send the entire string over the network.

Parameters:
	NONE

Returns:
	NOTHING

Examples:
    (begin example)

		call BLWK_fnc_hintDroppedDelete;

    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
if (!hasInterface) exitWith {};

hint parseText "<t color='#03d7fc'>At the start of the next wave, dropped items will be DELETED</t>"; 