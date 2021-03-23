/* ----------------------------------------------------------------------------
Function: BLWK_fnc_playAreaEnforcementLoop

Description:
	Starts the loop that plays the effects and teleports players back into bounds
	
	It is executed from the "initPlayerLocal.sqf"
	
Parameters:
	0: _force <BOOL> - If true, the loop will auto set BLWK_enforceArea to true

Returns:
	<BOOL> - true if loop created, false otherwise

Examples:
    (begin example)
		call BLWK_fnc_playAreaEnforcementLoop;
    (end)
	
Author(s):
	Hilltop(Willtop) & omNomios,
	Modified by: Ansible2 // Cipher
---------------------------------------------------------------------------- */
scriptName "BLWK_fnc_playAreaEnforcementLoop";

if (!hasInterface) exitWith {false};

if (missionNamespace getVariable ["BLKW_enforceAreaRunning",false]) exitWith {
	["There is already an enforce area loop running, exiting...",true] call KISKA_fnc_log;
	false
};

params [
	["_force",false,[true]]
];

/*
	When players initially join and if not set by another source
	BLWK_enforceArea will be nil
*/
if (isNil "BLWK_enforceArea") then {
	BLWK_enforceArea = true;
};

if (!_force AND {!BLWK_enforceArea}) exitWith {
	["BLWK_enforceArea is set to not run and won't force, exiting..."] call KISKA_fnc_log;
	false
};

if (!BLWK_enforceArea) then {
	BLWK_enforceArea = true
};
missionNamespace setVariable ["BLKW_enforceAreaRunning",true];

[] spawn {
	waitUntil {!isNil "BLWK_mainCrate" AND {!isNil "BLWK_playAreaCenter"}};

	/*
	Each one of these functions checks the successive distance percentage to see if the player is farther away.
	this is so that they do not overlay text on top of each other and to allow one condition check for 
	the vast majority of the time which is when the player is WITHIN the boundries
	*/
	private _fn_90percentFromCenter = {
		if (BLWK_playerDistanceToTheCrate >= BLWK_playAreaRadius * 0.95) then {
			call _fn_95percentFromCenter;
		} else {
			["<t color='#ffffff'>Warning: Leaving mission area!</t>", 0, 0.1, 2, 0] spawn BIS_fnc_dynamicText;
		};
	};
	private _fn_95percentFromCenter = {
		if (BLWK_playerDistanceToTheCrate >= BLWK_playAreaRadius * 0.99) then {
			call _fn_99percentFromCenter;
		} else {
			["<t color='#ffff00'>Warning: Leaving mission area!</t>", 0, 0.1, 2, 0] spawn BIS_fnc_dynamicText;
		};
	};
	private _fn_99percentFromCenter = {
		if (BLWK_playerDistanceToTheCrate >= BLWK_playAreaRadius * 1.1) then {
			call _fn_110percentFromCenter;
		} else {
			["<t color='#ff0000'>Warning: Leaving mission area!</t>", 0, 0.1, 2, 0] spawn BIS_fnc_dynamicText;
		};
	};
	private _fn_110percentFromCenter = {
		if (BLWK_playerDistanceToTheCrate > BLWK_playAreaRadius * 2) then {
			call _fn_200percentFromCenter;
		} else {
			// blur screen
			private _effectHandle = ppEffectCreate ["DynamicBlur",200];
			_effectHandle ppEffectEnable true;
			_effectHandle ppEffectAdjust [10];
			_effectHandle ppEffectCommit 0.5;

			waitUntil {ppEffectCommitted _effectHandle};

			// put player back eight meters
			private _dir = BLWK_playAreaCenter getDir player;
			private _eightMetersBack = BLWK_playAreaCenter getPos [(BLWK_playAreaRadius * 1.1)-8, _dir];
			player setPos _eightMetersBack;

			// delete effects
			_effectHandle ppEffectAdjust [0];
			ppEffectDestroy _effectHandle;
		};
	};
	private _fn_200percentFromCenter = {
		private _radius = 2;
		waitUntil {
			if (player setVehiclePosition [BLWK_mainCrate,[],_radius]) exitWith {true};
			_radius = _radius + 0.5;
			sleep 1;
			false;
		};
		hint "Get back here you...";
	};


	while {sleep 2; BLWK_enforceArea} do {
		_playerDistanceToTheCrate = player distance2D BLWK_playAreaCenter;

		if (_playerDistanceToTheCrate >= (BLWK_playAreaRadius * 0.9)) then {
			BLWK_playerDistanceToTheCrate = _playerDistanceToTheCrate;
			call _fn_90percentFromCenter;
		};
	};
	missionNamespace setVariable ["BLKW_enforceAreaRunning",false];
};


true