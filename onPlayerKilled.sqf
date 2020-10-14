params ["_oldUnit"];

// see BLWK_fnc_stalkPlayers: used for getting an even distribution of AI to move to players
player setVariable ["BLWK_stalkerAmount",0];

// remove handle damage event from corpse as it will continue to fire otherwise
[_oldUnit] call BLWK_fnc_removeReviveEhs;

// free respawn if we are between waves
if !(missionNamespace getVariable ["BLWK_inBetweenWaves",false]) then { 

	private _respawnTickets = [BLUFOR] call BIS_fnc_respawnTickets;
	if (_respawnTickets <= 0) then {
		setPlayerRespawnTime 99999;
		["Initialize", [player, [west], false, true, true, false, true, true, true, true]] call BIS_fnc_EGSpectator;
	};
};