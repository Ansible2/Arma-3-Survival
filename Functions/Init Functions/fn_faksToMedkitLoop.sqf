/* ----------------------------------------------------------------------------
Function: BLWK_fnc_faksToMedkitLoop

Description:
	Loops while players are looking at the bulwark's inventory 
	 to see if a medkit should be made out of 15 first aid kits

	Executed from players with a ContainerOpened event 
	 in the "BLWK_fnc_prepareBulwarkPlayer"

Parameters:
	NONE

Returns:
	NOTHING

Examples:
    (begin example)

		null = [] spawn BLWK_fnc_faksToMedkitLoop;

    (end)

Author:
	Hilltop & omNomios,
	Modified by: Ansible2 // Cipher
---------------------------------------------------------------------------- */
if (!isServer) exitWith {};

// check if the loop was already started
if (missionNamespace getVariable ["BLWK_faksToMedkitLooprunning",false]) exitWith {};

BLWK_faksToMedkitLooprunning = false;

private ["_players","_return"];
private _fn_someoneLookingInBulwark = {
	_players = call CBAP_fnc_players;
	_return = _players findIf {_x getVariable ["BLWK_lookingInBulwark",false]};

	if (_return isEqualTo -1) then {
		false
	} else {
		true
	};
};

private ["_bulwarkItems","_numberOfFAKs"];
while {(call _fn_someoneLookingInBulwark) AND {!BLWK_dontUseRevive}} do {
	_bulwarkItems = itemCargo bulwarkBox;
	_numberOfFAKs = count (_bulwarkItems select {_x == "FirstAidKit"});
	
	if (_numberOfFAKs >= BLWK_faksToMakeMedkit) then {
		
		private _subtractArray = [];
		for "_i" from 1 to BLWK_faksToMakeMedkit do {
			_subtractArray pushBack "FirstAidKit";
		};

		_bulwarkItems = _bulwarkItems - _subtractArray;

		clearItemCargoGlobal  bulwarkBox;
		_bulwarkItems apply {
			bulwarkBox addItemCargoGlobal [_x,1];
		};	
		bulwarkBox addItemCargoGlobal ["Medikit", 1];
	};

	sleep 2;
};

BLWK_faksToMedkitLooprunning = false;