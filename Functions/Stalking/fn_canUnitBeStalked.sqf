params [
	["_unit",objNull,[objNull]]
];

if (alive _unit AND {incapacitatedState _unit isEqualTo ""} AND {_unit getVariable ["BLWK_availableForStalking",true]}) then {
	true
} else {
	false
};