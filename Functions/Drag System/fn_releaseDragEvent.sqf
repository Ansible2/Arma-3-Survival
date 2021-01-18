/* ----------------------------------------------------------------------------
Function: BLWK_fnc_releaseDragEvent

Description:
	The actual action of releasing a dragged unit.
	
	Resets animations and global variables involved.

	Executed from "BLWK_fnc_addReleaseDragAction" & "BLWK_fnc_dragUnitEvent"

Parameters:
	0: _draggedUnit : <OBJECT> - The unit being dragged

Returns:
	NOTHING

Examples:
    (begin example)

		[player] call BLWK_fnc_releaseDragEvent;

    (end)

Author(s):
	BangaBob (H8erMaker),
	Modified By: Ansible2 // Cipher
---------------------------------------------------------------------------- */
if (!hasInterface) exitWith {};

#define DRAG_ANIMATIONS ["amovpercmstpslowwrfldnon_acinpknlmwlkslowwrfldb_2", "amovpercmstpsraswpstdnon_acinpknlmwlksnonwpstdb_2", "amovpercmstpsnonwnondnon_acinpknlmwlksnonwnondb_2", "acinpknlmstpsraswrfldnon", "acinpknlmstpsnonwpstdnon", "acinpknlmstpsnonwnondnon", "acinpknlmwlksraswrfldb", "acinpknlmwlksnonwnondb", "AinjPpneMrunSnonWnonDb_grab"]

params ["_draggedUnit"];

// only reset player animation if they are in the dragging animtions (i.e. not shot and going into injured anim)
if (incapacitatedState player isEqualTo "") then {
	player playActionNow "released";
};

detach _draggedUnit;
if (animationState _draggedUnit in DRAG_ANIMATIONS) then {
	[_draggedUnit,"Unconscious"] remoteExecCall ["playActionNow",_draggedUnit];
};

player forceWalk false;

_draggedUnit setVariable ["BLWK_beingDragged",false,true];

missionNamespace setVariable ["BLWK_draggingUnit",false];

player removeAction (missionNamespace getVariable "BLWK_releaseDragActionId");
missionNamespace setVariable ["BLWK_releaseDragActionId",nil];