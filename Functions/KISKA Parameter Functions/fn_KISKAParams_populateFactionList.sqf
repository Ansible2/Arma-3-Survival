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
    private _mods = getLoadedModsInfo apply { _x select 1 };

    private _name = "";
    private _dependencies = [];
    private _loadedDependencies = [];
    private _hasAllDependencies = false;
    private _factionConfigs = [];

    _factionConfigsUnsorted apply {
        _name = getText (_x >> "displayName");
        if (_name isNotEqualTo "") then {

            _dependencies = getArray (_x >> "dependencies");
            if (_dependencies isNotEqualTo []) then {
                _loadedDependencies = _mods arrayIntersect _dependencies;
                _hasAllDependencies = (count _loadedDependencies) isEqualTo (count _dependencies);

                if (_hasAllDependencies) then {
                    _factionConfigs pushBack _x;
                    _listOfNames pushBack _name;
                };

            } else {
                // some players may have added custom factions in the past without this
                // so add to the list if no dependencies are defined
                _factionConfigs pushBack _x;
                _listOfNames pushBack _name;

            };
        }

    };

    localNamespace setVariable ["BLWK_factionConfigs",_factionConfigs];
    localNamespace setVariable ["BLWK_factionNames",_listOfNames];

};


_listOfNames;
