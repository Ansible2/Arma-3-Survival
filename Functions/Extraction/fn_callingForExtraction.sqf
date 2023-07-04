/* ----------------------------------------------------------------------------
Function: BLWK_fnc_callForExtraction

Description:
    Sets the extraction queued variable to true and notifies players that an
     extraction is inbound.

Parameters:
	NONE

Returns:
    NOTHING

Examples:
    (begin example)
        call BLWK_fnc_callingForExtraction;
    (end)

Author(s):
	Ansible2
---------------------------------------------------------------------------- */
scriptName "BLWK_fnc_callingForExtraction";

if !(call KISKA_fnc_isAdminOrHost) exitWith {
    ["You must be an admin or a host to initiate the extraction"] call KISKA_fnc_errorNotification;
};

if (missionNamespace getVariable ["BLWK_extractionQueued",false]) exitWith {
    ["An extraction is already queued!"] call KISKA_fnc_errorNotification;
};


private _players = call CBAP_fnc_players;
["Extraction will be inbound once the next wave begins!",4,false] remoteExec ["KISKA_fnc_notification",_players];
missionNamespace setVariable ["BLWK_extractionQueued",true,true];

if (BLWK_extractionHintsEnabled AND !(localNamespace getVariable ["BLWK_showedHints_CallingForExtraction",false])) then {
    localNamespace setVariable ["BLWK_showedHints_callingForExtraction",true];

    ["You will teleported to a different site with the crate",4,false] remoteExec ["KISKA_fnc_notification",_players];
    ["Ensure that you have points to setup a defense",4,false] remoteExec ["KISKA_fnc_notification",_players];
    ["You will NOT be able to respawn if killed",4,false] remoteExec ["KISKA_fnc_notification",_players];
};


nil
