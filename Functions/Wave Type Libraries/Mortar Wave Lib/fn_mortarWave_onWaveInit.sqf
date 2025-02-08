/* ----------------------------------------------------------------------------
Function: BLWK_fnc_mortarWave_onWaveInit

Description:
       

Parameters:
    NONE

Returns:
    NOTHING

Examples:
    (begin example)
        call BLWK_fnc_mortarWave_onWaveInit;
    (end)

Author(s):
    Ansible2
---------------------------------------------------------------------------- */
scriptName "BLWK_fnc_mortarWave_onWaveInit";

#define MORTAR_CLASS "O_Mortar_01_F"


private _spawnPosition = [
    BLWK_playAreaCenter, 
    BLWK_playAreaRadius - 15, 
    BLWK_playAreaRadius - 5, 
    3, 
    0, 
    10
] call BIS_fnc_findSafePos;
private _mortarTube = MORTAR_CLASS createVehicle _spawnPosition;

private _startingWaveUnits = call BLWK_fnc_getMustKillList;
private _mortarMan = _startingWaveUnits select 0;
private _mortarGroup = createGroup [OPFOR,true];
[_mortarMan] joinSilent _mortarGroup;

_mortarMan moveInGunner _mortarTube;
[BLWK_zeus,[[_mortarTube],true]] remoteExec ["addCuratorEditableObjects",2];

[_mortarMan,_mortarTube] spawn {
    params ["_mortarMan","_mortarTube"];

    // give players a bit of time before starting
    sleep 20;

    private _ammo = getArtilleryAmmo [_mortarTube] select 0;
    private _doFire = true; 
    while {_doFire} do {
        private _fireAtPosition = [
            BLWK_mainCrate,
            (random 45),
            (random 360)
        ] call CBAP_fnc_randPos;
        _mortarTube doArtilleryFire [_fireAtPosition,_ammo,1];

        sleep (random [15,20,25]);

        if (!alive _mortarMan) exitWith {
            deleteVehicle _mortarTube;
            _doFire = false;
        };
    };
};


nil
