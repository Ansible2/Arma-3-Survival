params ["_oldUnit"];

// remove handle damage event from corpse as it will continue to fire otherwise
[_oldUnit] call BLWK_fnc_removeReviveEhs;

// free respawn if we are between waves
if !(missionNamespace getVariable ["BLWK_inBetweenWaves",false]) then { 
	private _respawnTickets = [BLUFOR] call BIS_fnc_respawnTickets;
	// The server will update respawn times to revive people at the end of the round
	if (_respawnTickets <= 0) then {
		setPlayerRespawnTime 99999;
		//missionNamespace setVariable ["BLWK_respawnTime",99999,true];
		//[BLWK_respawnTime] remoteExec ["setPlayerRespawnTime", 0];
	} else {
		[BLUFOR,-1] call BIS_fnc_respawnTickets;
		missionNamespace setVariable ["BLWK_numRespawnTickets",_respawnTickets - 1,true];
		setPlayerRespawnTime BLWK_respawnTime;
	};
};

sleep 0.1;

if(!isNull _oldUnit) then {
    ["Initialize", [_oldUnit, [west], false, true, true, false, true, true, true, true]] call BIS_fnc_EGSpectator;
};
