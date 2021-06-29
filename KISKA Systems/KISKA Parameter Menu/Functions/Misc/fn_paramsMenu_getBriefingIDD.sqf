/* ----------------------------------------------------------------------------
Function: KISKA_fnc_paramsMenu_getBriefingIDD

Description:
    The briefing menu prior to mission start has a different IDD depending on
     whether it is singlePlayer, you're the server, or you're a client.

Parameters:
    NONE

Returns:
	<NUMBER> - The idd of the briefing menu

Examples:
    (begin example)
        call KISKA_fnc_paramsMenu_getBriefingIDD
    (end)

Author:
	Ansible2
---------------------------------------------------------------------------- */
scriptName "KISKA_fnc_paramsMenu_getBriefingIDD";

private _idd = -1;
if (isMultiplayer) then {

    if (isServer) then {
        _idd = 52;

    } else {
        _idd = 53;

    };

} else {
    _idd = 37;

};


_idd
