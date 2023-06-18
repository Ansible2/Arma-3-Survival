/* ----------------------------------------------------------------------------
Function: KISKA_fnc_spawnVehicle

Description:
    A slightly altered/optimized version of BIS_fnc_spawnVehicle.
    Has support for CUP aircraft to spawn at velocity.

Parameters:
    0: _spawnPosition <ARRAY or OBJECT> - 3D array in the format of PositionATL
        (PositionAGL if boat or amphibious). Objects can be used, however, this
    1: _spawnDirection <NUMBER> - The direction the vehicle is facing when created (relative to north)
        if _spawnPosition is an object and _spawnDirection == -1, _spawnDirection will be set to the
        direction of the _spawnPosition object
    2: _vehicleClass <STRING> - The typeOf vehicle to spawn
    3: _group <SIDE or GROUP> - Either the side to create a group on or an
        already existing group to add the units to
    4: _forcePosition <BOOL> - Force vehicle to spawn at exact coordinates
        Does nothing when _spawnPosition is an object
    5: _crewInstructions <ARRAY> - An array of classnames of unit types and/or man objects
        for the crew. Units are moved into the vehicle using moveInAny in the order provided
    6: _deleteOverflow <BOOL> - Delete any units from _crewInstructions that prexisted if they don't fit in the vehicle

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
    Modified by: Ansible2
---------------------------------------------------------------------------- */
scriptName "KISKA_fnc_spawnVehicle";

params [
    ["_spawnPosition",[0,0,0],[[],objNull]],
    ["_spawnDirection",0,[123]],
    ["_vehicleClass","",[""]],
    ["_group",BLUFOR,[sideUnknown,grpNull]],
    ["_forcePosition",true,[true]],
    ["_crewInstructions",[], [[]] ],
    ["_deleteOverflow",true,[true]]
];

private _positionIsObject = _spawnPosition isEqualType objNull;
if (_positionIsObject AND {isNull _spawnPosition}) exitWith {
    ["_spawnPosition is null object!",true] call KISKA_fnc_log;
    []
};


if (_vehicleClass isEqualTo "") exitWith {
    ["_vehicleClass is empty string, exiting...",true] call KISKA_fnc_log;
    []
};

if (_group isEqualType grpNull AND {isNull _group}) exitWith {
    [["Tried to spawn class: ",_vehicleClass," but the _group is type GROUP and the group is null, exiting..."],true] call KISKA_fnc_log;
    []
};

if (_positionIsObject AND (_spawnDirection isEqualTo -1)) then {
    _spawnDirection = getDir _spawnPosition;
};

private _spawnPositionATL = _spawnPosition;
if (_positionIsObject) then {
    _spawnPositionATL = getPosATL _spawnPosition;
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
switch (toLowerANSI _simulationType) do {
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
        if (!_forcePosition) then {
            _spawnPositionATL set [2,(_spawnPositionATL select 2) max 50];
            _createdVehicle = createVehicle [_vehicleClass,_spawnPositionATL,[],0,"FLY"];

            _forcePosition = true;
        } else {
            _createdVehicle = createVehicle [_vehicleClass,_spawnPositionATL,[],0,"NONE"];

        };

    };
    default {
        _createdVehicle = createvehicle [_vehicleClass,_spawnPosition,[],0,"NONE"];
    };
};

if (_forcePosition) then {
    _createdVehicle setPosATL _spawnPositionATL;
};

_createdVehicle setDir _spawnDirection;



private _crew = [];
// soldiers do not need anymore handling
if (_simulationType != "soldier") then {
    // Set plane velocity straight ahead so they don't crash
    if (_simulationType == "airplanex" OR {_simulationType == "airplane"}) then {
        _createdVehicle setVelocityModelSpace [0,100,0];
        //_createdVehicle setVelocity [100 * (sin _spawnDirection), 100 * (cos _spawnDirection), 0];
    };

    // Spawn the crew and add the vehicle to the group
    if (_crewInstructions isEqualTo []) then {
        createvehiclecrew _createdVehicle;
        _crew = crew _createdVehicle;

    } else {
        private _movedIn = false;
        private "_unit";
        _crewInstructions apply {
            if (_x isEqualType objNull) then {
                _unit = _x;
            } else {
                _unit = _group createunit [_x,[0,0,0],[],0,"NONE"];
            };

            _movedIn = _unit moveInAny _createdVehicle;
            if (!_movedIn) then {
                [["Unit ",_unit," could not be moved into the vehicle ",_createdVehicle," as there was no room in the vehicle"],true] call KISKA_fnc_log;
                if (_deleteOverflow) then {
                    deleteVehicle _unit;
                };

            } else {
                _crew pushBack _unit;
            };
        };

    };

    _crew joinsilent _group;
    _group addVehicle _createdVehicle;

    // If this is a new group, select a leader
    if (_createdNewGroup) then {
        _group selectLeader (commander _createdVehicle);
    };

} else {
    _crew pushBack _createdVehicle;

};


[_createdVehicle, _crew, _group]
