/* ----------------------------------------------------------------------------
Function: KISKA_fnc_addArsenal

Description:
    Adds both BIS and ACE arsenals to several or a single object.
    This has a global effect.

Parameters:
    0: _arsenals <ARRAY or OBJECT> - An array of objects or a single one to add arsenals to

Returns:
    <BOOL> - True if arsenal added, false if not

Examples:
    (begin example)
        [[arsenal1, arsenal2]] call KISKA_fnc_addArsenal;
    (end)

Author(s):
    Ansible2
---------------------------------------------------------------------------- */
scriptName "KISKA_fnc_addArsenal";

params [
    ["_arsenals",[],[[],objNull]]
];

if (_arsenals isEqualTo [] OR {(_arsenals isEqualType objNull) AND {isNull _arsenals}}) exitWIth {
    [["_arsenals are invalid: ",str _arsenals],true] call KISKA_fnc_log;
    false
};

if !(_arsenals isequalType []) then {
    _arsenals = [_arsenals];
};

private _aceLoaded = ["ace_arsenal"] call KISKA_fnc_isPatchLoaded;

_arsenals apply {
    
    if (_aceLoaded) then {
        [_x, true, true] call ace_Arsenal_fnc_InitBox;
    };
    
    ["AmmoboxInit",[_x,true]] call BIS_fnc_arsenal;
};


true