/* ----------------------------------------------------------------------------
Function: KISKA_fnc_musicEventHandlers

Description:
	A preInit function to create the required music event handlers for
	 KISKA music functions

Parameters:
	NONE

Returns:
	NONE

Examples:
    (begin example)
		PREINIT FUNCTION
    (end)

Author(s):
	Ansible2
---------------------------------------------------------------------------- */
scriptName "KISKA_fnc_musicEventHandlers";

if (!hasInterface) exitWith {};

if (call KISKA_fnc_isMainMenu) exitWith {
	["Main menu detected, will not init",false] call KISKA_fnc_log;
	nil
};

["Added KISKA music event handlers",false] call KISKA_fnc_log;

addMusicEventHandler ["MusicStart", {
	_this call KISKA_fnc_musicStartEvent;
}];


addMusicEventHandler ["MusicStop", {
	[false] call KISKA_fnc_musicStopEvent;
}];


nil
