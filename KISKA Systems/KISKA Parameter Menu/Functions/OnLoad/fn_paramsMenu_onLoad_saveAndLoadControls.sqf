#include "..\..\Headers\params menu common defines.hpp"
/* ----------------------------------------------------------------------------
Function: KISKA_fnc_paramsMenu_onLoad_saveAndLoadControls

Description:
	Adds the event handlers for save and load controls on the params menu.

Parameters:
	0: _paramsMenuDisplay : <DISPLAY> - The display of the param menu

Returns:
	NOTHING

Examples:
    (begin example)
		[display] call KISKA_fnc_paramsMenu_onLoad_saveAndLoadControls;
    (end)

Author:
	Ansible2
---------------------------------------------------------------------------- */
scriptName "KISKA_fnc_paramsMenu_onLoad_saveAndLoadControls";

disableSerialization;

params ["_paramsMenuDisplay"];


private _loadCombo_ctrl = _paramsMenuDisplay displayCtrl PARAMS_MENU_LOAD_COMBO_IDC;
_paramsMenuDisplay setVariable ["KISKA_paramsMenu_loadCombo_ctrl",_loadCombo_ctrl];

[_loadCombo_ctrl] spawn KISKA_fnc_paramsMenu_updateLoadCombo;


private _saveButton_ctrl = _paramsMenuDisplay displayCtrl PARAMS_MENU_SAVE_BUTTON_IDC;
_saveButton_ctrl ctrlAddEventHandler ["ButtonClick",{

    private _paramsMenuDisplay = GET_PARAMS_MENU_DISPLAY;
    private _loadCombo_ctrl = _paramsMenuDisplay getVariable ["KISKA_paramsMenu_loadCombo_ctrl",controlNull];
    private _profileName = _loadCombo_ctrl lbText (lbCurSel _loadCombo_ctrl);

    if (_profileName isNotEqualTo "") then {
        private _savedProfilesHash = GET_PARAMS_SAVED_PROFILES_HASHMAP;
        private _savedMissionParamsHash = call KISKA_fnc_paramsMenu_hashParams;

        _savedProfilesHash set [_profileName,_savedMissionParamsHash];
        saveProfileNamespace;
        ["Saved profile: " + _profileName] call KISKA_fnc_paramsMenu_logMessage;
    } else {
        ["No valid profile was selected!"] call KISKA_fnc_paramsMenu_logMessage;

    };

}];


private _saveAsButton_ctrl = _paramsMenuDisplay displayCtrl PARAMS_MENU_SAVEAS_BUTTON_IDC;
_saveAsButton_ctrl ctrlAddEventHandler ["ButtonClick",{

    private _paramsMenuDisplay = localNamespace getVariable [PARAMS_MENU_DISPLAY_VAR_STR,displayNull];
    private _profileName = ctrlText (_paramsMenuDisplay displayCtrl PARAMS_MENU_SAVEAS_EDIT_BOX_IDC);

    if (_profileName isNotEqualTo "") then {
        private _savedProfilesHash = GET_PARAMS_SAVED_PROFILES_HASHMAP;
        private _savedMissionParamsHash = call KISKA_fnc_paramsMenu_hashParams;

        _savedProfilesHash set [_profileName,_savedMissionParamsHash];
        profilenamespace setVariable [GET_PARAMS_PROFILE_VAR_STR,_savedProfilesHash];
        saveProfileNamespace;

        [_paramsMenuDisplay displayCtrl PARAMS_MENU_LOAD_COMBO_IDC] spawn KISKA_fnc_paramsMenu_updateLoadCombo;
        ["Saved profile: " + _profileName] call KISKA_fnc_paramsMenu_logMessage;
    } else {
        ["You must enter a profile name"] call KISKA_fnc_paramsMenu_logMessage;

    };
}];



private _loadButton_ctrl = _paramsMenuDisplay displayCtrl PARAMS_MENU_LOAD_BUTTON_IDC;
_loadButton_ctrl ctrlAddEventHandler ["ButtonClick",{

    private _paramsMenuDisplay = GET_PARAMS_MENU_DISPLAY;
    private _loadCombo_ctrl = _paramsMenuDisplay getVariable ["KISKA_paramsMenu_loadCombo_ctrl",controlNull];
    private _profileName = _loadCombo_ctrl lbText (lbCurSel _loadCombo_ctrl);

    if (_profileName isNotEqualTo "") then {
        private _savedProfilesHash = GET_PARAMS_SAVED_PROFILES_HASHMAP;
        private _savedMissionParamsHash = call KISKA_fnc_paramsMenu_hashParams;

        private _profileSettingsHash = _savedProfilesHash get _profileName;

        // clear current staged changes so that anything that was changed before the load does not still show up as altered (yellow) by remaining in the hash
        localNamespace setVariable [STAGED_CHANGE_VAR_HASH_VAR_STR,nil];

        private _config = configNull;
        private "_currentValue";
        {
            // make sure config path is still viable
            _config = (GET_PARAMS_VAR_NAMES_CONFIG_HASH getOrDefault [_x, configNull]);
            if !(isNull _config) then {
                _currentValue = [_config] call KISKA_fnc_paramsMenu_getCurrentParamValue;

                // text will be yellow for all params regardless of if they are actually changed from current otherwise
                if (_currentValue isNotEqualTo _y) then {
                    [_config,_y] call KISKA_fnc_paramsMenu_addToChangedParamHash;
                };

            } else {
                private _message = ["Could not find a param config that matched variable ",_x] joinString "";
                [_message] call KISKA_fnc_paramsMenu_logMessage;
                [[_message,_x],true] call KISKA_fnc_log;

            };

        } forEach _profileSettingsHash;


        call KISKA_fnc_paramsMenu_refresh;
        ["Finished Load of: " + _profileName + "!"] call KISKA_fnc_paramsMenu_logMessage;
    } else {
        ["No Valid Profile Selected!"] call KISKA_fnc_paramsMenu_logMessage;

    };
}];


private _deleteButton_ctrl = _paramsMenuDisplay displayCtrl PARAMS_MENU_DELETE_BUTTON_IDC;
_deleteButton_ctrl ctrlAddEventHandler ["ButtonClick",{
    private _paramsMenuDisplay = localNamespace getVariable [PARAMS_MENU_DISPLAY_VAR_STR,displayNull];
    private _loadCombo_ctrl = _paramsMenuDisplay getVariable ["KISKA_paramsMenu_loadCombo_ctrl",controlNull];
    private _selectedIndex = lbCurSel _loadCombo_ctrl;
    private _profileName = _loadCombo_ctrl lbText _selectedIndex;

    if (_profileName isNotEqualTo "") then {
        private _savedProfilesHash = GET_PARAMS_SAVED_PROFILES_HASHMAP;
        _savedProfilesHash deleteAt _profileName;
        saveProfileNamespace;

        [_loadCombo_ctrl] spawn KISKA_fnc_paramsMenu_updateLoadCombo;
        ["Saved profile: " + _profileName] call KISKA_fnc_paramsMenu_logMessage;
    } else {
        ["No valid profile selected for deletetion..."] call KISKA_fnc_paramsMenu_logMessage;
    };
}];


nil
