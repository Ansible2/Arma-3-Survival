/* ----------------------------------------------------------------------------
Function: BLWK_fnc_purchaseSupport

Description:
	Creates the object purchased from the bulwark 

	Executed from "bulwarkShopGUI.hpp" under the "bulwarkShopDialog_supportButton" class

Parameters:
	NONE

Returns:
	NOTHING

Examples:
    (begin example)

		call BLWK_fnc_purchaseSupport;

    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
// the comm menu can only support 10 items at a time
if (count (player getVariable "BIS_fnc_addCommMenuItem_menu") isEqualTo 10) exitWith {
	null = [format ["<t size='0.6' color='#ff3300'>You have the max number of supports (10)!</t>"], -0, -0.02, 2, 0.1] spawn BIS_fnc_dynamicText;
};

// get the current slected list index from the purchase GUI when you press the button
private _selectedIndex = lbCurSel 1501;
if (isNil "_selectedIndex") exitWith {
	hint "Invalid selection";
};

(BLWK_supports_array select _selectedIndex) params [
	"_price",
	"_itemClass"
];

if ((missionNamespace getVariable ["BLWK_playerKillPoints",0]) >= _price) then {
	[_price] call BLWK_fnc_subtractPoints;
	[player,_itemClass] call BIS_fnc_addCommMenuItem;
} else {
	private _nameOfSupport = getText(missionConfigFile >> "cfgCommunicationMenu" >> _itemClass >> "text");
	null = [format ["<t size='0.6' color='#ff3300'>Not enough points for: %1!</t>", _nameOfSupport], -0, -0.02, 2, 0.1] spawn BIS_fnc_dynamicText;
};