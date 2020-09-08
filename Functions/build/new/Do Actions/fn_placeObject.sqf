/* ----------------------------------------------------------------------------
Function: BLWK_fnc_placeObject

Description:
	Either snaps object to surface or places it floating

	Executed from ""

Parameters:
	0: _object : <OBJECT> - The object to place
	1: _player : <OBJECT> - The person who picked up the object
	2: _snapToSurface : <BOOL> - Should the object snap to the nearest surface

Returns:
	BOOL

Examples:
    (begin example)

		[myObject,player] call BLWK_fnc_placeObject;

    (end)

Author:
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
params [
	"_object",
	"_player",
	["_snapToSurface",false,[true]]
];

detach _object;

private _objectPositionATL = getPosATL _object;
if (_snapToSurface) then {
	private _ATLBeneathObject = _objectPositionATL vectorDiff [0,0,_objectPositionATL select 2];

	private _closestIntersect = (lineIntersectsSurfaces [ATLToASL _objectPositionATL,ATLToASL _ATLBeneathObjectm,_object]) select 0;
	_closestIntersect params ["_intersectPosASL","_intersectPosSurfaceNormal"];

	_object setPosASL _intersectPosASL;
	[_object,_intersectPosSurfaceNormal] remoteExecCall ["setVectorUp",_object];
} else {

};

[_object] remoteExecCall ["BLWK_fnc_enableCollisionWithPlayer",BLWK_allPlayersTargetID,_object];

true