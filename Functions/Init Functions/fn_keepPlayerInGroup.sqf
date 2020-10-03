/* ----------------------------------------------------------------------------
Function: BLWK_fnc_keepPlayerInGroup

Description:
	Tries to keep player's in the group they had just before death after respawns

Parameters:
	NONE

Returns:
	NOTHING

Examples:
    (begin example)

		PostInit function

    (end)

Author:
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
if (!hasInterface) exitWith {};

waitUntil {!isNull player};

player addEventHandler ["KILLED", {
	params ["_corpse"];

	BLWK_playerGroup = group _corpse;			
}];

player addEventHandler ["Respawn", {
	params ["_unit"];
	
	if (!isNull BLWK_playerGroup AND (!((group _unit) isEqualTo BLWK_playerGroup))) then {
		[_unit] joinSilent BLWK_playerGroup;
	};			
}];