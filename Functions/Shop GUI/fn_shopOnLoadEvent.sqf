/* ----------------------------------------------------------------------------
Function: BLWK_fnc_shopOnLoadEvent

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

		[myDisplay] call BLWK_fnc_shopOnLoadEvent;

    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
params ["_display"];

null = [_display] spawn BLWK_fnc_shopAdjustPointsLoop;
null = [_display] spawn BLWK_fnc_shopAdjustCommunityPoolLoop;