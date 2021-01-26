/* ----------------------------------------------------------------------------
Function: BLWK_fnc_explodeSuicideBomberEvent

Description:
	Creates the explosion at a suicide bomber's position

	Executed from the event added in "BLWK_fnc_createSuicideWave" & "BLWK_fnc_suicideBomberLoop"

Parameters:
	0: _bomber : <OBJECT> - The suicide bomber

Returns:
	NOTHING

Examples:
    (begin example)

		[mySuicideBomber,0] call BLWK_fnc_explodeSuicideBomberEvent;

    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
params ["_bomber"];

if (isNull _bomber) exitWith {};

private _explosiveType = selectRandom [
	"DemoCharge_Remote_Ammo_Scripted",
	"SatchelCharge_Remote_Ammo_Scripted",
	"ClaymoreDirectionalMine_Remote_Ammo_Scripted"
];

private _explosive = _explosiveType createVehicle (getPosATLVisual _bomber);

_explosive setDamage 1;

deleteVehicle _bomber;