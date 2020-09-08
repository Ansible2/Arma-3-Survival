/* ----------------------------------------------------------------------------
Function: BLWK_fnc_getOnlyPlayers

Description:
    Reports all (human) player objects. Does not include headless client entities.
    Unlike "BIS_fnc_listPlayers", this function will not report the game logics of headless clients.

    Sourced from CBA3
Parameters:
    None

Returns:
    List of all player objects <ARRAY>

Examples:
    (begin example)

        call BLWK_fnc_getOnlyPlayers
    
    (end)
Author:
    commy2
---------------------------------------------------------------------------- */
(allUnits + allDeadMen) select {isPlayer _x && {!(_x isKindOf "HeadlessClient_F")}}