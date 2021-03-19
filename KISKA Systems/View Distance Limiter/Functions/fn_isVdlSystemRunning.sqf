/* ----------------------------------------------------------------------------
Function: KISKA_fnc_isVdlSystemRunning

Description:
	Checks to see whether the global var that controls the VDL loop is currently
	 true.

Parameters:
	NONE
	
Returns:
	BOOL 

Examples:
	(begin example)
		_isSystemRunning = call KISKA_fnc_isVdlSystemRunning;
	(end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
disableSerialization;
if (!hasInterface) exitWith {false};

#include "..\ViewDistanceLimiterCommonDefines.hpp"

private _isRunning = missionNamespace getVariable [VDL_GLOBAL_RUN_STR,false];

_isRunning