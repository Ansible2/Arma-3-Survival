/* ----------------------------------------------------------------------------
Function: BLWK_fnc_explodeSuicideBomber

Description:
	Creates the explosion at a suicide bomber's position

	Executed from ""

Parameters:
	0: _bomber : <OBJECT> - The suicide bomber

Returns:
	NOTHING

Examples:
    (begin example)

		[mySuicideBomber] call BLWK_fnc_explodeSuicideBomber;

    (end)

Author:
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
params ["_bomber"];

private _explosiveType = selectRandom ["DemoCharge_Remote_Ammo_Scripted","SatchelCharge_Remote_Ammo_Scripted","ClaymoreDirectionalMine_Remote_Ammo_Scripted"];

private _explosive = _explosiveType createVehicle (getPosWorld _bomber);

_explosive setDamage 1;