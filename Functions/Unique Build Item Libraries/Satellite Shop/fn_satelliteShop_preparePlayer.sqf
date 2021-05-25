/* ----------------------------------------------------------------------------
Function: BLWK_fnc_satelliteShop_preparePlayer

Description:
	Sets up player relevant things such as the action and locking of the inventory
	 on the Satellite Shop. This is its own function to cut down on netowrk messages.

Parameters:
	0: _satelliteObject : <OBJECT> - The satellite shop object

Returns:
	NOTHING

Examples:
    (begin example)
		[anObject] call BLWK_fnc_satelliteShop_preparePlayer;
    (end)

Author(s):
	Ansible2 // Cipher
---------------------------------------------------------------------------- */
scriptName "BLWK_fnc_satelliteShop_preparePlayer";

if (!hasInterface) exitWith {};

params ["_satelliteObject"];

if (isNull _satelliteObject) exitWith {
	["_satelliteObject was null, exiting...",true] call KISKA_fnc_log;
	nil
};

missionNamespace setVariable ["BLWK_satShopOut",true];
_satelliteObject lockInventory true;
[_satelliteObject] call BLWK_fnc_addOpenShopAction;


nil
