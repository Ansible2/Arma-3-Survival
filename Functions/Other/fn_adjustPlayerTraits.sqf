params [
	["_player",player,[objNull]]
];

_player setCustomAimCoef 0.2;
_player setUnitRecoilCoefficient 0.5;
_player enableStamina false;

_player setUnitTrait ["Medic",true];
_player setUnitTrait ["Engineer",true];