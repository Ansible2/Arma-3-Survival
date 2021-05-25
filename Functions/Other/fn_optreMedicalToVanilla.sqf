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

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
scriptName "BLWK_fnc_optreMedicalToVanilla";

if (!BLWK_isOptreLoaded) exitWith {
	["OPTRE is not loaded, exiting...",false] call KISKA_fnc_log;
	nil
};

if (BLWK_dontUseRevive) exitWith {
	["Revive is off, exiting...",false] call KISKA_fnc_log;
	nil
};

params ["_unit"];

private _unitsItems = (items _unit);
if (_unitsItems isEqualTo []) exitWith {};

private _numberOfMedkits = {_x == "OPTRE_MedKit"} count _unitsItems;
if (_numberOfMedkits > 0) then {
	for "_i" from 1 to _numberOfMedkits do {
		_unit removeItem "OPTRE_MedKit";
		_unit addItem "MedKit";  
	};
};

private _numberOfBiofoams = {_x == "OPTRE_Biofoam"} count _unitsItems;
if (_numberOfBiofoams > 0) then {
	for "_i" from 1 to _numberOfBiofoams do {
		_unit removeItem "OPTRE_Biofoam";
		_unit addItem "FirstAidKit";  
	};
};
private _numberOfMedigel = {_x == "OPTRE_Medigel"} count _unitsItems;
if (_numberOfMedigel > 0) then {
	for "_i" from 1 to _numberOfMedigel do {
		_unit removeItem "OPTRE_Medigel";
		_unit addItem "FirstAidKit";  
	};
};
