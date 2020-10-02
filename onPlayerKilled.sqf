params ["_oldUnit"];

// remove handle damage event from corpse as it will continue to fire otherwise
[_oldUnit] call BLWK_fnc_removeReviveEhs;

if !(missionNamespace getVariable ["BLWK_inBetweenRounds",false]) then { // free respawn in build phase
	_respawnTickets = [west, -1] call BIS_fnc_respawnTickets;
	if (_respawnTickets <= 0) then {
		missionNamespace setVariable ["BLWK_respawnTime",99999,true];
		[BLWK_respawnTime] remoteExec ["setPlayerRespawnTime", 0];
	} else {
		// CIPHER COMMENT: Do you really need to set this on all machines almost every respawn?
		[0] remoteExec ["setPlayerRespawnTime",0];
	};
};

sleep 0.1;

// CIPHER COMMENT: is there anything stopping players from immediately respawning? if so, what is it?

if(!isNull _oldUnit) then {
    ["Initialize", [_oldUnit, [west], false, true, true, false, true, true, true, true]] call BIS_fnc_EGSpectator;
};
