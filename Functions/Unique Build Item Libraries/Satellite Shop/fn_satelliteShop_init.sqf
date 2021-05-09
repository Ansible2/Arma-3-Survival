/* ----------------------------------------------------------------------------
Function: BLWK_fnc_satelliteShop_init

Description:
	Initializes the item reclaimer object.

	Executed from its onPurchasedPostFix event added in the config "main build items.hpp"

Parameters:
	0: _satelliteObject : <OBJECT> - The satellite shop object

Returns:
	NOTHING

Examples:
    (begin example)
		[anObject] call BLWK_fnc_satelliteShop_init;
    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
scriptName "BLWK_fnc_satelliteShop_init";

params ["_satelliteObject"];

if (isNull _satelliteObject) exitWith {
	["_satelliteObject was null, exiting...",true] call KISKA_fnc_log;
	nil
};

[_satelliteObject] remoteExecCall ["BLWK_fnc_satelliteShop_preparePlayer",BLWK_allClientsTargetID,_satelliteObject];

private _waveToDeleteOn = BLWK_currentWaveNumber + 2;
if (BLWK_inBetweenWaves) then {
	_waveToDeleteOn = _waveToDeleteOn + 1;
};

[_satelliteObject,_waveToDeleteOn] remoteExecCall ["BLWK_fnc_satelliteShop_addDeleteEvent",2];


nil
