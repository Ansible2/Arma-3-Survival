/* ----------------------------------------------------------------------------
Function: BLWK_fnc_suicideBomberLoop

Description:
	Starts the loop that checks a bombers surroundings to see if they should explode.
	Also plays their weird audio.

	Executed from "BLWK_fnc_createSuicideWave"

Parameters:
	NONE

Returns:
	NOTHING

Examples:
    (begin example)

		null = [myBomber] spawn BLWK_fnc_suicideBomberLoop;

    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
if (!canSuspend) exitWith {};

params ["_bomber"];

private ["_players","_nearPlayer"];
private _bomberDistanceToBlow = random [10,15,20];
while {alive _bomber} do {
	_players = call CBAP_fnc_players;
	
	[_bomber,["suicideSound",70]] remoteExec ["say3D",_players];
	
	_nearPlayer = _players findIf {(_bomber distance2D _x) <= _bomberDistanceToBlow};
	
	if (!(_nearPlayer isEqualTo -1) OR {_bomber distance2D BLWK_mainCrate <= 10}) exitWith {
		[_bomber] call BLWK_fnc_explodeSuicideBomberEvent;
	};

	sleep 3;
};	