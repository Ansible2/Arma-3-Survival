params ["_unit","_queName","_group"]

// CIPHER COMMENT: need to adjust skill depending on wave number

_unit setVariable ["BLWK_cameFromQue",_queName];

_group allowFleeing 0;
[_group, bulwarkBox, 20, "SAD", "AWARE", "RED"] call CBAP_fnc_addWaypoint;

[BLWK_zeus, [[_unit],false]] remoteExec ["addCuratorEditableObjects",2];


// keep items (maps, nvgs, binoculars, etc.) so that they can just be loot drops
removeAllAssignedItems _unit;


// hit and killed events
[_unit] call BLWK_fnc_addStdEnemyManEHs;

// for pistol only waves and randomized weapons
[_unit] call BLWK_fnc_handleEnemyWeapons;