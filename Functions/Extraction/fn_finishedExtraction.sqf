/* ----------------------------------------------------------------------------
Function: BLWK_fnc_finishedExtraction

Description:
    Counts down a random amount of time before displaying mission complete
     after an extract.

Parameters:
	NONE

Returns:
    NOTHING

Examples:
    (begin example)
        [] spawn BLWK_fnc_finishedExtraction;
    (end)

Author(s):
	Ansible2
---------------------------------------------------------------------------- */
scriptName "BLWK_fnc_finishedExtraction";

if (localNamespace getVariable ["BLWK_extractionDone",false]) exitWith {};

sleep (random [20,25,30]);

"end2" call BIS_fnc_endMissionServer;
