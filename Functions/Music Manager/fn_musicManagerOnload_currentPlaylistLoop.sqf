#include "..\..\Headers\descriptionEXT\GUI\musicManagerCommonDefines.hpp"
/* ----------------------------------------------------------------------------
Function: BLWK_fnc_musicManagerOnLoad_currentPlaylistLoop

Description:
	Keeps the current playlist listBox up to date between the multiple people that
	 can be simaltaneously updating it.

Parameters:
	0: _currentPlaylistControl : <CONTROL> - The control for the list box to update
	1: _display : <DISPLAY> - The display for the Music Manager

Returns:
	NOTHING

Examples:
    (begin example)
		[_currentPlaylistControl] call BLWK_fnc_musicManagerOnLoad_currentPlaylistLoop;
    (end)

Author(s):
	Ansible2 // Cipher


	// TODO:
	- list needs to be multiplayer synced
	- list needs to be sorted alphabetically
	- user can add a song to the list with just its className
	- user can remove a song from the list with just its className
	- available list correctly reflects that a song has been added
---------------------------------------------------------------------------- */
disableSerialization;
scriptName "BLWK_fnc_musicManagerOnLoad_currentPlaylistLoop";

params ["_currentPlaylistControl","_display"];

// initialize variable if not done
if (isNil TO_STRING(BLWK_PUB_CURRENT_PLAYLIST)) then {
	missionNamespace setVariable [TO_STRING(BLWK_PUB_CURRENT_PLAYLIST),[]];
};

// CIPHER COMMENT: Why not use localNamespace?
uiNamespace setVariable ["BLWK_fnc_musicManager_getSongName",{
	scriptName "BLWK_fnc_musicManager_getSongName";
	params ["_songClassName"];

	private _musicMap = localNamespace getVariable "BLWK_musicManager_musicMap";
	private _songInfo = _musicMap getOrDefaultCall [_songClassName,{[]}];
	if (_songInfo isEqualTo []) exitWith {
		[["Error, could not find music map info for: ",_songClassName],true] call KISKA_fnc_log;
		""
	};

	private _songName = _songInfo param [0,""];
	_songName
}];

// TODO: this should not be needed
// // initially populate list if there is anything in the public array
// if (GET_PUBLIC_ARRAY_DEFAULT isNotEqualTo []) then {
// 	BLWK_PUB_CURRENT_PLAYLIST apply {
// 		private _songName = [_x] call (uiNamespace getVariable "BLWK_fnc_musicManager_getSongName");
// 		_currentPlaylistControl lbAdd _songName;
// 		[_x,true] call BLWK_fnc_musicManager_markAvailableSong;
// 	};
// };

_this spawn {
	params ["_currentPlaylistControl","_display"];

	private _fn_adjustList = {
		params ["_displayedPlaylist","_actualPlaylist"];

		if (_actualPlaylist isEqualTo []) exitWith {
			private _listBoxIsAlreadyEmpty = (lbSize _currentPlaylistControl) < 1;
			if !(_listBoxIsAlreadyEmpty) then {
				lbClear _currentPlaylistControl;
			};
		};

		private _maxIndexOfDisplayedPlaylist = count _displayedPlaylist - 1;
		private _maxIndexOfActualPlaylist = count _actualPlaylist - 1;
		{

			private _previousClassname = _currentPlaylistControl lbData _forEachIndex;
			private _classNamesMatch = _previousClassname == _x;
			if (_classNamesMatch) then { 
				[_previousClassname,true] call BLWK_fnc_musicManager_markAvailableSong;
				continue 
			};
			

			private _songName = [_x] call (uiNamespace getVariable "BLWK_fnc_musicManager_getSongName");
			private _listItemAlreadyExists = _previousClassname isNotEqualTo "";
			if (_listItemAlreadyExists) then {
				[_previousClassname,false] call BLWK_fnc_musicManager_markAvailableSong;
				_currentPlaylistControl lbSetText [_forEachIndex,_songName];
			} else {
				_currentPlaylistControl lbAdd _songName;
			};

			[_x,true] call BLWK_fnc_musicManager_markAvailableSong;
			_currentPlaylistControl lbSetTooltip [_forEachIndex,_x];
			_currentPlaylistControl lbSetData [_forEachIndex,_x];
		} forEach _actualPlaylist;


		private _previousListOverflows = _maxIndexOfDisplayedPlaylist > _maxIndexOfActualPlaylist;
		if (_previousListOverflows) then {
			private _indexToDelete = _maxIndexOfActualPlaylist + 1;
			for "_i" from _maxIndexOfActualPlaylist to _maxIndexOfDisplayedPlaylist do {
				// deleting the same index because the list will move down with each deletetion
				_currentPlaylistControl lbDelete _indexToDelete;
			};
		};

		lbSort _currentPlaylistControl
	};

	private _playlist_displayed = [];
	while {sleep 0.5; !(isNull _display)} do {

		// compare cached and public array
		if (_playlist_displayed isNotEqualTo GET_PUBLIC_ARRAY_DEFAULT) then {
			[_playlist_displayed,BLWK_PUB_CURRENT_PLAYLIST] call _fn_adjustList;
			_playlist_displayed = +BLWK_PUB_CURRENT_PLAYLIST;
		};
	};
};


nil
