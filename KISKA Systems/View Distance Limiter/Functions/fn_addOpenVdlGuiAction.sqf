/* ----------------------------------------------------------------------------
Function: KISKA_fnc_addOpenVdlGuiAction

Description:
	Opens the dialog or GUI of the bulwark to let you purchase
	 supports and build objects.

	Executed from an action added in "BLWK_fnc_prepareBulwarkPlayer"

Parameters:
	NONE

Returns:
	NOTHING

Examples:
    (begin example)

		Postinit function

    (end)

Author:
	Hilltop & omNomios,
	Modified by: Ansible2 // Cipher
---------------------------------------------------------------------------- */
waitUntil {!isNull player};

player addEventHandler ["RESPAWN",{
	params ["_unit", "_corpse"];

	[_corpse,KISKA_vdl_dialogOpenAction] call BIS_fnc_holdActionRemove;

	KISKA_vdl_dialogOpenAction = [	
		_unit,
		"<t color='#4287f5'>Edit Dynamic View Distance</t>", 
		"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa", 
		"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa", 
		"true", 
		"true", 
		{}, 
		{}, 
		{
			call KISKA_fnc_openVdlDialog;
		}, 
		{}, 
		[], 
		1, 
		1, 
		false, 
		false, 
		false
	] call BIS_fnc_holdActionAdd;
}];

KISKA_vdl_dialogOpenAction = [	
	player,
	"<t color='#4287f5'>Edit Dynamic View Distance</t>", 
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa", 
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa", 
	"true", 
	"true", 
	{}, 
	{}, 
	{
		call KISKA_fnc_openVdlDialog;
	}, 
	{}, 
	[], 
	1, 
	1, 
	false, 
	false, 
	false
] call BIS_fnc_holdActionAdd;