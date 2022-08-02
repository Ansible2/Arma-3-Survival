/* ----------------------------------------------------------------------------
Function: KISKA_fnc_errorNotification

Description:
	Prints an error notification

Parameters:
	0: _message : <STRING or ARRAY> - If string, the message to display as title
		0: _text : <STRING> - Text to display or path to .paa or .jpg image (may be passed directly if only text is required)
		1: _size : <NUMBER> - Scale of text
		2: _color : <ARRAY> - RGB or RGBA color (range 0-1). (optional, default: [1, 1, 1, 1])
	1: _lifetime : <NUMBER> - How long the notification lasts in seconds (at least 2)

Returns:
	NOTHING

Examples:
    (begin example)
        ["Hello World"] call KISKA_fnc_errorNotification;
    (end)

Author:
	Ansible2
---------------------------------------------------------------------------- */
scriptName "KISKA_fnc_errorNotification";

params [
	["_message","",["",[]]],
	["_lifetime",4,[123]]
];

[
	["Error:",1.1,[0.75,0,0,1]],
	_message,
	false,
	_lifetime
] call BLWK_fnc_notify;


nil
