/* ----------------------------------------------------------------------------
Function: KISKA_fnc_isMainMenu

Description:
    Checks if loaded mission is main menu.

Parameters:
	NONE

Returns:
	<BOOL>

Examples:
    (begin example)
		isMainMenu = call KISKA_fnc_isMainMenu;
    (end)

Author(s):
	Leopard20
---------------------------------------------------------------------------- */
scriptName "KISKA_fnc_isMainMenu";

allDisplays isEqualTo [findDisplay 0]
