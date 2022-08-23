/* ----------------------------------------------------------------------------
Function: KISKA_fnc_staticLine

Description:
    Ejects the unit from their airecraft and
	Used to reduce network messages.

Parameters:
	0: _aircraft <OBJECT> - The aircraft dropping off the unit
	1: _unit <OBJECT> - The unit to parachute
	2: _chuteType <STRING> - Class name of the chute
    3: _index <NUMBER> - index in drop order
    4: _invincibleOnDrop <BOOL> - Whether or not the unit is invincible on drop

Returns:
	NOTHING

Examples:
    Executed from KISKA_fnc_staticLine

Author:
	Ansible2
---------------------------------------------------------------------------- */
scriptName "KISKA_fnc_staticLine_eject";

params ["_aircraft","_unit","_chuteType","_index","_invincibleOnDrop"];

private _loadout = getUnitLoadout _unit;

if !(isNull (unitbackpack _unit)) then {
    removeBackpackGlobal _unit;
};
// decided not to use addBackpackGlobal because of waiting for locality
waitUntil {
    _unit addBackpack _chuteType;
    if (!isNull (backpackContainer _unit) OR {!alive _unit}) exitWith {true};
    sleep 0.25;
    false
};

if (!(alive _aircraft) OR !(alive _unit)) exitWith {};

sleep (_index / 5); // delay for getting a spread of units

_unit moveOut _aircraft;

// keep units from trying to enter vehicle after being moved out
// leaveVehicle causes the aircraft to shift while in-flight
[_unit] orderGetIn false;

// determine the side of the aircraft to eject the person on
private _sideOfAircraft = [10,-10] select ((_index mod 2) isEqualTo 0);


// might need to waitUntil backpackContainer is not Null to be sure
// delay chute open to create some distance with plane
[_unit,_aircraft,_sideOfAircraft] spawn {
    params ["_unit","_aircraft","_sideOfAircraft"];

    // place unit to the side of the aircraft
    _unit setPosATL ((getPosATLVisual _unit) vectorAdd (_aircraft vectorModelToWorldVisual [_sideOfAircraft,0,0]));
    // if a unit is moving too fast when they open the chute, it will sometimes cause it to not attach
    _unit setVelocity [0,0,0];
    sleep 1;
    _unit action ["OpenParachute", _unit];
};

sleep 3;

if (_invincibleOnDrop) then {
    _unit allowDamage false;
};

waitUntil {
    if (((getPosATL _unit) select 2) < 0.1 OR {isTouchingGround _unit}) exitWith {true};
    sleep 2;
    false;
};

if (alive _unit) then {
    if (_invincibleOnDrop) then {
        _unit allowDamage true;
    };

    _unit setUnitLoadout _loadout;

    private _group = group _unit;
    private _unitLeader = leader _group;
    if !(_unitLeader in _aircraft) then {
        /*
            orderGetIn combined with unassignVehicle does NOT keep units
            from trying to re-embark.

            The only two commands that are capable of this are leaveVehicle
            and allowGetIn. allowGetIn is the more invasive option, so I chose
            leaveVehicle as it would not leave a lasting affect.
        */
        [_group,_aircraft] remoteExec ["leaveVehicle",_unitLeader];
    };
};

nil
