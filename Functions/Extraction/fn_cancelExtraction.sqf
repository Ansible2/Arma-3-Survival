/* ----------------------------------------------------------------------------
Function: BLWK_fnc_cancelExtraction

Description:
    Sets the extraction queued public var to false if permitted.

Parameters:
	NONE

Returns:
    NOTHING

Examples:
    (begin example)
        call BLWK_fnc_cancelExtraction;
    (end)

Author(s):
	Ansible2
---------------------------------------------------------------------------- */
scriptName "BLWK_fnc_cancelExtraction";


if !(call KISKA_fnc_isAdminOrHost) exitWith {
    ["You must be an admin or a host to initiate the extraction"] call KISKA_fnc_errorNotification;
};

if !(missionNamespace getVariable ["BLWK_extractionQueued",false]) exitWith {
    ["There is no extraction queued at the moment"] call KISKA_fnc_errorNotification;
};

if (BLWK_currentWaveNumber isEqualTo BLWK_maxNumWaves) exitWith {
    ["You must increase the max wave in order to cancel this extraction"] call KISKA_fnc_errorNotification;
};

if (BLWK_currentWaveNumber > BLWK_maxNumWaves) exitWith {
    ["Extraction can't be canceled once in progress"] call KISKA_fnc_errorNotification;
};


["Extraction has been cancelled"] remoteExec ["KISKA_fnc_notification", call CBAP_fnc_players];
missionNamespace setVariable ["BLWK_extractionQueued",false,true];
