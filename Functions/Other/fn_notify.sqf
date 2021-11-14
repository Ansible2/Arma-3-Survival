#include "\a3\ui_f\hpp\defineCommonGrids.inc"
/* ----------------------------------------------------------------------------
Function: BLWK_fnc_notify

Description:
    Display a text message. Multiple incoming messages are queued.

Parameters:
	0: _titleLine : <STRING or ARRAY> - If string, the message to display as title
        0: _text : <STRING> - Text to display or path to .paa or .jpg image (may be passed directly if only text is required)
        1: _size : <NUMBER> - Scale of text
        2: _color : <ARRAY> - RGB or RGBA color (range 0-1). (optional, default: [1, 1, 1, 1])

	1: _subLine : <STRING or ARRAY> - Formatted the same as _titleLine
	2: _skippable : <ARRAY> - If there are more notifications behind in the queue and this notification
        comes up, it will not be shown and thrown away

Examples:
    (begin example)

    (end)

Returns:
    NOTHING

Authors:
    commy2,
    Modified by: Ansible2 // Cipher
---------------------------------------------------------------------------- */
#define NOTIFY_DEFAULT_X (safezoneX + safezoneW - 13 * GUI_GRID_W)
#define NOTIFY_DEFAULT_Y (safezoneY + 6 * GUI_GRID_H)
#define NOTIFY_MIN_WIDTH (12 * GUI_GRID_W)
#define NOTIFY_MIN_HEIGHT (3 * GUI_GRID_H)

#define TRIPLES(var1,var2,var3) var1##_##var2##_##var3

#define NOTIFICATION_LIFETIME 4

#define FADE_IN_TIME 0.2
#define FADE_OUT_TIME 1

#define GET_QUEUE localNamespace getVariable "BLWK_notificationQueue"
#define SET_QUEUE(var) localNamespace setVariable ["BLWK_notificationQueue",var]


if (canSuspend) exitWith {
    [BLWK_fnc_notify, _this] call CBAP_fnc_directCall;
};

if (!hasInterface) exitWith {};


params [
    ["_titleLine","",[[],""]],
    ["_subLine","",[[],""]],
    ["_skippable",false,[true]]
];


/* ----------------------------------------------------------------------------
    Build composition
---------------------------------------------------------------------------- */
private _composition = [];

[_titleLine,_subLine] apply {
    // Line
    _composition pushBack lineBreak;

    _x params [
        ["_text","",[""]],
        ["_size",1,[123]],
        ["_color",[1,1,1,1],[[]],[3,4]]
    ];

    if ((count _color) isEqualTo 3) then {
        _color pushBack 1;
    };

    _color = _color call BIS_fnc_colorRGBAtoHTML;
    _size = _size * 0.55 / (getResolution select 5);

    private _isImage = (toLower _text) select [(count _text) - 4] in [".paa", ".jpg"];
    if (_isImage) then {
        _composition pushBack parseText format ["<img align='center' size='%2' color='%3' image='%1'/>", _text, _size, _color];

    } else {
        _composition pushBack parseText format ["<t align='center' size='%2' color='%3'>%1</t>", _text, _size, _color];

    };
};


private _notification = [_composition, _skippable];

// add the queue
if (isNil {GET_QUEUE}) then {
    SET_QUEUE([]);
};

(GET_QUEUE) pushBack _notification;


/* ----------------------------------------------------------------------------
    loop
---------------------------------------------------------------------------- */
if !(localNamespace getVariable ["BLWK_notificationLoopRunning",false]) then {
    localNamespace setVariable ["BLWK_notificationLoopRunning",true];

    [] spawn {
        /* ----------------------------------------------------------------------------
            _fn_createNotification
        ---------------------------------------------------------------------------- */
        private _fn_createNotification = {
            //params ["_composition"];

            "BLWK_ui_notify" cutRsc ["RscTitleDisplayEmpty", "PLAIN", 0, true];
            private _display = uiNamespace getVariable "RscTitleDisplayEmpty";

            private _vignette = _display displayCtrl 1202;
            _vignette ctrlShow false;

            private _background = _display ctrlCreate ["RscText", -1];
            _background ctrlSetBackgroundColor [0,0,0,0.25];

            private _text = _display ctrlCreate ["RscStructuredText", -1];
            _text ctrlSetStructuredText (composeText _this);

            private _controls = [_background, _text];

            private _left = profileNamespace getVariable ['TRIPLES(IGUI, cba_ui_notify, x)', NOTIFY_DEFAULT_X];
            private _top = profileNamespace getVariable ['TRIPLES(IGUI, cba_ui_notify, y)', NOTIFY_DEFAULT_Y];
            private _width = profileNamespace getVariable ['TRIPLES(IGUI, cba_ui_notify, w)', NOTIFY_MIN_WIDTH];
            private _height = profileNamespace getVariable ['TRIPLES(IGUI, cba_ui_notify, h)', NOTIFY_MIN_HEIGHT];

            _width = ctrlTextWidth _text max _width;

            // need to set this before reading the text height, to get the correct amount of auto line breaks
            _text ctrlSetPosition [0, 0, _width, _height];
            _text ctrlCommit 0.01;

            private _textHeight = ctrlTextHeight _text;
            _height = _textHeight max _height;

            // ensure the box not going off screen
            private _right = _left + _width;
            private _bottom = _top + _height;

            private _leftEdge = safezoneX;
            private _rightEdge = safezoneW + safezoneX;
            private _topEdge = safezoneY;
            private _bottomEdge = safezoneH + safezoneY;

            if (_right > _rightEdge) then {
                _left = _left - (_right - _rightEdge);
            };

            if (_left < _leftEdge) then {
                _left = _left + (_leftEdge - _left);
            };

            if (_bottom > _bottomEdge) then {
                _top = _top - (_bottom - _bottomEdge);
            };

            if (_top < _topEdge) then {
                _top = _top + (_topEdge - _top);
            };

            _background ctrlSetPosition [_left, _top, _width, _height];

            if (_textHeight < _height) then {
                _top = _top + (_height - _textHeight) / 2;
            };

            _text ctrlSetPosition [_left, _top, _width, _textHeight];

            // fade in
            _controls apply {
                _x ctrlSetFade 1;
                _x ctrlCommit 0.01;
                _x ctrlSetFade 0;
                _x ctrlCommit (FADE_IN_TIME);
            };

            sleep NOTIFICATION_LIFETIME - FADE_OUT_TIME;

            _controls apply {
                _x ctrlSetFade 1;
                _x ctrlCommit (FADE_OUT_TIME);
            };

            sleep FADE_OUT_TIME;
        };


        /* ----------------------------------------------------------------------------
            Queue loop
        ---------------------------------------------------------------------------- */
        private ["_notificationInfo","_skippable"];
        private _queue = GET_QUEUE;

        while {(count _queue) > 0} do {
            _notificationInfo = _queue deleteAt 0;
            _skippable = _notificationInfo select 1;

            if !(_skippable AND ((count _queue) > 0)) then {
                (_notificationInfo select 0) call _fn_createNotification;
            };
        };

        localNamespace setVariable ["BLWK_notificationLoopRunning",false];
    };

};


nil
