/* ----------------------------------------------------------------------------
Function: BLWK_fnc_pathingLoop

Description:
	AI enemies sometimes get stuck an refuse to move or just rotate while
	 decding how to proceed. Often in urban environments.
	
	During the main loop, if the leader has a velocity of zero, he will then
	 be given 10 seconds to have a meaningful movement on any axis before
	 being teleported to a random spawn location.
	
	Hopefully this resets his pathing.

Parameters:
	0: _groupToCheck : <OBJECT OR GROUP> - The unit or group to add to check over
	1: _timeBetweenChecks : <NUMBER> - How often to check the unit leader's velocity

Returns:
	BOOL

Examples:
    (begin example)

		null = [myGroup,25] spawn BLWK_fnc_pathingLoop;

    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
if (!canSuspend) exitWith {
	"BLWK_fnc_pathingLoop should be run in scheduled environment" call BIS_fnc_error;
};

params [
	["_groupToCheck",objNull,[grpNull,objNull]],
	["_timeBetweenChecks",25,[123]]
];

if (isNull _groupToCheck) exitWith {
	"BLWK_fnc_pathingLoop: null _groupToCheck" call BIS_fnc_error;
};

// follower units won't likely get stuck as their primary goal is to join the formation at all cost
if (_groupToCheck isEqualType objNull) then {
	_groupToCheck = group _groupToCheck;
};

private _groupLeader = leader _groupToCheck;
if (!alive _groupLeader) exitWith {
	["BLWK_fnc_pathingLoop: _groupLeader %1 is dead!",_groupLeader] call BIS_fnc_error;
};


private _groupUnits = units _groupToCheck;
private "_aliveIndex";
private _fn_checkGroupStatus = {
	if (isNull _groupToCheck) exitWith {false};// check if it was deleted

	_groupUnits = units _groupToCheck;
	if (_groupUnits isEqualTo []) exitWith {false};// check if anyone is in it

	_aliveIndex = _groupUnits findIf {alive _x};
	if (_aliveIndex != -1) exitWith {true}; // check if anyone is alive

	false
};

private "_leaderVelocity";
private _fn_leaderVelocityCheck = {
	_groupLeader = leader _groupToCheck; 
	// forward/backward velocity is the most telling of movement
	_leaderVelocity = (velocityModelSpace _groupLeader) select 0;
	
	//diag_log _leaderVelocity;
	
	// if leader is stationary
	if (_leaderVelocity isEqualTo 0) exitWith {false};
	true
};

private ["_currentPosition","_positionDifference","_needsReset"];
private _fn_handleStationaryLeader = {
	// don't mess with vehicle units
	if (!isNull (objectParent _groupLeader)) exitWith {false};

	_currentPosition = getPosWorld _groupLeader;
	
	sleep 20;

	if !(call _fn_checkGroupStatus) exitWith {
		//["%1 failed secondary group status check",_groupToCheck] call BIS_fnc_error;
		false
	}; // exit if all units are dead

	_needsReset = true;
	// if the leader fails the velocity check again
	if !(call _fn_leaderVelocityCheck) then {
		//["%1 failed secondary leader velocity check",_groupToCheck] call BIS_fnc_error;
		
		// check if there is enough difference in their position to justify not reseting them
		_positionDifference = (getPosWorld _groupLeader) vectorDiff _currentPosition;
		_positionDifference apply {
			// check to make sure there was some significant movement in the unit on any axis
			if ((abs _x) > 0.5) exitWith {
				//["%1 found a position axis that passed",_groupToCheck] call BIS_fnc_error;
				_needsReset = false;
			};
		};
	} else {
		_needsReset = false;
	};

	_needsReset
};


#define LOOP_VAR_NAME "BLWK_runPathingLoop"
_groupToCheck setVariable [LOOP_VAR_NAME,true];

while {sleep _timeBetweenChecks; true} do {
	// update unit list and check if they are still up
	
	if (!(isNull _groupToCheck) AND {_groupToCheck getVariable [LOOP_VAR_NAME,false]}) exitWith {};

	if !(call _fn_checkGroupStatus) exitWith {
		//["%1 exited pathing loop because of failed group status",_groupToCheck] call BIS_fnc_error;
		_groupToCheck setVariable [LOOP_VAR_NAME,nil];
	};

	if !(call _fn_leaderVelocityCheck) then {
		//["%1 failed velocity test",_groupToCheck] call BIS_fnc_error;
		
		if (call _fn_handleStationaryLeader) then {
			//["%1 leader reset",_groupToCheck] call BIS_fnc_error;
			//_groupLeader setPos (selectRandom BLWK_infantrySpawnPositions);
			_groupLeader setPos ([BLWK_mainCrate, 75, 125, 2, 0] call BIS_fnc_findSafePos);
			sleep 1;
			[_groupLeader,position BLWK_mainCrate] remoteExecCall ["move",_groupLeader];
		};
	};
};