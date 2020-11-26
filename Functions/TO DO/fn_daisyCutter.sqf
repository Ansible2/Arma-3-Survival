/* ----------------------------------------------------------------------------
Function: BLWK_fnc_daisyCutter

Description:
	

Parameters:
	NONE

Returns:
	NOTHING

Examples:
    (begin example)

		null = [] spawn BLWK_fnc_daisyCutter;

    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
private _daisyCutterObject = "VR_3DSelector_01_exit_F" createVehicle [0,0,0];

[	
	player,
	"<t color='#c91306'>Deploy Daisy Cutter</t>", 
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_unloaddevice_ca.paa", 
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_unloaddevice_ca.paa",
	"true",
	"true", 
	{}, 
	{}, 
	{
		params ["", "_caller", "_actionId", "_arguments", "", ""];

		private _daisyCutterObject = _arguments select 0;

		
	{}, 
	[_daisyCutterObject], 
	1, 
	1, 
	false, 
	false, 
	false
] remoteExecCall ["BIS_fnc_holdActionAdd",BLWK_allClientsTargetID,true];