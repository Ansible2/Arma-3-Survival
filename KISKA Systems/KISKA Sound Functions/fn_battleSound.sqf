/* ----------------------------------------------------------------------------
Function: KISKA_fnc_battleSound

Description:
	Create ambient battlefield sounds for a specified duration

Parameters:
	0: _source <OBJECT or ARRAY> - Where the sound is coming from. Can be an object or positions array (ASL)
	1: _distance <NUMBER or ARRAY> - Distance at which the sounds can be heard
	2: _duration <NUMBER> - Distance at which the sound can be heard
	3: _intensity <NUMBER> - Value between 1-5 that determines how frequent these sounds are played (5 being the fastest)

Returns:
	NOTHING

Examples:
    (begin example)

		[player,20,10] spawn KISKA_fnc_battleSound;

    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
scriptName "KISKA_fnc_battleSound";

if (!canSuspend) exitWith {
	"Must be run in a scheduled environement" call BIS_fnc_error;
};

if (!isServer) then {
	"Recommend this be run on the server" call BIS_fnc_error;
};

params [
	["_source",objNull,[objNull,[]]],
	["_distance",500,[[],123]],
	["_duration",60,[123]],
	["_intensity",1,[123]]
];

if (_source isEqualType objNull AND {isNull _source}) exitWith {
	"_source isNull" call BIS_fnc_error;
};

if (_distance isEqualType 123 AND {_distance <= 0}) exitWith {
	"_distance is less than or equal to 0" call BIS_fnc_error;
};

if (_distance isEqualType [] AND {!(_distance isEqualTypeParams [0,0,0])}) exitWith {
	"_distance random array is not configured properly" call BIS_fnc_error;
};

#define MAX_INTENSITY 5
#define MIN_INTENSITY 1

if (_source isEqualType objNull) then {
	_source = getPosASL _source;
};

if (_intensity > MAX_INTENSITY) then {
	_intensity = MAX_INTENSITY;
} else {
	if (_intensity < MIN_INTENSITY) then {
		_intensity = MIN_INTENSITY;
	};
};

private _intensityArray = switch _intensity do {
	case 1: {[2.5,3,3.5]};
	case 2: {[2,2.5,3]};
	case 3: {[1.5,2,2.5]};
	case 4: {[1,1.5,2]};
	case 5: {[0.5,1,1.5]};
};

private _soundArr = [
	"A3\Sounds_F\environment\ambient\battlefield\battlefield_explosions1.wss",0.25,
	"A3\Sounds_F\environment\ambient\battlefield\battlefield_explosions2.wss",0.25,
	"A3\Sounds_F\environment\ambient\battlefield\battlefield_explosions3.wss",0.25,
	"A3\Sounds_F\environment\ambient\battlefield\battlefield_explosions4.wss",0.25,
	"A3\Sounds_F\environment\ambient\battlefield\battlefield_explosions5.wss",0.25,
	"A3\Sounds_F\environment\ambient\battlefield\battlefield_firefight1.wss",1,
	"A3\Sounds_F\environment\ambient\battlefield\battlefield_firefight2.wss",1,
	"A3\Sounds_F\environment\ambient\battlefield\battlefield_firefight3.wss",1,
	"A3\Sounds_F\environment\ambient\battlefield\battlefield_firefight4.wss",1
];

private _endTime = _duration + time;

private _timeBetweenSounds = _intensityArray vectorMultiply 4;

waitUntil {
	if (_endTime <= time) exitWith {true};

	private _volume = floor (random [3,4,5]);
		
	playSound3D [selectRandomWeighted _soundArr, objNull, false, _source, _volume, random [-2,-1,0],[_distance,random _distance] select (_distance isEqualType [])];

	sleep (random _intensityArray);

	playSound3D [selectRandomWeighted _soundArr, objNull, false, _source, _volume, random [-2,-1,0],[_distance,random _distance] select (_distance isEqualType [])];

	sleep (random _timeBetweenSounds);

	false
};