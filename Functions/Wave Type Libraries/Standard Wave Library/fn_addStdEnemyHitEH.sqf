/* ----------------------------------------------------------------------------
Function: BLWK_fnc_addStdEnemyHitEH

Description:
	Adds the eventhandler to the standard enemies for showing
	 hit points and adding them to players.

	A local eventhandler was used to avoid networking such a
	 potentially frequent event. 

	Executed from "BLWK_fnc_addStdEnemyHitEHs"

Parameters:
	0: _unit : <OBJECT> - The unit to add the eventhandler to

Returns:
	BOOL

Examples:
    (begin example)

		[aUnit] call BLWK_fnc_addStdEnemyHitEH;

    (end)

Author:
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
if (!hasInterface) exitWith {false};

params ["_unit"];

private _eventID = _unit addEventHandler ["Hit",{
	_this call BLWK_fnc_stdEnemyHitEvent;
	hint "hit";
}];

_unit setVariable ["BLWK_stdHitEH_info",["Hit",_eventID]];


true