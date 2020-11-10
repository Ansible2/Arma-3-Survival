/* ----------------------------------------------------------------------------
Function: BLWK_fnc_forceCloseBISArsenal

Description:
	Does what it says; if player has the arseanl open, it is closed.
	This is used to ensure that you can't use the arsenal past its lifetime.

	Executed from "BLWK_fnc_arsenalSupplyDrop"

Parameters:
	NONE

Returns:
	NOTHING

Examples:
    (begin example)

		call BLWK_fnc_forceCloseBISArsenal;

    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
// make sure the arsenal is open
if (isnull (uinamespace getvariable ["BIS_fnc_arsenal_cam",objnull])) exitwith {};

["Exit"] call BIS_fnc_arsenal;

closeDialog 2;