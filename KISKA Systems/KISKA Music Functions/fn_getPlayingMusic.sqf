#include "Headers\Music Common Defines.hpp"
/* ----------------------------------------------------------------------------
Function: KISKA_fnc_getPlayingMusic

Description:
	Returns the current playing tracks class name.

Parameters:
	NONE

Returns:
	<STRING> - The class name of music. Will be "" if nonthing is playing.

Examples:
    (begin example)
		call KISKA_fnc_getPlayingMusic;
    (end)

Author(s):
	Ansible2
---------------------------------------------------------------------------- */
scriptName "KISKA_fnc_getPlayingMusic";

GET_MUSIC_CURRENT_TRACK;
