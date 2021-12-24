/* ----------------------------------------------------------------------------
Function: BLWK_fnc_createSuicideWave

Description:
	creates the suicide bombers and sends them towards The Crate

	Executed from "BLWK_fnc_handleSuicideWave"

Parameters:
	0: _unitsToWorkWith : <ARRAY> - Units to potentially turn into bombers

Returns:
	NOTHING

Examples:
    (begin example)

		[unitsArray] call BLWK_fnc_createSuicideWave;

    (end)

Author(s):
	Hilltop(Willtop) & omNomios,
	Modified by: Ansible2 // Cipher
---------------------------------------------------------------------------- */
#define VEST_CHARGE "DemoCharge_Remote_Ammo"

params ["_unitsToWorkWith"];

private _numberOfBombers = round (count _unitsToWorkWith / 4);
private _bombersArray = _unitsToWorkWith select [0,_numberOfBombers];

private "_unitGroupTemp";
_bombersArray apply {
	_unitGroupTemp = group _x;
	_unitGroupTemp setBehaviour "CARELESS";
	[_unitGroupTemp,(getPosATL BLWK_mainCrate)] remoteExec ["move", groupOwner _unitGroupTemp];
	[_unitGroupTemp,"full"] remoteExec ["setSpeedMode",groupOwner _unitGroupTemp];

	removeAllWeapons _x;

	// added suicide uniform by KillZoneKid
	removeHeadgear _x;
	removeVest _x;
	_x addVest "V_HarnessOGL_brn";
	_x addHeadgear "H_ShemagOpen_khk";

	private _unitPosition = position _x;

	private _expl1 = VEST_CHARGE createVehicle _unitPosition;
	_expl1 attachTo [_x, [-0.1, 0.1, 0.15], "Pelvis"];
	_expl1 setVectorDirAndUp [ [0.5, 0.5, 0], [-0.5, 0.5, 0] ];

	private _expl2 = VEST_CHARGE createVehicle _unitPosition;
	_expl2 attachTo [_x, [0, 0.15, 0.15], "Pelvis"];
	_expl2 setVectorDirAndUp [ [1, 0, 0], [0, 1, 0] ];

	private _expl3 = VEST_CHARGE createVehicle _unitPosition;
	_expl3 attachTo [_x, [0.1, 0.1, 0.15], "Pelvis"];
	_expl3 setVectorDirAndUp [ [0.5, -0.5, 0], [0.5, 0.5, 0] ];
	// end suicide uniform

	_x addEventHandler ["KILLED",{
		[_this select 0] call BLWK_fnc_explodeSuicideBomberEvent;
	}];

	_x setVariable ["BLWK_suicideBombs",[_expl1,_expl2,_expl3]];
	_x addEventHandler ["Deleted", {
		((_this select 0) getVariable ["BLWK_suicideBombs",[]]) apply {
			deleteVehicle _x;
		};
	}];

	[_x] spawn BLWK_fnc_suicideBomberLoop;
};
