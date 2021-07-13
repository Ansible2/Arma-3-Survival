/* ----------------------------------------------------------------------------
Function: BLWK_fnc_KISKAParams_populateLootWhitelists

Description:
    Returns all the names of the custom loot lists in the "BLWK_lootlists" >> "customLootLists"
     class.

Parameters:
	NONE

Returns:
	<ARRAY> - An array of strings of each "title" property

Examples:
    (begin example)
        private _listOfNames = call BLWK_fnc_KISKAParams_populateLootWhitelists;
    (end)

Author:
	Ansible2
---------------------------------------------------------------------------- */
scriptName "BLWK_fnc_KISKAParams_populateLootWhitelists";


private _listOfTitles = localNamespace getVariable ["BLWK_lootListTitles",[]];
if (_listOfTitles isEqualTo []) then {

    private _customLootListConfigs = "true" configClasses (missionConfigFile >> "BLWK_lootLists" >> "CustomLootLists");
    localNamespace setVariable ["BLWK_lootListConfigs",_listOfTitles];

    _listOfTitles = _customLootListConfigs apply {
        getText(_x >> "title");
    };
    localNamespace setVariable ["BLWK_lootListTitles",_listOfTitles];

};


_listOfTitles;
