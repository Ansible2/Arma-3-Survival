/* ----------------------------------------------------------------------------
Function: BLWK_fnc_keepPlayerLoadout

Description:
	Saves player's loadout upon death

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

player addEventHandler ["Killed", {
	params ["_corpse"];

	// if there are no respawns left, the corpse shouldn't be deleted in case your buddies want your things
	if (missionNamespace getVariable ["BLWK_saveRespawnLoadout",false] AND {!(BLWK_numRespawnTickets isEqualTo 0)}) then {
		BLWK_savedLoadout = getUnitLoadout _corpse;
		deleteVehicle _corpse;
	};
}];