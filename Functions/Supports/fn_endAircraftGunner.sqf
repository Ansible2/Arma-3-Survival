/* ----------------------------------------------------------------------------
Function: BLWK_fnc_endAircraftGunner

Description:
	Stops a player's use of their current aircraft gunner support.

	This is a companion function that is meant to be called after a running of
	 BLWK_fnc_startAircraftGunner.

Parameters:
	NONE

Returns:
    NOTHING

Examples:
    (begin example)
        call BLWK_fnc_endAircraftGunner;
    (end)

Author(s):
    Ansible2
---------------------------------------------------------------------------- */
scriptName "BLWK_fnc_endAircraftGunner";

if (
	(!hasInterface) OR 
	!(missionNamespace getVariable ["BLWK_isAircraftGunner",false])
) exitWith {};


(localNamespace getVariable ["BLWK_aircraftGunnerEndData",[]]) params [
	["_holdActionIdsToRemove",[],[[]]],
	["_vehicle",objNull,[objNull]],
	["_vehicleGroup",grpNull,[grpNull]],
	["_supportTypeInUseVariableName","",[""]],
	["_VDLWasRunning",false,[true]],
	["_damageAllowedAdjustmentId",-1,[123]],
	["_soundAdjustId",-1,[123]]
];

missionNamespace setVariable ["BLWK_isAircraftGunner",false];

setViewDistance -1;
setObjectViewDistance -1;

if (_VDLWasRunning) then {
	[] spawn KISKA_fnc_viewDistanceLimiter;
};

moveOut player;
player setVehiclePosition [BLWK_mainCrate,[],5,"NONE"];
player setVelocity [0,0,0];
[player,true] call BLWK_fnc_adjustStalkable;

_holdActionIdsToRemove apply {
	[player,_x] call BIS_fnc_holdActionRemove;
};


(units _vehicleGroup) apply {
	_vehicle deleteVehicleCrew _x;
};
deleteGroup _vehicleGroup;
deleteVehicle _vehicle;

// allow other users to access the support type again
missionNamespace setVariable [_supportTypeInUseVariableName,false,true];

[false] call BLWK_fnc_playAreaEnforcementLoop;

[
	"BLWK_manage_aircraftSound",
	[3, (localNamespace getVariable "BLWK_soundVolume"),true],
	localNamespace,
	_soundAdjustId
] call KISKA_fnc_managedRun_execute;

[
	{
		[player,false,_damageAllowedAdjustmentId] call BLWK_fnc_allowDamage;
	},
	[_damageAllowedAdjustmentId],
	10
] call CBAP_fnc_waitAndExecute;

localNamespace setVariable ["BLWK_aircraftGunnerEndData",nil];

nil
