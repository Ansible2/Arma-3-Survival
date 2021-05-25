/* ----------------------------------------------------------------------------
Function: BLWK_fnc_satelliteShop_addDeleteEvent

Description:
	Adds a wave start eventhandler that will delete the satellite shop object.

Parameters:
	0: _satelliteObject : <OBJECT> - The satellite shop object

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
	"_satelliteObject",
	"_waveToDeleteOn"
];

if (isNull _satelliteObject) exitWith {
	["_satelliteObject was null, exiting...",true] call KISKA_fnc_log;
	nil
};

missionNamespace setVariable ["BLWK_satelliteShopObject",_satelliteObject];
missionNamespace setVariable ["BLWK_deleteSatShopOnWave",_waveToDeleteOn];

[missionNamespace,"BLWK_onWaveStart",{
	private _waveToDeleteOn = missionNamespace getVariable "BLWK_deleteSatShopOnWave";
	if (BLWK_currentWaveNumber isEqualTo _waveToDeleteOn) then {
		private _satelliteObject = missionNamespace getVariable "BLWK_satelliteShopObject";
		deleteVehicle _satelliteObject;

		missionNamespace setVariable ["BLWK_satShopOut",false,true];
		[missionNamespace,"BLWK_onWaveStart",_thisScriptedEventHandler] call BIS_fnc_removeScriptedEventHandler;
	};
}] call BIS_fnc_addScriptedEventHandler;


nil
