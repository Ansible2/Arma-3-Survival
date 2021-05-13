/* ----------------------------------------------------------------------------
Function: KISKA_fnc_detectControlKeys

Description:
    Arma 3's support system currently has a bug that allows players to call in
     multiple supports by having the map open and holding down a ctrl key and left
     - clicking while in the support menu. Each click will call in a support.

Parameters:
	NONE

Returns:
	NOTHING

Examples:
    (begin example)
		PRE-INIT Function
    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
scriptName "KISKA_fnc_detectControlKeys";

#define LEFT_CTRL_CODE 29
#define RIGHT_CTRL_CODE 157

if (!hasInterface) exitWith {};

if (!canSuspend) exitWith {
    ["Needs to be run in scheduled, exiting to scheduled...",false] call KISKA_fnc_log;
    [] spawn KISKA_fnc_detectControlKeys;
};

waitUntil {
    if !(isNull (findDisplay 46)) exitWith {true};
    ["Looping for Display",false] call KISKA_fnc_log;
    sleep 0.1;
    false
};

["Found display, loop ended",false] call KISKA_fnc_log;

(findDisplay 46) displayAddEventHandler ["KeyDown",{
    params ["", "_key", "", "", ""];

    if (
        (_key isEqualTo LEFT_CTRL_CODE OR {_key isEqualTo RIGHT_CTRL_CODE})
        AND {!(missionNamespace getVariable ["KISKA_ctrlDown",false])}
    ) then {
        //hint "control down";
        missionNamespace setVariable ["KISKA_ctrlDown",true];
    };
}];

(findDisplay 46) displayAddEventHandler ["KeyUp",{
    params ["", "_key", "", "", ""];

    if (
        (_key isEqualTo LEFT_CTRL_CODE OR {_key isEqualTo RIGHT_CTRL_CODE})
        AND {missionNamespace getVariable ["KISKA_ctrlDown",false]}
    ) then {
        //hint "control up";
        missionNamespace setVariable ["KISKA_ctrlDown",false];
    };
}];
