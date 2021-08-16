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
#define MIN_SEARCH_DISTANCE_FOR_LZ 250
#define MAX_SEARCH_DISTANCE_FOR_LZ 


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
while {!_lzFound OR {_attempts <= MAX_ATTEMPTS}} do {
    private _centerPosition = [
        BLWK_
    ] call BIS_fnc_findSafePos;
};
