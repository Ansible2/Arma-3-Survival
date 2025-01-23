#include "..\Headers\View Distance Limiter Common Defines.hpp"
/* ----------------------------------------------------------------------------
Function: KISKA_fnc_VDL_onLoad

Description:
    Acts as the onload event for the KISKA View Distance Limiter Dialog

Parameters:
    0: _display <DISPLAY> - The display of the dialog

Returns:
    NOTHING

Examples:
    (begin example)
        [display] call KISKA_fnc_VDL_onLoad;
    (end)

Author(s):
    Ansible2
---------------------------------------------------------------------------- */
scriptName "KISKA_fnc_VDL_onLoad";

if (!hasInterface) exitWith {};

disableSerialization;

params ["_display"];


/* ----------------------------------------------------------------------------
    unload event
---------------------------------------------------------------------------- */
localNamespace setVariable ["KISKA_VDL_display",_display];
_display displayAddEventHandler ["Unload", {
    //params ["_display"];
    localNamespace setVariable ["KISKA_VDL_display",nil];
}];


/* ----------------------------------------------------------------------------
    System On Check box
---------------------------------------------------------------------------- */
private _systemOnCheckox = _display displayCtrl VDL_SYSTEM_ON_CHECKBOX_IDC;
if (localNamespace getVariable ["KISKA_VDL_isRunning",false]) then {
    _systemOnCheckox cbSetChecked true;
};

_systemOnCheckox ctrlAddEventHandler ["CheckedChanged",{
    params ["_control", "_checked"];
    _checked = [false,true] select _checked;

    localNamespace setVariable ["KISKA_VDL_run",_checked];
    private _vdlIsRunning = localNamespace getVariable ["KISKA_VDL_isRunning",false];
    if (_checked AND !_vdlIsRunning) then {
        #define GET_SLIDER_POS_FOR_CTRLGRP(idc) sliderPosition (((ctrlParent _control) displayCtrl idc) controlsGroupCtrl VDL_SLIDER_IDC)
        [
            GET_SLIDER_POS_FOR_CTRLGRP( VDL_TARGET_FPS_CTRL_GRP_IDC ),
            GET_SLIDER_POS_FOR_CTRLGRP( VDL_CHECK_FREQ_CTRL_GRP_IDC ),
            GET_SLIDER_POS_FOR_CTRLGRP( VDL_MIN_OBJECT_DIST_CTRL_GRP_IDC ),
            GET_SLIDER_POS_FOR_CTRLGRP( VDL_MAX_OBJECT_DIST_CTRL_GRP_IDC ),
            GET_SLIDER_POS_FOR_CTRLGRP( VDL_INCRIMENT_CTRL_GRP_IDC ),
            GET_SLIDER_POS_FOR_CTRLGRP( VDL_TERRAIN_DIST_CTRL_GRP_IDC )
        ] spawn KISKA_fnc_viewDistanceLimiter;
    };

}];


/* ----------------------------------------------------------------------------
    Tie View Distance Check box
---------------------------------------------------------------------------- */
private _tieViewDist_checkBox = _display displayCtrl VDL_TIED_DISTANCE_CHECKBOX_IDC;
if (localNamespace getVariable ["KISKA_VDL_tiedViewDistance",false]) then {
    _tieViewDist_checkBox cbSetChecked true;
};

_tieViewDist_checkBox ctrlAddEventHandler ["CheckedChanged",{
    params ["", "_checked"];
    _checked = [false,true] select _checked;
    localNamespace setVariable ["KISKA_VDL_tiedViewDistance",_checked];
}];


/* ----------------------------------------------------------------------------
    Close button
---------------------------------------------------------------------------- */
(_display displayCtrl VDL_CLOSE_BUTTON_IDC) ctrlAddEventHandler ["ButtonClick",{
    (localNamespace getVariable ["KISKA_VDL_display",displayNull]) closeDisplay 2;
}];


/* ----------------------------------------------------------------------------
    Set all button
---------------------------------------------------------------------------- */
(_display displayCtrl VDL_SET_ALL_BUTTON_IDC) ctrlAddEventHandler ["ButtonClick",{
    params ["_setButton_ctrl"];

    private _display = localNamespace getVariable ["KISKA_VDL_display",displayNull];
    (_display getVariable "KISKA_VDL_controlGroups") apply {
        private _slider_ctrl = _x getVariable [CTRL_GRP_SLIDER_CTRL_VAR_STR,controlNull];

        private _varName = _x getVariable [CTRL_GRP_VAR_STR,""];
        private _value = sliderPosition _slider_ctrl;
        profileNamespace setVariable [_varName,_value];
        localNamespace setVariable [_varName,_value];
    };

    saveProfileNamespace;
    ["Saved All changes"] call KISKA_fnc_notification;
}];


/* ----------------------------------------------------------------------------
    Control groups
---------------------------------------------------------------------------- */
private _controlGroups = [];
[
    [VDL_TARGET_FPS_CTRL_GRP_IDC, "KISKA_VDL_fps"],
    [VDL_MIN_OBJECT_DIST_CTRL_GRP_IDC, "KISKA_VDL_minDist"],
    [VDL_MAX_OBJECT_DIST_CTRL_GRP_IDC, "KISKA_VDL_maxDist"],
    [VDL_TERRAIN_DIST_CTRL_GRP_IDC, "KISKA_VDL_viewDist"],
    [VDL_CHECK_FREQ_CTRL_GRP_IDC, "KISKA_VDL_freq"],
    [VDL_INCRIMENT_CTRL_GRP_IDC, "KISKA_VDL_increment"]
] apply {
    private _controlIdc = _x select 0;
    private _control = _display displayCtrl _controlIdc;
    private _settingVariableName = _x select 1;
    [_control,_settingVariableName] call KISKA_fnc_VDL_controlsGroup_onLoad;
    _controlGroups pushBack _control;
};

_display setVariable ["KISKA_VDL_controlGroups",_controlGroups];


nil
