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
params ["_unitsToWorkWith"];

private _numberOfBombers = round (count _unitsToWorkWith / 4);
private _bombersArray = _unitsToWorkWith select [0,_numberOfBombers];

private "_unitGroupTemp";
private "_eventIdTemp";
_bombersArray apply {
	_unitGroupTemp = group _x;
	[_unitGroupTemp] call CBAP_fnc_clearWaypoints;
	[_unitGroupTemp, BLWK_mainCrate, 5, "MOVE", "CARELESS"] call CBAP_fnc_addWaypoint;

	removeAllWeapons _x;

	// CIPHER COMMENT: consider trying local eventhandler
	_eventIdTemp = _x addMPEventHandler ["MPKilled",{
		[_this Select 0,_thisEventHandler] call BLWK_fnc_explodeSuicideBomberEvent;
	}];

	_x setVariable ["BLWK_suicideBomberEventID",_eventIdTemp];

	null = [_x] spawn BLWK_fnc_suicideBomberLoop;
};