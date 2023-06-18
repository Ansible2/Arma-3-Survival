/* ----------------------------------------------------------------------------
Function: KISKA_fnc_isAdminOrHost

Description:
    Checks if the machine is an admin or host's.

Parameters:
    NONE

Returns:
    <BOOL> - True if is, false if not

Examples:
    (begin example)
        _isAdminOrHost = call KISKA_fnc_isAdminOrHost;
    (end)

Author(s):
    Ansible2
---------------------------------------------------------------------------- */
scriptName "KISKA_fnc_isAdminOrHost";

// singleplayer is always true
if (isServer) exitWith {true};

if (!(call BIS_fnc_admin > 0) AND {clientOwner isNotEqualTo 2}) then {
    false
} else {
    true
};
