params ["_startingEnemyUnits"];

private "_positionTemp";
_startingEnemyUnits apply {
	_positionTemp = [bulwarkBox,50,random 360] call CBAP_fnc_randPos;
	_x setVehiclePosition [_positionTemp, [], 1, "NONE"];
};