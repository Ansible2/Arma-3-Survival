/* ----------------------------------------------------------------------------
Function: KISKA_fnc_notification

Description:
    Prints a simple KISKA Notify notification on screen.

Parameters:
    0: _message : <STRING or ARRAY> - If string, the message to display as title.
        
        If array:
        - 0: _text : <STRING> - Text to display or path to .paa or .jpg
            image (may be passed directly if only text is required)
        - 1: _size : <NUMBER> - Scale of text
        - 2: _color : <NUMBER[]> - RGB or RGBA color (range 0-1). (optional, default: [1, 1, 1, 1])

    1: _lifetime : <NUMBER> - How long the notification will be visible (min of 2 seconds)
    2: _canSkip : <BOOL> - Can the notification be skipped when another is in the queue
    3: _headerColor : <NUMBER[]> - An array of [R,G,B,A] color values; defaults to green

Returns:
    NOTHING

Examples:
    (begin example)
        ["Hello World"] call KISKA_fnc_notification;
    (end)

Author:
    Ansible2
---------------------------------------------------------------------------- */
scriptName "KISKA_fnc_notification";

#define GREEN_RBGA [0.21,0.71,0.21,1]

params [
    ["_message","",["",[]]],
    ["_lifetime",4,[123]],
    ["_canSkip",true,[true]],
    ["_headerColor",GREEN_RBGA,[[]],[3,4]]
];

[
    ["Notification:",1.1,_headerColor],
    _message,
    _lifetime,
    _canSkip
] call KISKA_fnc_notify;


nil
