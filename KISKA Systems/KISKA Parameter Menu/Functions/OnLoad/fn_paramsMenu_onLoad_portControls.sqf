#include "..\..\Headers\params menu common defines.hpp"
/* ----------------------------------------------------------------------------
Function: KISKA_fnc_paramsMenu_onLoad_portControls

Description:
    Adds event handlers for the functionality of import/export controls.

Parameters:
	0: _display : <DISPLAY> - The params menu display

Returns:
	NOTHING

Examples:
    (begin example)
        [display] call KISKA_fnc_paramsMenu_onLoad_portControls;
    (end)

Author:
	Ansible2
---------------------------------------------------------------------------- */
scriptName "KISKA_fnc_paramsMenu_onLoad_portControls";

disableSerialization;

params ["_display"];


private _importButton_ctrl = _display displayCtrl PARAMS_MENU_IMPORT_BUTTON_IDC;
_importButton_ctrl ctrlAddEventHandler ["ButtonClick",{

    if (call KISKA_fnc_isAdminOrHost) then {

        private _portEdit_ctrl = (GET_PARAMS_MENU_DISPLAY) displayCtrl PARAMS_MENU_PORT_EDIT_BOX_IDC;
        private _importText = ctrlText _portEdit_ctrl;
        if (_importText isNotEqualTo "") then {
            private _arrayHash = createHashMapFromArray (parseSimpleArray _importText);

            private _config = configNull;
            private "_currentValue";
            private _changedVarsHash = GET_STAGED_CHANGE_PARAMS_HASH;
            {
                // make sure config path is still viable
                _config = (GET_PARAMS_VAR_NAMES_CONFIG_HASH getOrDefault [_x, configNull]);
                if !(isNull _config) then {
                    _currentValue = [_config,false] call KISKA_fnc_paramsMenu_getCurrentParamValue;

                    // text will be yellow for all params regardless of if they are actually changed from current otherwise
                    if (_currentValue isNotEqualTo _y) then {
                        [_config,_y] call KISKA_fnc_paramsMenu_addToChangedParamHash;

                    } else {
                        if (_config in _changedVarsHash) then {
                            _changedVarsHash deleteAt _config;
                        };

                    };

                } else {
                    [["Could not find a param config that matched variable ",_x],true] call KISKA_fnc_log;

                };

            } forEach _arrayHash;

            call KISKA_fnc_paramsMenu_refresh;
        };
    };

}];


private _exportButton_ctrl = _display displayCtrl PARAMS_MENU_EXPORT_BUTTON_IDC;
_exportButton_ctrl ctrlAddEventHandler ["ButtonClick",{

    private _savedMissionParamsHash = call KISKA_fnc_paramsMenu_hashParams;
    private _stringExport = str _savedMissionParamsHash;

    private _portEdit_ctrl = (GET_PARAMS_MENU_DISPLAY) displayCtrl PARAMS_MENU_PORT_EDIT_BOX_IDC;
    _portEdit_ctrl ctrlSetText _stringExport;

    copyToClipboard _stringExport;

}];


nil
