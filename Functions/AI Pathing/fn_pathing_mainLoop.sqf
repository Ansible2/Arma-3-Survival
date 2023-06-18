#include "..\..\Headers\Stalker Global Strings.hpp"
/* ----------------------------------------------------------------------------
Function: BLWK_fnc_pathing_mainLoop

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
	NOTHING

Examples:
    (begin example)
		[myGroup,25] spawn BLWK_fnc_pathing_mainLoop;
    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
// telling the unit to go to their stalked player seems to cause
// the issue of AI getting stuck too, hence why they go to the crate

#define RESET_POSITION \
	[["Reset ", _groupLeader],false] call KISKA_fnc_log; \
	[_groupLeader,[BLWK_mainCrate, 5] call CBA_fnc_randPos] remoteExecCall ["move",_groupLeader]; \


#define LOOP_VAR_NAME "BLWK_runPathingLoop"
scriptName "BLWK_fnc_pathing_mainLoop";


if (!canSuspend) exitWith {
	["Should be run in scheduled environment, exiting to scheduled...",true] call KISKA_fnc_log;
	_this spawn BLWK_fnc_pathing_mainLoop;
};

params [
	["_groupToCheck",objNull,[grpNull,objNull]],
	["_timeBetweenChecks",25,[123]]
];


if (isNull _groupToCheck) exitWith {
	["_groupToCheck is null. Exiting...",true] call KISKA_fnc_log;
	nil
};

// follower units won't likely get stuck as their primary goal is to join the formation at all cost
if (_groupToCheck isEqualType objNull) then {
	_groupToCheck = group _groupToCheck;
};


_groupToCheck setVariable [LOOP_VAR_NAME,true];
while {sleep _timeBetweenChecks; true} do {

	if (
		!(isNull _groupToCheck) AND
		{ !(_groupToCheck getVariable [LOOP_VAR_NAME,false]) }

	) then {
		[["Loop var for group ",_groupToCheck," was set to false. Exiting..."],false] call KISKA_fnc_log;

		break;
	};


	if !([_groupToCheck] call BLWK_fnc_pathing_isGroupAlive) then {
		[["Found that ",_groupToCheck," failed group alive check. Exiting..."],false] call KISKA_fnc_log;
		_groupToCheck setVariable [LOOP_VAR_NAME,nil];

		break;
	};


	_groupLeader = leader _groupToCheck;
	// checks for units that walk away from play area
	if (
		!(_groupLeader getVariable ["BLWK_isACEUnconscious",true]) AND
		{isNull (objectParent _groupLeader)} AND
		{ (_groupLeader distance2D BLWK_playAreaCenter) >= BLWK_maxDistanceFromPlayArea }

	) then {
		[["_groupLeader ",_groupLeader," appears to have walked too far from the play area and will be reset"],true] call KISKA_fnc_log;
		RESET_POSITION

	} else {
		if !([_groupLeader] call BLWK_fnc_pathing_checkLeaderVelocity) then {
			[["_groupLeader ",_groupLeader," failed velocity check at point 1"],false] call KISKA_fnc_log;

			if ([_groupToCheck] call BLWK_fnc_pathing_detailedStuckCheck) then {
				[["_groupLeader ",_groupLeader," failed detailted stuck check at point 1"],false] call KISKA_fnc_log;
				RESET_POSITION

			};
		};
	};
};


nil
