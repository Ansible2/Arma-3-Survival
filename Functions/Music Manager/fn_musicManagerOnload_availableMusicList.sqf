/* ----------------------------------------------------------------------------
Function: BLWK_fnc_musicManagerOnLoad_availableMusicList

Description:
    Populates the ListNBox that shows all available tracks when the Music Manager
     is openned.

Parameters:
    0: _availableSongsListControl : <CONTROL> - The control for the ListNBox with available music

Returns:
    NOTHING

Examples:
    (begin example)
        [_availableSongsListControl] call BLWK_fnc_musicManagerOnLoad_availableMusicList;
    (end)

Author(s):
    Ansible2 // Cipher
---------------------------------------------------------------------------- */
disableSerialization;
scriptName "BLWK_fnc_musicManagerOnLoad_availableMusicList";

params ["_availableSongsListControl"];

/* ----------------------------------------------------------------------------
    Setup events
---------------------------------------------------------------------------- */
_availableSongsListControl ctrlAddEventHandler ["LBSelChanged", {
    params [
        "_availableSongsListControl",
        "_lastSelectedIndex",
        "_allCurrentlySelectedIndexes"
    ];

    uiNamespace setVariable ["BLWK_musicManager_selectedAvailableTrackRowIndexes",_allCurrentlySelectedIndexes];
    
    private _musicClass = _availableSongsListControl lnbData [_lastSelectedIndex,0];
    uiNamespace setVariable ["BLWK_musicManager_selectedTrackToPlay",_musicClass];
}];

_availableSongsListControl ctrlAddEventHandler ["LBDblClick", {
    params ["_availableSongsListControl", "_selectedIndex"];

    private _musicClass = _availableSongsListControl lnbData [_selectedIndex,0];
    uiNamespace setVariable ["BLWK_musicManager_selectedTrackToPlay",_musicClass];
    [] call BLWK_fnc_musicManager_playMusic;
}];


/* ----------------------------------------------------------------------------
    Generate List
---------------------------------------------------------------------------- */
// cache and/or get music info for list
private "_musicMap";
if (isNil {localNamespace getVariable "BLWK_musicManager_classNameToInfoMap"}) then {
    
    private _musicClasses = missionNamespace getVariable ["BLWK_sortedServerMusicConfigs",[]];
    private _classNameToInfoArray = [];
    private _indexToInfoArray = [];
    {
        private _songDisplayName = getText(_x >> "name");
        if (_songDisplayName isEqualTo "") then {
            _songDisplayName = configName _x;
        };

        private _songDuration = getNumber(_x >> "duration");
        private _songClassname = configName _x;
        _classNameToInfoArray pushBack [
            _songClassname,
            [_songDisplayName, str (round _songDuration), _songDuration,_forEachIndex]
        ];
        _indexToInfoArray pushBack [
            _forEachIndex,
            [_songDisplayName, str (round _songDuration), _songDuration,_songClassname]
        ];
    } forEach _musicClasses;

    _musicMap = createHashMapFromArray _classNameToInfoArray;
    localNamespace setVariable ["BLWK_musicManager_classNameToInfoMap",_musicMap];
    localNamespace setVariable ["BLWK_musicManager_indexToInfoMap",createHashMapFromArray _indexToInfoArray];

} else {
    _musicMap = localNamespace getVariable "BLWK_musicManager_classNameToInfoMap";

};

// add duration column
_availableSongsListControl lnbAddColumn 1;
_availableSongsListControl lnbSetColumnsPos [0,0.82];


{
    _y params ["_songName","_songDurationString","","_songIndex"];
    private _rowIndex = _availableSongsListControl lnbAddRow [_songName,_songDurationString];

    private _songClassname = _x;
    _availableSongsListControl lnbSetData [[_rowIndex,0],_songClassname];
    _availableSongsListControl lnbSetValue [[_rowIndex,0],_songIndex];
    _availableSongsListControl lnbSetTooltip [[_rowIndex,0],_songClassname];
} forEach _musicMap;


_availableSongsListControl lnbSort [0,false];

private _currentPlaylistMap = localNamespace getVariable ["BLWK_musicManager_currentPlaylistMap", -1];
private _noPlaylistToLoad = _currentPlaylistMap isEqualTo -1;
if (_noPlaylistToLoad) exitWith {};

(keys _currentPlaylistMap) apply {
    [_x,true,false] call BLWK_fnc_musicManager_markAvailableMusicListEntry;
};


nil
