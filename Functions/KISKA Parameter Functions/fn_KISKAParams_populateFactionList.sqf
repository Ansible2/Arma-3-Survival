/* ----------------------------------------------------------------------------
Function: BLWK_fnc_KISKAParams_populateFactionList

Description:
    Returns all the names of the factions in the "BLWK_factions" config class.

Parameters:
	NONE

Returns:
	<ARRAY> - An array of strings of each "displayName" property

Examples:
    (begin example)
        private _listOfNames = call BLWK_fnc_KISKAParams_populateFactionList;
    (end)

Author:
	Ansible2
---------------------------------------------------------------------------- */
scriptName "BLWK_fnc_KISKAParams_populateFactionList";

private _listOfNames = localNamespace getVariable ["BLWK_factionNames",[]];
if (_listOfNames isEqualTo []) then {

    private _factionConfigsUnsorted = "true" configClasses (missionConfigFile >> "BLWK_factions");

    private _name = "";
    private _factionConfigs = [];
    _factionConfigsUnsorted apply {
    	_name = getText(_x >> "displayName");

        if (_name isNotEqualTo "") then {
            _factionConfigs pushBack _x;
            _listOfNames pushBack _name;
        };
    };

    localNamespace setVariable ["BLWK_factionConfigs",_factionConfigs];
    localNamespace setVariable ["BLWK_factionNames",_listOfNames];

};


_listOfNames;
