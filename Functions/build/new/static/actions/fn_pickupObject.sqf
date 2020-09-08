/* ----------------------------------------------------------------------------
Function: BLWK_fnc_pickupObject

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
if !(hasInterface) exitWith {};

params [
	["_object",objNull,[objNull]],
	["_player",player,[objNull]],
	["_justPurchased",false,[true]]
];

// get attachment info from global build objects array
private _objectType = typeOf _object;

private _index = BLWK_buildableObjects_array findIf {_x select 0 == _objectType};
private _attachmentInfo = (BLWK_buildableObjects_array select _index) select 4;

if (_justPurchased) then {
	_object attachTo [_player,_attachmentInfo select 1];
	_object setDir (_attachmentInfo select 0);
} else {
	// attaching relative to player if it is already placed down
	_object attachTo [_player];
};

// make sure nobody else can manipulate the object through actions
_object setVariable ["BLWK_objectPickedUp",true,true];

// marks the client as holding an object for other functions such as trying to access the bulwark
missionNamespace setVariable ["BLWK_holdingObject",true];

// add a drop action to the player so that it is not finicky about looking at the object
[_object,_player] call BLWK_fnc_addPickedUpObjectActions;