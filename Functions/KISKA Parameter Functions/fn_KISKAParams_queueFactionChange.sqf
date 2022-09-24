/* ----------------------------------------------------------------------------
Function: BLWK_fnc_KISKAParams_queueFactionChange

Description:
    Sets the variable for the all machines that indicates whether factions are
     queued to change at the next available point (end of the current wave)

Parameters:
	NONE

Returns:
    NOTHING

Examples:
    (begin example)
        call BLWK_fnc_KISKAParams_queueFactionChange;
    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
scriptName "BLWK_fnc_KISKAParams_queueFactionChange";

if (!isServer) exitWith {};

params [
    "_newFactionName",
    "_varName"
];


if (BLWK_inBetweenWaves) then {
    [[_newFactionName],true] call BLWK_fnc_setupFactionMaps;

} else {
    private _queue = localNamespace getVariable ["BLWK_factionChangeQueue",[]];
    _queue pushBack _varName;
    localNamespace setVariable ["BLWK_factionChangeQueue",_queue];
};
