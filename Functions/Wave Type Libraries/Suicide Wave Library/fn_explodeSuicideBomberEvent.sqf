/* ----------------------------------------------------------------------------
Function: BLWK_fnc_explodeSuicideBomberEvent

Description:
	Creates the explosion at a suicide bomber's position

	Executed from the event added in "BLWK_fnc_createSuicideWave" & "BLWK_fnc_suicideBomberLoop"

Parameters:
	0: _bomber : <OBJECT> - The suicide bomber
	1: _eventHandlerId : <NUMBER> - The ID of the MPKilled

Returns:
	NOTHING

Examples:
    (begin example)

		[mySuicideBomber,0] call BLWK_fnc_explodeSuicideBomberEvent;

    (end)

Author:
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
params [
	"_bomber",
	["_eventHandlerId",-1]
];

if (!local _bomber) exitWith {};

if (_eventHandlerId isEqualTo -1) then {
	_eventHandlerId = _bomber getVariable "BLWK_suicideBomberEventID";	
};
_bomber removeEventHandler ["MPKILLED",_eventHandlerId];

private _explosiveType = selectRandom ["DemoCharge_Remote_Ammo_Scripted","SatchelCharge_Remote_Ammo_Scripted","ClaymoreDirectionalMine_Remote_Ammo_Scripted"];

private _explosive = _explosiveType createVehicle (getPosWorld _bomber);

_explosive setDamage 1;

deleteVehicle _bomber;