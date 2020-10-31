/* ----------------------------------------------------------------------------
Function: BLWK_fnc_startPathingLoop

Description:
	AI enemies sometimes get stuck an refuse to move.
	
	This loop takes units added to the array and resets there position to
	 another spawn point if they are static for 25 seconds.

Parameters:
	NONE

Returns:
	NOTHING

Examples:
    (begin example)

		null = [] spawn BLWK_fnc_startPathingLoop;

    (end)

Author:
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
#include "..\..\Headers\Pathing Global Strings.hpp"

if (!local BLWK_theAiHandlerEntity OR {!canSuspend}) exitWith {};

private ["_arrayToCheck","_savedPosition_temp","_currentPosition_temp","_newSpawnPosition_temp","_unitToCheck_temp"];
BLWK_runPathingLoop = true;


while {sleep 25; BLWK_runPathingLoop} do {
	_arrayToCheck = call BLWK_fnc_getPathingArray;

	if !(_arrayToCheck isEqualTo []) then {

		_arrayToCheck apply {
			// need an object to use getPos on
			if (_x isEqualType grpNull) then {
				_unitToCheck_temp = leader _x;
			} else {
				_unitToCheck_temp = _x;
			};

			_currentPosition_temp = getPosWorld _unitToCheck_temp;
			_savedPosition_temp = _x getVariable [SAVED_UNIT_POSITION_VAR,[]];
			if (_savedPosition_temp isEqualTo []) then {// save current position if one does not exist
				_x setVariable [SAVED_UNIT_POSITION_VAR,_currentPosition_temp];
			} else {
				if (_currentPosition_temp isEqualTo _savedPosition_temp) then { // if still in same position, then put them a spawn point
					if (alive _unitToCheck_temp) then {
						hint "adjusted a unit position";
						_newSpawnPosition_temp = selectRandom BLWK_infantrySpawnPositions;
						_x setVariable [SAVED_UNIT_POSITION_VAR,_newSpawnPosition_temp];
					} else {
						[_x] call BLWK_fnc_removeFromPathingLoop; // remove if unit/group is dead
					};
				} else { // else save new position if it's not the same
					_x setVariable [SAVED_UNIT_POSITION_VAR,_currentPosition_temp]; // save
				};
			};

			sleep 0.5;
		};
	};
};