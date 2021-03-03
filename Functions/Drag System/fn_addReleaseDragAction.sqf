/* ----------------------------------------------------------------------------
Function: BLWK_fnc_addReleaseDragAction

Description:
	Adds an action to the player to release the unit they are dragging.

	Executed from "BLWK_fnc_dragUnitEvent"

Parameters:
	0: _unit : <OBJECT> - The unit to add the eventhandler to
	1: _draggedUnit : <OBJECT> - The unit to add the eventhandler to

Returns:
	<NUMBER> - the release action Id

Examples:
    (begin example)

		_releaseActionId = [player,unitBeingDragged] call BLWK_fnc_addReleaseDragAction;

    (end)

Author(s):
	BangaBob (H8erMaker),
	Modified By: Ansible2 // Cipher
---------------------------------------------------------------------------- */
if (!hasInterface) exitWith {-1};

params [
	["_player",player,[objNull]],
	"_draggedUnit"
];

private _actionId = _player addAction [ 
	"<t color='#4287f5'>-- Release Dragged Unit --</t>",  
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