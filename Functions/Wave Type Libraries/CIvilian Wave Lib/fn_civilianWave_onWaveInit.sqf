/* ----------------------------------------------------------------------------
Function: BLWK_fnc_civilianWave_onWaveInit

Description:
    The on wave init for a civilian wave.

Parameters:
    NONE

Returns:
    NOTHING

Examples:
    (begin example)
        call BLWK_fnc_civilianWave_onWaveInit;
    (end)

Author(s):
    Ansible2
---------------------------------------------------------------------------- */
scriptName "BLWK_fnc_civilianWave_onWaveInit";

if (!isServer) exitWith {};

#define NUM_CIVILIANS 12
#define CIVILIAN_CLASS "C_man_1"

private _civilians = [];
for "_i" from 1 to NUM_CIVILIANS do {
    private _randomBuilding = selectRandom BLWK_playAreaBuildings;
    private _spawnPosition = selectRandom (_randomBuilding buildingPos -1);

    private _group = createGroup [civilian,true];
    private _unit = _group createUnit [CIVILIAN_CLASS, _spawnPosition, [], 0.5, "NONE"];

    [_unit] call BLWK_fnc_civilianWave_randomGear; 


    _unit addEventHandler ["KILLED",{
        params ["_killedUnit", "", "_instigator"];

        if (!(isNull _instigator) AND {isPlayer _instigator}) then {
            // show a player hit points and add them to there score
            [_killedUnit] remoteExecCall ["BLWK_fnc_civilianWave_onCivilianKilled",_instigator];
        };
    }];


    // make civilians run around
    [_group,BLWK_playAreaCenter,BLWK_playAreaRadius,3] call CBAP_fnc_taskPatrol;

    _unit allowFleeing 0;
    _unit setBehaviour "CARELESS";

    _civilians pushBack _unit;
};

// for deleteing cvilians at wave end
localNamespace setVariable ["BLWK_civilianWave_civilians",_civilians];

[BLWK_zeus,[_civilians, true]] remoteExecCall ["addCuratorEditableObjects",2];


nil
