/**
*  fn_add
*
*  Adds score to the specified player
*
*  Domain: Server
**/

if (isServer) then {
	_player = _this select 0;
	_points = _this select 1;
	_killPoints = missionNamespace getVariable ["BLWK_playerKillPoints",0];
	if(isNil "_killPoints") then {
		_killPoints = 0;
	};
	_killPoints = round (_killPoints + _points);
	_player setVariable ["killPoints", _killPoints, true];

	[] remoteExec ["killPoints_fnc_updateHud", _player];
};
