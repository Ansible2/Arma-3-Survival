/* ----------------------------------------------------------------------------
Function: BLWK_fnc_setCrew

Description:
	Moves units into a vehicle as crew and then as passengers.

	If no seats are available, the unit that the attempt was made with will be deleted

Parameters:
	0: _crew : <GROUP, ARRAY, or OBJECT> - The units to move into the vehicle
	1: _vehicle : <OBJECT> - The vehicle to put units into

Returns:
	BOOL

Examples:
    (begin example)

		[_group1,_vehicle] call BLWK_fnc_setCrew;

    (end)

Author:
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
params [
	["_crew",grpNull,[[],grpNull]],
	["_vehicle",objNull,[objNull]]
];

if (_crew isEqualType grpNull) then {_crew = units _crew};

if (_crew isEqualType objNull) then {_crew = [_crew]};

if (_crew isEqualTo []) exitWith {
	"_crew is undefined" call BIS_fnc_error;
	false
};

if (isNull _vehicle OR {!(alive _vehicle)}) exitWith {
	"Vehicle isNull, crew will be deleted" call BIS_fnc_error;
	
	_crew apply {
		deleteVehicle _x;
	};

	false
};

_crew apply {
	private _movedIn = _x moveInAny _vehicle;

	if !(_movedIn) then {deleteVehicle _x};
};

true