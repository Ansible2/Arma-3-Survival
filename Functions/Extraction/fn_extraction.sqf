#include "..\..\Headers\Faction Map Ids.hpp"
/* ----------------------------------------------------------------------------
Function: BLWK_fnc_callForExtraction

Description:
    Handles the logic for initiating the extraction sequence.

Parameters:
	NONE

Returns:
    NOTHING

Examples:
    (begin example)

    (end)

Author(s):
	Ansible2
---------------------------------------------------------------------------- */
scriptName "BLWK_fnc_callForExtraction";

#define DEFAULT_TRANSPORT_HELI "B_Heli_Transport_01_F"
#define TOO_LITTLE_SEATS 3
#define SPACE_BUFFER 5
#define MIN_VEHICLE_SIZE 15
#define NUMBER_OF_ENEMIES 5000

#define MAX_ATTEMPTS 300


if (!isServer) exitWith {
    ["Must be executed on the server!",true] call KISKA_fnc_log;
    nil
};

/* ----------------------------------------------------------------------------
	_fn_getExtractionHeliData
---------------------------------------------------------------------------- */
private _fn_getExtractionHeliData = {
    /* ----------------------------------------------------------------------------
        Determine helicopeter class to use for player pick up
    ---------------------------------------------------------------------------- */
    private _fn_getNumberOfCargoSeats = {
        params ["_vehicleClass"];

        private _totalSeats = [_vehicleClass, true] call BIS_fnc_crewCount;
        private _crewSeats = [_vehicleClass, false] call BIS_fnc_crewCount;

        _totalSeats - _crewSeats;
    };

    // get the helicopter with the most seats
    private _extractionHeliClass = "";
    private _extractionHeliSeatCount = -1;
    private _availableExtractionHeliClasses = BLWK_friendlyFaction_map get TRANSPORT_HELI_FACTION_MAP_ID;
    _availableExtractionHeliClasses apply {
        private _numberOfCargoSeatsInHeli = [_x] call _fn_getNumberOfCargoSeats;
        private _isBiggerThanLastHeli = _numberOfCargoSeatsInHeli > _extractionHeliSeatCount;

        if (_isBiggerThanLastHeli) then {
            _extractionHeliSeatCount = _numberOfCargoSeatsInHeli;
            _extractionHeliClass = _x;
        };
    };

    private _useDefaultHeli = (_extractionHeliSeatCount < TOO_LITTLE_SEATS) OR (_extractionHeliClass isEqualTo "");
    if (_useDefaultHeli) then {
        _extractionHeliClass = DEFAULT_TRANSPORT_HELI;
        _extractionHeliSeatCount = [_extractionHeliClass] call _fn_getNumberOfCargoSeats;
    };


    /* ----------------------------------------------------------------------------
        Determine number of transports needed for player numbers
    ---------------------------------------------------------------------------- */
    private _numberOfExtractionHelis = 1;
    private _currentNumPlayers = count (call CBAP_fnc_players);
    if (_extractionHeliSeatCount < _currentNumPlayers) then {
        _numberOfExtractionHelis = ceil(_currentNumPlayers / _extractionHeliSeatCount);
    };

    // sizeOf is not reliable
    private _sizeOfExtractionHeli = (sizeOf _extractionHeliClass) max MIN_VEHICLE_SIZE;
    private _sizeOfLZArea = (_sizeOfExtractionHeli + SPACE_BUFFER) * _numberOfExtractionHelis;


    [
        _extractionHeliClass,
        _extractionHeliSeatCount,
        _sizeOfLZArea,
        _sizeOfExtractionHeli,
        _numberOfExtractionHelis
    ]
};


/* ----------------------------------------------------------------------------
	_fn_findLandingPositions
---------------------------------------------------------------------------- */
private _fn_findLandingPositions = {
    params ["_sizeOfLZArea"];

    /* ----------------------------------------------------------------------------
        Find LZs needed for number of transports
    ---------------------------------------------------------------------------- */
    private _lzFound = false;
    private _landingPositions = [];
    private _blackListPositions = [];
    private _fn_pushBackPos = {
        params ["_pos"];
        _blacklistPositions pushBack _pos;
        _landingPositions pushBack _pos;
    };

    private _centerPosition = [];
    for "_i" from 1 to MAX_ATTEMPTS do {

        _centerPosition = [
            BLWK_playAreaCenter,
            BLWK_playAreaRadius,
            -1,
            0,
            0,
            0.25,
            0,
            _blacklistPositions,
            [BLWK_playAreaCenter,BLWK_playAreaCenter]
        ] call BIS_fnc_findSafePos;
        [_centerPosition] call _fn_pushBackPos;


        if (_centerPosition isEqualTo BLWK_playAreaCenter) then { break; };


        for "_j" from 1 to (_numberOfExtractionHelis - 1) do {
            private _lz = [
                _centerPosition,
                0,
                _sizeOfLZArea,
                0,
                0,
                0.25,
                0,
                _blacklistPositions,
                [BLWK_playAreaCenter,BLWK_playAreaCenter]
            ] call BIS_fnc_findSafePos;

            if (_lz isEqualTo BLWK_playAreaCenter) then {
                break;
            };

            [_lz] call _fn_pushBackPos;
        };


        if ((count _landingPositions) isEqualTo _numberOfExtractionHelis) then {
            _lzFound = true;
            break;
        };

        // reset for next attempt
        _landingPositions = [];
    };


    [_centerPosition,_landingPositions]
};


/* ----------------------------------------------------------------------------
	_fn_prepareExtractionSites
---------------------------------------------------------------------------- */
private _fn_prepareExtractionSites = {
    params ["_centerPosition","_landingPositions","_sizeOfLZArea"];

    /* ----------------------------------------------------------------------------
        Remove terrain objects from LZ so helis can land
    ---------------------------------------------------------------------------- */
    private _terrainObjects = nearestTerrainObjects [_centerPosition,[],_sizeOfLZArea,false,true];
    _terrainObjects apply {
        hideObjectGlobal _x;
    };

    /* ----------------------------------------------------------------------------
        Mark extraction sites for players
    ---------------------------------------------------------------------------- */
    {
        private _markerName = "BLWK_extractionMarker_" + (str _forEachIndex);
        private _marker = createMarkerLocal [_markerName,_x];
        _marker setMarkerShapeLocal "ICON";
        _marker setMarkerTypeLocal "hd_dot";
        _marker setMarkerText ("Extraction LZ " +  (str(_forEachIndex + 1)));
        missionNamespace setVariable [_markerName,_marker];

        _x pushBack 0;
        [AGLToASL _x,_sizeOfLZArea,10,1] call KISKA_fnc_markBorder;
    } forEach _landingPositions;

};


/* ----------------------------------------------------------------------------
	_fn_startExtractionDefense
---------------------------------------------------------------------------- */
private _fn_startExtractionDefense = {
    params ["_centerPosition","_afterExtractionArgs","_fn_afterExtractionWaitTime"];

    missionNamespace setVariable ["BLWK_playAreaCenter",_centerPosition,true];
    [20,300,350,375] call BLWK_fnc_cacheEnemyMenSpawnPositions;
    
    /* -------------------------------------
        Teleport players
    ------------------------------------- */
    private _players = [] call CBAP_fnc_players;
    [_centerPosition] remoteExec ["BLWK_fnc_teleportToExtractionSite",_players];
    // _centerPosition is a 2d position ([1,1])
    BLWK_mainCrate setPos _centerPosition;

    [BLWK_extractionSetUpTime,15,10] remoteExec ["KISKA_fnc_countDown",-2];
    [BLWK_extractionSetUpTime,15,10] call KISKA_fnc_countDown;


    /* -------------------------------------
        Spawn enemy units
    ------------------------------------- */
    // set respawns to 0
    private _currentRespawnTicketCount = [BLUFOR] call BIS_fnc_respawnTickets;
    [
        BLUFOR,
        -_currentRespawnTicketCount,
        false
    ] call BIS_fnc_respawnTickets;
    missionNamespace setVariable ["BLWK_numRespawnTickets",0,true];

    [false,NUMBER_OF_ENEMIES] remoteExec ["BLWK_fnc_createStdWaveInfantry",BLWK_theAIHandlerOwnerID];

    [
        "SpecialWarning",
        ["Enemies are inbound to your site, hold the position!"]
    ] remoteExec ["BIS_fnc_showNotification", _players];
    

    [
        _fn_afterExtractionWaitTime,
        _afterExtractionArgs,
        BLWK_timeTillExtraction
    ] call CBAP_fnc_waitAndExecute;
};


/* ----------------------------------------------------------------------------
	_fn_afterExtractionWaitTime
---------------------------------------------------------------------------- */
private _fn_afterExtractionWaitTime = {
    params ["_centerPosition","_landingPositions","_extractionHeliClass"];

    ["Helicopters will arrive shortly"] remoteExec ["KISKA_fnc_notification",call CBAP_fnc_players];

    /* -------------------------------------
        Create helicopters and have them land
    ------------------------------------- */
    BLWK_extractionAircraft = [];
    BLWK_playersInExtractAircraft = [];
    _landingPositions apply {
        private _spawnPosition = [_centerPosition,3000,random 360] call CBAP_fnc_randPos;

        private _aircraftInfo = [
            _spawnPosition,
            _spawnPosition getDir _centerPosition,
            _extractionHeliClass
        ] call KISKA_fnc_spawnVehicle;

        // handle crew AI
        private _aircraft = _aircraftInfo select 0;
        BLWK_extractionAircraft pushBack _aircraft;
        _aircraft allowDamage false;
        _aircraft setCaptive true;
        _aircraft flyInHeight 50;
        _aircraft lockDriver true;


        _aircraft addEventHandler ["GetIn", {
            params ["_aircraft", "", "_unit"];

            if (isPlayer _unit) then {
                _unit allowDamage false;
                _unit setCaptive true;
                BLWK_playersInExtractAircraft pushBackUnique _unit;
            };
        }];
        _aircraft addEventHandler ["GetOut", {
            params ["_aircraft", "", "_unit"];

            if (isPlayer _unit) then {
                BLWK_playersInExtractAircraft deleteAt (BLWK_playersInExtractAircraft find _unit);
                _unit allowDamage true;
                _unit setCaptive false;
            };
        }];


        private _crew = _aircraftInfo select 1;
        _crew apply {
            _x allowDamage false;
            _x setCaptive true;
            _x disableAI "AUTOCOMBAT";
            _x disableAI "FSM";
            _x disableAI "TARGET";
            private _turret = _aircraft unitTurret _x;
            if (_turret isNotEqualTo [] AND {_turret isNotEqualTo [-1]}) then {
                _aircraft lockTurret [_turret,true];
            };
        };

        private _aircraftGroup = _aircraftInfo select 2;
        _aircraftGroup setBehaviour "CARELESS";
        _aircraftGroup setCombatBehaviour "CARELESS";
        _aircraftGroup setCombatMode "BLUE";

        private _exfilPosition = [
            [1,1,1],
            500,
            360
        ] call CBAP_fnc_randPos;
        _aircraft setVariable ["BLWK_exfilPosition",_exfilPosition];

        [
            _aircraft,
            _x,
            "GET IN",
            true,
            {
                _this spawn {
                    params ["_aircraft"];

                    waitUntil {
                        sleep 2;
                        (count (call CBAP_fnc_players)) isEqualTo (count BLWK_playersInExtractAircraft)
                    };

                    _aircraft move (_aircraft getVariable "BLWK_exfilPosition");
                    [] spawn BLWK_fnc_finishedExtraction;
                };
            }
        ] call KISKA_fnc_heliLand;
    };

};




/* ----------------------------------------------------------------------------
	Main Function
---------------------------------------------------------------------------- */

/* -------------------------------------
	Get Heli Data
------------------------------------- */
private _extractionHeliData = call _fn_getExtractionHeliData;
_extractionHeliData params ["_extractionHeliClass","_extractionHeliSeatCount","_sizeOfLZArea"];
missionNamespace setVariable ["BLWK_extractSeatCount",_extractionHeliSeatCount];


/* -------------------------------------
	Find LZs
------------------------------------- */
private _landingData = [_sizeOfLZArea] call _fn_findLandingPositions;
private _lzFound = _landingPositions isNotEqualTo [];
if (!_lzFound) exitWith {
    [
        "The map does not accomodate an extraction, mission will end shortly..."
    ] remoteExec ["KISKA_fnc_errorNotification", call CBAP_fnc_players];

    [
        {
            "end2" call BIS_fnc_endMissionServer;
        },
        [],
        5
    ] call CBAP_fnc_waitAndExecute;
};


/* -------------------------------------
	Prepare LZs for fight
------------------------------------- */
_landingData params ["_centerPosition","_landingPositions"];
[_centerPosition, _landingPositions, _sizeOfLZArea] call _fn_prepareExtractionSites;


/* -------------------------------------
	Notify players
------------------------------------- */
private _players = call CBAP_fnc_players;
["You will be teleported to the extraction site shortly",5,false] remoteExec ["KISKA_fnc_notification",_players];
if (BLWK_extractionHintsEnabled) then {
    [
        "There will be marked positions that are your LZs, do not place objects in the middle of these zones!",
        15,
        false
    ] remoteExec ["KISKA_fnc_notification",_players];
};


/* -------------------------------------
	Teleport and start
------------------------------------- */
missionNamespace setVariable ["BLWK_enforceArea",false,true];
// need to wait or else players will get auto placed 
// at BLWK_playAreaCenter due to enforce area script
private _afterExtractionArgs = [_centerPosition,_landingPositions,_extractionHeliClass];
[
    _fn_startExtractionDefense,
    [_centerPosition,_afterExtractionArgs,_fn_afterExtractionWaitTime],
    3
] call CBAP_fnc_waitAndExecute;


nil
