/* ----------------------------------------------------------------------------
Function: KISKA_fnc_addArsenal

Description:
	Adds both BIS and ACE arsenals to several or a single object.
	This has a global effect.

Parameters:

	0: _arsenals <ARRAY or OBJECT> - An array of objects to add arsenals to

Returns:
	BOOL

Examples:
    (begin example)

		[[arsenal1, arsenal2]] call KISKA_fnc_addArsenal;

    (end)

Author(s):
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
		[_x, true, true] call ace_Arsenal_FNC_InitBox;
	};
	
	["AmmoboxInit",[_x,true]] call BIS_fnc_arsenal;
};

true