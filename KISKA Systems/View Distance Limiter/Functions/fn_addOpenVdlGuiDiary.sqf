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
waitUntil {!isNull player};

player createDiarySubject ["VDL_entry","View Distance Limiter",""];

player createDiaryRecord ["VDL_entry", ["View Distance Limiter", 
	"<execute expression='openMap false; call KISKA_fnc_openVdlDialog;'>OPEN VDL DIALOG</execute>"
]];