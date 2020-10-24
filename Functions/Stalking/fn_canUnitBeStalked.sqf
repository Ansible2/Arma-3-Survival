#include "..\..\Headers\Stalker Global Strings.hpp"

params [
	["_unit",objNull,[objNull]]
];

if (alive _unit AND {incapacitatedState _unit isEqualTo ""} AND {_unit getVariable [IS_UNIT_AVAILABLE_VAR,true]}) then {
	true
} else {
	false
};