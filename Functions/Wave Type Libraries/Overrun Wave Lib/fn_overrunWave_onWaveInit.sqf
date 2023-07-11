/* ----------------------------------------------------------------------------
Function: BLWK_fnc_overrunWave_onWaveInit

Description:
    The on wave init for overrun waves.

Parameters:
    NONE

Returns:
    NOTHING

Examples:
    (begin example)
        call BLWK_fnc_overrunWave_onWaveInit;
    (end)

Author(s):
    Ansible2
---------------------------------------------------------------------------- */
scriptName "BLWK_fnc_overrunWave_onWaveInit";

// store crate position fro moving AI to surround its former place
localNamespace setVariable [
    "BLWK_overrunWave_playerBasePosition",
    (getPosATL BLWK_mainCrate)
];


// allow players outside the play area
missionNamespace setVariable ["BLWK_enforceArea",false,true];

[
    {
        private _playerSpawnPosition = localNamespace getVariable "BLWK_overrunWave_playerSpawn";
        BLWK_mainCrate setPosATL _playerPosition;

        (call CBAP_fnc_players) apply {
            // don't teleport players in vehicles
            if (isNull (objectParent _x)) then {
                _x setPosATL (
                    [_playerPosition,15,random 360] call CBAP_fnc_randPos
                );
            };
        };
    },
    [],
    2
] call CBAP_fnc_waitAndExecute;

private _startingWaveUnits = call BLWK_fnc_getMustKillList;
[
    {
        params ["_startingWaveUnits"];
     
        private _playerBasePosition = localNamespace getVariable "BLWK_overrunWave_playerBasePosition";
        _startingWaveUnits apply {
            private _teleportPosition = [
                _playerBasePosition,
                50,
                random 360
            ] call CBAP_fnc_randPos;
            
            _x setVehiclePosition [_teleportPosition, [], 1, "NONE"];
        };

        _startingWaveUnits apply {
            [group _x,BLWK_playerBasePosition] call BLWK_fnc_stopStalking
        };
    },
    [_startingWaveUnits],
    5
] call CBAP_fnc_waitAndExecute;


nil
