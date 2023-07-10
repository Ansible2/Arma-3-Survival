/* ----------------------------------------------------------------------------
Function: BLWK_fnc_suicideWave_onWaveInit

Description:
    The on wave init for suicide waves.

Parameters:
    NONE

Returns:
    NOTHING

Examples:
    (begin example)
        call BLWK_fnc_suicideWave_onWaveInit;
    (end)

Author(s):
	Hilltop(Willtop) & omNomios,
	Modified by: Ansible2
---------------------------------------------------------------------------- */
scriptName "BLWK_fnc_suicideWave_onWaveInit";

#define VEST_CHARGE "DemoCharge_Remote_Ammo"

private _startingWaveUnits = call BLWK_fnc_getMustKillList;
private _numberOfBombers = round (count _startingWaveUnits / 4);
private _bombers = _startingWaveUnits select [0,_numberOfBombers];

_bombers apply {
    private _unit = _unit;
    private _unitGroup = group _unit;
    
    _unitGroup setBehaviour "CARELESS";
    
    private _owner = groupOwner _unitGroup;
    [_unitGroup,(getPosATL BLWK_mainCrate)] remoteExec ["move", _owner];
    [_unitGroup,"full"] remoteExec ["setSpeedMode", _owner];

    removeAllWeapons _unit;
    removeHeadgear _unit;
    removeVest _unit;
    _unit addVest "V_HarnessOGL_brn";
    _unit addHeadgear "H_ShemagOpen_khk";

    private _unitPosition = position _unit;
    private _bombs = [
        [
            [-0.1, 0.1, 0.15],
            [ [0.5, 0.5, 0], [-0.5, 0.5, 0] ]
        ],
        [
            [0.1, 0.1, 0.15],,
            [ [0.5, -0.5, 0], [0.5, 0.5, 0] ]
        ],
        [
            [0, 0.15, 0.15],
            [ [1, 0, 0], [0, 1, 0] ]
        ]
    ] apply {
        _x params ["_attachmentPoint","_vectorDirAndUp"];

        private _explosive = VEST_CHARGE createVehicle _unitPosition;
        _explosive attachTo [_unit, _attachmentPoint, "Pelvis"];
        _explosive setVectorDirAndUp _vectorDirAndUp;

        _explosive
    };
	_unit setVariable ["BLWK_suicideBombs",_bombs];


    _unit addEventHandler ["KILLED",{
		params ["_bomber"];
        [_bomber] call BLWK_fnc_suicideWave_explodeBomber;
	}];

	_unit addEventHandler ["Deleted", {
        params ["_unit"];

		(_unit getVariable ["BLWK_suicideBombs",[]]) apply {
			deleteVehicle _unit;
		};
	}];


    [_unit] spawn BLWK_fnc_suicideWave_bomberLoop;
};


nil
