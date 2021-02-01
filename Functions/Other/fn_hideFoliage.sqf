/* ----------------------------------------------------------------------------
Function: BLWK_fnc_hideFoliage

Description:
	Clears out trees and bushes within a given radius around a given position.

	Operates in 2d.

Parameters:
	0: _position : <OBJECT, PositionAGL, or Position2d> - The center of the zone to hide around
	1: _radius : <NUMBER> - The distance from _position to search around

Returns:
	NOTHING

Examples:
    (begin example)
		[player,100] call BLWK_fnc_hideFoliage;
    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
scriptName "BLWK_fnc_hideFoliage";

if (!isServer) exitWith {
	["Should be executed on the server. Remoting to server...",true] call KISKA_fnc_log;
	_this remoteExecCall ["BLWK_fnc_hideFoliage",2];
};

params ["_position","_radius"];

private _foliage = nearestTerrainObjects [_position,["TREE","SMALL TREE","BUSH"],_radius,false,true];

_foliage apply {
	_x hideObjectGlobal true;
};