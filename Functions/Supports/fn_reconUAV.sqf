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
	Ansible2
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

private _createdMarkers = [];
private _endtime = time + LIFETIME;
while {sleep UPDATE_TIME; time < _endTime} do {

	{
		private _markerName = [RECON_MARKER,_forEachIndex] joinString "_";
		private _markerExists = (getMarkerType _markerName) != "";
		if (alive _x) then {
			if (_markerExists) then {
				_markerName setMarkerPos _x;
				//diag_log (["Updating position of",_markerName] joinString " ");
			} else {
				private _marker = createMarkerLocal [_markerName,_x];
				_marker setMarkerTypeLocal "mil_triangle";
				_marker setMarkerSizeLocal [MARKER_SIZE,MARKER_SIZE];
				_marker setMarkerColor "colorOPFOR";

				_createdMarkers pushBack _marker;
				//diag_log (["created marker:",_marker] joinString " ");
			};

			sleep UPDATE_TIME;
		} else {
			if (_markerExists) then {
				deleteMarker _markerName;
				//diag_log (["marker", _markerName, "was deleted"] joinString " ");
			};
		};
	} forEach (call BLWK_fnc_getMustKillList);

	//diag_log "Reached end of while, going back";
};


_createdMarkers apply {
	// if marker is not already deleted
	private _markerNotDeleted = (getMarkerType _x) != "";
	if (_markerNotDeleted) then {
		deleteMarker _x;
	};
};


missionNamespace setVariable ["BLWK_reconUavActive",false,true];
["Recon UAV is no longer active"] remoteExecCall ["KISKA_fnc_notification",BLWK_allClientsTargetId];


nil
