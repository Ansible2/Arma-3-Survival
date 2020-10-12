/* ----------------------------------------------------------------------------
Function: BLWK_fnc_optreMedicalToVanilla

Description:
	Does a one for one swap of OPTRE's medical items into vanilla ones

Parameters:
	0: _unit : <OBJECT> - The unit to swap out gear for

Returns:
	NOTHING

Examples:
    (begin example)

		[myOptreUnit] call BLWK_fnc_optreMedicalToVanilla;

    (end)

Author:
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
if (!BLWK_isOptreLoaded AND {BLWK_dontUseRevive}) exitWith {};

params ["_unit"];

private _unitsItems = (items _unit);
if (_unitsItems isEqualTo []) exitWith {};

private _numberOfMedkits = _unitsItems count {_x == "OPTRE_MedKit"};
if (_numberOfMedkits > 0) then {
	for "_i" from 1 to _numberOfMedkits do {
		_unit removeItem "OPTRE_MedKit";
		_unit addItem "MedKit";  
	};
};

private _numberOfBiofoams = _unitsItems count {_x == "OPTRE_Biofoam"};
if (_numberOfBiofoams > 0) then {
	for "_i" from 1 to _numberOfBiofoams do {
		_unit removeItem "OPTRE_Biofoam";
		_unit addItem "FirstAidKit";  
	};
};