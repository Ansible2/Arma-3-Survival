params [
	["_player",player]
];

// Lower recoil, lower sway, remove stamina on respawn, make medic and engineer
[_player] call BLWK_fnc_adjustPlayerTraits;

//setup Kill Points
private _startingKillPoints = ("BLWK_startingKillPoints" call BIS_fnc_getParamValue);
missionNamespace setVariable ["BLWK_playerKillPoints",_startingKillPoints];

// adds starter items if selected (map, NVGs, pistol, etc.)
[_player] call BLWK_fnc_addPlayerItems;

[_player] call BLWK_fnc_addDiaryEntries;

// vanilla mag repack
if (BLWK_magRepackEnabled) then {
    waituntil {!isNull (findDisplay 46)};
    
    (findDisplay 46) displayAddEventHandler ["KeyDown",{

        // passes the pressed key and whether or not a ctrl key is down. The proper combo is ctrl+R
        if ((_this select 0) isEqualTo 19 AND {_this select 3}) exitWith {
            call BLWK_fnc_doMagRepack;
        };
    }];
};

waitUntil {!isNil "BLWK_playAreaCenter"};
_player setVehiclePosition [bulwarkBox,[],2,"NONE"];

// keeps the mission area
null = [] spawn BLWK_fnc_playAreaEnforcementLoop;
// a loop that updates the info panel in the top left (respawn tickets, current wave #)
null = [] spawn BLWK_fnc_infoPanelLoop;

// for preventing damage under certain cirumstances (friendly fire for one)
// also revives the player if they go down with a medkit in inventory
[_player] call BLWK_fnc_handleDamagePlayer;