/* ----------------------------------------------------------------------------
Function: BLWK_fnc_updateFlareEffects

Description:
	Due to the local nature of many light commands, this function is used
	 to sync up the brightness increase of the flares launched in the support function.

Parameters:
	0: _light <OBJECT> - The #lightPoint attached to the flare
	1: _flare <OBJECT> - The flare object

Returns:
	NOTHING

Examples:
    (begin example)
		[_light,_flare] remoteExecCall ["BLWK_fnc_updateFlareEffects",BLWK_allClientsTargetId,_flare];
    (end)

Authors:
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
scriptName "BLWK_fnc_updateFlareEffects";

if (!hasInterface) exitWith {};

params ["_light","_flare"];

if (isNull _flare) exitWith {
	["_flare is null, exiting..."] call KISKA_fnc_log;
	nil
};

_light setLightColor [1, 1, 1];
_light setLightAmbient [1, 1, 1];
_light setLightIntensity 100000;
_light setLightUseFlare true;
_light setLightFlareSize 10;
_light setLightFlareMaxDistance 600;
_light setLightDayLight true;
_light setLightAttenuation [4, 0, 0, 0.2, 1000, 2000];