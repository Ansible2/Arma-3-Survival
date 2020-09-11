params [
	["_player",player]
];

_player setCustomAimCoef 0.2;
_player setUnitRecoilCoefficient 0.5;
_player enableStamina FALSE;
"BLWK_startingKillPoints" call BIS_fnc_getParamValue;
_player setVariable ["RevByMedikit", false, true];
_player setVariable ["buildItemHeld", false];

// Lower recoil, lower sway, remove stamina on respawn
_player addEventHandler ['Respawn',{
    player setCustomAimCoef 0.2;
    player setUnitRecoilCoefficient 0.5;
    player enableStamina false;
}];

[_player] call BLWK_fnc_addDiaryEntries;

//setup Kill Points
_killPoints = ("BLWK_startingKillPoints" call BIS_fnc_getParamValue);
_player setVariable ["killPoints", _killPoints, true];
call killPoints_fnc_updateHud;

// Delete all map markers on clients
//CIPHER COMMENT: why are there map markers?
{
    _currMarker = toArray _x;
    if(count _currMarker >= 4) then {
        _currMarker resize 8; _currMarker = toString _currMarker;
        if(_currMarker == "bulwark_") then{ deleteMarker _x; };
    };
} foreach allMapMarkers;


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

waitUntil {!isNil "BLWK_playAreaCenter"};

// kill player if they disconnected and rejoined during a wave
_buildPhase = missionNamespace getVariable ["buildPhase", true];
waitUntil {alive _player && !isnil "playersInWave" && !isnil "attkWave"};

if (getPlayerUID _player in playersInWave && attkWave > 0 && !_buildPhase) then {
    _player setDamage 1;
};


// vanilla mag repack
if (BLWK_magRepackEnabled) then {
    waituntil {!isNull (findDisplay 46)};
    
    (findDisplay 46) displayAddEventHandler ["KeyDown",{

        // passes the pressed key and whether or not a ctrl key is down. The proper combo is ctrl+R
        if ((_this select 0) isEqualTo 19 AND {_this select 3}) exitWith {
            call BLWK_fnc_magRepack;
        };
    }];
};

null = [] spawn BLWK_fnc_playAreaEnforcementLoop;