/* ----------------------------------------------------------------------------
Function: BLWK_fnc_teleportToExtractionSite

Description:
    Fades a player's screen to black and then teleports them to the extraction
     area.

Parameters:
	0: _position : <ARRAY> - An array [a,b] that is the ceneter position of the
     extraction site

Returns:
    NOTHING

Examples:
    (begin example)
        [[0,0,0]] call BLWK_fnc_teleportToExtractionSite
    (end)

Author(s):
	Ansible2
---------------------------------------------------------------------------- */
scriptName "BLWK_fnc_teleportToExtractionSite";

#define LAYER_NAME "BLWK_extractionFade"
#define FADE_SPEED 3
#define RAND_POS_RADIUS 20

if (!hasInterface) exitWith {};

LAYER_NAME cutText ["Teleporting To Extraction Site...","BLACK OUT",FADE_SPEED];

[
    {
        params ["_position"];

        if (missionNamespace getVariable ["BLWK_isAircraftGunner",false]) then {
            private _aircraft = objectParent player;
            private _pilotGroup = group (currentPilot _aircraft);
            private _loiterHeight = _pilotGroup getVariable "BLWK_aircraftGunner_loiterHeight";
            private _newPosition = +BLWK_playAreaCenter;
            _newPosition set [2,_loiterHeight];
            
            _aircraft setPosASL (ATLToASL _newPosition);

            [_pilotGroup] call KISKA_fnc_clearWaypoints;

            private _loiterWaypoint = _pilotGroup addWaypoint [BLWK_playAreaCenter,0];
            _loiterWaypoint setWaypointType "LOITER";
            _loiterWaypoint setWaypointLoiterRadius (_pilotGroup getVariable "BLWK_aircraftGunner_loiterRadius");
            _loiterWaypoint setWaypointLoiterType (_pilotGroup getVariable "BLWK_aircraftGunner_loiterType");
            _loiterWaypoint setWaypointLoiterAltitude _loiterHeight;
            _vehicle flyInHeight _loiterHeight;
            _loiterWaypoint setWaypointSpeed "LIMITED";

        } else {
            private _teleportPos = [_position, RAND_POS_RADIUS] call CBAP_fnc_randPos;
            // _teleportPos is a 2d position ([1,1])
            player setPos _teleportPos;

        };

        LAYER_NAME cutText ["Teleporting To Extraction Site...","BLACK IN",FADE_SPEED];
    },
    _this,
    FADE_SPEED + 1
] call CBAP_fnc_waitAndExecute;


nil
