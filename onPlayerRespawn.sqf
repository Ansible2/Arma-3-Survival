params ["_player"];

["Terminate"] call BIS_fnc_EGSpectator;

_player setVehiclePosition [bulwarkBox,[],5,"NONE"];

//remove and add gear
if !(BLWK_saveRespawnLoadout) then {
    // check if the player should have any default items (per mission params)
    // i.e. radio, compass, pistol, etc.
    [_player] call BLWK_fnc_addPlayerItems;
} else {
    _player setUnitLoadout BLWK_savedLoadout;
};

[_player] call BLWK_fnc_addReviveEhs;

// Lower recoil, lower sway, remove stamina, make medic and engineer
[_player] call BLWK_fnc_adjustPlayerTraits;

[_player] call BLWK_fnc_initDragSystem;

[_player] joinSilent BLWK_playerGroup;

// should be free respawns unless it is during a wave
if !(missionNamespace getVariable ["BLWK_inBetweenWaves",false]) then { 
    private _remainingTickets = [BLUFOR,-1] call BIS_fnc_respawnTickets;
    missionNamespace setVariable ["BLWK_numRespawnTickets",_remainingTickets,true];
};

[false] call BLWK_fnc_reassignCurator;