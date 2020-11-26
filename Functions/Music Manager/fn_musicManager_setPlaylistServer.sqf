#include "..\..\Headers\descriptionEXT\GUI\musicManagerCommonDefines.hpp"

if (!isServer) exitWith {
	"BLWK_fnc_musicManager_setPlaylistServer needs to be run on the server" call BIS_fnc_error;
};

// copying playlist by value not reference, otherwise they will be deleted out of the current playlist box
private _publicPlaylist = +GET_PUBLIC_ARRAY_DEFAULT;
missionNamespace setVariable ["KISKA_randomMusic_tracks",_publicPlaylist];

missionNamespace setVariable ["KISKA_randomMusic_usedTracks",[]];

if (missionNamespace getVariable ["KISKA_musicSystemIsRunning",false]) then {
	null = [] spawn KISKA_fnc_randomMusic; 
};