/* ----------------------------------------------------------------------------
Function: KISKA_fnc_getMusicDuration

Description:
	Returns the duration of a track of music. Will return 0 if undefined duration or class.

Parameters:
	0: _track <STRING or CONFIG> - a classname to check the duration of or its config path

Returns:
	<NUMBER> - The duration of the requested track

Examples:
    (begin example)

		["LeadTrack01_F_Curator"] call KISKA_fnc_getMusicDuration;

    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
scriptName "KISKA_fnc_getMusicDuration";

params [
	["_track","",["",configNull]]
];

if (_track isEqualTo "") exitWith {
	"No class string passed" call BIS_fnc_error;
};

private _duration = 0;
private "_config";
if (_track isEqualType configNull) then {
	_config = _track;
} else {
	_config = [["cfgMusic",_track]] call KISKA_fnc_findConfigAny;
};

if (isNull _config) exitWith {
	["_track %1 is not defined in any cfgMusic class",_track] call BIS_fnc_error;
	_duration
};

_duration = getNumber(_config >> "duration");


_duration