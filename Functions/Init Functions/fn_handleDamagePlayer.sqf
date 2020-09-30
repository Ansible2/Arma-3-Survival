if (!hasInterface OR {BLWK_dontUseRevive}) exitWith {};

params [
	["_player",player]
];

// handle damage events fire even on dead bodies, we will remove it in the onPlayerKilled.sqf
// while it can be persisant on player object, the persistence is somewhat unreliable
BLWK_dammagedEventHandler = _player addEventHandler ["HandleDamage", {
	private _unit = _this select 0;
	private _instigator = _this select 6;

	if (alive _unit) then {
		if !(missionNamespace getVariable ["BLWK_medKitSelfReviveRunning",false]) then {
			// to keep this function from running multiple times
			BLWK_medKitSelfReviveRunning = true;
			null = [_unit] spawn {	
				params ["_unit"];
				private _unitItems = items _unit;
				sleep 5;
				
				private _isIncapactated = !(incapacitatedState _unit isEqualTo "");
				if (_isIncapactated AND {"Medikit" in _unitItems}) then {
					_unit removeItem "Medikit";				
					
					// revives player for BIS revive system
					["BLWK_reviveOnStateVar",1,_unit] call BIS_fnc_reviveOnState;
					hint "Reived from your medkit";
					
					// make the player invincible for 15 seconds to avoid BS
					_unit allowDamage false;
					sleep 15;
					_unit allowDamage true;
				} else {
					BLWK_medKitSelfReviveRunning = false;
				};
			};
		};

		/*
			If the event returns 0, it means 0 damage will be dealt to the _unit
			The checks below are so that the player will be invincible if:
				- it is friendly fire
				- the player is in an incapcitated state already
		*/
		private _isIncapactated = !(incapacitatedState _unit isEqualTo "");
		if ((side _unit) isEqualTo (side _instigator) OR {_isIncapactated}) then {0};
	};
}];