/* ----------------------------------------------------------------------------
Function: BLWK_fnc_musicManager_adjustNameColor

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
		["someClass",true] call BLWK_fnc_musicManager_adjustNameColor;
    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
disableSerialization;
scriptName "BLWK_fnc_musicManager_adjustNameColor";

#define TAKEN_COLOR [0.22,1,0.16,1]
#define WHITE_COLOR [1,1,1,1]
#define INDEX_IN_AVAILABLE_MUSIC_LIST 2

params [
    "_class",
    ["_added",true]
];

if (_class isEqualTo "") exitWith {
    ["_class is empty",true] call KISKA_fnc_log;
    nil
};

private _musicHash = missionNamespace getVariable "BLWK_musicManager_musicHash";
private _classInfo = _musicHash get _class;
private _index = _classInfo select INDEX_IN_AVAILABLE_MUSIC_LIST;

if (isNil {uiNamespace getVariable "BLWK_musicManager_coloredClasses"}) then {
    uiNamespace setVariable ["BLWK_musicManager_coloredClasses",[]];
};

private _coloredClasses = uiNamespace getVariable "BLWK_musicManager_coloredClasses";
private "_color";
if (_added) then {
    _coloredClasses pushBack _class;
    _color = TAKEN_COLOR;
} else {
    _deleteindex = _coloredClasses find _class;
    [str _deleteindex] call KISKA_fnc_log;
    _coloredClasses deleteAt _deleteindex;
    _color = WHITE_COLOR;
};

private _availableMusicListControl = (uiNamespace getVariable "BLWK_musicManager_control_songsList");
_availableMusicListControl lnbSetColor [[_index, 0], _color];
