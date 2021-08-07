/* ----------------------------------------------------------------------------
Function: KISKA_fnc_str

Description:
	Given that str command produces triple quoted strings if used on a string
	 (which can be incompatible with other commands) this function simply formats
	 them as "'string'" instead, and all other types as normal with str.

Parameters:
	0: _value <ANY> - The value to convert to a string

Returns:
	<STRING> - The value as a string

Examples:
    (begin example)
		_asString = [_someValue] call KISKA_fnc_str;
    (end)

Authors:
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
scriptName "KISKA_fnc_str";

params ["_value"];

[str _value,format ["'%1'",_value]] select (_value isEqualType "")
