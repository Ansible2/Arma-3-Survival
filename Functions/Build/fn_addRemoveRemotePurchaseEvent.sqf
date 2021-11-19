/* ----------------------------------------------------------------------------
Function: BLWK_fnc_addRemoveRemotePurchaseEvent

Description:
    Adds a "deleted" eventhandler on the server for purchased objects so their
     purchase events are removed from the JIP queue.

	When an object is purchased, BLWK_fnc_buildItemPurchasedEvent_remote will be
     executed on every machine but the purchaser's. In order to not have a clogged
     JIP queue, a unique JIP ID is used: (netId _object) + "_purchasedEvent"


    It is called from "BLWK_fnc_purchaseObject" & BLWK_fnc_buildItemPurchasedEvent_remote

Parameters:
	0: _object : <OBJECT> - The object to add the event to

Returns:
	<NUMBER> - The eventhandler id

Examples:
    (begin example)
		[comeObject] call BLWK_fnc_addRemoveRemotePurchaseEvent;
    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
scriptName "BLWK_fnc_addRemoveRemotePurchaseEvent";

if (!isServer) exitWith {};

params ["_object"];

_object addEventHandler ["deleted",{
    params ["_object"];
    remoteExec ["",(netId _object) + "_purchasedEvent"];
}];
