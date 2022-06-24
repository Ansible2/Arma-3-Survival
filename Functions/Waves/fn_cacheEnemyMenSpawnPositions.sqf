/* ----------------------------------------------------------------------------
Function: BLWK_fnc_cacheEnemyMenSpawnPositions

Description:
	Saves a number of positions for enemy Men AI to spawn at around the
     BLWK_playAreaCenter.

	Executed from "BLWK_fnc_preparePlayArea"

Parameters:
	0: _numberOfPositions : <NUMBER> - Number of positions to find
	1: _minRadius : <NUMBER> - min radius to search from BLWK_playAreaCenter
	2: _maxRadius : <NUMBER> - Max radius to search from BLWK_playAreaCenter
	3: _maxAiTravelDistance : <NUMBER> - How far from the BLWK_playAreaCenter can the ai travel before being reset

Returns:
	NOTHING

Examples:
    (begin example)
		call BLWK_fnc_cacheEnemyMenSpawnPositions;
    (end)

Author(s):
	Hilltop(Willtop) & omNomios,
	Modified by: Ansible2 // Cipher
---------------------------------------------------------------------------- */
scriptName "BLWK_fnc_cacheEnemyMenSpawnPositions";

params [
    ["_numberOfPositions",15,[123]],
    ["_minRadius",BLWK_playAreaRadius + 50,[123]],
    ["_maxRadius",BLWK_playAreaRadius + 100,[123]],
    ["_maxAiTravelDistance",BLWK_playAreaRadius + 125,[123]],
    ["_distanceToObjects",3,[123]]
];

["Starting cache of infantry spawn positions",false] call KISKA_fnc_log;
// used for AI inftantry in BLWK_fnc_pathing_checkUnitDistance
missionNamespace setVariable ["BLWK_maxDistanceFromPlayArea",_maxAiTravelDistance,BLWK_theAIHandlerOwnerID];


private _AISpawnPositionsArray = [];
private _positionToPushBack = [];
while {count _AISpawnPositionsArray < _numberOfPositions} do {
	_positionToPushBack = [BLWK_playAreaCenter, _minRadius, _maxRadius, _distanceToObjects, 0] call BIS_fnc_findSafePos;
	_AISpawnPositionsArray pushBackUnique _positionToPushBack;
};


// give the spawn positions to whomever will be handling AI (server or headless client)
missionNamespace setVariable ["BLWK_infantrySpawnPositions",_AISpawnPositionsArray,BLWK_theAIHandlerOwnerID];
["Completed cache of infantry spawn positions",false] call KISKA_fnc_log;


nil
