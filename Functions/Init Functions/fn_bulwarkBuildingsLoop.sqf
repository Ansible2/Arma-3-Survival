if (!isServer OR {!canSuspend}) exitWith {};

private _invincibleBuildings = [];
private _buildingsCurrentlyNear = nearestTerrainObjects [position player,["house"],20,false,true];
private _buildingsToMakeVulnerable = [];

while {BLWK_buildingsNearBulwarkAreIndestructable} do {
	_buildingsCurrentlyNear = nearestTerrainObjects [bulwarkBox,["house"],BLWK_buildingsNearBulwarkAreIndestructable_radius,false,true];

	if !(_buildingsCurrentlyNear isEqualTo _invincibleBuildings) then {
		// get the buildings no longer in the bulwark's radius
		_buildingsToMakeVulnerable = _invincibleBuildings select {!(_x in _buildingsCurrentlyNear)};
		_buildingsToMakeVulnerable apply {
			_x allowDamage true;
		};
		_buildingsCurrentlyNear apply {
			if !(isDamageAllowed _x) then {
				_x allowDamage false;
			};
		};

		_invincibleBuildings = _buildingsCurrentlyNear;
	};

	sleep 5;
};