/* ----------------------------------------------------------------------------
Function: BLWK_fnc_paramsQuery

Description:
	Requests that the server either delete or save the mission parameters.

Parameters:
	0: _saveParams <BOOL> - True to save, false to delete

Returns:
	NOTHING

Examples:
    (begin example)
		// delete params on server
		[false] call BLWK_fnc_paramsQuery

    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
// check if admin or host
if (!(call BIS_fnc_admin > 0) AND {clientOwner != 2}) exitWith {
	hint "Only admins and hosts can adjust params";
};

params [
	["_saveParams",true,[true]]
];

if (_saveParams) then {
	remoteExecCall ["BLWK_fnc_saveAllMissionParameters",2];
} else {
	remoteExecCall ["BLWK_fnc_deleteSavedMissionParameters",2];
};