/* ----------------------------------------------------------------------------
Function: CBAP_fnc_getItemConfig

Description:
    A function used to return the config of an item.

    Modifications: made to return a string denoting what the type was and added vehicles and ammo

Parameters:
    _item - Any kind of item, weapon or magazine class name <STRING>

Returns:
    <ARRAY>
        _config - Item config. <CONFIG>
        - a string denoting what the type is <STRING>

Example:
    (begin example)
        _config = currentWeapon player call CBAP_fnc_getItemConfig;
        (currentMagazine cameraOn) call CBAP_fnc_getItemConfig;
        (goggles player) call CBAP_fnc_getItemConfig;
    (end)

Author:
    commy2
    Modified By: Anbsible2 // Cipher
---------------------------------------------------------------------------- */
params [["_item", "", [""]]];

private _result = [];

{
    private _config = configFile >> _x >> _item;

    if (isClass _config) exitWith {
        _result = [_config,_x];

        // if it was marked as in cfgVehicles
        if  (_forEachIndex isEqualTo 2) then {

            // check if item and/or backpack
            if ([_config,configFile >> "CfgVehicles" >> "item_Base_f"] call CBAP_fnc_inheritsFrom) then {
                _result = [_config,"isItem"];
            };
            if (getNumber (_config >> "isBackpack") isEqualTo 1) then {
                _result = [_config,"isBackpack"];
            };
        };
    };
} forEach ["CfgWeapons", "CfgMagazines", "CfgVehicles", "CfgAmmo"];

_result