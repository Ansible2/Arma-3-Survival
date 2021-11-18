/* ----------------------------------------------------------------------------
Function: BLWK_fnc_KISKAParams_updateFactionClasses

Description:
    Sets the variable for the all machines that indicates whether factions are
     queued to change at the next available point (end of the current wave)

Parameters:
	NONE

Returns:
    NOTHING

Examples:
    (begin example)
        call BLWK_fnc_KISKAParams_updateFactionClasses;
    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
scriptName "BLWK_fnc_KISKAParams_updateFactionClasses";

if (!isServer) exitWith {};

if !(missionNamespace getVariable ["BLWK_factionChangeQueued",false]) then {
    missionNamespace setVariable ["BLWK_factionChangeQueued",true,true];
};
