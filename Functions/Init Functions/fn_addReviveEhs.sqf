/* ----------------------------------------------------------------------------
Function: BLWK_fnc_addReviveEhs

Description:
	Adds eventhandlers relavent to the vanilla revive system.
	Includes revive from Medkit, friendly fire handling, and adding a drag action when downed

	Executed from "initPlayerLocal.sqf" & "onPlayerRespawn.sqf"

Parameters:
	0: _player : <OBJECT> - The player to add the eventhandlers

Returns:
	NOTHING

Examples:
    (begin example)

		call BLWK_fnc_addReviveEhs;

    (end)

Author(s):
	Ansible2 // Cipher,
	Hilltop(Willtop) & omNomios
---------------------------------------------------------------------------- */
if (!hasInterface OR {BLWK_dontUseRevive}) exitWith {};

params [
	["_player",player]
];

BLWK_animStateChangedEh_ID = _player addEventHandler ["AnimStateChanged",{
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
				null = [_unit] spawn {
					params ["_unit"];
					_unit allowDamage false;
					sleep 30;
					_unit allowDamage true;
				};
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
		private _source = _this select 3;
		private _projectile = _this select 4;

		// check if it is friendly fire or the player is already downed
		// in which case, the damage will be 0
		if (
			(!BLWK_friendlyFireOn AND {(side _unit) isEqualTo (side _instigator)}) OR // if friendly fire
			{!((incapacitatedState _unit) isEqualTo "")} OR // if player is unconcious
			{!BLWK_fallDamageOn AND {_unit isEqualTo _source AND {_projectile == ""}}} // fall damage, sometimes fires on a players own explosives, 
			// ...but not often enough to be considered game breaking
		) then {0};
	};
}];