/* ----------------------------------------------------------------------------
Function: KISKA_fnc_markBorder

Description:
    Places a number of objects around a given radius to mark an area.

Parameters:
    0: _centerPos <POSITION_ASL or OBJECT> - The center of the area to mark
    1: _radius <NUMBER> - The distance from the center to place markers around
    2: _markerCount <NUMBER> - The number of markers to use for the area
    3: _verticalOffset <NUMBER> - Objects will be placed at Z axis of 0, this will offset that position
    4: _markerObjectClass <STRING> - The classname of the object to place to mark the area

Returns:
    <ARRAY> - An array of simple objects created to mark the area

Examples:
    (begin example)
        _markers = [
            player
        ] call KISKA_fnc_markBorder;
    (end)

Author(s):
    Leopard20
---------------------------------------------------------------------------- */
scriptName "KISKA_fnc_markBorder";

params [
    ["_centerPos",objNull,[objNull,[]]],
    ["_radius",25,[123]],
    ["_markerCount",10,[123]],
    ["_verticalOffset",0,[123]],
    ["_markerObjectClass","Sign_Sphere100cm_F",[""]]
];

if (_centerPos isEqualType objNull) then {
    _centerPos = getPosASL _centerPos;
};

private _markerInterval = 360 / _markerCount;
private _heading = 0;
private _objects = [];
for "_i" from 1 to _markerCount do {
    private _pos = AGLToASL(_centerPos getPos [_radius,_heading]) vectorAdd [0,0,_verticalOffset];
    _heading = _heading + _markerInterval;

    private _object = [_markerObjectClass,_pos,0,false,false] call BIS_fnc_createSimpleObject;
    _objects pushback _object;
};


_objects
