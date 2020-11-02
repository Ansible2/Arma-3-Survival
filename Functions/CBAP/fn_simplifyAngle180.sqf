/* ----------------------------------------------------------------------------
Function: CBAP_fnc_simplifyAngle180

Description:
    Returns an equivalent angle to the specified angle in the range -180 to 180.
    If the input angle is in the range -180 to 180, it will be returned unchanged.

Parameters:
    0: _angle : <NUMBER> - The degree of the angle you want to simplify

Returns:
    NUMBER - Simplified angle

Examples:
   (begin example)
   _angle = [912] call CBAP_fnc_simplifyAngle180;
   (end)
   
Author(s):
    SilentSpike 2015-27-07
	Modified by: Ansible2 // Cipher
---------------------------------------------------------------------------- */

params ["_angle"];

// Normalize to 0-360
_angle = [_angle] call CBAP_fnc_simplifyAngle;

// If within second half of range then move back a phase
if (_angle > 180) then {
    _angle = _angle - 360;
};

_angle