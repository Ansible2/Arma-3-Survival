/* ----------------------------------------------------------------------------
Function: BLWK_fnc_placeObject

Description:
	Either snaps object to surface or places it floating

	Executed from "BLWK_fnc_addPickedUpObjectActions" and
		"BLWK_fnc_pickUpObject" (in the event that the player is downed)

Parameters:
	0: _object : <OBJECT> - The object to place
	1: _snapToSurface : <BOOL> - Should the object snap to the nearest surface

Returns:
	BOOL

Examples:
    (begin example)

		[myObject] call BLWK_fnc_placeObject;

    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
params [
	["_object",missionNamespace getVariable ["BLWK_heldObject",objNull],[objNull]],
	["_snapToSurface",false,[true]]
];

if (isNull _object) exitWith {false};

detach _object;

if (_snapToSurface) then {
	private _objectPositionATL = getPosATL _object;
	private _ATLBeneathObject = _objectPositionATL vectorDiff [0,0,_objectPositionATL select 2];
	private _ASLBeneathObject = ATLToASL _ATLBeneathObject;

	private _closestIntersect = (lineIntersectsSurfaces [ATLToASL _objectPositionATL,_ASLBeneathObject,_object]) select 0;
	// if there is just terrain below
	if (isNil "_closestIntersect") then {
		_closestIntersect = [_ASLBeneathObject,surfaceNormal _ATLBeneathObject]
	};
	_closestIntersect params ["_intersectPosASL","_intersectPosSurfaceNormal"];

	_object setPosASL _intersectPosASL;
	[_object,_intersectPosSurfaceNormal] remoteExecCall ["setVectorUp",_object];

	// enable object physics 
	[_object,true] remoteExecCall ["enableSimulationGlobal",2];
};

// sync collision to all players
null = [_object] remoteExec ["BLWK_fnc_enableCollisionWithAllPlayers",_object];

// make sure people can manipulate up the object now
missionNamespace setVariable ["BLWK_heldObject",nil];
_object setVariable ["BLWK_objectPickedUp",false,true];

// remove the actions tied to the player
call BLWK_fnc_removePickedUpObjectActions;

true