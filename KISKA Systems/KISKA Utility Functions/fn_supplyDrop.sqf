/* ----------------------------------------------------------------------------
Function: KISKA_fnc_supplyDrop

Description:
    Spawns a supply drop near the requested position. Crates will parachute in.

Parameters:
    0: _classNames <ARRAY> - Classnames of boxes you want dropped. Also determines the number of crates
    1: _altittude <NUMBER> - Start height of drop
    2: _dropPosition <OBJECT, GROUP, ARRAY, LOCATION, TASK> - Position you want the drop to be near

    OPTIONAL:
    3: _stopAdjustingHeight <NUMBER> - The height (ATL) at which the velocity of the crates should top being managed
    4: _chuteVelocityFreq <NUMBER> - The frequency in seconds at which the velocity of the crates should be managed
    5: _stage_1_height <NUMBER> - The height above which the _stage_1_velocityDiff is used to manage the downward velocity of the crates
    6: _stage_1_velocityDiff <NUMBER> - The downward velocity of the crates above _stage_1_height
    7: _stage_2_velocityDiff <NUMBER> - The downward velocity of the crates below _stage_1_height

Returns:
    <ARRAY> - The containers dropped

Examples:
    (begin example)
        [["className1","className2"], 500, player] call KISKA_fnc_supplyDrop;
    (end)

Author(s):
    Ansible2
---------------------------------------------------------------------------- */
scriptName "KISKA_fnc_supplyDrop";

params [
    ["_classNames",["B_supplyCrate_F"],[[]]],
    ["_altittude",100,[1]],
    ["_dropPosition",objNull,[objNull,[],grpNull,locationNull,taskNull]],
    ["_stopAdjustingHeight",80,[123]],
    ["_chuteVelocityFreq",0.25,[123]],
    ["_stage_1_height",500,[123]],
    ["_stage_1_velocityDiff",90,[123]],
    ["_stage_2_velocityDiff",35,[123]]
];

if (_classNames isEqualTo []) exitWith {
    ["No classnames passed!",true] call KISKA_fnc_log;
    []
};

private _containersArray = [];
private ["_container_temp","_dropZone_temp","_chute_temp"];
_classNames apply {
    // create Container
    _container_temp = createVehicle [_x,[0,0,0],[],0];
    _containersArray pushBack _container_temp;

    _dropZone_temp = [_dropPosition,50] call CBAP_fnc_randPos;
    _dropZone_temp set [2,0];
    _container_temp allowDamage false;

    // create it's parachutes
    _chute_temp = createVehicle ["b_parachute_02_F",[0,0,0]];
    _chute_temp setPosATL (_dropZone_temp vectorAdd [random [-10,0,10],random [-10,0,10],_altittude]);
    _container_temp attachTo [_chute_temp,[0,0,0]];

    // speed up the drop
    [_chute_temp,_container_temp,_chuteVelocityFreq,_stage_1_height,_stage_1_velocityDiff,_stage_2_velocityDiff,_stopAdjustingHeight] spawn {
        params [
            "_chute",
            "_container",
            "_chuteVelocityFreq",
            "_stage_1_height",
            "_stage_1_velocityDiff",
            "_stage_2_velocityDiff",
            "_stopAdjustingHeight"
        ];
        // give chute time to deploy
        sleep 3;


        private "_chuteVelocity";
        private _chuteHeight = (getPosATLVisual _chute) select 2;
        waitUntil {
            sleep _chuteVelocityFreq;
            _chuteVelocity = velocity _chute;

            if (_chuteHeight > _stage_1_height) then {
                _chute setVelocity (_chuteVelocity vectorDiff [0,0,_stage_1_velocityDiff]);
            } else {
                _chute setVelocity (_chuteVelocity vectorDiff [0,0,_stage_2_velocityDiff]);
            };
            _chuteHeight = (getPosATLVisual _chute) select 2;


            _chuteHeight < _stopAdjustingHeight
        };

        waitUntil {
            _chuteHeight = (getPosATL _chute) select 2;
            if (_chuteHeight < 15) exitWith {
                detach _container;
                true
            };
            sleep 1;
            false
        };
    };
};


[_containersArray select 0] spawn {
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
        if (
            (((call CBAP_fnc_players) findIf {
                (_x distance2D _firstContainer) <= 10
            }) isNotEqualTo -1) OR
            {time > _deleteTime}
        ) exitWith {true};

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


_containersArray
