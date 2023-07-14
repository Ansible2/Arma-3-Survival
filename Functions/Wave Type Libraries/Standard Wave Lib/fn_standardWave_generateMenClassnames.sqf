/* ----------------------------------------------------------------------------
Function: BLWK_fnc_standardWave_generateMenClassnames

Description:
    Gets the standard (weighted) list of available men classes.

Parameters:
    NONE

Returns:
    <(STRING | NUMBER)[]> - A weighted or unweighted array of classnames that
        enemy units will spawn from.

Examples:
    (begin example)
        private _availableClasses = call BLWK_fnc_standardWave_generateMenClassnames;
    (end)

Author(s):
    Ansible2
---------------------------------------------------------------------------- */
scriptName "BLWK_fnc_standardWave_generateMenClassnames";


private _classes = [];
private _weights = [];

_classes append BLWK_level1Faction_menClasses;
BLWK_level1Faction_menClasses apply { _weights pushBack BLWK_level1Faction_weight };

if (BLWK_currentWaveNumber >= BLWK_level2Faction_startWave) then {
    _classes append BLWK_level2Faction_menClasses;
    BLWK_level2Faction_menClasses apply { _weights pushBack BLWK_level2Faction_weight };
};
if (BLWK_currentWaveNumber > BLWK_level3Faction_startWave) then {
    _classes append BLWK_level3Faction_menClasses;
    BLWK_level3Faction_menClasses apply { _weights pushBack BLWK_level3Faction_weight };
};
if (BLWK_currentWaveNumber > BLWK_level4Faction_startWave) then {
    _classes append BLWK_level4Faction_menClasses;
    BLWK_level4Faction_menClasses apply { _weights pushBack BLWK_level4Faction_weight };
};
if (BLWK_currentWaveNumber > BLWK_level5Faction_startWave) then {
    _classes append BLWK_level5Faction_menClasses;
    BLWK_level5Faction_menClasses apply { _weights pushBack BLWK_level5Faction_weight };
};


[
    _classes,
    _weights
]
