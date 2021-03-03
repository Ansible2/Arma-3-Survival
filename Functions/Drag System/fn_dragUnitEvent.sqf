/* ----------------------------------------------------------------------------
Function: BLWK_fnc_dragUnitEvent

Description:
	Handles the actual dragging of a unit.
	Attaches the dragged unit to the player and perfroms animations
	
	Adds the release action too.

	Executed from "BLWK_fnc_addDragAction"

Parameters:
	0: _unitToDrag : <OBJECT> - The person to be dragged

Returns:
	NOTHING

Examples:
    (begin example)
		[_unitToDrag] call BLWK_fnc_dragUnitEvent;
    (end)

Author(s):
	BangaBob (H8erMaker),
	Modified By: Ansible2 // Cipher
---------------------------------------------------------------------------- */
if (!hasInterface) exitWith {};

params ["_unitToDrag"];

// set dragged units animations
[_unitToDrag,"AinjPpneMrunSnonWnonDb_grab"] remoteExecCall ["switchMove",0,_unitToDrag];
_unitToDrag attachTo [player,[0,1.2,0]];
[_unitToDrag,180] remoteExecCall ["setDir",_unitToDrag];

[_unitToDrag] remoteExec ["BLWK_fnc_handleReviveAfterDrag",_unitToDrag];

// set players animations
player playAction "grabDrag";
player forceWalk true;

// make sure nobody else can drag the unit
_unitToDrag setVariable ["BLWK_beingDragged",true,true];
missionNamespace setVariable ["BLWK_draggingUnit",true];

// give the player dragging the action to release
private _releaseActionId = [player,_unitToDrag] call BLWK_fnc_addReleaseDragAction;
missionNamespace setVariable ["BLWK_releaseDragActionId",_releaseActionId];


// loop for certain conditions to auto drop the person being dragged
[_unitToDrag] spawn {
	params ["_draggedUnit"];

	private _conditionCheck = {
		// if not dragging someone
		!(missionNamespace getVariable ["BLWK_draggingUnit",false]) OR
		// if player died 
		{!alive player} OR 
		// if player was incapacitated
		{(incapacitatedState player) isNotEqualTo ""} OR 
		// if the dragged unit died
		{!alive _draggedUnit} OR
		// if the dragged unit was revived
		{incapacitatedState _draggedUnit isEqualTo ""}
	};

	waitUntil {
		if (call _conditionCheck) exitWith {
			
			// release dragged unit if condition is met in _conditionCheck and they were not already dropped
			if (!isNil "BLWK_releaseDragActionId") then {
				[_draggedUnit] call BLWK_fnc_releaseDragEvent;
			};

			true
		};

		sleep 0.5;

		false
	};
};