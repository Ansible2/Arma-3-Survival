/* ----------------------------------------------------------------------------
Function: KISKA_fnc_setAllVdlButton

Description:
	Saves all the current values input to the VDL GUI.

Parameters:
	0: _control <CONTROL> - The control of the set all button
	
Returns:
	NOTHING 

Examples:
	(begin example)
		// used in onButtonClick eventhandler in config
		_this call KISKA_fnc_setAllVdlButton;
	(end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
disableSerialization;
if (!hasInterface) exitWith {};

params ["_control"];
private _partnerControls = [_control] call KISKA_fnc_findVDLPartnerControl;

_partnerControls apply {
	[_x] call KISKA_fnc_setVDLValue;
};

hint "All changes applied";