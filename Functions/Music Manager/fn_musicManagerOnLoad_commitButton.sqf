#include "..\..\Headers\descriptionEXT\GUI\musicManagerCommonDefines.hpp"

params ["_control"];

_control ctrlAddEventHandler ["ButtonClick",{
	if !(GET_PUBLIC_ARRAY_DEFAULT isEqualTo []) then {
		null = remoteExecCall ["BLWK_fnc_musicManager_setPlaylistServer",2];
		hint "Playlist set on server";
	} else {
		hint "You can't commit an empty playlist";
	};
}];