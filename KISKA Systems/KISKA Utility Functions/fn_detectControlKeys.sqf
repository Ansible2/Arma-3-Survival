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


if (["ace_interact_menu"] call KISKA_fnc_isPatchLoaded) then {
    [
        "ace_interactMenuClosed",
        {
            params ["_menuType"];

            //diag_log "(ACE EVENT) ACE interact menu is closed";

            // making sure _menuType is the seld interact menu
            if (missionNamespace getVariable ["KISKA_ctrlDown",false] AND {_menuType isEqualTo 1}) then {
                //hint "(ACE EVENT) KISKA_ctrlDown is true, setting to false";
                //diag_log "(ACE EVENT) KISKA_ctrlDown is true, setting to false";

                missionNamespace setVariable ["KISKA_ctrlDown",false];
            };
        }
    ] call CBA_fnc_addeventhandler;
};


waitUntil {
    if !(isNull (findDisplay 46)) exitWith {true};
    ["Looping for Display",false] call KISKA_fnc_log;
    sleep 0.1;
    false
};

["Found display, loop ended",false] call KISKA_fnc_log;


(findDisplay 46) displayAddEventHandler ["KeyDown",{
    private _key = _this select 1;
    private _ctrl = _this select 3;

    // if a key other then a ctrl is pressed without ctrl down
    if (!_ctrl AND {_key isNotEqualTo LEFT_CTRL_CODE} AND {_key isNotEqualTo RIGHT_CTRL_CODE}) then {

        // then if KISKA_ctrlDown is true, set it to false
        if (missionNamespace getVariable ["KISKA_ctrlDown",true]) then {
            missionNamespace setVariable ["KISKA_ctrlDown",false];
        };

    } else { // if ctrl is pressed

        // then if KISKA_ctrlDown is false, set it to true
        if !(missionNamespace getVariable ["KISKA_ctrlDown",false]) then {
            missionNamespace setVariable ["KISKA_ctrlDown",true];
        };
    };


    nil
}];

(findDisplay 46) displayAddEventHandler ["KeyUp",{
    private _key = _this select 1;
    private _ctrl = _this select 3;

    // if a key other then a ctrl is released without ctrl down OR the released key is a ctrl key
    if (!_ctrl OR {_key isEqualTo LEFT_CTRL_CODE} OR {_key isEqualTo RIGHT_CTRL_CODE}) then {

        // then if KISKA_ctrlDown is true, set it to false
        if (missionNamespace getVariable ["KISKA_ctrlDown",true]) then {
            missionNamespace setVariable ["KISKA_ctrlDown",false];
        };
    } else { // if ctrl is still down or the released key is not a ctrl key

        // then if KISKA_ctrlDown is false, set it to true
        if !(missionNamespace getVariable ["KISKA_ctrlDown",false]) then {
            missionNamespace setVariable ["KISKA_ctrlDown",true];
        };
    };


    nil
}];








// debug code
/*
(findDisplay 46) displayAddEventHandler ["KeyDown",{
    //params ["", "_key", "", "_ctrl", ""];
    private _key = _this select 1;
    private _ctrl = _this select 3;

    hint "key down";
    diag_log "------------------------------------------";
    diag_log "Key down";

    // if a key other then a ctrl is pressed without ctrl down
    if (!_ctrl AND {_key isNotEqualTo LEFT_CTRL_CODE} AND {_key isNotEqualTo RIGHT_CTRL_CODE}) then {
        hint "_ctrl is false (key-down)";
        diag_log "_ctrl is false (key-down)";

        // then if KISKA_ctrlDown is true, set it to false
        if (missionNamespace getVariable ["KISKA_ctrlDown",true]) then {
            hint "KISKA_ctrlDown is true (key-down), setting it to false";
            diag_log "KISKA_ctrlDown is true (key-down), setting it to false";

            missionNamespace setVariable ["KISKA_ctrlDown",false];
        } else {
            hint "KISKA_ctrlDown is false (key-down) and it will remain so";
            diag_log "KISKA_ctrlDown is false (key-down) and it will remain so";
        };
    } else { // if ctrl is pressed
        hint "_ctrl is true (key-down)";
        diag_log "_ctrl is true (key-down)";

        // then if KISKA_ctrlDown is false, set it to true
        if !(missionNamespace getVariable ["KISKA_ctrlDown",false]) then {
            hint "KISKA_ctrlDown is false (key-down), setting it to true";
            diag_log "KISKA_ctrlDown is false (key-down), setting it to true";

            missionNamespace setVariable ["KISKA_ctrlDown",true];
        } else {
            hint "KISKA_ctrlDown is true (key-down) and it will remain so";
            diag_log "KISKA_ctrlDown is true (key-down) and it will remain so";
        };
    };


    nil
}];

(findDisplay 46) displayAddEventHandler ["KeyUp",{
    //params ["", "_key", "", "_ctrl", ""];
    private _key = _this select 1;
    private _ctrl = _this select 3;

    hint "key up";
    diag_log "------------------------------------------";
    diag_log "Key up";

    // if a key other then a ctrl is released without ctrl down OR the released key is a ctrl key
    if (!_ctrl OR {_key isEqualTo LEFT_CTRL_CODE} OR {_key isEqualTo RIGHT_CTRL_CODE}) then {
        hint "_ctrl is false (key-up)";
        diag_log "_ctrl is false (key-up)";

        // then if KISKA_ctrlDown is true, set it to false
        if (missionNamespace getVariable ["KISKA_ctrlDown",true]) then {
            hint "KISKA_ctrlDown is true (key-up), setting it to false";
            diag_log "KISKA_ctrlDown is true (key-up), setting it to false";

            missionNamespace setVariable ["KISKA_ctrlDown",false];
        } else {
            hint "KISKA_ctrlDown is false (key-up) and it will remain so";
            diag_log "KISKA_ctrlDown is false (key-up) and it will remain so";
        };
    } else { // if ctrl is still down or the released key is not a ctrl key
        hint "_ctrl is true (key-up)";
        diag_log "_ctrl is true (key-up)";

        // then if KISKA_ctrlDown is false, set it to true
        if !(missionNamespace getVariable ["KISKA_ctrlDown",false]) then {
            hint "KISKA_ctrlDown is false (key-up), setting it to true";
            diag_log "KISKA_ctrlDown is false (key-up), setting it to true";

            missionNamespace setVariable ["KISKA_ctrlDown",true];
        } else {
            hint "KISKA_ctrlDown is true (key-up) and it will remain so";
            diag_log "KISKA_ctrlDown is true (key-up) and it will remain so";
        };
    };


    nil
}];
*/
