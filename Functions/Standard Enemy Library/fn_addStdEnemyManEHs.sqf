params ["_unit"];

if (!local _unit) exitWith {false};

// Didn't use MPHit event to avoid the networking of it to every client
[_unit] remoteExecCall ["BLWK_fnc_addStdEnemyHitEH",BLWK_allClientsTargetID,true];

_unit addMPEventHandler ["mpKilled",{
	[_this,_thisEventHandler] call BLWK_fnc_stdEnemyKilledEvent;
}];

true