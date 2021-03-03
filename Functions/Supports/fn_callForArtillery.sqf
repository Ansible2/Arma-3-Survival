#include "..\..\Headers\descriptionEXT\supportDefines.hpp"
/* ----------------------------------------------------------------------------
Function: BLWK_fnc_callForArtillery

Description:
	Calls for an artillery or mortart strike at players cursor position.

Parameters:
	0: _target <OBJECT, ARRAY, or STRING(marker)> - The target you want to cluter fire around
	1: _ammoType <STRING> - The ammo type from cfgAmmo 

Returns:
	NOTHING

Examples:
    (begin example)

		[target_1,"Sh_155mm_AMOS"] spawn BLWK_fnc_callForArtillery;

    (end)

Authors:
	Ansible2 // Cipher,
	h - // for flare script
---------------------------------------------------------------------------- */
if (!canSuspend) exitWith {};

params [
	"_fireAtPosition",
	["_ammoType","Sh_155mm_AMOS",[""]]
];

// flare round need to fall slower
if (_ammoType == "F_20mm_white") exitWith {
	[TYPE_ARTILLERY,player] call BLWK_fnc_supportRadioGlobal;
	
	// delay for fire
	sleep 3;
	
	private _flare = "F_20mm_white" createvehicle (_fireAtPosition vectorAdd [0,0,200]);  
	_flare setVelocity [0,0,-10];
	private _light = "#lightpoint" createVehicle (getPosASL _flare);
	_light attachTo [_flare, [0, 0, 0]];
	
	// light characteristic adjustments must be done locally for each player
	[_light,_flare] remoteExecCall ["BLWK_fnc_updateFlareEffects",BLWK_allClientsTargetId,_flare];

	waitUntil {
		sleep 0.5;
		!alive _flare;
	};
	deletevehicle _light;
};

[TYPE_ARTILLERY,player] call BLWK_fnc_supportRadioGlobal;

// create markers
private _chemlight = createvehicle ["Chemlight_green_infinite",_fireAtPosition,[],0,"NONE"];
private _smoke = createvehicle ["G_40mm_SmokeRed_infinite",_fireAtPosition,[],0,"NONE"];
//private _flare = createvehicle ["F_40mm_Red",_fireAtPosition,[],0,"NONE"];

sleep 5;

[_fireAtPosition,_ammoType,25,3,5,{},nil,1300] spawn BIS_fnc_fireSupportVirtual;

sleep 20;
deleteVehicle _chemlight;
deleteVehicle _smoke;
//deleteVehicle _flare;