/* ----------------------------------------------------------------------------
Function: KISKA_fnc_getMusicDuration

Description:
	Returns the duration of a track of music. Will return 0 if undefined duration or class.

Parameters:
	0: _trackClass <STRING> - a classname to check the duration of.

Returns:
	<NUMBER> - The duration of the requested track

Examples:
    (begin example)

		["LeadTrack01_F_Curator"] call KISKA_fnc_getMusicDuration;

    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
params [
	["_trackClass","",[""]]
];

if (_trackClass isEqualTo "") exitWith {
	"No class string passed" call BIS_fnc_error;
};

private _duration = getNumber (configFile >> "cfgMusic" >> _trackClass >> "duration");

_duration