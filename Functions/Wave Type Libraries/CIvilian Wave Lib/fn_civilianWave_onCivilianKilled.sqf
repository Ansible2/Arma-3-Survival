/* ----------------------------------------------------------------------------
Function: BLWK_fnc_civilianWave_onCivilianKilled

Description:
    Docks players points and plays a sound informing them of a killed civilian.

Parameters:
    0: _killedUnit : <OBJECT> - The unit killed by the player

Returns:
    NOTHING

Examples:
    (begin example)
        [_killedUnit] remoteExecCall ["BLWK_fnc_civilianWave_onCivilianKilled",_instigator];
    (end)

Author(s):
    Ansible2
---------------------------------------------------------------------------- */
scriptName "BLWK_fnc_civilianWave_onCivilianKilled";

if !(hasInterface) exitWith {};

params ["_killedUnit"];

if (isNull _killedUnit) exitWith {};

[_killedUnit, round (BLWK_pointsForKill * -10), true] call BLWK_fnc_createHitMarker;
[BLWK_pointsForKill * 10] call BLWK_fnc_subtractPoints;

playSound "alarm";