/* ----------------------------------------------------------------------------
Function: BLWK_fnc_onCivWaveEnd

Description:
	Deletes any alive civilians after wave end.

Parameters:
	NONE

Returns:
	NOTHING

Examples:
    (begin example)
		call BLWK_fnc_onCivWaveEnd;
    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
scriptName "BLWK_fnc_onCivWaveEnd";

// delete any alive civilians from special wave
if ((missionNamespace getVariable ["BLWK_civiliansFromWave",[]]) isNotEqualTo []) then {
	BLWK_civiliansFromWave apply {
		if (alive _x) then {
			deleteVehicle _x;
		};
	};

	missionNamespace setVariable ["BLWK_civiliansFromWave",[]];
};
