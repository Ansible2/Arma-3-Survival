/* ----------------------------------------------------------------------------
Function: BLWK_fnc_shop_onLoadEvent

Description:
	Activates for the shop's load event.

	Primarily starts the loops that keep the community pool and 
	 points pools in sync between players while the GUI is open.

Parameters:
	0: _display : <DISPLAY> - The display to load onto

Returns:
	NOTHING

Examples:
    (begin example)

		[myDisplay] call BLWK_fnc_shop_onLoadEvent;

    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
disableSerialization;

params ["_display"];

[_display] spawn BLWK_fnc_shop_adjustPointsLoop;
[_display] spawn BLWK_fnc_shop_adjustCommunityPoolLoop;