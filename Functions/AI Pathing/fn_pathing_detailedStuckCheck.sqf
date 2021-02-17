/* ----------------------------------------------------------------------------
Function: BLWK_fnc_pathing_detailedStuckCheck

Description:
	If a units leader was detected as not moving in BLWK_fnc_pathing_checkLeaderVelocity
	 this will do further checks that make sure a unit actually should be teleported
	 to "unstick" them.

	Needs to be run in scheduled environment.

Parameters:
	0: _unit : <OBJECT> - The unit to handle

Returns:
	<BOOL> - true if unit is stuck, false if not

Examples:
    (begin example)

		_needsToBeReset = [_unit] call BLWK_fnc_pathing_detailedStuckCheck;

    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
scriptName "BLWK_fnc_pathing_detailedStuckCheck";

params ["_unit"];

// don't mess with vehicle units
if (!isNull (objectParent _unit)) exitWith {false};

private _currentPosition = getPosWorld _unit;

sleep 20;

// exit if all units are dead
if !([_groupToCheck] call BLWK_fnc_pathing_checkGroupStatus) exitWith {
	[[_groupToCheck," failed secondary group status check..."],false] call KISKA_fnc_log;
	false
}; 

private _needsReset = true;
// if the leader fails the velocity check again
if !([_unit] call BLWK_fnc_pathing_checkLeaderVelocity) then {
	[[_groupToCheck," failed secondary velocity status check..."],false] call KISKA_fnc_log;
	
	// check if there is enough difference in their position to justify not reseting them
	private _positionDifference = (getPosWorld _unit) vectorDiff _currentPosition;
	[["Checking position differences for group ", _groupToCheck,"... Position differences are: ",_positionDifference],false] call KISKA_fnc_log;
	_positionDifference apply {
		// check to make sure there was some significant movement in the unit on any axis
		if ((abs _x) > 0.5) exitWith {
			[[_groupToCheck," found a position axis that passed..."],false] call KISKA_fnc_log;
			_needsReset = false;
		};
	};
} else {
	[[_groupToCheck," had immediate velocity check that passed."],false] call KISKA_fnc_log;
	_needsReset = false;
};


_needsReset