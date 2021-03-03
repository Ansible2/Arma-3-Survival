/* ----------------------------------------------------------------------------
Function: BLWK_fnc_createMortarWave

Description:
	Creates the mortar and starts firing at The Crate

	Executed from "BLWK_fnc_handleMortarWave"

Parameters:
	0: _mortarMan : <OBJECT> - The person to operate the mortar

Returns:
	NOTHING

Examples:
    (begin example)

		[aUnit] spawn BLWK_fnc_createMortarWave;

    (end)

Author(s):
	Hilltop(Willtop) & omNomios,
	Modified by: Ansible2 // Cipher
---------------------------------------------------------------------------- */
#define MORTAR_CLASS "O_Mortar_01_F"

if (!canSuspend) exitWith {};

params ["_mortarMan"];

private _spawnPosition = [BLWK_playAreaCenter, BLWK_playAreaRadius - 15, BLWK_playAreaRadius - 5, 3, 0, 10] call BIS_fnc_findSafePos;
private _mortarTube = MORTAR_CLASS createVehicle _spawnPosition;

_mortarMan moveInGunner _mortarTube;
[BLWK_zeus,[[_mortarTube],true]] remoteExecCall ["addCuratorEditableObjects",2];

// give players a bit of time before starting
sleep 20;

private _ammo = getArtilleryAmmo [_mortarTube] select 0;
private "_fireAtPosition";
private _doFire = true; 
while {_doFire} do {
	_fireAtPosition = [BLWK_mainCrate,random 45,random 360] call CBAP_fnc_randPos;
	_mortarTube doArtilleryFire [_fireAtPosition,_ammo,1];

	sleep (random [15,20,25]);
	if (!alive _mortarMan) exitWith {
		deleteVehicle _mortarTube;
		_doFire = false;
	};
};