/* ----------------------------------------------------------------------------
Function: BLWK_fnc_dragUnitEvent

Description:
	Handles the actual dragging of a unit.
	Attaches the dragged unit to the player and perfroms andimations
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

Author:
	BangaBob (H8erMaker),
	Modified By: Ansible2 // Cipher
---------------------------------------------------------------------------- */
if (!hasInterface) exitWith {};

params ["_unitToDrag"];

// set dragged units animations
null = [_unitToDrag,"AinjPpneMrunSnonWnonDb_grab"] remoteExecCall ["switchMove",0,true];
_unitToDrag attachTo [player,[0,1.2,0]];
null = [_unitToDrag,180] remoteExecCall ["setDir",_unitToDrag];

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
null = [_unitToDrag] spawn {
	params ["_draggedUnit"];

	private _conditionCheck = {
		!(missionNamespace getVariable ["BLWK_draggingUnit",false]) OR 
		{!alive player} OR 
		{!(incapacitatedState player isEqualTo "")} OR 
		{!alive _draggedUnit} OR
		// check to see if unit was revived 
		{incapacitatedState _draggedUnit isEqualTo ""}
	};

	waitUntil {
		if (call _conditionCheck) exitWith {
			
			// check to see if the dragged unit was released
			if (!isNil "BLWK_releaseDragActionId") then {
				[_draggedUnit] call BLWK_fnc_releaseDragEvent;
			};

			true
		};

		sleep 0.5;

		false
	};
};