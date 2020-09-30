if (!hasInterface) exitWith {-1};

params [
	["_player",player,[objNull]],
	"_draggedUnit"
];
// dragged unit should return to "unconsciousrevivedefault"

private _actionId = _player addAction [ 
	"<t color='#4287f5'>-- Release Unit --</t>",  
	{
		// pass _draggedUnit
		[_this select 3] call BLWK_fnc_releaseDragEvent;
	}, 
	_draggedUnit, 
	200,  
	true,  
	false,  
	"true", 
	"true", 
	2 
];


_actionId