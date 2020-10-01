if (!canSuspend) exitWith {};

#define MORTAR_CLASS "O_Mortar_01_F"

params ["_mortarMan"];

private _spawnPosition = [BLWK_playAreaCenter, BLWK_playAreaRadius - 15, BLWK_playAreaRadius - 5, 3, 0, 10] call BIS_fnc_findSafePos;
private _mortarTube = MORTAR_CLASS createVehicle _spawnPosition;
_mortarMan moveInGunner _mortarTube;
[BLWK_zeus,[[_mortarTube],true]]remoteExec ["addCuratorEditableObjects",2];

// give players a bit of time
sleep 20;

private _ammo = getArtilleryAmmo [_mortarTube] select 0;
private "_fireAtPosition"; 
while {alive _mortarMan} do {
	_fireAtPosition = [bulwarkBox,random 45,random 360] call CBAP_fnc_randPos;
	_mortarTube doArtilleryFire [_fireAtPosition,_ammo,1];

	sleep 30;
};