/* ----------------------------------------------------------------------------
Function: KISKA_fnc_getVectorToTarget

Description:
	Returns vectorDir and vectorUp that should angle the object towards the target.

    E.g. this will point the nose of a plane towards a target if paired with
     setVector commands.

Parameters:
	0: _object : <OBJECT,ARRAY> - The object to set the vectors of or its ASL position
	1: _target : <OBJECT,ARRAY> - The target to angle towards or its ASL position

Returns:
	<ARRAY> - An array of arrays formatted as [directionVector,upVector]

Examples:
    (begin example)
        // angles to player
		myObject setVectorDirAndUp ([myObject,player] call KISKA_fnc_getVectorToTarget);
    (end)

Author(s):
    Nelson Duarte,
	Modified by: Ansible2
---------------------------------------------------------------------------- */
scriptName "KISKA_fnc_getVectorToTarget";

params [
    ["_object",objNull,[objNull,[]]],
    ["_target",objNull,[objNull,[]]]
];


private _objectPosition = _object;
if (_object isEqualType objNull) then {
    _objectPosition = getPosASLVisual _object;
};

private _targetPosition = _target;
if (_target isEqualType objNull) then {
    _targetPosition = getPosASLVisual _target;
};

private _dirVector = vectorNormalized (_targetPosition vectorDiff _objectPosition);
private _rightVector = (_dirVector vectorCrossProduct [0,0,1]) vectorMultiply -1;
private _upVector = _dirVector vectorCrossProduct _rightVector;


[_dirVector,_upVector]
