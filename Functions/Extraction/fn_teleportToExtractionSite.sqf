/* ----------------------------------------------------------------------------
Function: BLWK_fnc_teleportToExtractionSite

Description:
    Fades a player's screen to black and then teleports them to the extraction
     area.

Parameters:
	0: _position : <ARRAY> - An array [a,b] that is the ceneter position of the
     extraction site

Returns:
    NOTHING

Examples:
    (begin example)

    (end)

Author(s):
	Ansible2
---------------------------------------------------------------------------- */
scriptName "BLWK_fnc_teleportToExtractionSite";

#define LAYER_NAME "BLWK_extractionFade"
#define FADE_SPEED 3
#define RAND_POS_RADIUS 20;

if (!hasInterface) exitWith {};

if (!canSuspend) exitWith {
    _this spawn BLWK_fnc_teleportToExtractionSite;
};


params ["_position"];

LAYER_NAME cutText ["Teleporting To Extraction Site...","BLACK IN",FADE_SPEED];
sleep 3;

private _teleportPos = [_position, RAND_POS_RADIUS] call CBAP_fnc_randPos;
missionNamespace setVariable ["BLWK_enforceArea",false];


waitUntil {
    !(missionNamespace getVariable ["BLKW_enforceAreaRunning",false]);
};


player setPos _teleportPos;
LAYER_NAME cutText ["Teleporting To Extraction Site...","BLACK IN",FADE_SPEED];
