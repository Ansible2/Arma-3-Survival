/* ----------------------------------------------------------------------------
Function: KISKA_fnc_addOpenVdlGuiAction

Description:
	Creates a diary entry to open the VDL dialog

	Executed from an action added in "BLWK_fnc_prepareBulwarkPlayer"

Parameters:
	NONE

Returns:
	NOTHING

Examples:
    (begin example)

		Postinit function

    (end)

Author:
	Hilltop & omNomios,
	Modified by: Ansible2 // Cipher
---------------------------------------------------------------------------- */
waitUntil {!isNull player};

player createDiarySubject ["VDL_entry","View Distance Limiter",""];

player createDiaryRecord ["VDL_entry", ["View Distance Limiter", 
	"<execute expression='openMap false; call KISKA_fnc_openVdlDialog;'>OPEN VDL DIALOG</execute>"
]];