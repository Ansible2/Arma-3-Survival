if (!hasInterface) exitWith {};

params [
	["_object",objNull,[objNull]]
];

if (isNull _object) exitWith {
	["BLWK_fnc_addLocalDamageEventHandler","Did not add local handle for null object"] call KISKA_fnc_log;
};

_object addEventHandler ["LOCAL",{
	params ["_entity", "_isLocal"];

	if (_isLocal) then {
		_entity allowDamage false;
	};
}];