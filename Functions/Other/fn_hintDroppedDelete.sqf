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

[
	["Notification:",1.1,[0.21,0.71,0.21,1]],
	["At the start of the next wave, dropped items will be DELETED",1,[0,0.87,1,1]],
	5,
	false
] call KISKA_fnc_notify;
