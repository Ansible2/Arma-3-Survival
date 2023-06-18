/* ----------------------------------------------------------------------------
Function: KISKA_fnc_countdown

Description:
    Sleeps for a given time and eventually displays a certain amount on screen.

Parameters:
    0: _countDownTotal : <NUMBER> - The amount to countdown from
    1: _shownCountDown : <NUMBER> - The number at which a print out of the
        current countdown will show on screen.
    2: _soundedCountDown : <NUMBER> - The number at which a beep should play for each second
    3: _soundName : <STRING> - The cfgSournds entry to play for the sound portion of the countdown

Returns:
    NOTHING

Examples:
    (begin example)
        // print numbers when at 15 and play sound at 10
        [30,15,10] spawn KISKA_fnc_countdown;
    (end)
    (begin example)
        // print numbers when at 15 and play no sound
        [30,15,-1] spawn KISKA_fnc_countdown;
    (end)

Author(s):
    Hilltop(Willtop) & omNomios,
    Modified by: Ansible2
---------------------------------------------------------------------------- */
scriptName "KISKA_fnc_countdown";

if (!canSuspend) exitWith {
    ["Needs to be called from a scheduled environment!",true] call KISKA_fnc_log;
    _this spawn KISKA_fnc_countdown;
};

params [
    ["_countDownTotal",15,[123]],
    ["_shownCountDown",15,[123]],
    ["_soundedCountDown",10,[123]],
    ["_soundName","beep_target",[""]]
];

if (_countDownTotal < _shownCountDown) then {
    [["_shownCountDown: ",_shownCountDown ," should be less then _countDownTotal: ", _countDownTotal],true] call KISKA_fnc_log;
    _shownCountDown = _countDownTotal;
};

if (_soundedCountDown > _shownCountDown) then {
    [["_soundedCountDown: ",_soundedCountDown ," should be less then _shownCountDown: ", _shownCountDown],true] call KISKA_fnc_log;
    _soundedCountDown = _shownCountDown;
};


if (_countDownTotal < 0) exitWith {
    [["Negative countdown was passed: ",_countDownTotal],true] call KISKA_fnc_log;
    nil
};

if (hasInterface) then {
    private _timeToSleepBeforeShown = _countDownTotal - _shownCountDown;
    sleep _timeToSleepBeforeShown;

    while {_shownCountDown >= 0} do {
        if (_shownCountDown <= _soundedCountDown) then {
            playSound _soundName;
        };

        [str _shownCountDown, 0, 0, 1, 0] spawn BIS_fnc_dynamicText;

        sleep 1;
        _shownCountDown = _shownCountDown - 1;
    };

} else {
    sleep _countDownTotal;

};



nil
