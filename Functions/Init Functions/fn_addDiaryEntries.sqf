/* ----------------------------------------------------------------------------
Function: BLWK_fnc_addDiaryEntries

Description:
	Adds diary entries at the start of the mission to the player.

	Executed from "BLWK_fnc_initClientAlias"

Parameters:
	0: _player : <OBJECT> - The player to add diary entries to

Returns:
	NOTHING

Examples:
    (begin example)

		call BLWK_fnc_addDiaryEntries;

    (end)

Author(s):
	Hilltop(Willtop) & omNomios,
	Modified by: Ansible2 // Cipher
---------------------------------------------------------------------------- */
if !(hasInterface) exitWith {};

params [
	["_player",player]
];

_player createDiaryRecord ["Survival Tips", ["Looting", "
Across the play area you will be able to find various loot in buildings.
<br/>
<br/>
These come in various categories: <t underline='true'>magazines, explosives, weapons, vests, items, backpacks, and uniforms</t>.
<br/>
<br/>
There are also a few unique items:
<br/>
<br/>
<t color='#FF008200'>Money Pile:</t> The money pile contains 5000 points.
<br/>
<t color='#FF00599E'>Support Dish:</t> Unlocks supports inside the shop on The Crate. Once found, it will not spawn again.
<br/>
<t color='#FFB2599E'>Loot Reveal Box:</t> Depending on your server settings, it will either reveal all loot on the map or of a type of your choosing.
<br/>
<t color='#FF750000'>Random Weapon Box:</t> Spin the box, get a random weapon drop.
"]];


_player createDiaryRecord ["Survival Tips", ["Supports", "
Supports can be purchased from the <t color='#00ff00'>-- Open Shop --</t> action attached to <t underline='true'>The Crate</t>.
<br/>
<br/>
To use support, bring up the SUPPORT MENU via <t underline='true'>0 -> 8</t> (not on numpad). <t color='#ffff0000'>If you have ACE loaded</t>, then you will likely need to press <t underline='true'>BACKSPACE</t> then navigate to <t underline='true'>Reply</t> then to <t underline='true'>Supports</t>.
<br/>
<br/>
Supports can be called in both on the <t color='#FF0073A6'>map</t> and through <t color='#FF0073A6'>Line Of Sight</t>.
"]];

_player createDiaryRecord ["Survival Tips", ["Mag Repack", "
If enabled in the mission parameters, this will be Ctrl+R.
"]];


_player createDiarySubject ["ReassignZeus_entry","Reassign Zeus",""];

_player createDiaryRecord ["ReassignZeus_entry", ["Reassign Zeus Curator",
	"<execute expression= '[true] call BLWK_fnc_reassignCurator;'>If You've Lost Zeus, Click Here</execute>"
]];