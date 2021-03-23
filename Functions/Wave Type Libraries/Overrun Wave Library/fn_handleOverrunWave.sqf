/* ----------------------------------------------------------------------------
Function: BLWK_fnc_handleOverrunWave

Description:
	This is simply an alias for the below functions. It is used to exec
	 both on whomever the AI handler is without using multiple remoteExecs

	Executed from "BLWK_fnc_decideWaveType"

Parameters:
	NONE

Returns:
	NOTHING

Examples:
    (begin example)
		call BLWK_fnc_handleOverrunWave;
    (end)

Author(s):
	Ansible2 // Cipher


	- units are spawned in at crate position before players are teleported
	- Stalker system for enemies has not initialized before the are told to stop stalking
---------------------------------------------------------------------------- */
private _canDoWave = call BLWK_fnc_overrunTheCrateWave;
private _startingWaveUnits = call BLWK_fnc_createStdWaveInfantry;

if !(_canDoWave) exitWith {};


[_startingWaveUnits] spawn {
	params ["_startingWaveUnits"];

	waitUntil {missionNamespace getVariable ["BLWK_baseIsClear",false]};
	
	private "_positionTemp";
	_startingWaveUnits apply {
		_positionTemp = [BLWK_playerBasePosition,50,random 360] call CBAP_fnc_randPos;
		_x setVehiclePosition [_positionTemp, [], 1, "NONE"];
	};

	_startingWaveUnits apply {
		waitUntil {
			sleep 0.05;
			[group _x,BLWK_playerBasePosition] call BLWK_fnc_stopStalking
		};
	};
};


nil