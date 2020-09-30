if (!hasInterface) exitWith {};

params ["_draggedUnit"];

private _playerAnimationState = animationState player;
// only reset player animation if they are in the dragging animtions (i.e. not shot and going into injured anim)
if (_playerAnimationState == "acinpknlmstpsraswrfldnon" OR {_playerAnimationState == "acinpknlmwlksraswrfldb"}) then {
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