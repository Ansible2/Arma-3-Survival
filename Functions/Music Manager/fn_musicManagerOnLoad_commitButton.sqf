#include "..\..\Headers\descriptionEXT\GUI\musicManagerCommonDefines.hpp"
/* ----------------------------------------------------------------------------
Function: BLWK_fnc_musicManagerOnLoad_commitButton

Description:
	Adds functionality to the commit button of the Music Manager.

Parameters:
	0: _control : <CONTROL> - The control for the commit button

Returns:
	NOTHING

Examples:
    (begin example)
		[_control] call BLWK_fnc_musicManagerOnLoad_commitButton;
    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
disableSerialization;
scriptName "BLWK_fnc_musicManagerOnLoad_commitButton";

params ["_control"];

_control ctrlAddEventHandler ["ButtonClick",{

	if (GET_PUBLIC_ARRAY_DEFAULT isNotEqualTo []) then {
		remoteExecCall ["BLWK_fnc_musicManager_setPlaylistServer",2];
		["Playlist set on server"] call BLWK_fnc_notification;

	} else {
		["You can't commit an empty playlist"] call BLWK_fnc_errorNotification;

	};

}];


nil
