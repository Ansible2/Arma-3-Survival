if (!(call BIS_fnc_admin > 0) AND {clientOwner != 2}) exitWith {
	hint "Only admins and hosts can adjust params";
};

params [
	["_saveParams",true,[true]]
];

if (_saveParams) then {
	remoteExecCall ["BLWK_fnc_saveAllMissionParameters",2];
} else {
	remoteExecCall ["BLWK_fnc_deleteSavedMissionParameters",2];
};