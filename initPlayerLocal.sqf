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

hitMarkers = [];

//Show the Bulwark label on screen
// CIPHER COMMENT: change this to an addMissionEventHandler
onEachFrame {
    if(!isNil "bulwarkBox") then {
        _textPos = getPosATL bulwarkBox vectorAdd [0, 0, 1.5];
        drawIcon3D ["", [1,1,1,0.5], _textPos, 1, 1, 0, "Bulwark", 0, 0.04, "RobotoCondensed", "center", true];
    };

    if (BLWK_hitPointsShown) then {
      {
          _pos    = _x select 0;
          _label  = _x select 1;
          _unit   = _x select 2;
          _age    = _x select 3;
          _active = _x select 4;
          _colour = _x select 5;

          if(_active) then {
              _x set [3, _age + 1];

              _alpha = 1;
              _scale = 0;
              if(_age > 0 && _age <= 10) then {
                  _scale = 0.035 * _age / 10;
              };
              if(_age > 10) then {
                  _scale = 0.035;
              };
              if(_age > 30 && _age <= 40) then {
                  _alpha = 1 - ((_age - 40) / 10);
              };
              _textPos = _pos vectorAdd [0, 0, 1 +_age / 100];

              if(_age > 40) then {_x set [4, false];};
              drawIcon3D ["", [_colour select 0, _colour select 1, _colour select 2, _alpha], _textPos, 1, 1, 0, format ["%1", _label], 0, _scale, "RobotoCondensed", "center", false];
          };
      } foreach hitMarkers;
    };
};


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