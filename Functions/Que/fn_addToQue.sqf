params [
	["_queName","",[""]],
	["_type","",[""]],
	["_position",[],[objNull,[]]]
];

if (_queName isEqualTo "" OR {_spawnInfo isEqualTo []}) exitWith {false};

if (_type isEqualTo "") exitWith {false};

if (_position isEqualTo []) exitWith {false};

if (isNil _queName) then {
	missionNamespace setVariable [_queName,[]];
};

(missionNamespace getVariable _queName) pushBack [_type,_position];


true