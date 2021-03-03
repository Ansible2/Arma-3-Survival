/* ----------------------------------------------------------------------------
Function: BLWK_fnc_addDragAction

Description:
	Adds an action to drag a unit if they are downed.

	Executed from "BLWK_fnc_initDragSystem" & "BLWK_fnc_addReviveEhs"

Parameters:
	0: _unit : <OBJECT> - The unit to be able to drag

Returns:
	NOTHING

Examples:
    (begin example)

		[player] spawn BLWK_fnc_addDragAction;

    (end)

Author(s):
	BangaBob (H8erMaker),
	Modified By: Ansible2 // Cipher
---------------------------------------------------------------------------- */
#define SCRIPT_NAME "BLWK_fnc_addDragAction"
scriptName SCRIPT_NAME;

if (!hasInterface) exitWith {};

if (!canSuspend) exitWith {
	["Needs to executed in scheduled, wasn't, executing now in scheduled...",false] call KISKA_fnc_log;
	_this spawn BLWK_fnc_addDragAction;
};

params ["_unit"];

if (isNull _unit) exitWith {
	["Null unit passed. Exiting..."] call KISKA_fnc_log;
};

waitUntil {
	sleep 0.1;
	!isNil "BLWK_dontUseRevive"
};

if (BLWK_dontUseRevive) exitWith {
	["Vanilla revive is disabled, exiting...",false] call KISKA_fnc_log;
};

waitUntil {
	sleep 0.1;
	player isEqualTo player
};

// make sure a player can't drag themself
if (_unit isEqualTo player) exitWith {
	["Can't add drag action to self player, exiting...",false] call KISKA_fnc_log;
};

sleep 1;

private _actionId = _unit addAction [ 
	"<t color='#02b016'>-- Drag Unit --</t>",  
	{
		[_this select 0] call BLWK_fnc_dragUnitEvent;
	}, 
	nil, 
	200,  
	true,  
	false,  
	"true", 
	"(!(_originalTarget getVariable ['BLWK_beingDragged',false])) AND {(incapacitatedState _target) isNotEqualTo ''}", 
	3 
];

// store actionid for removing action upon unit death of _unit
_unit setVariable ["BLWK_dragActionId",_actionId];