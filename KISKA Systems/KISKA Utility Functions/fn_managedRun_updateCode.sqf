/* ----------------------------------------------------------------------------
Function: KISKA_fnc_managedRun_updateCode

Description:
    Adjusts the code for a given ID that will run when called 
     from KISKA_fnc_managedRun_execute

Parameters:
    0: _nameOfCode : <STRING> - The name of the code to update
    1: _code : <CODE, STRING, ARRAY> - The code to run when ID is called 
        (see KISKA_fnc_callBack). Use `{}`

Returns:
    NOTHING
    
Examples:
    (begin example)
        ["KISKA_test",{hint "Hello World"}] call KISKA_fnc_managedRun_updateCode;
    (end)

Author(s):
    Ansible2
---------------------------------------------------------------------------- */
scriptName "KISKA_fnc_managedRun_updateCode";

params [
    ["_nameOfCode","",[""]],
    ["_code",{},[{},[],""]]
];

private _codeMap = localNamespace getVariable ["KISKA_managedRun_codeMap",-1];
if (_codeMap isEqualTo -1) then {
    _codeMap = createHashMap;
    localNamespace setVariable ["KISKA_managedRun_codeMap",_codeMap];
};

if ((_nameOfCode in _codeMap) AND (_code isEqualTo {})) exitWith {
    _codeMap deleteAt _nameOfCode;
    nil
};

_codeMap set [_nameOfCode,_code];


nil
