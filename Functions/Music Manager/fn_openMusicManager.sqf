/* ----------------------------------------------------------------------------
Function: BLWK_fnc_openMusicManager

Description:
	Opens the Music Manager

Parameters:
	NONE

Returns:
	NOTHING

Examples:
    (begin example)
		call BLWK_fnc_openMusicManager;
    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
scriptName "BLWK_fnc_openMusicManager";

// check if player is host or admin
if !(call KISKA_fnc_isAdminOrHost) exitWith {
	["Only admins and hosts can open the manager"] call KISKA_fnc_errorNotification;
};

createDialog ["musicManagerDialog",true];
