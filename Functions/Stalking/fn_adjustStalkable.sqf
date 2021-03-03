#include "..\..\Headers\Stalker Global Strings.hpp"
/* ----------------------------------------------------------------------------
Function: BLWK_fnc_adjustStalkable

Description:
	Changes whether or not a unit/player is stalkable by the AI.
	 
Parameters:
	0: _unit : <OBJECT> - The unit to adjust the state
	1: _state : <BOOL> - State to set, true means stalkable, false means not

Returns:
	NOTHING

Examples:
    (begin example)

		[myUnit,false] call BLWK_fnc_adjustStalkable;

    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
params [
	"_unit",
	["_state",false,[true]]
];

_unit setVariable [IS_UNIT_AVAILABLE_VAR,_state,BLWK_theAIHandlerOwnerID];