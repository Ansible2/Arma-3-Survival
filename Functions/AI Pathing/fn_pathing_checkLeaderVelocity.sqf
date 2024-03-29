/* ----------------------------------------------------------------------------
Function: BLWK_fnc_pathing_checkLeaderVelocity

Description:
	Checks the velocity of a unit to see if they are currently moving.

Parameters:
	0: _unit : <OBJECT> - The group to check over

Returns:
	<BOOL> - true if any velocity is detected, otherwise false

Examples:
    (begin example)
		_isActive = [_unit] call BLWK_fnc_pathing_checkLeaderVelocity;
    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
scriptName "BLWK_fnc_pathing_checkLeaderVelocity";

params ["_unit"];

if (!alive _unit) exitWith {
	false
};

// units seem to only get stuck in the standing position, otherwise, assume they are shooting and/or under fire
if (stance _unit != "STAND") exitWith {
	true
};

// forward/backward velocity is the most telling of movement
private _leaderVelocity = (velocityModelSpace _unit) select 0;

// if leader is stationary
if (_leaderVelocity isEqualTo 0) exitWith {
	false
};


true
