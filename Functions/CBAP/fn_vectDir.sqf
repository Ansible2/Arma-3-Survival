/* ----------------------------------------------------------------------------
Function: CBAP_fnc_vectDir

Description:
 Returns the angle of a vector with the given i and k coordinates in the range 0 to 360.

Parameters:
 _vect the 2D vector array in the form [x, z] or [x, z, y] (y value is ignored).

Returns:
 the corresponding angle in range 0 to 360.

Examples:
    (begin example)

    (end)

Author:
    Vigilante, courtesy by -=ACE=- of Simcentric
---------------------------------------------------------------------------- */
scriptName "CBAP_fnc_vectDir";

[((_this select 0) atan2 (_this select 1))] call CBAP_fnc_simplifyAngle;
