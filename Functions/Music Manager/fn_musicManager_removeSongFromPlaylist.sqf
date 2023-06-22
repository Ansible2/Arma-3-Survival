/* ----------------------------------------------------------------------------
Function: BLWK_fnc_musicManager_removeSongFromPlaylist

Description:
    Removes a given song className from current playlist

Parameters:
    0: _songIndex : <NUMBER> - The index of the song in the 

Returns:
    NOTHING

Examples:
    (begin example)
        [0] remoteExecCall ["BLWK_fnc_musicManager_removeSongFromPlaylist",0,true];
    (end)

Author(s):
    Ansible2
---------------------------------------------------------------------------- */
scriptName "BLWK_fnc_musicManager_removeSongFromPlaylist";

params [
    ["_songIndex",-1,[123]]
];

private _currentPlaylistMap = localNamespace getVariable ["BLWK_musicManager_currentPlaylistMap",-1];
if (_currentPlaylistMap isEqualTo -1) then {
    _currentPlaylistMap = createHashMap;
    localNamespace setVariable ["BLWK_musicManager_currentPlaylistMap",_currentPlaylistMap];
};

private _songClassName = _currentPlaylistMap getOrDefault [_songIndex,""];
if !(_songIndex in _currentPlaylistMap) exitWith {
    [["Index: ",_songIndex," was not found in BLWK_musicManager_currentPlaylistMap"], true] call KISKA_fnc_log;
    nil
};

_currentPlaylistMap deleteAt _songIndex;
if (isServer) then {
    [values _currentPlaylistMap] call KISKA_fnc_randomMusic_setUnusedTracks;
    [[]] call KISKA_fnc_randomMusic_setUsedTracks;
};

[_songIndex,false] call BLWK_fnc_musicManager_markAvailableMusicListEntry;


nil
