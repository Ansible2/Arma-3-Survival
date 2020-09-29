params [
	["_queName","",[""]],
	["_codeToRun",{},[{}]],
	["_side",OPFOR,[sideNull]],
	["_group",grpNull,[grpNull]]
];

if (_queName isEqualTo "") exitWith {objNull};

private _queArray = missionNamespace getVariable [_queName,[]];
if (_queArray isEqualTo []) exitWith {objNull};


// get the first available unit in the que
(_queArray deleteAt 0) params ["_position","_type"];


if (isNull _group) then {
	_group = createGroup _side;
};
private _unit = _type createVehicle _position;
[_unit] joinSilent _group;


if !(_codeToRun isEqualTo {}) then {
	[_unit,_queName,_group] call _codeToRun;
};


_unit