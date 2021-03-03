/* ----------------------------------------------------------------------------
Function: KISKA_fnc_supplyDrop

Description:
	Spawns a supply drop near the requested position. Crates will parachute in.

Parameters:
	0: _classNames <ARRAY> - Classnames of boxes you want dropped. Also determines the number of crates
	1: _altittude <NUMBER> - Start height of drop
	2: _dropPosition <OBJECT, GROUP, ARRAY, LOCATION, TASK> - Position you want the drop to be near

Returns:
	<ARRAY> - The containers dropped

Examples:
    (begin example)

		[["className1","className2"]], 500, player, -1] call KISKA_fnc_supplyDrop;

    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
scriptName "KISKA_fnc_supplyDrop";

params [
	["_classNames",["B_supplyCrate_F"],[[]]],
	["_altittude",100,[1]],
    ["_dropPosition",objNull,[objNull,[],grpNull,locationNull,taskNull]]
];

if (_classNames isEqualTo []) exitWith {
	"No classnames passed!" call BIS_fnc_error;
};

private _containersArray = [];
private ["_container_temp","_dropZone_temp","_chute_temp"];
_classNames apply {
    // create Container
    _container_temp = createVehicle [_x,[0,0,0],[],0];

    _containersArray pushBack _container_temp;

    // give the conatainer a random position above DZ
    _dropZone_temp = [_dropPosition,50] call CBAP_fnc_randPos;    
    // make it invincible
    _container_temp allowDamage false;

    // create it's parachutes
    _chute_temp = createVehicle ["b_parachute_02_F",[0,0,0]];
	_chute_temp setPosATL (_dropZone_temp vectorAdd [random [-10,0,10],random [-10,0,10],_altittude]);
    _container_temp attachTo [_chute_temp,[0,0,0]];

    // speed up the drop
	[_chute_temp,_container_temp] spawn {
		params ["_chute","_container"];

		// give chute time to deploy
		sleep 3;

		private "_chuteVelocity";
		private _chuteHeight = (getPosATLVisual _chute) select 2;
		while {_chuteHeight > 80} do {
			_chuteVelocity = velocityModelSpace _chute;
			if (_chuteHeight > 500) then {
				_chute setVelocityModelSpace (_chuteVelocity vectorDiff [0,0,90]);
			} else {
				_chute setVelocityModelSpace (_chuteVelocity vectorDiff [0,0,35]);
			};
            _chuteHeight = (getPosATLVisual _chute) select 2;
			sleep 0.25;
		};

		waitUntil {
			_chuteHeight = (getPosATL _chute) select 2;
			if (_chuteHeight < 10) exitWith {
				detach _container;
				true
			};
			sleep 1;
			false
		};
	};
};


KISKA_fnc_SD_markDropPosition = {
    params ["_firstContainer"];
	
	private _containerHeight = (getPosATL _firstContainer) select 2;
	waitUntil {
		if (_containerHeight < 5) exitWith {true};
		sleep 2;
		_containerHeight = (getPosATL _firstContainer) select 2;
		false
	};

    private _position = [_firstContainer,10] call CBAP_fnc_randPos;
    private _chemlight = createvehicle ["Chemlight_green_infinite",_position,[],0,"NONE"];
    private _smoke = createvehicle ["G_40mm_SmokeBlue_infinite",_position,[],0,"NONE"];
	private _deleteTime = time + 60;
    waitUntil {
        // waitUntil a player is within 10m of the first container
        if (!(((call CBAP_fnc_players) findIf {(_x distance2D _firstContainer) <= 10}) isEqualTo -1) OR {time > _deleteTime}) exitWith {true};
        
        sleep 2;
        false
    };
    // delete markers
    [_chemlight,_smoke] apply {
        if (!isNull _x) then {
            deleteVehicle _x;
        };
    };
};

// give the containers arsenals
[_containersArray] call KISKA_fnc_addArsenal;

[_containersArray select 0] spawn KISKA_fnc_SD_markDropPosition;


_containersArray