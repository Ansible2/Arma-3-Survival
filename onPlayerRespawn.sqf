params ["_player"];

["Terminate"] call BIS_fnc_EGSpectator;

_player setVehiclePosition [BLWK_mainCrate,[],5,"NONE"];

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

// handle if someone died while an aircraft gunner
if (missionNamespace getVariable ["BLWK_isAircraftGunner",false]) then {
    missionNamespace setVariable ["BLWK_isAircraftGunner",false];
};



// make players briefly invincible
_player allowDamage false;
[] spawn {
    sleep 15;
    player allowDamage true;
};
