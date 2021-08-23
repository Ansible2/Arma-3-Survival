/* ----------------------------------------------------------------------------
Function: BLWK_fnc_pathing_detailedStuckCheck

Description:
	If a units leader was detected as not moving in BLWK_fnc_pathing_checkLeaderVelocity
	 this will do further checks that make sure a unit actually should be teleported
	 to "unstick" them.

	Needs to be run in scheduled environment.

Parameters:
	0: _group : <GROUP> - The group to check

Returns:
	<BOOL> - true if unit is stuck, false if not

Examples:
    (begin example)
		_needsToBeReset = [_groupLeader] call BLWK_fnc_pathing_detailedStuckCheck;
    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
scriptName "BLWK_fnc_pathing_detailedStuckCheck";

params ["_group"];


private _groupLeader = leader _group;
// don't mess with vehicle units
if (!isNull (objectParent _groupLeader)) exitWith {false};

private _currentPosition = getPosWorld _groupLeader;
private _ammoOfLeader = _groupLeader ammo (currentMuzzle _groupLeader);


sleep 5;


// Check if leader was engaging targets
if (_groupLeader ammo (currentMuzzle _groupLeader) < _ammoOfLeader) exitWith {
	[["Leader of group: ", _group, " appears to be firing at something; doesn't need reset..."],false] call KISKA_fnc_log;
	false;
};


// exit if all units are dead
if !([_group] call BLWK_fnc_pathing_isGroupAlive) exitWith {
	[[_group," failed secondary group status check..."],false] call KISKA_fnc_log;
	false
};

private _needsReset = true;
// if the leader fails the velocity check again
if !([_groupLeader] call BLWK_fnc_pathing_checkLeaderVelocity) then {
	[[_group," failed secondary velocity status check..."],false] call KISKA_fnc_log;

	// check if there is enough difference in their position to justify not reseting them
	private _positionDifference = (getPosWorld _groupLeader) vectorDiff _currentPosition;
	[["Checking position differences for group ", _group,"... Position differences are: ",_positionDifference],false] call KISKA_fnc_log;
	_positionDifference apply {
		// check to make sure there was some significant movement in the unit on any axis
		if ((abs _x) > 0.5) then {
			[[_group," found a position axis that passed..."],false] call KISKA_fnc_log;
			_needsReset = false;
			break;
		};
	};

} else {
	[[_group," had immediate velocity check that passed."],false] call KISKA_fnc_log;
	_needsReset = false;

};


_needsReset
