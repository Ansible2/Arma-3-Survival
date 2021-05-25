/* ----------------------------------------------------------------------------
Function: BLWK_fnc_musicManagerOnLoad_closeButton

Description:
	Adds functionality to the close button of the Music Manager

Parameters:
	0: _control : <CONTROL> - The control for the close button

Returns:
	NOTHING

Examples:
    (begin example)
		[_control] call BLWK_fnc_musicManagerOnLoad_closeButton;
    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
disableSerialization;
scriptName "BLWK_fnc_musicManagerOnLoad_closeButton";

params ["_control"];

_control ctrlAddEventHandler ["ButtonClick",{
	(uiNamespace getVariable "BLWK_musicManager_display") closeDisplay 2;
}];


nil
