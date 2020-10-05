/* ----------------------------------------------------------------------------
Function: BLWK_fnc_pickupObject

Description:
	Executes the action to pick up a player built object

	Executed from "BLWK_fnc_purchaseObject" & "BLWK_fnc_addBuildableObjectActions"

Parameters:
	0: _object : <OBJECT> - The object to pickup
	1: _player : <OBJECT> - The person picking up the object
	2: _justPurchased : <BOOL> - Was the item just purchased from the Bulwark?

Returns:
	BOOL

Examples:
    (begin example)

		[myObject,player] call BLWK_fnc_pickupObject;

    (end)

Author:
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
if !(hasInterface) exitWith {};

// if they have an object in hand
if !(isNil "BLWK_heldObject") exitWith {
	hint "Can't pick up two objects Superman";
	false
};

params [
	["_object",objNull,[objNull]],
	["_player",player,[objNull]],
	["_justPurchased",false,[true]]
];

// get attachment info from global build objects array
private _objectType = typeOf _object;

private "_attachmentInfo";
if (_justPurchased) then {
	private _index = BLWK_buildableObjects_array findIf {(_x select 2) == _objectType};
	_attachmentInfo = (BLWK_buildableObjects_array select _index) select 4;
	_object attachTo [_player,_attachmentInfo select 1];
	_object setDir (_attachmentInfo select 0);
} else {
	[_object,_player,true] remoteExecCall ["BIS_fnc_attachToRelative",_object];
};

// special handle for BLWK_randomWeaponBox being found
if (_object isEqualTo BLWK_randomWeaponBox AND {missionNamespace getVariable ["BLWK_randomWeaponBoxFound",false]}) then {
	missionNamespace setVariable ["BLWK_randomWeaponBoxFound",true,true];
};

// make sure nobody else can manipulate the object through actions
_object setVariable ["BLWK_objectPickedUp",true,true];

// marks the client as holding an object for other functions such as trying to access the bulwark shop
missionNamespace setVariable ["BLWK_heldObject",_object];

// add every action to the player for or them to manipulate the object while it is being held
[_object,_player] call BLWK_fnc_addPickedUpObjectActions;

// this loop is checking to see if the player is unconcious or dead
/// if they are, they drop the object
[_object,_player] spawn {
	params ["_object","_player"];

	waitUntil {
		if (isNil "BLWK_heldObject" OR {!(alive _player)} OR {!(incapacitatedState _player isEqualTo "")} OR {_player getVariable ["ace_isUnconscious",false]}) exitWith {
			
			// check to see if object was already dropped (if the fnc was already called, BLWK_heldObjectActionIDs will have been set to nil)
			if (!isNil "BLWK_heldObjectActionIDs") then {
				//CIPHER COMMENT: the actions will be removed from the player via BLWK_heldObjectActionIDs. delete comment once done
				[_object] call BLWK_fnc_placeObject;
			};

			true
		};

		sleep 0.25;

		false
	};
};


true