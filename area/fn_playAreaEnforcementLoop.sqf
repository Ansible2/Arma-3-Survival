/* ----------------------------------------------------------------------------
Function: BLWK_fnc_playAreaEnforcementLoop

Description:
	Starts the loop that plays the effects and teleports players back into bulwark bounds
	
	It is executed from the "initPlayerLocal.sqf"
	
Parameters:
	NONE

Returns:
	Nothing

Examples:
    (begin example)

		null = [] spawn BLWK_fnc_playAreaEnforcementLoop;

    (end)
---------------------------------------------------------------------------- */
if (!hasInterface) exitWith {};
// In the interest of potentially changing the play area dynamically, these percentages of the play area radius will not be cached

waitUntil {player isEqualTo player};

/*
 Each one of these functions checks the successive distance percentage to see if the player is farther away.
 this is so that they do not overlay text on top of each other and to allow one condition check for 
 the vast majority of the time which is when the player is WITHIN the boundries
*/
private _fn_90percentFromCenter = {
	if (BLWK_playerDistanceToBulwark >= BLWK_playAreaRadius * 0.95) then {
		call _fn_95percentFromCenter;
	} else {
		["<t color='#ffffff'>Warning: Leaving mission area!</t>", 0, 0.1, 2, 0] spawn BIS_fnc_dynamicText;
	};
};
private _fn_95percentFromCenter = {
	if (BLWK_playerDistanceToBulwark >= BLWK_playAreaRadius * 0.99) then {
		call _fn_99percentFromCenter;
	} else {
		["<t color='#ffff00'>Warning: Leaving mission area!</t>", 0, 0.1, 2, 0] spawn BIS_fnc_dynamicText;
	};
};
private _fn_99percentFromCenter = {
	if (BLWK_playerDistanceToBulwark >= BLWK_playAreaRadius * 1.1) then {
		call _fn_110percentFromCenter;
	} else {
		["<t color='#ff0000'>Warning: Leaving mission area!</t>", 0, 0.1, 2, 0] spawn BIS_fnc_dynamicText;
	};
};
private _fn_110percentFromCenter = {
	if (BLWK_playerDistanceToBulwark > BLWK_playAreaRadius * 2) then {
		call _fn_200percentFromCenter;
	} else {
		// blur screen
		private _effectHandle = ppEffectCreate ["DynamicBlur",200];
		_effectHandle ppEffectEnable true;
		_effectHandle ppEffectAdjust [10];
		
		playSound "teleportHit";

		// put player back eight meters
		private _dir = BLWK_playAreaCenter getDir _player;
		private _eightMetersBack = BLWK_playAreaCenter getPos [(BLWK_playAreaRadius * 1.1)-8, _dir];
		player setPos _eightMetersBack;

		// delete effects
		_effectHandle ppEffectAdjust [0];
		sleep 0.5;
		ppEffectDestroy _effectHandle;
	};
};
private _fn_200percentFromCenter = {
	private _radius = 2;
	waitUntil {
		if (player setVehiclePosition [bulwarkBox,[],_radius]) exitWith {true}
		_radius = _radius + 0.5;
		sleep 1;
		false;
	};
	hint "Get back here you...";
};

while {sleep 2; true} do {
	_playerDistanceToBulwark = player distance2D BLWK_playAreaCenter

	if (_playerDistanceToBulwark >= (BLWK_playAreaRadius * 0.9)) then {
		BLWK_playerDistanceToBulwark = _playerDistanceToBulwark;
		call _fn_90percentFromCenter;
	};
};