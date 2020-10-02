params ["_player"];

// CIPHER COMMENT: this is also exec'd on all machines by the server at the end of a wave
// decide where to actually put it
["Terminate"] call BIS_fnc_EGSpectator;

_player setVehiclePosition [bulwarkBox,[],2,"NONE"];

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