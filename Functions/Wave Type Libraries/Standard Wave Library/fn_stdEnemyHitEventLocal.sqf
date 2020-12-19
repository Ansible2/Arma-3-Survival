params ["_hitUnit", "_source", "_damage", "_instigator"];

if (!(isNull _instigator) AND {isPlayer _instigator}) then {
	// show a player hit points and add them to there score
	[_hitUnit,_damage] remoteExecCall ["BLWK_fnc_handleHitEventPlayer",_instigator];
};