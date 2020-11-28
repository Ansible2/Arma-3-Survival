/* ----------------------------------------------------------------------------
Function: KISKA_fnc_getMusicFromClass

Description:
	Returns an array of track names for the given class of music

Parameters:
	0: _musicClass <STRING> - a class of music to search for (e.g. "stealth")

Returns:
	<ARRAY> - list of tracks from class

Examples:
    (begin example)

		["stealth"] call KISKA_fnc_getMusicFromClass;

    (end)

Author(s):
	Ansible2 // Cipher (modified by)
---------------------------------------------------------------------------- */
scriptName "KISKA_fnc_getMusicFromClass";

params [
	["_musicClass","",[""]]
];

if (_musicClass isEqualTo "") exitWith {
	"no class string passed" call BIS_fnc_error;
};

private _configCondition = ["getText (_x >> 'musicClass') == ",str _musicClass] joinString "";

private _configs = _configCondition configClasses (configFile >> "CfgMusic");

private _trackNames = [];

_configs apply {

	private _class = configName _x;

	_trackNames pushBackUnique _class;
};


_trackNames