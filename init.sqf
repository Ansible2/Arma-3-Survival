// get rid of any old saaved mission params
if (profileNamespace getVariable ["BLWK_savedMissionParameters",[]] isNotEqualTo []) then {
    profileNamespace setVariable ["BLWK_savedMissionParameters",nil];
    saveProfileNamespace;
};
