#include "..\Headers\Music Common Defines.hpp"
/* ----------------------------------------------------------------------------
Function: KISKA_fnc_randomMusic_getCurrentTrack

Description:
    Returns the most recent track selected by the random music system.
    Will be an empty string "" if none is defined.

    This is regardless of whether the song is actually playing.

Parameters:
    NONE

Returns:
    <STRING> - The current randomly selected track

Examples:
    (begin example)
        _mostRecentRandomTrack = call KISKA_fnc_randomMusic_getCurrentTrack;
    (end)

Author(s):
    Ansible2
---------------------------------------------------------------------------- */
scriptName "KISKA_fnc_randomMusic_getCurrentTrack";

GET_MUSIC_CURRENT_RANDOM_TRACK;
