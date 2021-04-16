#include "..\..\Headers\Loot Reveal Types.hpp"
/* ----------------------------------------------------------------------------
Function: BLWK_fnc_lootReveal

Description:
	Displays a notification that loot has been revealed on the map for a given
     category

	Executed from "BLWK_fnc_addRevealLootAction"

Parameters:
	0: _revealType : <NUMBER> - The type of loot shown

Returns:
	NOTHING

Examples:
    (begin example)
        // notification for all revealed on local machine
		[0] call BLWK_fnc_lootReveal;
    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
scriptName "BLWK_fnc_lootReveal";

#define CHECK_REVEAL_TYPE(TYPE_OF) _revealType isEqualTo TYPE_OF
#define IF_SERVER_CREATE_MARKERS(TYPE_OF_MARKERS) \
    if (isServer) then { \
        [TYPE_OF_MARKERS] call BLWK_fnc_createLootMarkers; \
    }; \
    nil

// exit headless clients
if (!hasInterface AND {!isServer}) exitWith {};


params [
    ["_revealType",0,[123]]
];


// all types
if (CHECK_REVEAL_TYPE(TYPE_ALL)) exitWith {
    ["IntelAdded",["Loot Locations Added To Map"]] call BIS_fnc_showNotification;

    IF_SERVER_CREATE_MARKERS("all")
};


// Equipment
if (CHECK_REVEAL_TYPE(TYPE_EQUIPMENT)) exitWith {
    ["IntelAdded",["Equipment Locations Added To Map"]] call BIS_fnc_showNotification;

    if (isServer) then {
        [["headgear","backpack","uniform","vest"]] call BLWK_fnc_createLootMarkers;
    };
};


// weapons
if (CHECK_REVEAL_TYPE(TYPE_WEAPONS)) exitWith {
    ["IntelAdded",["Weapon Locations Added To Map"]] call BIS_fnc_showNotification;

    IF_SERVER_CREATE_MARKERS("weapon")
};


// items
if (CHECK_REVEAL_TYPE(TYPE_ITEMS)) exitWith {
    ["IntelAdded",["Item Locations Added To Map"]] call BIS_fnc_showNotification;

    IF_SERVER_CREATE_MARKERS("item")
};


// ammo
if (CHECK_REVEAL_TYPE(TYPE_AMMO)) exitWith {
    ["IntelAdded",["Ammo Locations Added To Map"]] call BIS_fnc_showNotification;

    IF_SERVER_CREATE_MARKERS("magazine")
};


// uniques
if (CHECK_REVEAL_TYPE(TYPE_UNIQUE)) exitWith {
    ["IntelAdded",["Unique item Locations Added To Map"]] call BIS_fnc_showNotification;

    IF_SERVER_CREATE_MARKERS("unique")
};
