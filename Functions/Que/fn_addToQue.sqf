/* ----------------------------------------------------------------------------
Function: BLWK_fnc_addToQue

Description:
	Adds the type and position of a unit to a que

Parameters:
	0: _queName : <STRING> - The global var name for the que you want to add to
	1: _type : <STRING> - The className of the unit you want to add to the que
	2: _position : <ARRAY OR OBJECT> - The position to spawn the unit at

Returns:
	BOOL

Examples:
    (begin example)

		["BLWK_standardInfantryQue",_aClassName,[0,0,0]] call BLWK_fnc_addToQue;

    (end)

Author:
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
params [
	["_queName","",[""]],
	["_type","",[""]],
	["_position",[],[objNull,[]]]
];

if (_queName isEqualTo "" OR {_type isEqualTo ""} OR {_position isEqualTo []}) exitWith {false};

if (isNil _queName) then {
	missionNamespace setVariable [_queName,[]];
};

(missionNamespace getVariable _queName) pushBack [_type,_position];


true