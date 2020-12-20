if (!hasInterface OR {!BLWK_ACELoaded}) exitWith {};

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
