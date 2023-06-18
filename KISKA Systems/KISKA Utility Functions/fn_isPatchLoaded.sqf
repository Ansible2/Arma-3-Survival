/* ----------------------------------------------------------------------------
Function: KISKA_fnc_isPatchLoaded

Description:
    Simply checks a config name to see if it is loaded under CFGPatches

Parameters:
    0: _configName <STRING> - The patch config name to check for

Returns:
    <BOOL> - False if not, true if is loaded

Examples:
    (begin example)

        ["OPTRE_Core"] call KISKA_fnc_isPatchLoaded;

    (end)

Author(s):
    Ansible2
---------------------------------------------------------------------------- */
scriptName "KISKA_fnc_isPatchLoaded";

params [
    ["_configName","",[""]]
];

if (_configName isEqualTo "") exitWith {
    ["_configName is empty string",true] call KISKA_fnc_log;
    false
};

private _isLoaded = isClass (configFile / "cfgPatches" / _configName);

_isLoaded