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

// add every action to the player for or them to manipulate the object while it is being held
[_object,_player] call BLWK_fnc_addPickedUpObjectActions;


// this loop is checking to see if the player is not unconcious or dead
/// if they are, they drop the object
[_object,_player] spawn {
	params ["_object","_player"];

	waitUntil {
		if (!(BLWK_holdingObject) OR {!(alive _player)} OR {!(incapacitatedState _player isEqualTo "")} OR {_player getVariable ["ace_isUnconscious",false]}) exitWith {
			
			// check to see if object was already dropped (if the fnc was already called, BLWK_heldObjectActionIDs will have been set to nil)
			if (!isNil "BLWK_heldObjectActionIDs") then {
				//CIPHER COMMENT: the actions will be removed from the player via BLWK_heldObjectActionIDs. delete comment once done
				[_object,_player] call BLWK_fnc_placeObject;
			};

			true
		};

		sleep 0.25;

		false
	};
};

true