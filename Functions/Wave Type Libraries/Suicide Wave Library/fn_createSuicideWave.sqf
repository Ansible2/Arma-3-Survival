params ["_unitsToWorkWith"];

private _numberOfBombers = round (count _unitsToWorkWith / 4);
private _bombersArray = _unitsToWorkWith select [0,_numberOfBombers];

private "_unitGroupTemp";
private "_eventIdTemp";
_bombersArray apply {
	_unitGroupTemp = group _x;
	[_unitGroupTemp] call CBAP_fnc_clearWaypoints;
	[_unitGroupTemp, bulwarkBox, 5, "MOVE", "CARELESS"] call CBAP_fnc_addWaypoint;

	// CIPHER COMMENT: consider trying local eventhandler
	_eventIdTemp = _x addMPEventHandler ["MPKILLED",{
		[_this Select 0,_thisEventHandler] call BLWK_fnc_explodeSuicideBomberEvent;
	}];

	_x setVariable ["BLWK_suicideBomberEventID",_eventIdTemp];

	null = [_x] spawn BLWK_fnc_suicideBomberLoop;
};