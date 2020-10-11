/* ----------------------------------------------------------------------------
Function: BLWK_fnc_sellObject;

Description:
	Sells the selected object, adds the cost of it back into the player's pool

	Executed from "BLWK_fnc_addBuildableObjectActions" & "BLWK_fnc_addPickedUpObjectActions"

Parameters:
	0: _object : <OBJECT> - The object to sell

Returns:
	BOOL

Examples:
    (begin example)

		[myObject] call BLWK_fnc_sellObject;

    (end)

Author:
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
params ["_object"];

// check if someone is carrying the object
if !(isNull attachedTo _object) then {
	detach _object;

	call BLWK_fnc_removePickedUpObjectActions;
};

private _objectType = typeOf _object;
private _indexOfType = BLWK_buildableObjects_array findIf {(_x select 1) == _objectType};

// add the cost back to player's total
private _price = (BLWK_buildableObjects_array select _indexOfType) select 0;

[_price] call BLWK_fnc_addPoints;

deleteVehicle _object;


true