/* ----------------------------------------------------------------------------
Function: BLWK_fnc_pathing_collisionLoop

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

		[myUnit] spawn BLWK_fnc_pathing_collisionLoop;

    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
scriptName "BLWK_fnc_pathing_collisionLoop";

if (!BLWK_doDetectCollision) exitWith {
	["BLWK_doDetectCollision is set to be false, exiting...",false] call KISKA_fnc_log;
};

if (!canSuspend) exitWith {
	["Needs to be run in scheduled, exting to run in scheduled",true] call KISKA_fnc_log;
	_this spawn BLWK_fnc_pathing_collisionLoop;
};

params ["_unit"];

sleep 5;

if (isNull _unit) exitWith {};
private _unitGroup = group _unit;

private ["_objects","_position","_index","_moveToPosition"];
while {BLWK_doDetectCollision AND {alive _unit}} do {
	sleep 0.1;

	// don't run while a unit is in a vehicle
	if (isNull (objectParent _unit)) then {
		_position = getposASL _unit;
		_objects = lineIntersectsObjs [_position,AGLToASL (_unit getRelPos [1,0]), objNull, _unit, false, 4];
		
		if (_objects isNotEqualTo []) then {

			// check if any encountered object is a built one
			_index = _objects findIf {
				!(isNull _x) AND 
				{_x getVariable ["BLWK_collisionObject",false]}
			};
			
			if (_index != -1) then {
				private _collisionObject = _objects select _index;
				_moveToPosition = (_unit getRelPos [20,180]);
				// push the unit back from the object
				_unit setPosATL (_unit getRelPos [2,180]);
				
				_unitGroup setCombatMode "BLUE";
				_unitGroup setBehaviour "SAFE";
				_unit disableAI "TARGET";
				_unit disableAI "AUTOTARGET";
				//_unit disableAI "AUTOCOMBAT";
				
				[group _unit] call CBAP_fnc_clearWaypoints;
			/*	
				waitUntil {
					if (unitReady _unit) exitWith {true};
					sleep 0.5;
					false
				};
			*/
				//_unit move _moveToPosition;

				waitUntil {
					if (isNull _unit OR {!alive _unit}) exitWith {true};
					if (_unit distance2D _collisionObject >= 10) exitWith {true};
					// tell the unit to move away
					_unit move _moveToPosition;
					sleep 0.1;
					false
				};

				// return unit state
				if (!isNull _unit AND {alive _unit}) then {
					_unitGroup setCombatMode "YELLOW";
					_unitGroup setBehaviour "AWARE";	
					_unit enableAI "TARGET";
					_unit enableAI "AUTOTARGET";
					//_unit enableAI "AUTOCOMBAT";
				};
			};
		};
	};
};


// FSM testing
/*
private ["_objects","_position","_index","_moveToPosition"];
while {BLWK_doDetectCollision AND {alive _unit}} do {
	sleep 0.1;

	// don't run while a unit is in a vehicle
	if (isNull (objectParent _unit)) then {
		_position = getposASL _unit;
		_objects = lineIntersectsObjs [_position,AGLToASL (_unit getRelPos [1,0]), objNull, _unit, false, 4];
		
		if !(_objects isEqualTo []) then {

			// check if any encountered object is a built one
			_index = _objects findIf {!(isNull _x) AND {_x getVariable ["BLWK_collisionObject",false]}};
			if (_index != -1) then {
				private _collisionObject = _objects select _index;
				_moveToPosition = (_unit getRelPos [20,180]);
				// push the unit back from the object
				_unit setPosATL (_unit getRelPos [2,180]);

				private _fsmHandle = [_unit,_moveToPosition,_collisionObject] execFSM "Functions\Other\testFSM.fsm";

				waitUntil {
					if (isNull _unit OR {completedFSM _fsmHandle}) exitWith {
						diag_log "exited wait loop";
						true
					};
					sleep 1;
					false
				};
			};
		};
	};
};
*/