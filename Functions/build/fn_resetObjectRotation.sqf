/* ----------------------------------------------------------------------------
Function: BLWK_fnc_resetObjectRotation

Description:
	Sets both vectorDir and vectorUp of the given object to 0 on the machine where it is local

	Executed from "BLWK_fnc_addBuildableObjectActions" & "BLWK_fnc_addPickedUpObjectActions"

Parameters:
	0: _object : <OBJECT> - The object to reset

Returns:
	NOTHING

Examples:
    (begin example)

		[myObject] call BLWK_fnc_resetObjectRotation;

    (end)

Author:
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
params ["_object"];

// must be executed where local
[_object,0] remoteExecCall ["setDir",_object];