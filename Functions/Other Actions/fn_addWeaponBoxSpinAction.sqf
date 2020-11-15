/* ----------------------------------------------------------------------------
Function: BLWK_fnc_addWeaponBoxSpinAction

Description:
	Adds the action to the weapon box to... spin it... imagine that...

	Executed from "BLWK_fnc_spawnLoot"

Parameters:
	0: _randomWeaponBox : <OBJECT> - The box to add the action to

Returns:
	NOTHING

Examples:
    (begin example)

		[myBox] call BLWK_fnc_addWeaponBoxSpinAction;

    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
if (!hasInterface) exitWith {};

params ["_randomWeaponBox"];

if (isNull _randomWeaponBox) exitWith {};

_randomWeaponBox addAction [ 
	"<t color='#FF0000'>-- Spin The Box --</t>",  
	{
		// check if player has enough to use the box
		if ((missionNamespace getVariable ["BLWK_playerKillPoints",0]) < BLWK_costToSpinRandomBox) exitWith {
			hint "You Do Not Enough Points To Spin The Box"
		};

		[BLWK_costToSpinRandomBox] call BLWK_fnc_subtractPoints;
		null = remoteExec ["BLWK_fnc_spinRandomWeaponBox",2]; 
	}, 
	nil, 
	100,  
	true,  
	false,  
	"", 
	"!(missionNamespace getVariable ['BLWK_randomWeaponBoxInUse',false])", 
	2.5 
];