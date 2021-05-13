/* ----------------------------------------------------------------------------
Function: KISKA_fnc_spawnVehicle

Description:
	A slightly altered/optimized version of BIS_fnc_spawnVehicle.
	Has support for CUP aircraft to spawn at velocity.

Parameters:
	0: _spawnPosition <ARRAY or OBJECT> - 3D array in the format of PositionATL
		(PositionAGL if boat or amphibious)
	1: _spawnDirection <NUMBER> - The direction the vehicle is facing when created (relative to north)
	2: _vehicleClass <STRING> - The typeOf vehicle to spawn
	3. _group <SIDE or GROUP> - Either the side to create a group on or an
		already existing group to add the units to
	4. _forcePosition <BOOL> - Force vehicle to spawn at exact coordinates

Returns:
	<ARRAY> -
		0: <OBJECT> - The created vehicle
		1: <ARRAY> - The vehicle crew (if soldier type, it will be the same as created vehicle)
		2: <GROUP> -  The group the crew is a part of

Examples:
    (begin example)
		[player,0,"someclass"] call KISKA_fnc_spawnVehicle;
    (end)

Author(s):
	Joris-Jan van 't Land,
	Modified by: Ansible2 // Cipher
---------------------------------------------------------------------------- */
scriptName "KISKA_fnc_spawnVehicle";

params [
	["_spawnPosition",[0,0,0],[[]]],
	["_spawnDirection",0,[123]],
	["_vehicleClass","",[""]],
	["_group",grpNull,[BLUFOR,grpNull]],
	["_forcePosition",true,[true]]
];


if (_vehicleClass isEqualTo "") exitWith {
	["_vehicleClass is empty string, exiting...",true] call KISKA_fnc_log;
	[]
};

if (_group isEqualType grpNull AND {isNull _group}) exitWith {
	[["Tried to spawn class: ",_vehicleClass," but the _group is type GROUP and the group is null, exiting..."],true] call KISKA_fnc_log;
	[]
};

// make a group if side is provided
private _createdNewGroup = false;
if (_group isEqualType sideEnemy) then {
	_group = createGroup _group;
	_createdNewGroup = true;
};


// determine vehicle type and then adjust creation params for it
// e.g. spawn some vehicles in the air
private _simulationType = getText(configFile >> "CfgVehicles" >> _vehicleClass >> "simulation");
private "_createdVehicle";
switch (tolower _simulationType) do {
	case "soldier": {
		_createdVehicle = _group createunit [_vehicleClass,_spawnPosition,[],0,"NONE"];
		// units have a tendency to still not be a part of an existing group with createUnit
		if !(_createdNewGroup) then {
			[_createdVehicle] joinSilent _group
		};
	};
	case "airplanex";
	case "airplane"; // CUP planes do not use airplaneX
	case "helicopterrtd";
	case "helicopter";
	case "helicopterx": {
		// make sure Z position has height for air vehicles
		_spawnPosition set [2,(_spawnPosition select 2) max 50];
		_createdVehicle = createVehicle [_vehicleClass,_spawnPosition,[],0,"FLY"];
	};
	default {
		_createdVehicle = createvehicle [_vehicleClass,_spawnPosition,[],0,"NONE"];
	};
};


_createdVehicle setDir _spawnDirection;

if (_forcePosition) then {
	_createdVehicle setPos _spawnPosition;
};


private _crew = [_createdVehicle];
// soldiers do not need anymore handling
if (_simulationType != "soldier") then {
	// Set plane velocity straight ahead so they don't crash
	if (_simulationType == "airplanex" OR {_simulationType == "airplane"}) then {
		_createdVehicle setVelocityModelSpace [0,100,0];
		//_createdVehicle setVelocity [100 * (sin _spawnDirection), 100 * (cos _spawnDirection), 0];
	};

	// Spawn the crew and add the vehicle to the group
	createvehiclecrew _createdVehicle;
	_crew = crew _createdVehicle;
	_crew joinsilent _group;
	_group addVehicle _createdVehicle;

	// If this is a new group, select a leader
	if (_createdNewGroup) then
	{
		_group selectLeader (commander _createdVehicle);
	};
};


[_createdVehicle, _crew, _group]
