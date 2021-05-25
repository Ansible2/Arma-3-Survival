/* ----------------------------------------------------------------------------
Function: BLWK_fnc_handleCivilianKilledEventPlayer

Description:
	Docks players points and plays a sound informing them of a killed civilian.
	
	Executed from "BLWK_fnc_killedCivilianEvent".

Parameters:
	0: _killedUnit : <OBJECT> - The unit killed by the player

Returns:
	NOTHING

Examples:
    (begin example)

		[_killedUnit] remoteExecCall ["BLWK_fnc_handleCivilianKilledEventPlayer",_instigator];

    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
if !(hasInterface) exitWith {};

params ["_killedUnit"];

if (isNull _killedUnit) exitWith {};

[_killedUnit, round (BLWK_pointsForKill * -10), true] call BLWK_fnc_createHitMarker;
[BLWK_pointsForKill * 10] call BLWK_fnc_subtractPoints;

playSound "alarm";