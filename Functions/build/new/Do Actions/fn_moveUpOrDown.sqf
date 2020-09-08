/* ----------------------------------------------------------------------------
Function: BLWK_fnc_moveUpOrDown

Description:
	Executes the action to pick up a building object

	Executed from ""

Parameters:
	0: _object : <OBJECT> - The object to pickup
	1: _player : <OBJECT> - The person picking up the object
	2: _justPurchased : <BOOL> - Was the item just purchased from the Bulwark?

Returns:
	Nothing

Examples:
    (begin example)

		[myObject,player] call BLWK_fnc_pickupObject;

    (end)

Author:
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
#define MOVEMENT_INCRIMENT 0.25;

_object = _this select 0;
_caller = _this select 1;
_movePos = _this select 2;

_callerPos = getPosATL (_caller);
_objectPos = getPosATL (_object);
[_object, false] remoteExec ["enableSimulation", 0];
[_object, [
	(_objectPos select 0) + (_movePos select 0),
	(_objectPos select 1) + (_movePos select 1),
	(_objectPos select 2) + (_movePos select 2)
]] remoteExec ["setPosATL", 0];
[_object, true] remoteExec ["enableSimulation", 0];
sleep 0.1;
_newCallerPos = getPosATL (_caller);
if ((_newCallerPos select 2) > (_callerPos select 2)) then {
	[_object, _objectPos] remoteExec ["setPosATL", 0];
};
