/* ----------------------------------------------------------------------------
Function: BLWK_fnc_handleWaitingForReviveEvent

Description:
	Loops while a player is waiting for revive. Will give a person the ability
	 to self revive with a hold action if a medkit is in their inventory.

	Executed from the event added in BLWK_fnc_addReviveEhs.

Parameters:
	0: _unit : <OBJECT> - The person to add the action to

Returns:
	NOTHING

Examples:
    (begin example)

		[player] spawn BLWK_fnc_handleWaitingForReviveEvent;

    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
scriptName "BLWK_fnc_handleWaitingForReviveEvent";

if (!canSuspend) exitWith {
	["Needs to be run in scheduled. Exiting to scheduled...",true] call KISKA_fnc_log;
	_this spawn BLWK_fnc_handleWaitingForReviveEvent;
};

params ["_unit"];

private _reviveActionId = -1;
private _actionAvailabile = false;
private _fn_addReviveAction = {
	_reviveActionId = [
		_unit,
		"Revive From Medkit",
		"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_revive_ca.paa",
		"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_revive_ca.paa",
		"true",
		"true",
		{},
		{},
		{
			_caller removeItem "Medikit";				

			// revives player for BIS revive system
			["BLWK_reviveOnStateVar",1,_caller] call BIS_fnc_reviveOnState;
			
			hint "Reived from your medkit";

			// make the player invincible for 30 seconds to avoid BS
			[_caller] spawn {
				params ["_caller"];
				_caller allowDamage false;
				sleep 30;
				_caller allowDamage true;
			};
		},
		{},
		[],
		1,
		10000,
		false,
		true
	] call BIS_fnc_holdActionAdd;
};


// while still in incapacitatedState
while {sleep 0.5; !(incapacitatedState _unit isEqualTo "") AND {alive _unit}} do {
	
	if ("Medikit" in (items _unit)) then {
		// add action if medkit now present
		if !(_actionAvailabile) then {
			call _fn_addReviveAction;
			_actionAvailabile = true;
			["Self revive action was not present and medkit found, adding it..."] call KISKA_fnc_log;
		};
	} else {
		// remove action if medkit is no longer present
		if (_actionAvailabile) then {
			[_unit,_reviveActionId] call BIS_fnc_holdActionRemove;
			_actionAvailabile = false;
			["Self revive action WAS added and medkit found, removing it..."] call KISKA_fnc_log;
		};
	};

};

["Exited waiting for revive loop."] call KISKA_fnc_log;

// remove action after loop condition no longer met
if (_actionAvailabile) then {
	["Self revive action WAS added before loop end, removing it..."] call KISKA_fnc_log;
	[_unit,_reviveActionId] call BIS_fnc_holdActionRemove;
};