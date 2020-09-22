params [
	["_player",player]
];

// Lower recoil, lower sway, remove stamina on respawn, make medic and engineer
[_player] call BLWK_fnc_adjustPlayerTraits;

private _startingKillPoints ("BLWK_startingKillPoints" call BIS_fnc_getParamValue);
_player setVariable ["RevByMedikit", false, true];

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

null = [] spawn BLWK_fnc_playAreaEnforcementLoop;












//setup Kill Points
_killPoints = ("BLWK_startingKillPoints" call BIS_fnc_getParamValue);
_player setVariable ["killPoints", _killPoints, true];
call killPoints_fnc_updateHud;


//Make player immune to fall damage and immune to all damage while incapacitated
waitUntil {!isNil "BLWK_friendlyFireOn"};
_player removeAllEventHandlers 'HandleDamage';
_player addEventHandler ["HandleDamage", {
    _beingRevived = player getVariable "RevByMedikit";
    BLWK_friendlyFireOn = missionNamespace getVariable "BLWK_friendlyFireOn";
    _incDamage = _this select 2;
    _hitpoint = _this select 5;
    _currentPointDamage = player getHitIndex _hitpoint;
    _totalDamage = _incDamage + _currentPointDamage;
    _playerItems = items player;
    _players = allPlayers;
    if ((_this select 4) == "" || lifeState player == "INCAPACITATED" || _beingRevived || ((_this select 3) in _players && !BLWK_friendlyFireOn && !((_this select 3) isEqualTo player))) then {
        0
    } else {
        if (_totalDamage >= 0.89) then {
        _playerItems = items player;
            if ("Medikit" in _playerItems) then {
            player removeItem "Medikit";
            player setVariable ["RevByMedikit", true, true];
            player playActionNow "agonyStart";
            player playAction "agonyStop";
            player setDamage 0;
            [player] remoteExec ["bulwark_fnc_revivePlayer", 2];
            0;
            }else{
                _this call bis_fnc_reviveEhHandleDamage;
            };
        } else {
            _this call bis_fnc_reviveEhHandleDamage;
        };
    };
}];

