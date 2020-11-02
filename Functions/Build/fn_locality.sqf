/* ----------------------------------------------------------------------------
Function: BLWK_fnc_locality

Description:
	Checks an objects locality and attempts to change it to the query machine.
	This is used to try and stem the networking issues associated with build objects.

	There is an inline version of this function used at: 
	 Headers\Wait For Transfer Inline.hpp"

Parameters:
	0: _object : <OBJECT> - The object to transfer or check

Returns:
	BOOL

Examples:
    (begin example)
		[myObject] call BLWk_fnc_locality;
    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
if (!hasInterface) exitWith {};

params ["_object"];

if !(local _object) then {
	[_object,clientOwner] remoteExecCall ["setOwner",2];
	hintsilent (parseText "This object is not local to your computer.<br></br>A transfer request has been sent to the server.<br></br>But it may be slow to respond to your actions.");
	
	false
} else {
	true
};