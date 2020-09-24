/* ----------------------------------------------------------------------------
Function: BLWK_fnc_mainLoop

Description:
	Starts the main loop of the mission 
	
	It is executed from the "initServer.sqf".
	
Parameters:
	NONE

Returns:
	Nothing

Examples:
    (begin example)

		null = [] spawn BLWK_fnc_mainLoop;

    (end)
---------------------------------------------------------------------------- */
/* Cipher Comment: 
	So set everyone conscious
	Play an animation
	Make them stand
	Then revive them?
	And set their damage to nothing

	...huh?
*/
{
	[_x, false] remoteExec ["setUnconscious", 0];
	_X action ["CancelAction", _X];
	_X switchMove "PlayerStand";
	[ "#rev", 1, _x ] remoteExecCall ["BIS_fnc_reviveOnState", _x];
	_x setDamage 0;
} forEach allPlayers;

_CenterPos = _this;
BLWK_currentWaveNumber = 0;
publicVariable "BLWK_currentWaveNumber";
suicideWave = false;

waveUnits = [[],[],[]];
revivedPlayers = [];
MIND_CONTROLLED_AI = [];
wavesSinceArmour = 0;
wavesSinceCar = 0;
wavesSinceSpecial = 0;
SatUnlocks = [];
publicVariable 'SatUnlocks';

//spawn start loot
if (isServer) then {
	execVM "loot\spawnLoot.sqf";
};

sleep 15;
runMissionLoop = true;
missionFailure = false;

// start in build phase
missionNamespace setVariable ["buildPhase", true, true];

[west, BLWK_numRespawnTickets] call BIS_fnc_respawnTickets;

while {runMissionLoop} do {

	//Reset the AI position checks
	AIstuckcheck = 0;
	AIStuckCheckArray = [];

	call bulwark_fnc_startWave;

	while {runMissionLoop} do {

		// Get all human players in this wave cycle // moved to contain players that respawned in this wave
		_allHCs = entities "HeadlessClient_F";
		_allHPs = allPlayers - _allHCs;

		//Check if all hostiles dead
		if (EAST countSide allUnits == 0) exitWith {};

		//check if all players dead or unconscious
		_deadUnconscious = [];
		{
			if ((!alive _x) || ((lifeState _x) == "INCAPACITATED")) then {
				_deadUnconscious pushBack _x;
			};
		} foreach _allHPs;
		_respawnTickets = [west] call BIS_fnc_respawnTickets;
		if (count (_allHPs - _deadUnconscious) <= 0 && _respawnTickets <= 0) then {
			sleep 1;

			//Check that Players have not been revived
			_deadUnconscious = [];
			{
				if ((!alive _x) || ((lifeState _x) == "INCAPACITATED")) then {
					_deadUnconscious pushBack _x;
				};
			} foreach _allHPs;
			if (count (_allHPs - _deadUnconscious) <= 0 && _respawnTickets <= 0) then {
				sleep 1;
				if (count (_allHPs - _deadUnconscious) <= 0 && _respawnTickets <= 0) then {
					runMissionLoop = false;
					missionFailure = true;
					"End1" call BIS_fnc_endMissionServer;
				};
			};
		};

		//Add objects to zeus
		{
			BLWK_zeus addCuratorEditableObjects [[_x], true];
		} foreach _allHPs;
	};

	if(missionFailure) exitWith {};

	if (BLWK_currentWaveNumber == BLWK_maxNumWaves) exitWith {
		"End2" call BIS_fnc_endMissionServer;
	};

	[] call bulwark_fnc_endWave;

};












#include "script_component.hpp"
/*
 * Author: Kingsley
 * Deploys the object to the player for them to move it around.
 *
 * Arguments:
 * 0: Target <OBJECT>
 * 1: Player <OBJECT>
 * 2: Object params (side, classname, rotations) <ARRAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, player, [west, "Land_BagBunker_Small_F"]] call acex_fortify_fnc_deployObject
 *
 * Public: No
 */

params ["", "_player", "_params"];
_params params [["_side", sideUnknown, [sideUnknown]], ["_classname", "", [""]], ["_rotations", [0,0,0]]];
TRACE_4("deployObject",_player,_side,_classname,_rotations);

private _budget = [_side] call FUNC(getBudget);
private _cost = [_side, _classname] call FUNC(getCost);

// Create a local only copy of the object
private _object = _classname createVehicleLocal [0, 0, 0];
_object disableCollisionWith _player;

GVAR(objectRotationX) = _rotations select 0;
GVAR(objectRotationY) = _rotations select 1;
GVAR(objectRotationZ) = _rotations select 2;

GVAR(isPlacing) = PLACE_WAITING;

private _lmb = LLSTRING(confirm);
if (_budget > -1) then {_lmb = _lmb + format [" -$%1", _cost];};
private _rmb = localize ACELSTRING(Common,Cancel);
private _wheel = LLSTRING(rotate);
private _xAxis = localize "str_disp_conf_xaxis";
private _icons = [["alt", localize "str_3den_display3den_entitymenu_movesurface_text"], ["shift", localize "str_disp_conf_xaxis" + " " + _wheel], ["control", localize "str_disp_conf_yaxis" + " " + _wheel]];
[_lmb, _rmb, _wheel, _icons] call ACEFUNC(interaction,showMouseHint);

private _mouseClickID = [_player, "DefaultAction", {GVAR(isPlacing) == PLACE_WAITING}, {GVAR(isPlacing) = PLACE_APPROVE}] call ACEFUNC(common,addActionEventHandler);
[QGVAR(onDeployStart), [_player, _object, _cost]] call CBA_fnc_localEvent;

[{
    params ["_args", "_pfID"];
    _args params ["_unit", "_object", "_cost", "_mouseClickID"];

    if (_unit != ACE_player || {isNull _object} || {!([_unit, _object, []] call ACEFUNC(common,canInteractWith))} || {!([_unit, _cost] call FUNC(canFortify))}) then {
        GVAR(isPlacing) = PLACE_CANCEL;
    };

    // If place approved, verify deploy handlers
    if (GVAR(isPlacing) == PLACE_APPROVE && {(GVAR(deployHandlers) findIf {([_unit, _object, _cost] call _x) isEqualTo false}) > -1}) then {
        GVAR(isPlacing) = PLACE_WAITING;
    };

    if (GVAR(isPlacing) != PLACE_WAITING) exitWith {
        TRACE_3("exiting PFEH",GVAR(isPlacing),_pfID,_mouseClickID);
        [_pfID] call CBA_fnc_removePerFrameHandler;
        call ACEFUNC(interaction,hideMouseHint);
        [_unit, "DefaultAction", _mouseClickID] call ACEFUNC(common,removeActionEventHandler);

        if (GVAR(isPlacing) == PLACE_APPROVE) then {
            TRACE_1("deploying object",_object);
            GVAR(isPlacing) = PLACE_CANCEL;
            [_unit, _object] call FUNC(deployConfirm);
        } else {
            TRACE_1("deleting object",_object);
            deleteVehicle _object;
        };
    };

    ([_object] call FUNC(axisLengths)) params ["_width", "_length", "_height"];
    private _distance = (_width max _length) + 0.5; // for saftey, move it a bit extra away from player's center

    private _start = eyePos _unit;
    private _camViewDir = getCameraViewDirection _unit;
    private _basePos = _start vectorAdd (_camViewDir vectorMultiply _distance);
    _basePos set [2, ((_basePos select 2) - (_height / 2)) max (getTerrainHeightASL _basePos - 0.05)];

    _object setPosASL _basePos;

    private _vZ =  180 + GVAR(objectRotationZ) + getDir _unit;
    if (cba_events_alt) then {
        // Snap to terrain surface dir
        _object setDir _vZ;
        _object setVectorUp (surfaceNormal _basePos);
    } else {
        [_object, GVAR(objectRotationX), GVAR(objectRotationY), _vZ] call ACEFUNC(common,setPitchBankYaw);
    };
    #ifdef DEBUG_MODE_FULL
    hintSilent format ["Rotation:\nX: %1\nY: %2\nZ: %3", GVAR(objectRotationX), GVAR(objectRotationY), GVAR(objectRotationZ)];
    #endif
}, 0, [_player, _object, _cost, _mouseClickID]] call CBA_fnc_addPerFrameHandler;