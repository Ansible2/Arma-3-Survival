/* ----------------------------------------------------------------------------
Function: BLWK_fnc_reassignCurator

Description:
	This function simply sends a message to the server to execute the function.
	
	It is executed from a briefing record in game that was added in the "BLWK_fnc_addDiaryEntries".
	And from the "onPlayerRespawn.sqf"

Parameters:
	0: _isManual : <BOOL> - Was this called from the diary entry (keeps hints from showing otherwise)

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
params [
	["_isManual",false,[true]]
];


// check if player is host or admin
if (!(call BIS_fnc_admin > 0) AND {clientOwner != 2}) exitWith {
	if (_isManual) then {
		hint "Only admins can be assigned curator";
	};
};
private _unitWithCurator = getAssignedCuratorUnit BLWK_zeus;
if (isNull _unitWithCurator) then {
	null = [player,BLWK_zeus] remoteExecCall ["assignCurator",2];
} else {
	if (alive _unitWithCurator) then {
		// no sense in alerting player if they are the curator still
		if (!(_unitWithCurator isEqualTo player)) then {
			hint "Another currently alive admin has the curator assigned to them already";
		} else {
			hint "You are already the curator";
		};
	} else {
		null = [_unitWithCurator,_isManual] spawn {
			params ["_unitWithCurator","_isManual"];
			null = [BLWK_zeus] remoteExec ["unAssignCurator",2];
			
			// wait till curator doesn't have a unit to give it the player
			waitUntil {
				if !(isNull (getAssignedCuratorUnit BLWK_zeus)) exitWith {
					null = [player,BLWK_zeus] remoteExecCall ["assignCurator",2];
					if (_isManual) then {
						hint "You are now the curator";
					};
					true
				};
				
				null = [BLWK_zeus] remoteExec ["unAssignCurator",2];
				
				sleep 2;
				false
			};
		};
	};
};