/* ----------------------------------------------------------------------------
Function: BLWK_fnc_checkDLC

Description:
	Checks a className to see if it is from any of the excluded DLCs
	
	It is executed from the "".
	
Parameters:
	0: _class : <STRING> - The className of the item to search for
	1: _configToSearch : <STRING> - The config section to search directly after configFile ("cfgWeapons", "cfgVehicles", etc.)

Returns:
	BOOL

Examples:
    (begin example)

		canBeUsed = [myWeapon,"CfgWeapons"] call BLWK_fnc_checkDLC;

    (end)
---------------------------------------------------------------------------- */

// CIPHER COMMENT: I suspect that when getAssetDLCInfo becomes available, it will return and ARRAY of dependent
//// DLCs due to the fact that some APEX guys have launchers from the tank DLC so there can be two dependancies

params ["_class","_configToSearch"];

private _dlcString = (getAssetDLCInfo [_class,configFile >> _configToSearch]) select 5;

if (_dlcString in BLWK_useableDLCs) then {
	true
} else {
	false
};