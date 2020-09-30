if (!hasInterface OR {BLWK_dontUseRevive}) exitWith {};

params ["_player"]
// add a drag action to every player for yourself
// the action will have a condition to keep it from always being shown
[_player] remoteExec ["BLWK_fnc_addDragAction",BLWK_allClientsTargetID,true];

// add an event handler to remove the action from all machines if you die
[_player] call BLWK_fnc_addDragKilledEh;

// modified from author BangaBob (H8erMaker) DragBody script