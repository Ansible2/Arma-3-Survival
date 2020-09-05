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
_hConfig   = [] execVM "editMe.sqf";
waitUntil { scriptDone _hConfig };

["<t size = '.5'>Creating Base...</t>", 0, 0, 30, 0] remoteExec ["BIS_fnc_dynamicText", 0];
_basepoint = [] execVM "bulwark\createBase.sqf";
waitUntil { scriptDone _basepoint };

["<t size = '.5'>Ready</t>", 0, 0, 0.5, 0] remoteExec ["BIS_fnc_dynamicText", 0];

publicVariable "bulwarkBox";
publicVariable "BLWK_paratroopClasses";
publicVariable "BLWK_supports_array";
publicVariable "BLWK_buildableObjects_array";
publicVariable "BLWK_startWithPistol";
publicVariable "BLWK_startWithMap";
publicVariable "BLWK_startWithNVGs";
publicVariable "BLWK_maxPistolOnlyWaves";
publicVariable "BLWK_timeBetweenRounds";
publicVariable "BLWK_numRespawnTickets";
publicVariable "BLWK_respawnTime";
publicVariable "PLAYER_OBJECT_LIST";
publicVariable "MIND_CONTROLLED_AI";
publicVariable "BLWK_costToSpinRandomBox";

//determine if Support Menu is available
_supportParam = ("SUPPORT_MENU" call BIS_fnc_getParamValue);
if (_supportParam == 1) then {
  SUPPORTMENU = false;
}else{
  SUPPORTMENU = true;
};
publicVariable 'SUPPORTMENU';

//Determine team damage Settings
_teamDamageParam = ("TEAM_DAMAGE" call BIS_fnc_getParamValue);
if (_teamDamageParam == 0) then {
  TEAM_DAMAGE = false;
}else{
  TEAM_DAMAGE = true;
};
publicVariable 'TEAM_DAMAGE';

//determine if hitmarkers appear on HUD
HITMARKERPARAM = ("HUD_POINT_HITMARKERS" call BIS_fnc_getParamValue);
publicVariable 'HITMARKERPARAM';

_dayTimeHours = BLWK_timeOfDayMax - BLWK_timeOfDayMin;
_randTime = floor random _dayTimeHours;
_timeToSet = BLWK_timeOfDayMin + _randTime;
setDate [2018, 7, 1, _timeToSet, 0];

//[] execVM "revivePlayers.sqf";
[bulwarkRoomPos] execVM "missionLoop.sqf";

[] execVM "area\areaEnforcement.sqf";
[] execVM "hostiles\clearStuck.sqf";
//[] execVM "hostiles\solidObjects.sqf";
[] execVM "hostiles\moveHosToPlayer.sqf";
