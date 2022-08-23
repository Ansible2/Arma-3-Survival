/* ----------------------------------------------------------------------------
Function: KISKA_fnc_errorNotification

Description:
	Prints a simple KISKA Notify error notification on screen.

Parameters:
	0: _message : <STRING or ARRAY> - The second line of the notification.
        Formatted the same as the parameters for CBA_fnc_notify:
            _lineN - N-th content line (may be passed directly if only 1 line is required). <ARRAY>
                _text  - Text to display or path to .paa or .jpg image (may be passed directly if only text is required). <STRING, NUMBER>
                _size  - Text or image size multiplier. (optional, default: 1) <NUMBER>
                _color - RGB or RGBA color (range 0-1). (optional, default: [1, 1, 1, 1]) <ARRAY>
	1: _lifetime : <NUMBER> - How long the notification lasts in seconds (at least 2)

Returns:
	NOTHING

Examples:
    (begin example)
        ["You made and error"] call KISKA_fnc_errorNotification;
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
	["Error",1.1,[0.75,0,0,1]],
	_message,
	_lifetime,
	false
] call KISKA_fnc_notify;


nil
