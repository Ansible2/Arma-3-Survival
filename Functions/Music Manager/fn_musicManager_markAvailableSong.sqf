/* ----------------------------------------------------------------------------
Function: BLWK_fnc_musicManager_markAvailableSong

Description:
	Changes the color of an available music list entry depending on if
     it was put into or removed fromt he current music playlist.

Parameters:
	0: _musicClass : <STRING> - The track classname as defined in CfgMusic
  	1: _added : <BOOL> - true if added, false if removed

Returns:
	NOTHING

Examples:
    (begin example)
        // change color to be taken
		["someClass",true] call BLWK_fnc_musicManager_markAvailableSong;
    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
disableSerialization;
scriptName "BLWK_fnc_musicManager_markAvailableSong";

#define TAKEN_COLOR [0.22,1,0.16,1]
#define NOT_TAKEN_COLOR [1,1,1,1]

params [
    "_class",
    ["_added",true]
];

if (_class isEqualTo "") exitWith {
    ["_class is empty",true] call KISKA_fnc_log;
    nil
};

private _musicMap = localNamespace getVariable "BLWK_musicManager_musicMap";
private _musicClassInfo = _musicMap getOrDefaultCall [_class,{[]}];
if (_musicClassInfo isEqualTo []) exitWith {
    [["Could not music info in map BLWK_musicManager_musicMap for _class", _class],true] call KISKA_fnc_log;
    nil
};

if (isNil {uiNamespace getVariable "BLWK_musicManager_coloredClasses"}) then {
    uiNamespace setVariable ["BLWK_musicManager_coloredClasses",[]];
};

// colored classes array is used to be able to clear out any colored classes after a load
private _coloredClasses = uiNamespace getVariable "BLWK_musicManager_coloredClasses";
private "_color";
if (_added) then {
    _coloredClasses pushBack _class;
    _color = TAKEN_COLOR;
} else {
    _deleteindex = _coloredClasses find _class;
    _coloredClasses deleteAt _deleteindex;
    _color = NOT_TAKEN_COLOR;
};

private _availableMusicListControl = (uiNamespace getVariable "BLWK_musicManager_control_availableSongsList");
hint str _musicClassInfo;
private _index = _musicClassInfo select 3;
_availableMusicListControl lnbSetColor [[_index, 0], _color];
