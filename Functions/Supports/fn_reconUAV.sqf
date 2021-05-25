#include "..\..\Headers\String Constants.hpp"
/* ----------------------------------------------------------------------------
Function: BLWK_fnc_reconUAV

Description:
	Marks all enemies on the map and updates their positions every
	 so often.

Parameters:
	NONE

Returns:
	NOTHING

Examples:
    (begin example)

		[] spawn BLWK_fnc_reconUAV;

    (end)

Authors:
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
#define LIFETIME 120
#define MARKER_SIZE 0.5
#define RECON_MARKER "BLWK_reconUavMarker"
#define UPDATE_TIME 0.5
scriptName "BLWK_fnc_reconUAV";

if !(isServer) exitWith {};

if !(canSuspend) exitWith {
	["Must be run in a scheduled environment. Exiting to scheduled...",true] call KISKA_fnc_log;
	[] spawn BLWK_fnc_reconUAV;
};

// make it so we can have 2 UAVs active at once
missionNamespace setVariable ["BLWK_reconUavActive",true,true];

private [
	"_unit_temp",
	"_markerName_temp",
	"_marker_temp",
	"_markerExists_temp",
	"_unitsArray"
];

private _createdMarkers = [];
private _endtime = time + LIFETIME;
while {sleep UPDATE_TIME; time < _endTime} do {
	//_unitsArray = units side OPFOR;
	_unitsArray = missionNamespace getVariable [WAVE_ENEMIES_ARRAY,[]];
	
	if !(_unitsArray isEqualTo []) then {
		
		{
			_markerName_temp = [RECON_MARKER,_forEachIndex] joinString "_";
			_markerExists_temp = (getMarkerType _markerName_temp) != "";
			if (alive _x) then {
				if (_markerExists_temp) then {
					_markerName_temp setMarkerPos _x;
					//diag_log (["Updating position of",_markerName_temp] joinString " ");
				} else {
					_marker_temp = createMarkerLocal [_markerName_temp,_x];
					_marker_temp setMarkerTypeLocal "mil_triangle";
					_marker_temp setMarkerSizeLocal [MARKER_SIZE,MARKER_SIZE];
					_marker_temp setMarkerColor "colorOPFOR";
					
					_createdMarkers pushBack _marker_temp;
					//diag_log (["created marker:",_marker_temp] joinString " ");
				};

				sleep UPDATE_TIME;
			} else {
				if (_markerExists_temp) then {
					deleteMarker _markerName_temp;
					//diag_log (["marker", _markerName_temp, "was deleted"] joinString " ");
				};
			};
		} forEach _unitsArray;
	};

	//diag_log "Reached end of while, going back";
};

// delete markers
_createdMarkers apply {
	// if marker is not already deleted
	if ((getMarkerType _x) != "") then {
		//diag_log (["The marker isn't already deleted, deleting marker:",_x] joinString " ");
		deleteMarker _x;
	}; 
};

missionNamespace setVariable ["BLWK_reconUavActive",false,true];
[parseText "<t color='#2adb59'>Recon UAV is no longer active</t>"] remoteExecCall ["hint",BLWK_allClientsTargetId];