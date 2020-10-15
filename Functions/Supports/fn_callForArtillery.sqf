/* ----------------------------------------------------------------------------
Function: BLWK_fnc_callForArtillery

Description:
	Calls for an artillery or mortart strike at players cursor position

Parameters:
	0: _target <OBJECT, ARRAY, or STRING(marker)> - The target you want to cluter fire around
	1: _ammoType <STRING> - The ammo type from cfgAmmo 

Returns:
	NOTHING

Examples:
    (begin example)

		[target_1,"Sh_155mm_AMOS"] call BLWK_fnc_callForArtillery;

    (end)

Authors:
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
params [
	"_fireAtPosition",
	["_ammoType","Sh_155mm_AMOS",[""]]
];

// flare round need to fall slower
if (_ammoType == "Flare_82mm_AMOS_White") exitWith {
	null = [_fireAtPosition,_ammoType,15,1,1,{},nil,250,1] spawn BIS_fnc_fireSupportVirtual;
};


#include "..\..\Headers\descriptionEXT\supportDefines.hpp"
[TYPE_ARTILLERY] call BLWK_fnc_supportRadioGlobal;

null = [_fireAtPosition,_ammoType,40,3,5,{},nil,1300] spawn BIS_fnc_fireSupportVirtual;




//BIS_fnc_fireSupportVirtual
//A3\functions_f\Combat\fn_fireSupportVirtual.sqf

/*
	Author: Vaclav "Watty Watts" Oliva

	Description:
	Virtual fire support of artillery/mortar unit.

	Parameters:
	Select 0 - ARRAY or OBJECT or STRING: Target position ([x,y,z] or Object or "Marker")
	Select 1 - STRING: Ammo (you can use nil or empty string for default 82mm mortar)
	Select 2 - NUMBER: Radius
	Select 3 - NUMBER: Number of rounds to be fired
	Select 4 - NUMBER or ARRAY: Delay between rounds - use either #x for precise timing or [#x,#y] for setting min and max delay
	Select 5 - (OPTIONAL) CODE: Condition to end bombardment before all rounds are fired
	Select 6 - (OPTIONAL) NUMBER: Safezone radius - minimal distance from the target position where shells may be fired at
	Select 7 - (OPTIONAL) NUMBER: Altitude where the shell will be created, default 250
	Select 8 - (OPTIONAL) NUMBER: Descending velocity, in m/s. Default is 150, if you use flare as ammo, set it to lower value (1-5) to let it fall down slowly
	Select 9 - (OPTIONAL) ARRAY: String of sounds to be played on the incoming shell, default is silence

	Returns:
	Boolean

	Examples:
	_barrage = [BIS_Player,"Sh_82mm_AMOS",100,24,10] spawn BIS_fnc_fireSupportVirtual;
	_barrage = [[3600,3600,0],nil,100,24,10] spawn BIS_fnc_fireSupportVirtual;
	_barrage = ["BIS_mrkTargetArea","",100,24,10,{BIS_Player distance BIS_EscapeZone < 100}] spawn BIS_fnc_fireSupportVirtual;
	_barrage = [BIS_Player,nil,100,24,10,{dayTime > 20},50] spawn BIS_fnc_fireSupportVirtual;
	_barrage = [BIS_Victim,"Sh_82mm_AMOS",100,24,10,{dayTime > 20},75,500,200,["mortar1","mortar2"]] spawn BIS_fnc_fireSupportVirtual;
	_barrage = [
		BIS_Victim,
		"Sh_82mm_AMOS",
		100,
		24,
		[10,20],
		{dayTime > 20},
		75,
		500,
		200,
		["mortar1","mortar2"]
	] spawn BIS_fnc_fireSupportVirtual;
*/