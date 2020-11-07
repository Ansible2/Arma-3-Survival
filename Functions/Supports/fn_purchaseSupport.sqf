/* ----------------------------------------------------------------------------
Function: BLWK_fnc_purchaseSupport

Description:
	Creates the object purchased from the bulwark 

	Executed from "bulwarkShopGUI.hpp" under the "bulwarkShopDialog_supportButton" class

Parameters:
	0: _selectedIndex : <NUMBER> - The index of the item in BLWK_supports_array
	1: _free : <BOOL> - Is this item free or not?

Returns:
	NOTHING

Examples:
    (begin example)

		call BLWK_fnc_purchaseSupport;

    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
params [
	"_selectedIndex",
	["_free",false]
];

(BLWK_supports_array select _selectedIndex) params [
	"_price",
	"_itemClass"
];

if !(_free) then {
	[_price] call BLWK_fnc_subtractPoints;
};
[player,_itemClass] call BIS_fnc_addCommMenuItem;