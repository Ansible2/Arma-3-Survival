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
#define SCRIPT_NAME "BLWK_fnc_openMusicManager"
scriptName SCRIPT_NAME;

// check if player is host or admin
if (!(call BIS_fnc_admin > 0) AND {clientOwner != 2}) exitWith {
	hint "Only admins and hosts can open the manager";
};

createDialog "musicManagerDialog"; 