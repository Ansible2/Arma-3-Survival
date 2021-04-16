/* ----------------------------------------------------------------------------
Function: KISKA_fnc_staticLine

Description:
	Ejects units from vehicle and deploys chutes, will select CUP T10 chute if available

Parameters:
	0: _dropArray <ARRAY, GROUP, OBJECT> - Units to drop. If array, can be groups and/or objects (example 2)
	1: _invincibleOnDrop <BOOL> - Should the units be invincible while dropping?

Returns:
	<BOOL> - False if encountered a problem, true if units will be dropped

Examples:
    (begin example)
		[group1] call KISKA_fnc_staticLine;
    (end)

	(begin example)
		[[group1,unit2]] call KISKA_fnc_staticLine;
    (end)

Author:
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
scriptName "KISKA_fnc_staticLine";

params [
	["_dropArray",[],[[],grpNull,objNull]],
	["_invincibleOnDrop",true,[true]]
];

if (_dropArray isEqualTo []) exitWith {
	["_dropArray is empty",true] call KISKA_fnc_log;
	false
};

if (_dropArray isEqualTypeAny [objNull,grpNull] AND {isNull _dropArray}) exitWith {
	["_dropArray isNull",true] call KISKA_fnc_log;
	false
};

if (_dropArray isEqualType grpNull) then {
	_dropArray = units _dropArray;
};

if (_dropArray isEqualType objNull) then {
	_dropArray = [_dropArray];
};

private _dropArrayFiltered = [];

if (_dropArray isEqualType []) then {
	_dropArray apply {
		if (_x isEqualType grpNull) then {
			_dropArrayFiltered append (units _x);
		};

		if (_x isEqualType objNull) then {
			_dropArrayFiltered pushBack _x;
		};
	};
};

private _chuteType = ["B_Parachute","CUP_T10_Parachute_backpack"] select (isClass (configfile >> "CfgVehicles" >> "CUP_T10_Parachute_backpack"));

localNamespace setVariable ["KISKA_fnc_staticline_doEject",{
	params ["_unit","_chuteType","_index","_invincibleOnDrop"];

	sleep (_index / 5); // delay for getting a spread of units

	private _loadout = getUnitLoadout _unit;

	if !(isNull (unitbackpack _unit)) then {
		removeBackpackGlobal _unit;
	};
	// decided not to use addBackpackGlobal because of waiting for locality
	waitUntil {
		[_unit,_chuteType] remoteExecCall ["addBackpack",_unit];
		if (!isNull (backpackContainer _unit) OR {!alive _unit}) exitWith {true};
		sleep 0.25;
		false
	};

	private _aircraft = objectParent _unit;

	if !(isNull _aircraft) then {
		[_unit] remoteExecCall ["unassignVehicle",_unit];
		//[_unit,_aircraft] remoteExecCall ["leaveVehicle",_unit];
		[_unit,["GetOut", _unit]] remoteExecCall ["action",_unit];
		[_unit] remoteExecCall ["moveOut",_unit];

		// determine the side of the aircraft to eject the person on
		private _sideOfAircraft = [10,-10] select ((_index mod 2) isEqualTo 0);


		// might need to waitUntil backpackContainer is not Null to be sure
		// delay chute open to create some distance with plane
		[_unit,_aircraft,_sideOfAircraft] spawn {
			params ["_unit","_aircraft","_sideOfAircraft"];

			_unit setPosATL ((getPosATLVisual _unit) vectorAdd (_aircraft vectorModelToWorldVisual [_sideOfAircraft,0,0]));
			// if a unit is moving too fast when they open the chute, it will sometimes cause it to not attach
			[_unit,[0,0,0]] remoteExecCall ["setVelocity",_unit];
			sleep 1;
			[_unit,["OpenParachute", _unit]] remoteExecCall ["action",_unit];
		};

		sleep 3;

		if (_invincibleOnDrop) then {
			[_unit,false] remoteExecCall ["allowDamage",_unit];
		};

		waitUntil {
			if (((getPosATL _unit) select 2) < 0.1 OR {isTouchingGround _unit}) exitWith {true};
			sleep 2;
			false;
		};

		if (_invincibleOnDrop) then {
			[_unit,true] remoteExecCall ["allowDamage",_unit];
		};
		_unit setUnitLoadout _loadout;
	};
}];


// execute eject
{
	[_x,_chuteType,_forEachIndex,_invincibleOnDrop] spawn (localNamespace getVariable "KISKA_fnc_staticLine_doEject");
} forEach ([_dropArrayFiltered,_dropArray] select (_dropArrayFiltered isEqualTo []));


true
