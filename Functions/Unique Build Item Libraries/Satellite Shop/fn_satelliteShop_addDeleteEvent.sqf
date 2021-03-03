/* ----------------------------------------------------------------------------
Function: BLWK_fnc_satelliteShop_addDeleteEvent

Description:
	Adds a 

Parameters:
	0: _satellitObject : <OBJECT> - The satellite shop object

Returns:
	NOTHING

Examples:
    (begin example)
		[anObject] call BLWK_fnc_satelliteShop_addDeleteEvent;
    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
scriptName "BLWK_fnc_satelliteShop_addDeleteEvent";

if (!isServer) exitWith {
	["Must be run on server",true] call KISKA_fnc_log;
};

params [
	"_satellitObject",
	"_waveToDeleteOn"
];

if (isNull _satellitObject) exitWith {
	["_satellitObject was null, exiting...",true] call KISKA_fnc_log;
	nil
};

missionNamespace setVariable ["BLWK_satelliteShopObject",_satellitObject];
missionNamespace setVariable ["BLWK_deleteSatShopOnWave",_waveToDeleteOn];

[missionNamespace,"BLWK_onWaveStart",{
	private _waveToDeleteOn = missionNamespace getVariable "BLWK_deleteSatShopOnWave";
	if (BWLK_currentWaveNumber isEqualTo _waveToDeleteOn) then {
		private _satellitObject = missionNamespace getVariable "BLWK_satelliteShopObject";
		deleteVehicle _satellitObject;
		
		missionNamespace setVariable ["BLWK_satShopOut",false,true];
		[missionNamespace,"BLWK_onWaveStart",_thisScriptedEventHandler] call BIS_fnc_removeScriptedEventHandler;
	};
}] call BIS_fnc_addScriptedEventHandler;