if (!hasInterface OR {BLWK_dontUseRevive}) exitWith {};

params [
	["_player",player]
];

BLWK_animStateChangedEh_ID = _player addEventHandler ["AnimStateChanged"{
	params ["_unit", "_anim"];
	
	if (_anim == "unconsciousrevivedefault" AND {alive _unit}) then {
		// if in incapacitatedState
		if !(incapacitatedState _unit isEqualTo "") then {
			
			private _unitItems = items _unit;
			if ("Medikit" in _unitItems) then {
				_unit removeItem "Medikit";				
				
				// revives player for BIS revive system
				["BLWK_reviveOnStateVar",1,_unit] call BIS_fnc_reviveOnState;
				
				hint "Reived from your medkit";

				// make the player invincible for 15 seconds to avoid BS
				null = [] spawn {
					_unit allowDamage false;
					sleep 15;
					_unit allowDamage true;
				};
			} else {
				// if unit is not revided by medkit add the drag action to them for all players
				[_unit] remoteExecCall ["BLWK_fnc_addDragAction",BLWK_allClientsTargetID,true];
			};
		};
	};
}];


// handle damage events fire even on dead bodies, we will remove it in the onPlayerKilled.sqf
// while it can be persisant on player object, the persistence is somewhat unreliable
BLWK_handleDamageEh_ID = _player addEventHandler ["HandleDamage", {
	private _unit = _this select 0;
	
	if (alive _unit) then {
		private _instigator = _this select 6;
		// check if it is friendly fire or the player is already downed
		// in which case, the damage will be 0
		if ((side _unit) isEqualTo (side _instigator) OR {!(incapacitatedState _unit isEqualTo "")}) then {0};
	};
}];