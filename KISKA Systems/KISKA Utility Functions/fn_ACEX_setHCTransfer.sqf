/* ----------------------------------------------------------------------------
Function: KISKA_fnc_ACEX_setHCTransfer

Description:
    Simply sets the blacklist variable of a given unit from being transferred by the
     ACEX headless client module. Variable is set on the server.

Parameters:
    0: _unit <GROUP or OBJECT> - The unit to blacklist
    1: _setting <BOOL> - The blacklist value to set (true to blacklist, false to allow transfer)

Returns:
    NOTHING

Examples:
    (begin example)
        // disable transfer
        [someGroup,true] call KISKA_fnc_ACEX_setHCTransfer;
    (end)

    (begin example)
        // enable transfer
        [someGroup,false] call KISKA_fnc_ACEX_setHCTransfer;
    (end)

Author(s):
    Ansible2
---------------------------------------------------------------------------- */
scriptName "KISKA_fnc_ACEX_setHCTransfer";

if (!isMultiplayer) exitWith {
    ["No need to run in singleplayer..."] call KISKA_fnc_log;
    nil
};

params [
    ["_unit",objNull,[grpNull,objNull]],
    ["_setting",false,[true]]
];

if (isNull _unit) exitWith {
    ["A null unit was passed, will not blacklist",true] call KISKA_fnc_log;
    nil
};

_unit setVariable ["acex_headless_blacklist",_setting,2];


nil
