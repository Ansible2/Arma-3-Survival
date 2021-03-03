/* ----------------------------------------------------------------------------
Function: BLWK_fnc_registerObjectPickup

Description:
	Changes the state of an object being picked up or not. This is so that
	 other player's do not have access the actions to manipulate an object
	 when it is in someone elses hands.

	Executed from "BLWK_fnc_pickUpObject" and "BLWK_fnc_placeObject".

Parameters:
	0: _object : <OBJECT> - The object to change the state on
	1: _pickedUp : <BOOL> - True if object is picked up, false if not

Returns:
	NOTHING

Examples:
    (begin example)

		// make sure nobody else can manipulate the object through actions
		[_object,true] remoteExecCall ["BLWK_fnc_registerObjectPickup",BLWK_allClientsTargetId,_object];

    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
#define SCRIPT_NAME "BLWK_fnc_registerObjectPickUp"
scriptName SCRIPT_NAME;

if (!hasInterface) exitWith {};

params [
	["_object",objNull,[objNull]],
	["_pickedUp",true,[true]]
];

if (isNull _object) exitWith {
	[["Null object asked for: ",_object," from remoteExecutedOwner ",remoteExecutedOwner]] call KISKA_fnc_log;
};

_object setVariable ["BLWK_objectPickedUp",_pickedUp];