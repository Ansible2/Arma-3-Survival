#include "..\..\Headers\Wait For Transfer Inline.hpp"
#include "..\..\Headers\Build Objects Properties Defines.hpp"
/* ----------------------------------------------------------------------------
Function: BLWK_fnc_pickupObject

Description:
	Executes the action to pick up a player built object.

	Executed from "BLWK_fnc_purchaseObject" & "BLWK_fnc_addBuildableObjectActions"

Parameters:
	0: _object : <OBJECT> - The object to pickup
	1: _player : <OBJECT> - The person picking up the object
	2: _justPurchased : <BOOL> - Was the item just purchased from the shop?

Returns:
	NOTHING

Examples:
    (begin example)

		[myObject,player] spawn BLWK_fnc_pickupObject;

    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
if (!hasInterface OR {!canSuspend}) exitWith {};

// if they have an object in hand
if !(isNil "BLWK_heldObject") exitWith {
	hint "Can't pick up two objects Superman";
};

params [
	["_object",objNull,[objNull]],
	["_player",player,[objNull]],
	["_justPurchased",false,[true]]
];


if (_justPurchased) then {
	private _propertiesArray = BLWK_buildableObjectsHash get (toLowerANSI (typeOf _object));
	_object attachTo [_player,_propertiesArray select ATTACHMENT_COORDS];
	_object setDir (_propertiesArray select ROTATION);
} else {
	WAIT_FOR_OWNERSHIP(_object)
	[_object,_player,true] call BIS_fnc_attachToRelative;
};

// special handle for BLWK_randomWeaponBox being found
if (_object isEqualTo BLWK_randomWeaponBox AND {!(missionNamespace getVariable ["BLWK_randomWeaponBoxFound",false])}) then {
	missionNamespace setVariable ["BLWK_randomWeaponBoxFound",true,true];
};

[_object] remoteExec ["BLWK_fnc_disableCollisionWithAllPlayers",_object];

// make sure nobody else can manipulate the object through actions
[_object,true] remoteExecCall ["BLWK_fnc_registerObjectPickup",BLWK_allClientsTargetId,_object];

// marks the client as holding an object for other functions such as trying to access the shop
missionNamespace setVariable ["BLWK_heldObject",_object];

// add every action to the player for them to manipulate the object while it is being held
[_object,_player] call BLWK_fnc_addPickedUpObjectActions;


[_object] call BLWK_fnc_buildEvent_onPickedUp;


// this loop is checking to see if the player is unconcious or dead
/// if they are, they drop the object
[_object,_player] spawn {
	params ["_object","_player"];

	waitUntil {
		if (
			isNil "BLWK_heldObject" OR 
			{!(alive _player)} OR 
			{incapacitatedState _player isNotEqualTo ""} OR 
			{_player getVariable ["ace_isUnconscious",false]}
		) exitWith {
			
			// check to see if object was already dropped (if the fnc was already called, BLWK_heldObjectActionIDs will have been set to nil)
			if (!isNil "BLWK_heldObjectActionIDs") then {
				[_object] call BLWK_fnc_placeObject;
			};

			true
		};

		sleep 0.25;

		false
	};
};