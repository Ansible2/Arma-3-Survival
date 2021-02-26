/* ----------------------------------------------------------------------------
Function: BLWK_fnc_addAllowDamageEH

Description:
	In order to avoid setting and reseting the allowDamage to false for certain
	 items when they change locality (are picked up for example), this eventhandler 
	 will be added to any object from the shop (and the main crate) that don't allow
	 damage.

Parameters:
	0: _object : <OBJECT> - The object to add the eventhandler to

Returns:
	NOTHING

Examples:
    (begin example)
		[anObject] call BLWK_fnc_addAllowDamageEH;
    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
scriptName "BLWK_fnc_addAllowDamageEH";

if (!hasInterface) exitWith {};

params ["_object"];

if (isNull _object) exitWith {
	["_object was null, event handler will not be added, exiting...",true] call KISKA_fnc_log;
	nil
};

_object addEventHandler ["LOCAL",{
	params ["_object"];
	_object allowDamage false;
}];


nil