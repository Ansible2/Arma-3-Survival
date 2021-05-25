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
	[_unitGroupTemp] call CBAP_fnc_clearWaypoints;
	[_unitGroupTemp, BLWK_mainCrate, 5, "MOVE", "CARELESS"] call CBAP_fnc_addWaypoint;

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

	[_x] spawn BLWK_fnc_suicideBomberLoop;
};
