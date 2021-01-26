/* ----------------------------------------------------------------------------
Function: BLWK_fnc_deleteSavedMissionParameters

Description:
	Clears the profileNamespace variable of "BLWK_savedMissionParameters".
	Also informs remoteExecutedOwner of clearing via hint.

Parameters:
	NONE

Returns:
	NOTHING

Examples:
    (begin example)

		remoteExecCall ["BLWK_fnc_deleteSavedMissionParameters",2];

    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
if !(isServer) exitWith {};

if !(isNil {profileNamespace getVariable "BLWK_savedMissionParameters"}) then {
	profileNamespace setVariable ["BLWK_savedMissionParameters",nil];
	saveProfileNamespace;

	["Parameteres were reset"] remoteExecCall ["hint",remoteExecutedOwner];
} else {
	["There were no parameters to reset"] remoteExecCall ["hint",remoteExecutedOwner];
};