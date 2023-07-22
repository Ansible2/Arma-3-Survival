/* ----------------------------------------------------------------------------
Function: BLWK_fnc_suicideWave_bomberLoop

Description:
    Starts the loop that checks a bombers surroundings to see if they should explode.
    
    Also plays their weird audio.

Parameters:
    0: _bomber : <OBJECT> - The suicide bomber

Returns:
    NOTHING

Examples:
    (begin example)
        [myBomber] spawn BLWK_fnc_suicideWave_bomberLoop;
    (end)

Author(s):
    Ansible2
---------------------------------------------------------------------------- */
scriptName "BLWK_fnc_suicideWave_bomberLoop";

if (!canSuspend) exitWith {
    _this spawn BLWK_fnc_suicideWave_bomberLoop;
    nil
};

params [
    ["_bomber",objNull,[objNull]]
];

private ["_players","_nearPlayer"];
private _bomberDistanceToBlow = random [10,15,20];
while {alive _bomber} do {
    _players = call CBAP_fnc_players;

    [_bomber] remoteExec ["BLWK_fnc_suicideWave_playBomberAudio",_players];

    _nearPlayer = _players findIf {
        (_bomber distance2D _x) <= _bomberDistanceToBlow
    };

    private _aPlayerIsNear = _nearPlayer isNotEqualTo -1;
    if (_aPlayerIsNear OR {(_bomber distance2D BLWK_mainCrate) <= 10}) exitWith {
        [_bomber] call BLWK_fnc_suicideWave_explodeBomber;
    };

    sleep 3;
};


nil
