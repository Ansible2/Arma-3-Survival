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

		null = [] spawn BLWK_fnc_reconUAV;

    (end)

Authors:
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
#define LIFETIME 120
#define RECON_MARKER "BLWK_reconUavMarker"

if !(isServer) exitWith {};

if !(canSuspend) exitWith {};

// make it so we can have 2 UAVs active at once
missionNamespace setVariable ["BLWK_reconUavActive",true,true];

private [
	"_unit_temp",
	"_markerName_temp",
	"_marker_temp"
];

private _createdMarkers = [];
private _markerCount = 0;
private _fn_createMarker = {
	_markerCount = _markerCount + 1;
	_markerName_temp = [RECON_MARKER,_markerCount] joinString "_";
	_marker_temp = createMarkerLocal [_markerName_temp,_unit_temp];
	
	_unit_temp setVariable [RECON_MARKER,_marker_temp];
	_createdMarkers pushBack _marker_temp;

	//diag_log (["created marker:",_marker_temp] joinString " ");

	// see https://community.bistudio.com/wiki/setMarkerPos as to why this is local
	_marker_temp setMarkerTypeLocal "mil_triangle";
	_marker_temp setMarkerColor "colorOPFOR";

	diag_log (["created marker:",_marker_temp] joinString " ");
};


private _endtime = time + LIFETIME;
private "_unitsArray";
while {sleep 1; time < _endTime} do {
	_unitsArray = missionNamespace getVariable [WAVE_ENEMIES_ARRAY,[]];
	
	if !(_unitsArray isEqualTo []) then {
		_unitsArray apply {
			_unit_temp = _x;
			_marker_temp = _unit_temp getVariable [RECON_MARKER,""];
			
			if (alive _unit_temp) then {
				diag_log "_unit_temp is alive";
				
				if (_marker_temp isEqualTo "") then {
					diag_log "_marker_temp is empty string";
					call _fn_createMarker;
				} else {
					diag_log (["Updating position of",_marker_temp] joinString " ");
					_marker_temp setMarkerPos _unit_temp;
				};
				
				sleep 1;
			} else {
				diag_log "_unit_temp is dead";
				// get rid of markers for the dead
				if !(_marker_temp isEqualTo "") then {
					diag_log (["_marker_temp isn't empty string, deleting:", _marker_temp] joinString " ");
					_unit_temp setVariable [RECON_MARKER,nil];
					deleteMarker _marker_temp;
				};
			};
		};
	};
};

// clear unit globals
_unitsArray apply {
	if ((_x getVariable [RECON_MARKER,""]) != "") then {
		_x setVariable [RECON_MARKER,nil];
	};
};

// delete markers
_createdMarkers apply {
	// if marker is not already deleted
	if !((getMarkerType _x) isEqualTo "") then {
		diag_log (["The marker isn't already deleted, deleting marker:",_x] joinString " ");
		deleteMarker _x;
	}; 
};

missionNamespace setVariable ["BLWK_reconUavActive",false,true];
[parseText "<t color='#005aff'>Recon UAV is no longer active</t>"] remoteExecCall ["hint",BLWK_allClientsTargetId];