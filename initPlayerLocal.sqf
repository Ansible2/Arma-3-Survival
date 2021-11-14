waitUntil {
	if (localNamespace getVariable ["KISKA_missionParams_preloadFinished",false]) exitWith {true};
    sleep 0.1;
	false
};

waitUntil {
	if (missionNamespace getVariable ["BLWK_serverGlobalsInitialized",false]) exitWith {true};
    sleep 0.1;
	false
};

// if you are a client and not a mission host, you now prep your globals
if (!isServer) then {
	call BLWK_fnc_prepareGlobals;
};

// headless client only needs BLWK_fnc_prepareGlobals
if (!hasInterface) exitWith {};

waitUntil {
    if !(isNull player) exitWith {true};
    sleep 0.1;
    false
};

private _player = player;
_player allowDamage false;

// Lower recoil, lower sway, remove stamina on respawn, make medic and engineer
[_player] call BLWK_fnc_adjustPlayerTraits;

//setup Kill Points
missionNamespace setVariable ["BLWK_playerKillPoints",BLWK_startingKillPoints];


// adds starter items if selected (map, NVGs, pistol, etc.)
waitUntil {
	sleep 0.1;
	!isNil "BLWK_uniformClass";
};

[_player] call BLWK_fnc_addPlayerItems;

[_player] call BLWK_fnc_addDiaryEntries;

[_player] call BLWK_fnc_addACESupportMenuAction;

[] spawn BLWK_fnc_handleUnconsciousAiEvent;

// vanilla mag repack
if (BLWK_magRepackEnabled) then {
    waituntil {!isNull (findDisplay 46)};

    (findDisplay 46) displayAddEventHandler ["KeyDown",{

        // passes the pressed key and whether or not a ctrl key is down. The proper combo is ctrl+R
        if ((_this select 1) isEqualTo 19 AND {_this select 3}) exitWith {
            [player,true] call BLWK_fnc_doMagRepack;
        };
    }];
};

// wait till the play area is defined
waitUntil {!isNil "BLWK_playAreaCenter" AND {!isNil "BLWK_mainCrate"}};
_player setVehiclePosition [BLWK_mainCrate,[],5,"NONE"];
sleep 0.25;
_player switchMove ""; // set player standing

// a loop that updates the info panel in the top left (respawn tickets, current wave #, points)
[] spawn BLWK_fnc_infoPanelLoop;

// for preventing damage under certain cirumstances (friendly fire for one)
// also revives the player if they go down with a medkit in inventory
[_player] call BLWK_fnc_addReviveEhs;

[_player] call BLWK_fnc_initDragSystem;

[false] call BLWK_fnc_playAreaEnforcementLoop;

_player allowDamage true;

waitUntil {
    sleep 0.1;
    !isNil "BLWK_playerGroup"
};

sleep 1;
[_player] joinSilent BLWK_playerGroup;
