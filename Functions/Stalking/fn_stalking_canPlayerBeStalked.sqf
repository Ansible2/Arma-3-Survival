/* ----------------------------------------------------------------------------
Function: BLWK_fnc_stalking_canPlayerBeStalked

Description:
	Checks whether or not a player can be stalked.

Parameters:
	0: _player : <OBJECT> - The player unit to check

Returns:
	BOOL

Examples:
    (begin example)
		private _isStalkable = [player] call BLWK_fnc_stalking_canPlayerBeStalked;
    (end)

Author(s):
	Ansible2
---------------------------------------------------------------------------- */
scriptName "BLWK_fnc_stalking_canPlayerBeStalked";

params [
	["_player",objNull,[objNull]]
];


(alive _player) AND 
// not incapacitated
{(incapacitatedState _player) isEqualTo ""} AND 
{_player getVariable ["BLWK_stalking_canBeStalked",true]}
