/* ----------------------------------------------------------------------------
Function: BLWK_fnc_handleUnconsciousAiEvent

Description:
	Suspends or restarts the AI pathing and stalking system depending on AI's
     ACE unconscious state.

Parameters:
	NONE

Returns:
	NOTHING

Examples:
    (begin example)
		call BLWK_fnc_handleUnconsciousAiEvent;
    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
scriptName "BLWK_fnc_handleUnconsciousAiEvent";

if !(canSuspend) exitWith {
    ["Must be run in scheduled. Exiting to scheduled"] call KISKA_fnc_log;
    [] spawn BLWK_fnc_handleUnconsciousAiEvent;
    nil
};

waitUntil {!isNil "BLWK_ACELoaded"};
if !(BLWK_ACELoaded) exitWith {
    ["ACE is not loaded. Exiting..."] call KISKA_fnc_log;
    nil
};

waitUntil {!isNil "BLWK_theAIHandlerOwnerID"};
if (clientOwner isNotEqualTo BLWK_theAIHandlerOwnerID) exitWith {
    ["Not AI handler. Exiting..."] call KISKA_fnc_log;
    nil
};

[
    "ace_unconscious",
    {
        params ["_unit","_unconscious"];
        if !(isPlayer _unit) then {
            _unit setVariable ["BLWK_isACEUnconscious",true];
            
            private _group = group _unit;
            if (_unconscious) then {
                _group setVariable ["BLWK_runPathingLoop",false];
                [_group] call BLWK_fnc_stopStalking;

            } else { // if waking up
                [_group] spawn BLWK_fnc_pathing_mainLoop;
                [_group] spawn BLWK_fnc_startStalkingPlayers;
            };

        };
    }
] call CBA_fnc_addEventhandler;


nil
