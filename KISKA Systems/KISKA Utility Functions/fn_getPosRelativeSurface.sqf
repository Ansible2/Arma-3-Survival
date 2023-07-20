/* ----------------------------------------------------------------------------
Function: KISKA_fnc_getPosRelativeSurface

Description:
    Returns a relative position but that the position is at the 0 position for the
     surface beneath (being either water or the terrain) in an ATL format.

    This means the z will always be 0 or the height of the sea above the terrain level
     at the given _centerPosition.

Parameters:
    0: _centerPosition <OBJECT or Position> - The center position to find a
        relative position to. If a 2d position, height will be 0.
    1: _distance <NUMBER> - The distance away from the _centerPosition to get the position
    2: _bearing <NUMBER> - The direction relative to the position to find the new position

Returns:
    PositionATL[] - the new position

Examples:
    (begin example)
        [
            player,
            100,
            180
        ] call KISKA_fnc_getPosRelativeSurface;
    (end)

Author(s):
    Ansible2
---------------------------------------------------------------------------- */
scriptName "KISKA_fnc_getPosRelativeSurface";

params [
    ["_centerPosition",[],[objNull,[]],[2,3]],
    ["_distance",0,[123]],
    ["_bearing",0,[123]]
];


private _relativePosition = _centerPosition getPos [_distance,_bearing];
private _height = _relativePosition select 2;
private _isUnderwater = _height < 0;
if (_isUnderwater) then {
    _relativePosition set [2,0];
    _relativePosition = ASLToATL _relativePosition;
};


_relativePosition
