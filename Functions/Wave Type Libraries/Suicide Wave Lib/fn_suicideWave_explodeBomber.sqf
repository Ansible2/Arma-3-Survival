/* ----------------------------------------------------------------------------
Function: BLWK_fnc_suicideWave_explodeBomber

Description:
    Creates the explosion at a given unit's position for to look like a suicide bomb

Parameters:
    0: _bomber : <OBJECT> - The suicide bomber

Returns:
    NOTHING

Examples:
    (begin example)
        [mySuicideBomber] call BLWK_fnc_suicideWave_explodeBomber;
    (end)

Author(s):
    Ansible2
---------------------------------------------------------------------------- */
scriptName "BLWK_fnc_suicideWave_explodeBomber";

params ["_bomber"];

if (isNull _bomber) exitWith {};

private _explosiveType = selectRandom [
    "DemoCharge_Remote_Ammo_Scripted",
    "SatchelCharge_Remote_Ammo_Scripted",
    "ClaymoreDirectionalMine_Remote_Ammo_Scripted"
];

private _explosive = _explosiveType createVehicle (getPosATLVisual _bomber);
_explosive setDamage 1;
// give time for BLWK_fnc_event_killedEnemy to execute
[
    {
        deleteVehicle (_this select 0);
    },
    [_bomber],
    0.5
] call CBAP_fnc_waitAndExecute;


nil
