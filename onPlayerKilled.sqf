params ["_oldUnit"];

// remove handle damage event from corpse as it will continue to fire otherwise
_oldUnit removeEventHandler ["handleDamage",BLWK_dammagedEventHandler];
BLWK_dammagedEventHandler = nil;

if !(missionNamespace getVariable ["BLWK_inBetweenRounds",false]) then { // free respawn in build phase
	_respawnTickets = [west, -1] call BIS_fnc_respawnTickets;
	if (_respawnTickets <= 0) then {
		BLWK_respawnTime = 99999;
		publicVariable "BLWK_respawnTime";
		[BLWK_respawnTime] remoteExec ["setPlayerRespawnTime", 0];
	} else {
		[0] remoteExec ["setPlayerRespawnTime", 0];
	};
};

sleep 0.1;
if(!isNull _oldUnit) then {
    ["Initialize", [_oldUnit, [west], false, true, true, false, true, true, true, true]] call BIS_fnc_EGSpectator;
};
