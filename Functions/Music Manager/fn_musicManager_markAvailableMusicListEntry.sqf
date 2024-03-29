/* ----------------------------------------------------------------------------
Function: BLWK_fnc_musicManager_markAvailableMusicListEntry

Description:
	Changes the color of an available music list entry depending on if
     it was put into or removed fromt he current music playlist.

Parameters:
	0: _songIndex : <NUMBER> - The songs index in the music selection listNBox
  	1: _added : <BOOL> - true if added, false if removed
  	2: _notify : <BOOL> - true to show notification about the addition or removal

Returns:
	NOTHING

Examples:
    (begin example)
        // mark as being in playlist
		[0,true] call BLWK_fnc_musicManager_markAvailableMusicListEntry;
    (end)

Author(s):
	Ansible2
---------------------------------------------------------------------------- */
disableSerialization;
scriptName "BLWK_fnc_musicManager_markAvailableMusicListEntry";

#define TAKEN_COLOR [0.22,1,0.16,1]
#define NOT_TAKEN_COLOR [1,1,1,1]


private _musicManagerIsClosed = isNil {uiNamespace getVariable "BLWK_musicManager_display"};
if ((!hasInterface) OR _musicManagerIsClosed) exitWith {};


params [
    ["_songIndex",-1,[123]],
    ["_added",true,[true]],
    ["_notify",true,[true]]
];


if (_songIndex < 0) exitWith {
    [["Invalid _songIndex: ",_songIndex],true] call KISKA_fnc_log;
    nil
};


private _availableMusicListControl = uiNamespace getVariable "BLWK_musicManager_control_availableSongsList";
private _color = [NOT_TAKEN_COLOR,TAKEN_COLOR] select _added;
_availableMusicListControl lnbSetColor [[_songIndex, 0],_color];

if (_notify) then {
    private _songInfo = (localNamespace getVariable "BLWK_musicManager_indexToInfoMap") getOrDefault [_songIndex,[]];
    private _songName = _songInfo param [0,""];
    private _notificationText = ["removed from playlist","added to playlist"] select _added;
    [[_songName,_notificationText] joinString " ",2,true] call KISKA_fnc_notification;
};


nil
