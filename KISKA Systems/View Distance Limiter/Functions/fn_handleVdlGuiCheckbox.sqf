/* ----------------------------------------------------------------------------
Function: KISKA_fnc_handleVdlGuiCheckbox

Description:
	Acts as an event when the box is checked or unchecked in the VDL GUI.
	It will either start the system or end it.

Parameters:
	0: _control <CONTROL> - The conrol of the box
	1: _checked <BOOL> - Is the box checked? 

Returns:
	BOOL 

Examples:
	(begin example)
		// from onCheckedChanged event in config
		_this call KISKA_fnc_handleVdlGuiCheckbox
	(end)

Author:
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
if (!hasInterface) exitWith {};

#include "..\ViewDistanceLimiterCommonDefines.hpp"

params ["_control","_checked"];

if (_checked) then {
	if !(call KISKA_fnc_isVDLSystemRunning) then {
		null = [] spawn KISKA_fnc_viewDistanceLimiter;
	} else {
		VDL_GLOBAL_RUN = true;
	};
} else {
	VDL_GLOBAL_RUN = false;
};