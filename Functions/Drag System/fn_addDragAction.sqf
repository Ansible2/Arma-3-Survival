/* ----------------------------------------------------------------------------
Function: BLWK_fnc_addDragAction

Description:
	Adds an action to drag a unit if they are downed

	Executed from "BLWK_fnc_initDragSystem" & "BLWK_fnc_addReviveEhs"

Parameters:
	0: _unit : <OBJECT> - The unit to be able to drag

Returns:
	NOTHING

Examples:
    (begin example)

		null = [player] spawn BLWK_fnc_addDragAction;

    (end)

Author(s):
	BangaBob (H8erMaker),
	Modified By: Ansible2 // Cipher
---------------------------------------------------------------------------- */
waitUntil {!isNil "BLWK_dontUseRevive"};

if (!hasInterface OR {!canSuspend} OR {BLWK_dontUseRevive}) exitWith {};

params ["_unit"];

waitUntil {player isEqualTo player};
// make sure a player can't drag themself
if (_unit isEqualTo player) exitWith {};

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
	"(!(_originalTarget getVariable ['BLWK_beingDragged',false])) AND {!(incapacitatedState _target isEqualTo '')}", 
	3 
];

// for removing action upon unit death
_unit setVariable ["BLWK_dragActionId",_actionId];