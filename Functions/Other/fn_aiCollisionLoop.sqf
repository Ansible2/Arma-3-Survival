/* ----------------------------------------------------------------------------
Function: BLWK_fnc_aiCollisionLoop

Description:
	Used to keep the AI from attempting to walk through a placed object.

	Units on roads sometimes follow predetermined paths that can have them walk
	 through objects a user places down.

Parameters:
	0: _unit : <OBJECT> - The unit to run the loop on

Returns:
	NOTHING

Examples:
    (begin example)

		null = [myUnit] spawn BLWK_fnc_aiCollisionLoop;

    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
if (!BLWK_doDetectCollision) exitWith {};

if (!canSuspend) exitWith {
	"BLWK_fnc_aiCollisionLoop: should be run in scheduled environment" call BIS_fnc_error;
	null = _this spawn BLWK_fnc_aiCollisionLoop;
};

params ["_unit"];

sleep 5;

private ["_objects","_position","_index","_moveToPosition"];
while {BLWK_doDetectCollision AND {alive _unit}} do {
	sleep 0.1;

	// don't run while a unit is in a vehicle
	if (isNull (objectParent _unit)) then {
		_position = getposASL _unit;
		_objects = lineIntersectsObjs [_position,AGLToASL (_unit getRelPos [1,0]), objNull, _unit, false, 4];
		
		if !(_objects isEqualTo []) then {

			// check if any encountered object is a built one
			_index = _objects findIf {_x getVariable ["BLWK_collisionObject",false]};
			if (_index != -1) then {
				_moveToPosition = (_unit getRelPos [20,180]);
				// push the unit back from the object
				_unit setPosATL (_unit getRelPos [2,180]);

				waitUntil {
					// tell the unit to move away
					_unit move _moveToPosition;
					sleep 0.25;
					if (_unit distance2D _moveToPosition < 5 OR {!alive _unit}) exitWith {true};
					false
				};
			};
		};
	};
};