if !(isServer) exitWith {};

if !(isNil {profileNamespace getVariable "BLWK_savedMissionParameters"}) then {
	profileNamespace setVariable ["BLWK_savedMissionParameters",nil];
	saveProfileNamespace;

	["Parameteres were reset"] remoteExecCall ["hint",remoteExecutedOwner];
} else {
	["There were no parameters to reset"] remoteExecCall ["hint",remoteExecutedOwner];
};