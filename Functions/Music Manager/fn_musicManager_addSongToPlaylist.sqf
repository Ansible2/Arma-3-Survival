/* ----------------------------------------------------------------------------
Function: BLWK_fnc_musicManager_addSongToPlaylist

Description:
    Adds a given song className to the current playlist

Parameters:
    0: _songIndex : <NUMBER> - The index of the song in the 

Returns:
    NOTHING

Examples:
    (begin example)
        [0] remoteExecCall ["BLWK_fnc_musicManager_addSongToPlaylist",0,true];
    (end)

Author(s):
    Ansible2
---------------------------------------------------------------------------- */
scriptName "BLWK_fnc_musicManager_addSongToPlaylist";

params [
    ["_songIndex",-1,[123]]
];

private _currentPlaylistMap = localNamespace getVariable ["BLWK_musicManager_currentPlaylistMap",-1];
if (_currentPlaylistMap isEqualTo -1) then {
    _currentPlaylistMap = createHashMap;
    localNamespace setVariable ["BLWK_musicManager_currentPlaylistMap",_currentPlaylistMap];
};

private _songConfig = BLWK_sortedServerMusicConfigs param [_songIndex,configNull];
if (isNull _songConfig) exitWith {
    [["Index: ",_songIndex," was not found in BLWK_sortedServerMusicConfigs"], true] call KISKA_fnc_log;
    nil
};

private _songClassName = configName _songConfig;
if (_songIndex in _currentPlaylistMap) exitWith {
    [[_songClassName," is already located in BLWK_musicManager_currentPlaylistMap"]] call KISKA_fnc_log;
    nil
};

_currentPlaylistMap set [_songIndex,_songClassName];
if (isServer) then {
    [values _currentPlaylistMap] call KISKA_fnc_randomMusic_setUnusedTracks;
    [[]] call KISKA_fnc_randomMusic_setUsedTracks;
};

[_songIndex,true] call BLWK_fnc_musicManager_markAvailableMusicListEntry;


nil