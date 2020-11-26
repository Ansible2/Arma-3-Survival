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

		null = [] spawn BLWK_fnc_faksToMedkitLoop;

    (end)

Author(s):
	Hilltop(Willtop) & omNomios,
	Modified by: Ansible2 // Cipher
---------------------------------------------------------------------------- */
if (!isServer) exitWith {};

if (BLWK_dontUseRevive) exitWith {};

// check if the loop was already started
if (missionNamespace getVariable ["BLWK_faksToMedkitLooprunning",false]) exitWith {};

BLWK_faksToMedkitLooprunning = false;

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
while {sleep 2; (call _fn_someoneLookingInTheCrate) AND {!BLWK_dontUseRevive}} do {
	_theCrateItems = itemCargo BLWK_mainCrate;
	_numberOfFAKs = count (_theCrateItems select {_x == "FirstAidKit"});
	
	if (_numberOfFAKs >= BLWK_faksToMakeMedkit) then {
		
		private _subtractArray = [];
		for "_i" from 1 to BLWK_faksToMakeMedkit do {
			_subtractArray pushBack "FirstAidKit";
		};

		_theCrateItems = _theCrateItems - _subtractArray;

		clearItemCargoGlobal  BLWK_mainCrate;
		_theCrateItems apply {
			BLWK_mainCrate addItemCargoGlobal [_x,1];
		};	
		BLWK_mainCrate addItemCargoGlobal ["Medikit", 1];
	};
};

BLWK_faksToMedkitLooprunning = false;