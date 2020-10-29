/* ----------------------------------------------------------------------------
Function: BLWK_fnc_createBattleAmbienceSound

Description:
	Creates the ambient battlefield sounds that surround the play area.

Parameters:
	NONE

Returns:
	NOTHING

Examples:
    (begin example)

		null = [] spawn BLWK_fnc_createBattleAmbienceSound;

    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
private _logicGroup = createGroup BLWK_logicCenter;
private "_logic";
private _distanceFromCenter = BLWK_playAreaRadius + 75;
private "_logicPosition";
for "_i" from 1 to 3 do {
	_logic = _logicGroup createUnit ["Logic", [0,0,0], [], 0, "NONE"];
	
	_logicPosition = BLWK_playAreaCenter getPos [_distanceFromCenter, random 360]; 
	_logic setPos _logicPosition;

	null = [_logic,_distanceFromCenter + 250,999999,1] spawn KISKA_fnc_battleSound;
};