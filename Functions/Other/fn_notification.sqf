/* ----------------------------------------------------------------------------
Function: BLWK_fnc_notification

Description:
	Prints a simple notification

Parameters:
	0: _message : <STRING or ARRAY> - If string, the message to display as title
		0: _text : <STRING> - Text to display or path to .paa or .jpg image (may be passed directly if only text is required)
		1: _size : <NUMBER> - Scale of text
		2: _color : <ARRAY> - RGB or RGBA color (range 0-1). (optional, default: [1, 1, 1, 1])

Returns:
	NOTHING

Examples:
    (begin example)
        ["Hello World"] call BLWK_fnc_notification;
    (end)

Author:
	Ansible2
---------------------------------------------------------------------------- */
scriptName "BLWK_fnc_notification";

params [
	["_message","",["",[]]]
];

[
	["Notification:",1.1,[0.21,0.71,0.21,1]],
	_message,
	false
] call BLWK_fnc_notify;


nil
