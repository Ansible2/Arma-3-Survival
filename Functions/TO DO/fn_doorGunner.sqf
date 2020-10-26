params ["_vehicleClass","_loiterHeight","_loiterRadius","_defaultVehicleType"];

// verify vehicle has turrets that are not fire from vehicle and not copilot positions

// excludes fire from vehicle turrets
private _allVehicleTurrets = [_vehicleClass, false] call BIS_fnc_allTurrets;
// just turrets with weapons
private _turretsWithWeapons = _allVehicleTurrets select {!(getArray([_vehicleClass, _x] call BIS_fnc_turretConfig >> "weapons") isEqualTo [])};
if (_turretsWithWeapons isEqualTo []) exitWith {
	[_defaultVehicleType] call BLWK_fnc_doorGunner;
};


private _spawnPosition = [[getPos player, 250, 250, 0, false], true] call CBA_fnc_randPosArea;
private _vehicleArray = [_spawnPosition,0,_vehicleClass,BLUFOR] call BIS_fnc_spawnVehicle;
private _vehicle = _vehicleArray select 0;
_vehicle allowDamage false;

private _vehicleCrew = _vehicleArray select 1;
// get rid of excess crew
_vehicleCrew apply {
	if ((_vehicle unitTurret _x) in _turretsWithWeapons) then {
		_vehicle deleteVehicleCrew _x
	} else {
		_x allowDamage false;
		_x disableAI "TARGET";
		_x disableAI "AUTOTARGET";
	};
};

private _vehicleGroup = _vehicleArray select 2;
_vehicleGroup setBehaviour "SAFE";
_vehicleGroup setCombatMode "BLUE";
private _loiterWaypoint = _vehicleGroup addWaypoint [position player,0];
_loiterWaypoint setWaypointType "LOITER";
_loiterWaypoint setWaypointLoiterRadius _loiterRadius;
_loiterWaypoint setWaypointLoiterType "CIRCLE";
_loiterWaypoint setWaypointLoiterAltitude _loiterHeight;
_loiterWaypoint setWaypointSpeed "LIMITED";

#define TURRET_CONDITTION(VEHICLE_TO_CHECK,TURRET_PATH) "!(("##VEHICLE_TO_CHECK##"unitTurret _caller) isEqualTo"##TURRET_PATH##")"

private _turretSwitchActions = [];
private ["_turretAction_temp","_turretMagazines_temp","_turretPath_temp"];
{
	_turretPath_temp = _x;

	_turretAction_temp = [	
		player,
		format ["<t color='#c91306'>Switch To Turret %1</t>",_forEachIndex + 1], 
		"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa", 
		"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa", 
		TURRET_CONDITTION(_vehicle,_turretPath_temp], // check if units current turret is the stored one, don't show if it is
		"true", 
		{}, 
		{}, 
		{
			params ["_target", "_caller", "", "_arguments", "", ""];
			moveOut _caller;
			_caller moveInTurret [(_arguments select 0),_arguments select 1];
		}, 
		{}, 
		[_vehicle,_turretPath_temp], 
		0.5, 
		1, 
		false, 
		false, 
		false
	] call BIS_fnc_holdActionAdd;

	_turretSwitchActions pushBack _turretAction_temp;

	// give turrets a bit more ammo
	_turretMagazines_temp = _vehicle magazinesTurret _turretPath_temp;
	_turretMagazines_temp apply {
		_vehicle addMagazineTurret [_x,_turretPath_temp];
		_vehicle addMagazineTurret [_x,_turretPath_temp];
	};
} forEach _turretsWithWeapons;

player moveInTurret [_vehicle,_turretsWithWeapons select 0];






turretUnit
(objectParent player) unitTurret player
(objectParent player) magazinesTurret [1]
(objectParent player) addMagazineTurret ["2000Rnd_65x39_Belt_Tracer_Red",[1]];

	[	
		ONL_entryWallComputer,
		"<t color='#c91306'>Open Testing Area</t>", 
		"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa", 
		"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa", 
		"!(missionNamespace getVariable ['ONL_testingAreaOpen',false])", 
		"true", 
		{
			["OMIntelGrabLaptop_02",ONL_entryWallComputer,50,3] call KISKA_fnc_playSound3D;
		}, 
		{}, 
		{
			[true] remoteExec ["ONL_fnc_testingAreaDoors",2];
		}, 
		{}, 
		[], 
		2, 
		10, 
		false, 
		false, 
		true
	] call BIS_fnc_holdActionAdd;