/* ----------------------------------------------------------------------------
Function: BLWK_fnc_releaseDragEvent

Description:
	The actual action of releasing a dragged unit.
	Resets animations and global variables involved

	Executed from "BLWK_fnc_addReleaseDragAction" & "BLWK_fnc_dragUnitEvent"

Parameters:
	0: _draggedUnit : <OBJECT> - The unit being dragged

Returns:
	NOTHING

Examples:
    (begin example)

		[player] call BLWK_fnc_releaseDragEvent;

    (end)

Author:
	BangaBob (H8erMaker),
	Modified By: Ansible2 // Cipher
---------------------------------------------------------------------------- */
if (!hasInterface) exitWith {};

params ["_draggedUnit"];

private _playerAnimationState = animationState player;
// only reset player animation if they are in the dragging animtions (i.e. not shot and going into injured anim)
if (incapacitatedState player isEqualTo "") then {
	player switchMove "";
};

player forceWalk false;

detach _draggedUnit;

if (animationState _draggedUnit == "AinjPpneMrunSnonWnonDb_grab") then {
	[_draggedUnit,"AinjPpneMstpSnonWrflDb_release"] remoteExec ["switchMove",0,true];
};
_draggedUnit setVariable ["BLWK_beingDragged",false,true];

missionNamespace setVariable ["BLWK_draggingUnit",false];

player removeAction (missionNamespace getVariable "BLWK_releaseDragActionId");
missionNamespace setVariable ["BLWK_releaseDragActionId",nil];