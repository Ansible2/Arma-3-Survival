/* ----------------------------------------------------------------------------
Function: BLWK_fnc_getMustKillList

Description:
	Returns the reference to the must kill list for the current wave.

Parameters:
	NONE

Returns:
	<OBJECT[]> - an array of all the units that must be killed

Examples:
    (begin example)
		private _listOfUnits = call BLWK_fnc_getMustKillList;
    (end)

Author(s):
	Ansible2
---------------------------------------------------------------------------- */
scriptName "BLWK_fnc_getMustKillList";

if (!isServer) exitWith {[]};

localNamespace getVariable ["BLWK_mustKillList",[]]