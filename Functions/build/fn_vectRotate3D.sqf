/* ----------------------------------------------------------------------------
Function: BLWK_fnc_vectRotate3D

Description:
    Rotates the first vector around the second, clockwise by theta degrees.

Parameters:
    0: _vector : <ARRAY> - 3D vector that is to be rotated
	1: _rotationAxis : <ARRAY> - 3D vector that the first argument is rotated around
    2: _theta : <OBJECT> - Angle, in degrees clockwise, about which the first vector is rotated

Returns:
    _returnVector - 3D vector returned after rotation <ARRAY>

Examples:
    (begin example)
    
    // Rotate 25 degrees right of player weapon direction;
    [weaponDirection player, [0,0,1], 25] call BLWK_fnc_vectRotate3D;

    // Pitch a projectile's velocity down 10 degrees;
    [velocity _projectile, (velocity _projectile) vectorCrossProduct [0,0,1], 10] call BLWK_fnc_vectRotate3D;
    
    // Rotate just an object's direction by 10 degrees
    _dir = vectorDir myObject;
    _up = vectorUP myObject;
    _new = [_dir,_up,10] call CBA_fnc_vectRotate3D;
    myObject setVectorDirAndUp [_new,_up];

    (end)

Author:
    LorenLuke
	(Exported from CBA)
---------------------------------------------------------------------------- */

params ["_vector", "_rotationAxis", "_theta"];

private _normalVector = vectorNormalized _rotationAxis;
private _sinTheta = sin _theta;
private _cosTheta = cos _theta;

// Rodrigues Rotation Formula;
// https://wikimedia.org/api/rest_v1/media/math/render/svg/2d63efa533bdbd776434af1a7af3cdafaff1d578
(_vector vectorMultiply _cosTheta) vectorAdd
((_normalVector vectorCrossProduct _vector) vectorMultiply _sinTheta) vectorAdd
(_normalVector vectorMultiply ((_normalVector vectorDotProduct _vector) * (1 - _cosTheta)))