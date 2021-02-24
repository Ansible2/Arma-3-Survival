/* ----------------------------------------------------------------------------
Function: BLWK_fnc_faksToMedkitLoop

Description:
	Loops while players are looking at the The Crate's inventory 
	 to see if a medkit should be made out of 15 first aid kits

	Executed from players with a ContainerOpened event 
	 in the "BLWK_fnc_prepareTheCratePlayer"

Parameters:
	NONE

Returns:
	NOTHING

Examples:
    (begin example)

		[] spawn BLWK_fnc_faksToMedkitLoop;

    (end)

Author(s):
	Hilltop(Willtop) & omNomios,
	Modified by: Ansible2 // Cipher
---------------------------------------------------------------------------- */
#define SCRIPT_NAME "BLWK_fnc_faksToMedkitLoop"
scriptName SCRIPT_NAME;

if (!isServer) exitWith {};

/*
if (BLWK_dontUseRevive) exitWith {
	["Revive is disabled, exiting..."] call KISKA_fnc_log;
};
*/

// check if the loop was already started
if (missionNamespace getVariable ["BLWK_faksToMedkitLooprunning",false]) exitWith {
	["Loop was already started (queried) by another player",false] call KISKA_fnc_log;
};

// set to true so that loop does not start again
missionNamespace setVariable ["BLWK_faksToMedkitLooprunning",true];

private ["_players","_return"];
private _fn_someoneLookingInTheCrate = {
	_players = call CBAP_fnc_players;
	_return = _players findIf {_x getVariable ["BLWK_lookingInTheCrate",false]};

	if (_return isEqualTo -1) then {
		false
	} else {
		true
	};
};

private ["_theCrateItems","_numberOfFAKs"];
while {sleep 2; (call _fn_someoneLookingInTheCrate) /*AND {!BLWK_dontUseRevive}*/} do {
	// get a list of every item in The Crate
	_theCrateItems = itemCargo BLWK_mainCrate;
	_numberOfFAKs = count (_theCrateItems select {_x == "FirstAidKit"});
	
	// if we have enough FAKs to make a medkit
	if (_numberOfFAKs >= BLWK_faksToMakeMedkit) then {
		
		// create an array to modify the every-item-in-The-Crate array
		private _subtractArray = [];
		for "_i" from 1 to BLWK_faksToMakeMedkit do {
			_subtractArray pushBack "FirstAidKit";
		};

		// subtract all the FAKs it would take to make a medkit
		_theCrateItems = _theCrateItems - _subtractArray;
		
		// clear the whole item inventory of The Crate
		clearItemCargoGlobal  BLWK_mainCrate;
		// add back all the items minus the FAKs we needed for the medkit
		_theCrateItems apply {
			BLWK_mainCrate addItemCargoGlobal [_x,1];
		};	
		BLWK_mainCrate addItemCargoGlobal ["Medikit", 1];
	};
};

// set to false so that loop can start again
missionNamespace setVariable ["BLWK_faksToMedkitLooprunning",false];