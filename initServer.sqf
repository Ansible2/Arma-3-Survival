call BLWK_fnc_prepareGlobals;

call BLWk_fnc_preparePlayArea;





// variable to prevent players rejoining during a wave
playersInWave = [];
publicVariable "playersInWave";
missionNamespace setVariable ["buildPhase", true, true];

["<t size = '.5'>Loading lists.<br/>Please wait...</t>", 0, 0, 10, 0] remoteExec ["BIS_fnc_dynamicText", 0];
_hLocation = [] execVM "locationLists.sqf";
_hLoot     = [] execVM "loot\lists.sqf";
_hHostiles = [] execVM "hostiles\lists.sqf";
waitUntil {
    scriptDone _hLocation &&
    scriptDone _hLoot &&
    scriptDone _hHostiles
};

_hConfig   = [] spawn BLWK_fnc_prepareGlobals;
waitUntil { scriptDone _hConfig };

["<t size = '.5'>Creating Base...</t>", 0, 0, 30, 0] remoteExec ["BIS_fnc_dynamicText", 0];
_basepoint = [] execVM "bulwark\createBase.sqf";
waitUntil { scriptDone _basepoint };

["<t size = '.5'>Ready</t>", 0, 0, 0.5, 0] remoteExec ["BIS_fnc_dynamicText", 0];

publicVariable "bulwarkBox";

_dayTimeHours = BLWK_timeOfDayMax - BLWK_timeOfDayMin;
_randTime = floor random _dayTimeHours;
_timeToSet = BLWK_timeOfDayMin + _randTime;
setDate [2018, 7, 1, _timeToSet, 0];

//[] execVM "revivePlayers.sqf";
[bulwarkRoomPos] execVM "missionLoop.sqf";


[] execVM "hostiles\clearStuck.sqf";
//[] execVM "hostiles\solidObjects.sqf";
[] execVM "hostiles\moveHosToPlayer.sqf";