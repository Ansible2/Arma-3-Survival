/* ----------------------------------------------------------------------------
Function: BLWK_fnc_addACESupportMenuAction

Description:
	Adds the ACE action to a player object that allows them to self interact
	 and pull up the support menu.

Parameters:
	0: _player <OBJECT> - The player object

Returns:
	NOTHING

Examples:
    (begin example)
		[player] call BLWK_fnc_addACESupportMenuAction
    (end)

Author:
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
scriptName "BLWK_fnc_addACESupportMenuAction";

if (!hasInterface) exitWith {};

if (!BLWK_ACELoaded) exitWith {
	["ACE is not loaded, action will not be added",false] call KISKA_fnc_log;
	nil
};

params [
	["_player",player]
];

private _action = [
	"Open Comm Menu",
	"Open Comm Menu",
	"\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\call_ca.paa",
	{showCommandingMenu "#User:BIS_fnc_addCommMenuItem_menu"},
	{alive _player}
] call ace_interact_menu_fnc_createAction;

[_player,1,["ACE_SelfActions"],_action] call ace_interact_menu_fnc_addActionToObject;
