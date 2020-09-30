// decide if special wave

// decide what AI should spawn

// start AI que loop

// spawn AI

// give AI the hit event handlers that add points

// inform pepople the round has started and what kind it is/number

// need to decide on special waves
#include "..\..\Headers\Wave Type Stings.hpp"

if (!isServer) exitWith {};


private _previousWaveNum = missionNamespace getVariable ["BLWK_currentWaveNumber",0];
missionNamespace setVariable ["BLWK_currentWaveNumber", _previousWaveNum + 1,true];

// spawn loot
call BLWK_fnc_spawnLoot;



BLWK_friendly_menClasses
BLWK_friendly_vehicleClasses
BLWK_level1_menClasses
BLWK_level1_vehicleClasses
BLWK_level2_menClasses
BLWK_level2_vehicleClasses
BLWK_level3_menClasses
BLWK_level3_vehicleClasses
BLWK_level4_menClasses
BLWK_level4_vehicleClasses
BLWK_level5_menClasses
BLWK_level5_vehicleClasses

if (!isServer) exitWIth {};


// Cipher Comment: Special wave decsion should be added here

null = [/*type of wave via string*/] remoteExec ["BLWK_fnc_handleWaveAI",BLWK_theAIHandler];

// CIPHER COMMENT: might use a Gvar and waitUntil to have things spawned before the server continues