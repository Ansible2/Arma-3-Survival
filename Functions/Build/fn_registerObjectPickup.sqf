if (!hasInterface) exitWith {};

params [
	["_object",objNull,[objNull]],
	["_pickedUp",true,[true]]
];

if (isNull _object) exitWith {
	["BLWK_fnc_registerObjectPickedUp",["Null object asked for:",_object,"from remoteExecutedOwner",remoteExecutedOwner]] call KISKA_fnc_log;
};

[_object,true] remoteExecCall ["BLWK_fnc_registerObjectPickup",BLWK_allClientsTargetId,true];