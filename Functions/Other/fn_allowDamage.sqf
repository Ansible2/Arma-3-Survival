/* ----------------------------------------------------------------------------
Function: BLWK_fnc_allowDamage

Description:
    Handles whether or not a given object can have its allowDamage adjusted,
     however it handles having multiple sources adjusting the state

Parameters:
    0: _object : <OBJECT> - The object to (potentially) adjust allowDamage on
    1: _isDamageAllowed : <BOOL> - Whether or not to allow damage
    2: _idToAdjust : <NUMBER> - the setting id to overwrite

Returns:
    <NUMBER> - The id of the adjustment made

Examples:
    (begin example)
        // set new Id 
        private _idAdjustment = [player,true] call BLWK_fnc_allowDamage;
        
        // make a new management id
        [player,true] call BLWK_fnc_allowDamage;
        
        // does nothing because id was overwritten 
        [player,false,_idAdjustment] call BLWK_fnc_allowDamage;
    (end)

Author(s):
    Ansible2
---------------------------------------------------------------------------- */
scriptName "BLWK_fnc_allowDamage";

params [
    ["_object",objNull,[objNull]],
    ["_isDamageAllowed",true,[true]],
    ["_idToAdjust",-1,[123]]
];

if !(["BLWK_manage_allowDamage"] call KISKA_fnc_managedRun_isDefined) then {
    [
        "BLWK_manage_allowDamage",
        {
            params ["_object","_isDamageAllowed"];
            _object allowDamage _isDamageAllowed;
        }
    ] call KISKA_fnc_managedRun_updateCode;
};


[
    "BLWK_manage_allowDamage",
    [_object, _isDamageAllowed],
    _object,
    _idToAdjust
] call KISKA_fnc_managedRun_execute