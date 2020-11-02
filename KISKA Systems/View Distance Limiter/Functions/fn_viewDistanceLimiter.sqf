/* ----------------------------------------------------------------------------
Function: KISKA_fnc_viewDistanceLimiter

Description:
	Starts a looping function for limiting a player's viewDistance.
	Loop can be stopped by setting mission variable "KISKA_VDL_run" to false.
	All other values have global vars that can be edited while it is in use.
	
	See each param for associated global var.

Parameters:

	0: _targetFPS <NUMBER> - The desired FPS (lower) limit (KISKA_VDL_fps)
	1: _checkFreq <NUMBER> - The frequency of checks for FPS (KISKA_VDL_freq)
	2: _minObjectDistance <NUMBER> - The minimum the objectViewDistance, can be set by (KISKA_VDL_minDist)
	3: _maxObjectDistance <NUMBER> - The max the objectViewDistance, can be set by (KISKA_VDL_maxDist)
	4: _increment <NUMBER> - The amount the viewDistance can incriment up or down each cycle (KISKA_VDL_inc)
	5: _viewDistance <NUMBER> - This is the static overall viewDistance, can be set by (KISKA_VDL_viewDist)
								 This is static because it doesn't affect FPS too much.

Returns:
	NOTHING 

Examples:
	(begin example)

		Every 3 seconds, check
		[45,3,500,1700,3000,25] spawn KISKA_fnc_viewDistanceLimiter; 

	(end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
if (!hasInterface OR {!canSuspend}) exitWith {
	"Must be run in scheduled environment." call BIS_fnc_error;
};

#include "..\ViewDistanceLimiterCommonDefines.hpp"

params [
	["_targetFPS",missionNamespace getVariable [VDL_GLOBAL_FPS_STR,60],[123]],
	["_checkFreq",missionNamespace getVariable [VDL_GLOBAL_FREQ_STR,3],[123]],
	["_minObjectDistance",missionNamespace getVariable [VDL_GLOBAL_MIN_DIST_STR,500],[123]],
	["_maxObjectDistance",missionNamespace getVariable [VDL_GLOBAL_MAX_DIST_STR,1700],[123]],
	["_increment",missionNamespace getVariable [VDL_GLOBAL_INC_STR,25],[123]],
	["_viewDistance",missionNamespace getVariable [VDL_GLOBAL_VIEW_DIST_STR,3000],[123]]
];

VDL_GLOBAL_RUN = true;
VDL_GLOBAL_FPS = _targetFPS;
VDL_GLOBAL_FREQ = _checkFreq;
VDL_GLOBAL_MIN_DIST = _minObjectDistance;
VDL_GLOBAL_MAX_DIST = _maxObjectDistance;
VDL_GLOBAL_VIEW_DIST = _viewDistance;
VDL_GLOBAL_INC = _increment;

private "_objectViewDistance";
private _fn_moveUp = {
	if (_objectViewDistance < VDL_GLOBAL_MAX_DIST) exitWith {
		setObjectViewDistance (_objectViewDistance + VDL_GLOBAL_INC);
	};
	if (_objectViewDistance > VDL_GLOBAL_MAX_DIST) exitWith {
		setObjectViewDistance VDL_GLOBAL_MAX_DIST;
	};
};
private _fn_moveDown = {
	if (_objectViewDistance > VDL_GLOBAL_MIN_DIST) exitWith {
		setObjectViewDistance (_objectViewDistance - VDL_GLOBAL_INC);
	};
	if (_objectViewDistance < VDL_GLOBAL_MIN_DIST) exitWith {
		setObjectViewDistance VDL_GLOBAL_MIN_DIST;
	};
};
while {sleep VDL_GLOBAL_FREQ; VDL_GLOBAL_RUN} do {
	_objectViewDistance = getObjectViewDistance select 0;

	if (VDL_GLOBAL_VIEW_DIST != viewDistance) then {
		setViewDistance VDL_GLOBAL_VIEW_DIST;
	};

	// is fps at target?
	if (diag_fps < VDL_GLOBAL_FPS) then {
		// not at target fps
		call _fn_moveDown;
	} else {
		// at target fps
		call _fn_moveUp;
	};
};