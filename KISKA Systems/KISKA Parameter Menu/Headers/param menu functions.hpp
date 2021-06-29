class ParamsMenu_ControlTypes
{
    file = "KISKA Systems\KISKA Parameter Menu\functions\ControlTypes";
    class paramsMenu_createCtrl_binary
    {};
    class paramsMenu_createCtrl_list
    {};
    class paramsMenu_createCtrl_edit
    {};
    class paramsMenu_createCtrl_slider
    {};
    class paramsMenu_updateSelection_comboBox
    {};
    class paramsMenu_updateSelection_listbox
    {};
};

class ParamsMenu_OnLoad
{
    file = "KISKA Systems\KISKA Parameter Menu\functions\OnLoad";
    class paramsMenu_onLoad_categoryCombo
    {};
    class paramsMenu_onLoad_saveAndLoadControls
    {};
    class paramsMenu_onLoad_portControls
    {};
};

class ParamsMenu_misc
{
    file = "KISKA Systems\KISKA Parameter Menu\functions\misc";
    class paramsMenu_cacheConfig
    {};
    class paramsMenu_commitChanges
    {};
    class paramsMenu_deserializeConfig
    {};
    class paramsMenu_getBriefingIDD
    {};
    class paramsMenu_getCurrentParamValue
    {};
    class paramsMenu_getDefaultParamValue
    {};
    class paramsMenu_getJIPQueueId
    {};
    class paramsMenu_getParamVarName
    {};
    class paramsMenu_hashParams
    {};
    class paramsMenu_loadCategory
    {};
    class paramsMenu_open
    {};
    class paramsMenu_paramChanged
    {};
    class paramsMenu_refresh
    {};
    class paramsMenu_serializeConfig
    {};
    class paramsMenu_updateLoadCombo
    {};

    class paramsMenu_preinit
    {
        preInit = 1;
    };
    class paramsMenu_postPreload
    {
        //postInit = 1;
    };
    class paramsMenu_notifyChange
    {};

};

class ParamsMenu_Adjustments
{
    file = "KISKA Systems\KISKA Parameter Menu\functions\ParamAdjustments";
    class paramsMenu_addParam
    {};
    class paramsMenu_addToChangedParamHash
    {};
    class paramsMenu_createCtrlOfClass
    {};
    class paramsMenu_fillParamTitle
    {};
    class paramsMenu_setNewYPos
    {};
    class paramsMenu_setParamValue
    {};
};
