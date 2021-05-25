/* ----------------------------------------------------------------------------
Function: KISKA_fnc_addOpenVdlGuiDiary

Description:
	Creates a diary entry to open the VDL dialog.

Parameters:
	NONE

Returns:
	NOTHING

Examples:
    (begin example)
		Postinit function
    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
if (!hasInterface) exitWith {};

waitUntil {
    if !(isNull player) exitWith {true};
    sleep 0.1;
    false
};

[
    [
        "View Distance Limiter",
        "<execute expression='openMap false; call KISKA_fnc_openVdlDialog;'>OPEN VDL DIALOG</execute>"
    ]
] call BLWK_fnc_addSurvivalDiaryEntry;


nil
