/* ----------------------------------------------------------------------------
Function: BLWK_fnc_reassignCurator

Description:
	This function simply sends a message to the server to execute the function.

	It is executed from a briefing record in game that was added in the "BLWK_fnc_addDiaryEntries".
	And from the "onPlayerRespawn.sqf"

Parameters:
	0: _isManual : <BOOL> - Was this called from the diary entry (keeps hints from showing otherwise)
	1: _curatorObject : <OBJECT or STRING> - The curator object to reassign

Returns:
	NOTHING

Examples:
    (begin example)
		// show hint messages
		[true] call BLWK_fnc_reassignCurator;

    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
scriptName "BLWK_fnc_reassignCurator";

params [
	["_isManual",false,[true]],
	["_curatorObject","BLWK_zeus",[objNull,""]]
];


if !(call KISKA_fnc_isAdminOrHost) exitWith {
	if (_isManual) then {
		["Only admins can be assigned curator"] call KISKA_fnc_errorNotification;
	};
};

if (_curatorObject isEqualType "") then {
	_curatorObject = missionNamespace getVariable [_curatorObject,objNull];
};

if (isNull _curatorObject) exitWith {
	["_curatorObject isNull!",true] call KISKA_fnc_log;
};

private _unitWithCurator = getAssignedCuratorUnit _curatorObject;
if (isNull _unitWithCurator) then {
	[player,_curatorObject] remoteExecCall ["assignCurator",2];
} else {
	if (alive _unitWithCurator) then {
		// no sense in alerting player if they are the curator still
		if (!(_unitWithCurator isEqualTo player)) then {
			["Another currently alive admin has the curator assigned to them already"] call KISKA_fnc_errorNotification;

		} else {
			["You are already the curator"] call KISKA_fnc_errorNotification;

		};

	} else {
		[_unitWithCurator,_isManual,_curatorObject] spawn {
			params ["_unitWithCurator","_isManual","_curatorObject"];
			[_curatorObject] remoteExec ["unAssignCurator",2];

			// wait till curator doesn't have a unit to give it the player
			waitUntil {
				if !(isNull (getAssignedCuratorUnit _curatorObject)) exitWith {
					[player,_curatorObject] remoteExecCall ["assignCurator",2];
					if (_isManual) then {
						["You are now the curator"] call KISKA_fnc_notification;
					};
					true
				};

				[_curatorObject] remoteExec ["unAssignCurator",2];

				sleep 2;
				false
			};
		};
	};
};
