#include "..\..\Headers\Build Objects Properties Defines.hpp"
/* ----------------------------------------------------------------------------
Function: BLWK_fnc_buildItemPurchasedEvent_remote

Description:
	After a remote item is purchased, this event/function will be raised on
     remote machines to sync some data such as addin build actions and adjusting
     global variables.

    It is called from "BLWK_fnc_purchaseObject"

Parameters:
	0: _purchasedObject : <OBJECT> - The remote object purchased

Returns:
	NOTHING

Examples:
    (begin example)
		[someObject] remoteExecCall ["BLWK_fnc_buildItemPurchasedEvent_remote",-clientOwner,true];
    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
scriptName "BLWK_fnc_buildItemPurchasedEvent_remote";

params ["_purchasedObject"];

if (isNull _purchasedObject) exitWith {
    ["A null object was passed, exiting..."] call KISKA_fnc_log;
    nil
};


private _indestructable = false;

if (isNil "BLWK_buildableObjectsHash") then {
    if (isNil "BLWK_ACELoaded") then {
        BLWK_ACELoaded = ["ace_common"] call KISKA_fnc_isPatchLoaded;
    };

    private _propertyConfig = missionConfigFile >> "BLWK_buildableItems" >> (typeOf _purchasedObject);
    _indestructable = [_propertyConfig >> "invincible"] call BIS_fnc_getCfgDataBool;

} else {
    private _propertiesArray = BLWK_buildableObjectsHash get (toLowerANSI (typeOf _purchasedObject));
    _indestructable = _propertiesArray select INDESTRUCTABLE;

};


if (hasInterface) then {
    [_purchasedObject] call BLWK_fnc_addBuildableObjectActions;

    if (_indestructable) then {
        [_purchasedObject] call BLWK_fnc_addAllowDamageEH;

        if (missionNamespace getVariable ["BLWK_ACELoaded",true]) then {
            _purchasedObject setVariable ["ace_cookoff_enable", false];
        };
    };

} else {
    if (_indestructable AND {missionNamespace getVariable ["BLWK_ACELoaded",true]}) then {
        _purchasedObject setVariable ["ace_cookoff_enable", false];
    };

};


if (isServer) then {
    [_purchasedObject] call BLWK_fnc_addRemoveRemotePurchaseEvent;
};


nil
