#include "..\..\Headers\descriptionEXT\GUI\musicManagerCommonDefines.hpp"
/* ----------------------------------------------------------------------------
Function: BLWK_fnc_musicManagerOnLoad_currentPlaylistLoop

Description:
	Keeps the current playlist listBox up to date between the multiple people that
	 can be simaltaneously updating it.

Parameters:
	0: _control : <CONTROL> - The control for the list box to update
	1: _display : <DISPLAY> - The display for the Music Manager

Returns:
	NOTHING

Examples:
    (begin example)
		[_control] call BLWK_fnc_musicManagerOnLoad_currentPlaylistLoop;
    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
disableSerialization;
scriptName "BLWK_fnc_musicManagerOnLoad_currentPlaylistLoop";

params ["_control","_display"];

// initialize variable if not done
if (isNil TO_STRING(BLWK_PUB_CURRENT_PLAYLIST)) then {
	missionNamespace setVariable [TO_STRING(BLWK_PUB_CURRENT_PLAYLIST),[]];
};

// CIPHER COMMENT: Why not use localNamespace?
uiNamespace setVariable ["BLWK_fnc_musicManager_getMusicName",{
	params ["_configClass"];
	private _configPath = [["cfgMusic",_configClass]] call KISKA_fnc_findConfigAny;
	private _displayName = getText(_configPath >> "name");
	if (_displayName isEqualTo "") then {
		_displayName = configName _configPath;
	};

	_displayName
}];

// initially populate list if there is anything in the public array
if !(GET_PUBLIC_ARRAY_DEFAULT isEqualTo []) then {
	private "_displayName_temp";
	BLWK_PUB_CURRENT_PLAYLIST apply {
		_displayName_temp = [_x] call (uiNamespace getVariable "BLWK_fnc_musicManager_getMusicName");
		_control lbAdd _displayName_temp;
		[_x,true] call BLWK_fnc_musicManager_adjustNameColor;
	};
};

_this spawn {
	params ["_control","_display"];

	private _fn_adjustList = {
		params ["_displayedArray","_globalArray"];

		// delete all entries if global is empty
		if (_globalArray isEqualTo []) exitWith {
			private _countOfEntries = lbSize _control;
			if (_countOfEntries > 0) then { // make sure the shown array isn't already empty
				lbClear _control;
			};
		};

		// get index numbers of array (start from 0)
		private _indexesOfDisplayed = count _displayedArray - 1;
		private _indexesOfCurrent = count _globalArray - 1;
		private ["_comparedIndex","_musicName"];
		{
			// check to see if we are out of bounds on the display array
			// e.g. stop changing entries and start adding them
			if (_indexesOfDisplayed >= _forEachIndex) then {
				_comparedIndex = _displayedArray select _forEachIndex;
				// if the index is not already the same
				if (_comparedIndex != _x) then {
					_musicName = [_x] call (uiNamespace getVariable "BLWK_fnc_musicManager_getMusicName");
					_control lbSetText [_forEachIndex,_musicName];
					_control lbSetTooltip [_forEachIndex,_musicName];
				};
			} else {
				_musicName = [_x] call (uiNamespace getVariable "BLWK_fnc_musicManager_getMusicName");
				_control lbAdd _musicName;
				_control lbSetTooltip [_forEachIndex,_musicName];
			};
		} forEach _globalArray;

		// delete overflow items
		if (_indexesOfDisplayed > _indexesOfCurrent) then {
			private _indexToDelete = _indexesOfCurrent + 1;
			for "_i" from _indexesOfCurrent to _indexesOfDisplayed do {
				// deleting the same index because the list will move down with each deletetion
				_control lbDelete _indexToDelete;
			};
		};

	};

	private _playlist_displayed = +GET_PUBLIC_ARRAY_DEFAULT;
	while {sleep 0.5; !(isNull _display)} do {

		// compare cached and public array
		if !(_playlist_displayed isEqualTo GET_PUBLIC_ARRAY_DEFAULT) then {
			[_playlist_displayed,BLWK_PUB_CURRENT_PLAYLIST] call _fn_adjustList;
			_playlist_displayed = +BLWK_PUB_CURRENT_PLAYLIST;
		};
	};
};


nil
