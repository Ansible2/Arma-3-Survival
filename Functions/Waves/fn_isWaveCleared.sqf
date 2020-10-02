if (!isServer) exitWith {};

#include "..\..\Headers\String Constants.hpp"

private _index = (missionNamespace getVariable [WAVE_ENEMIES_ARRAY,[]]) findIf {alive _x};
if !(_index isEqualTo -1) then {
	false
} else {
	true
};