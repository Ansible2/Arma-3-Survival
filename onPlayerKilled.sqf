_player = _this select 0;
_buildPhase = missionNamespace getVariable "buildPhase";

if (!_buildPhase) then { // free respawn in build phase
	_respawnTickets = [west, -1] call BIS_fnc_respawnTickets;
	if (_respawnTickets <= 0) then {
		BLWK_respawnTime = 99999;
		publicVariable "BLWK_respawnTime";
		[BLWK_respawnTime] remoteExec ["setPlayerRespawnTime", 0];
	} else {
    [0] remoteExec ["setPlayerRespawnTime", 0];
  }
};

sleep 0.1;
if(!isNull _player) then {
    ["Initialize", [_player, [west], false, true, true, false, true, true, true, true]] call BIS_fnc_EGSpectator;
};
