#include "..\..\Headers\Faction Map Ids.hpp"
/* ----------------------------------------------------------------------------
Function: BLWK_fnc_callForExtraction

Description:


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
#define NUMBER_OF_ENEMIES 1000

#define MAX_ATTEMPTS 300


if (!isServer) exitWith {
    ["Must be executed on the server!",true] call KISKA_fnc_log;
    nil
};

if (!canSuspend) exitWith {
    ["Must be called from scheduled",true] call KISKA_fnc_log;
    _this spawn BLWK_fnc_callForExtraction;
    nil
};


/* ----------------------------------------------------------------------------
	Determine helicopeter class to use for player pick up
---------------------------------------------------------------------------- */
// get the helicopter with the most seats
private _fn_getNumberOfCargoSeats = {
    params ["_vehicleClass"];

    private _totalSeats = [_vehicleClass, true] call BIS_fnc_crewCount;
    private _crewSeats = [_vehicleClass, false] call BIS_fnc_crewCount;

    _totalSeats - _crewSeats;
};

private _transportHeliClasses = BLWK_friendlyFactionMap get TRANSPORT_HELI_FACTION_MAP_ID;
private _transportHeliClass = "";
private _transportSeatCount = -1;
private _cargoSeatsCount = 0;
_transportHeliClasses apply {
    _cargoSeatsCount = [_x] call _fn_getNumberOfCargoSeats;
    if (_cargoSeatsCount > _transportSeatCount) then {
        _transportSeatCount = _cargoSeatsCount;
        _transportHeliClass = _x;
    };
};

if (_transportSeatCount < TOO_LITTLE_SEATS OR {_transportHeliClass isEqualTo ""}) then {
    _transportHeliClass = DEFAULT_TRANSPORT_HELI;
    _transportSeatCount = [_transportHeliClass] call _fn_getNumberOfCargoSeats;
};
missionNamespace setVariable ["BLWK_extractSeatCount",_transportSeatCount];


/* ----------------------------------------------------------------------------
	Determine number of transports needed for player numbers
---------------------------------------------------------------------------- */
private _numberOfTransports = 1;
private _currentNumPlayers = count (call CBAP_fnc_players);
if (_transportSeatCount < _currentNumPlayers) then {
    _numberOfTransports = ceil(_currentNumPlayers / _transportSeatCount);
};

// sizeOf is not reliable
private _sizeOfTransport = (sizeOf _transportHeliClass) max MIN_VEHICLE_SIZE;
private _sizeOfLZArea = (_sizeOfTransport + SPACE_BUFFER) * _numberOfTransports;


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


    if (_centerPosition isEqualTo BLWK_playAreaCenter) then {
        break;
    };


    for "_j" from 1 to (_numberOfTransports - 1) do {
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


    if ((count _landingPositions) isEqualTo _numberOfTransports) then {
        _lzFound = true;
        break;
    };

    // reset for next attempt
    _landingPositions = [];
};


/* ----------------------------------------------------------------------------
	Notify players
---------------------------------------------------------------------------- */
if (!_lzFound) exitWith {
    ["The map does not accomodate an extraction, mission will end shortly..."] remoteExec ["BLWK_fnc_errorNotification",call CBAP_fnc_players];
    sleep 5;
    "end2" call BIS_fnc_endMissionServer;
};

private _players = call CBAP_fnc_players;
["You will be teleported to the extraction site shortly"] remoteExec ["BLWK_fnc_notification",_players];
if (BLWK_extractionHintsEnabled) then {
    ["There will be marked positions that are your LZs, do not place objects inside of these zones!",5] remoteExec ["BLWK_fnc_notification",_players];
};



/* ----------------------------------------------------------------------------
	Remove terrain objects from LZ so helis can land
---------------------------------------------------------------------------- */
[_centerPosition,_sizeOfLZArea] spawn {
    params ["_centerPosition","_sizeOfLZArea"];

    private _terrainObjects = nearestTerrainObjects [_centerPosition,[],_sizeOfLZArea,false,true];
    _terrainObjects apply {
        hideObjectGlobal _x;
    };
};


/* ----------------------------------------------------------------------------
	Teleport
---------------------------------------------------------------------------- */
// need to wait or else players will get auto placed at BLWK_playAreaCenter due to enforce area script
missionNamespace setVariable ["BLWK_enforceArea",false,true];
sleep 3;

BLWK_playAreaCenter = _centerPosition;
[20,450,500,525] call BLWK_fnc_cacheEnemyMenSpawnPositions;

[_centerPosition] remoteExec ["BLWK_fnc_teleportToExtractionSite",_players];
// _centerPosition is a 2d position ([1,1])
BLWK_mainCrate setPos _centerPosition;


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


[BLWK_extractionSetUpTime,15,10] remoteExec ["KISKA_fnc_countDown",-2];
[BLWK_extractionSetUpTime,15,10] call KISKA_fnc_countDown;


/* ----------------------------------------------------------------------------
	Spawn enemy units
---------------------------------------------------------------------------- */
// set respawns to 0
[BLUFOR,-([BLUFOR] call BIS_fnc_respawnTickets),false] call BIS_fnc_respawnTickets;
missionNamespace setVariable ["BLWK_numRespawnTickets",0,true];
[false,NUMBER_OF_ENEMIES] remoteExec ["BLWK_fnc_createStdWaveInfantry",BLWK_theAIHandlerOwnerID];

["Enemies are inbound to your site, hold the position!"] remoteExec ["BLWK_fnc_notification",call CBAP_fnc_players];

sleep BLWK_timeTillExtraction;

["Helicopters will arrive shortly"] remoteExec ["BLWK_fnc_notification",call CBAP_fnc_players];


/* ----------------------------------------------------------------------------
	Create helicopters and have them land
---------------------------------------------------------------------------- */
BLWK_extractionAircraft = [];
BLWK_playersInExtractAircraft = [];
_landingPositions apply {
    private _spawnPosition = [_centerPosition,3000,random 360] call CBAP_fnc_randPos;

    private _aircraftInfo = [
        _spawnPosition,
        _spawnPosition getDir _centerPosition,
        _transportHeliClass
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
            waitUntil {
                sleep 2;
                (count (call CBAP_fnc_players)) isEqualTo (count BLWK_playersInExtractAircraft)
            };

            private _aircraft = _this select 0;
            _aircraft move (_aircraft getVariable "BLWK_exfilPosition");

            [] spawn BLWK_fnc_finishedExtraction;
        }
    ] call KISKA_fnc_heliLand;
};


nil
