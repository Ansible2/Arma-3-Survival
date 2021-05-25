/* ----------------------------------------------------------------------------
Function: KISKA_fnc_classTurretsWithGuns

Description:
	Checks a given vehicle class to see if it has turrets that have guns
     and returns those turret paths

Parameters:
	0: _classToCheck <STRING> - The vehicle class to check

Returns:
	<ARRAY> - The turret paths

Examples:
    (begin example)
        _turretPaths = ["B_Heli_Transport_01_F"] call KISKA_fnc_classTurretsWithGuns;
    (end)

Author:
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
scriptName "KISKA_fnc_classTurretsWithGuns";

params [
    ["_classToCheck","",[""]]
];


if (_classToCheck isEqualTo "") exitWith {
    ["_classToCheck is empty string!",true] call KISKA_fnc_log;
    []
};


if !(isClass(configFile >> "CfgVehicles" >> _classToCheck)) exitWith {
    ["_classToCheck is not defined within CfgVehicles!",true] call KISKA_fnc_log;
    []
};


// excludes fire from vehicle turrets
private _allVehicleTurrets = [_classToCheck, false] call BIS_fnc_allTurrets;
// just turrets with weapons
private _turretsWithWeapons =  [];
private ["_turretWeapons_temp","_return_temp","_turretPath_temp"];
_allVehicleTurrets apply {
	_turretPath_temp = _x;
	_turretWeapons_temp = getArray([_classToCheck,_turretPath_temp] call BIS_fnc_turretConfig >> "weapons");
	// if turrets are found
	if !(_turretWeapons_temp isEqualTo []) then {
		// some turrets are just optics, need to see they actually have ammo to shoot
		_return_temp = _turretWeapons_temp findIf {
			private _mags = [_x] call BIS_fnc_compatibleMagazines;
            // some turrets are just laser designators, hence checking that there are no laserbatteries
			!(_mags isEqualTo []) AND {!((_mags select 0) == "laserbatteries")}
		};

		if !(_return_temp isEqualTo -1) then {
			_turretsWithWeapons pushBack _turretPath_temp;
		};
	};
};


_turretsWithWeapons
