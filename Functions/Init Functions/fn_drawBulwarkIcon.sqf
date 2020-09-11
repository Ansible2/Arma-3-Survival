/* ----------------------------------------------------------------------------
Function: BLWK_fnc_drawBulwarkIcon

Description:
	Creates the bulwark icon on the player's screen

	Executed from ""

Parameters:
	NONE

Returns:
	NOTHING

Examples:
    (begin example)

		null = [] spawn BLWK_fnc_drawBulwarkIcon;

    (end)

Author:
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
if (!hasInterface) exitWith {};

waitUntil {!isNil "bulWarkBox"};

addMissionEventHandler [{
	drawIcon3D ["", [1,1,1,0.5], (getPosATLVisual bulwarkBox) vectorAdd [0, 0, 1.5], 1, 1, 0, "Bulwark", 0, 0.04, "RobotoCondensed", "center", true];
}];