/* ----------------------------------------------------------------------------
Function: KISKA_fnc_classTurretsWithGuns

Description:
    Checks a given vehicle class to see if it has turrets that have guns
     and returns those turret paths

Parameters:
    0: _classToCheck <STRING> - The vehicle class to check

Returns:
    <NUMBER[][]> - The turret paths

Examples:
    (begin example)
        _turretPaths = ["B_Heli_Transport_01_F"] call KISKA_fnc_classTurretsWithGuns;
    (end)

Author:
    Ansible2
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
    ["_classToCheck is not defined withing CfgVehicles!",true] call KISKA_fnc_log;
    []
};


// excludes fire from vehicle turrets
private _allVehicleTurrets = [_classToCheck, false] call BIS_fnc_allTurrets;
private _turretsWithWeapons =  [];

_allVehicleTurrets apply {
    private _turretPath = _x;
    private _turretWeapons = getArray([_classToCheck,_turretPath] call BIS_fnc_turretConfig >> "weapons");
    private _noTurretWeaponsFound = _turretWeapons isEqualTo [];
    
    if (_noTurretWeaponsFound) then { continue };
    
    // some turrets are just optics, need to see they actually have ammo to shoot
    private _indexOfValidMagazine = _turretWeapons findIf {
        private _mags = [_x,true] call BIS_fnc_compatibleMagazines;
        // some turrets are just laser designators, hence checking that there are no laserbatteries
        (_mags isNotEqualTo []) AND {!((_mags select 0) == "laserbatteries")}
    };

    private _validTurretMagazineFound = _indexOfValidMagazine isNotEqualTo -1;
    if (_validTurretMagazineFound) then {
        _turretsWithWeapons pushBack _turretPath;
    };
};


_turretsWithWeapons
