/* ----------------------------------------------------------------------------
Function: KISKA_fnc_addArsenal

Description:
	Removes both BIS and ACE arsenals from several or a single object.
	This has a global effect.

Parameters:
	0: _arsenals <ARRAY or OBJECT> - An array of objects to add arsenals to

Returns:
	BOOL

Examples:
    (begin example)

		[[arsenal1, arsenal2]] call KISKA_fnc_removeArsenal;

    (end)

Author:
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
params [
    ["_arsenals",[],[[],objNull]]
];

if (_arsenals isEqualTo [] OR {(_arsenals isEqualType objNull) AND {isNull _arsenals}}) exitWIth {
	["_arsenals %1 are invalid",_arsenals] call BIS_fnc_error;
	false
};

if !(_arsenals isequalType []) then {
	_arsenals = [_arsenals];
};

private _aceLoaded = ["ace_arsenal"] call KISKA_fnc_isPatchLoaded;

_arsenals apply {
	
	if (_aceLoaded) then {
		[_x, true] call ace_arsenal_fnc_removeBox
	};

	["AmmoboxExit",_x] call BIS_fnc_arsenal;
};

true