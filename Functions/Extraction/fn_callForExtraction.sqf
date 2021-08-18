#include "..\..\Headers\Faction Map Ids.hpp"
/* ----------------------------------------------------------------------------
Function: BLWK_fnc_callForExtraction

Description:


Parameters:
	0: _var : <> -


Returns:


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

#define MAX_ATTEMPTS 300
#define MAX_SEARCH_DISTANCE_FOR_LZ worldsize * sqrt 2


if (!isServer) exitWith {
    ["Must be executed on the server!",true] call KISKA_fnc_log;

};


if !(BLWK_inBetweenWaves) exitWith {
    ["You must be between waves to call for an extraction before reaching the end number of waves"] remoteExec ["hint",remoteExecutedOwner];

};



// get the helicopter with the most seats
private _fn_getNumberOfCargoSeats = {
    params ["_vehicleClass"];
    private _totalSeats = [_x, true] call BIS_fnc_crewCount;
    private _crewSeats = [_x, false] call BIS_fnc_crewCount﻿;

    _totalSeats - _crewSeats;
};

private _transportHeliClasses = BLWK_friendlyFactionMap get TRANSPORT_HELI_FACTION_MAP_ID;
private _transportHeliClass = "";
private _transportSeatCount = -1;
_transportHeliClasses apply {
    private _cargoSeats = [_x] call _fn_getNumberOfCargoSeats;
    if (_cargoSeats > _transportSeatCount) then {
        _transportHeliClass = _x;
    };
};

if (_transportSeatCount < TOO_LITTLE_SEATS OR {_transportHeliClass isEqualTo ""}) then {
    _transportHeliClass = DEFAULT_TRANSPORT_HELI;
    _transportSeatCount = [_transportHeliClass] call _fn_getNumberOfCargoSeats;
};


private _numberOfTransports = 1;
private _currentNumPlayers = count (call CBAP_fnc_players);
if (_transportSeatCount >= _transportSeatCount) then {
    _numberOfTransports = ceil(_currentNumPlayers / _transportSeatCount);
};

private _sizeOfTransport = sizeOf _transportHeliClass;
private _sizeOfLZArea = (_sizeOfTransport + SPACE_BUFFER) * _numberOfTransports;


private _lzFound = false;
private _landingPositions = [];
private _blackListPositions = [];
private _fn_pushBackPos = {
    params ["_pos"];
    _blacklistPositions pushBack _pos;
    _landingPositions pushBack _pos;
};

for "_i" from 1 to MAX_ATTEMPTS do {

    private _centerPosition = [
        BLWK_playAreaCenter,
        BLWK_playAreaRadius,
        MAX_SEARCH_DISTANCE_FOR_LZ,
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
            _sizeOfLZArea,
            MAX_SEARCH_DISTANCE_FOR_LZ,
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


if (!_lzFound) exitWith {
    ["The map does not accomodate an extraction, mission will end shortly..."] remoteExec ["hint",call CBAP_fnc_players];
    sleep 5;
    ["end1"] call BIS_fnc_endMissionServer;
};




private _hintMessage = ["You will be teleported to the extraction site in: ",BLWK_timeTillExtraction," seconds.","\n Cleanup your site!"] joinString "";
[_hintMessage] remoteExec ["hint",call CBAP_fnc_players];




// Clear LZ area
[_centerPosition,_sizeOfLZArea] spawn {
    params ["_centerPosition","_sizeOfLZArea"];

    private _terrainObjects nearestTerrainObjects [_centerPosition,[],_sizeOfLZArea,false,true];
    _terrainObjects apply {
        hideObjectGlobal _x;
    };


};
sleep BLWK_timeTillExtraction;
