if (!hasInterface OR {!canSuspend} OR {BLWK_dontUseRevive}) exitWith {};

params ["_unit"];

waitUntil {player isEqualTo player};
// make sure a player can't drag themself
if (_unit isEqualTo player) exitWith {};

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
	"!(_originalTarget getVariable ['BLWK_beingDragged',false]) AND {!(incapacitatedState _originalTarget isEqualTo "")}", 
	3 
];

// for removing action upon unit death
_unit setVariable ["BLWK_dragActionId",_actionId];