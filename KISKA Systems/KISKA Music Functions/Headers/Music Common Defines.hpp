//#include "Headers\Music Common Defines.hpp"

#define MUSIC_TICK_ACCURACY 10

#define MUSIC_VAR_SPACE localNamespace

#define SET_MUSIC_VAR(var_name, value) MUSIC_VAR_SPACE setVariable [var_name, value]

#define MUSIC_SHOW_SONG_NAMES_VAR_STR "KISKA_CBA_showSongNames"
#define GET_MUSIC_SHOW_SONG_NAMES missionNamespace getVariable [MUSIC_SHOW_SONG_NAMES_VAR_STR,false]


#define MUSIC_CURRENT_TRACK_VAR_STR "KISKA_currentTrack"
#define GET_MUSIC_CURRENT_TRACK MUSIC_VAR_SPACE getVariable [MUSIC_CURRENT_TRACK_VAR_STR,""]


#define MUSIC_IS_PLAYING_VAR_STR "KISKA_isMusicPlaying"
#define GET_MUSIC_IS_PLAYING MUSIC_VAR_SPACE getVariable [MUSIC_IS_PLAYING_VAR_STR,false]


/* ----------------------------------------------------------------------------
    Random Music
---------------------------------------------------------------------------- */
#define MUSIC_CURRENT_RANDOM_TRACK_VAR_STR "KISKA_currentRandomTrack"
#define GET_MUSIC_CURRENT_RANDOM_TRACK MUSIC_VAR_SPACE getVariable [MUSIC_CURRENT_RANDOM_TRACK_VAR_STR,""]


#define MUSIC_RANDOM_START_TIME_VAR_STR "KISKA_randomMusicCurrentTickID"
#define GET_MUSIC_RANDOM_START_TIME MUSIC_VAR_SPACE getVariable [MUSIC_RANDOM_START_TIME_VAR_STR,-1]


#define MUSIC_RANDOM_UNUSED_TRACKS_VAR_STR "KISKA_randomMusic_tracks"
#define GET_MUSIC_RANDOM_UNUSED_TRACKS MUSIC_VAR_SPACE getVariable [MUSIC_RANDOM_UNUSED_TRACKS_VAR_STR,[]]


#define MUSIC_RANDOM_TIME_BETWEEN_VAR_STR "KISKA_randomMusic_timeBetween"
#define GET_MUSIC_RANDOM_TIME_BETWEEN MUSIC_VAR_SPACE getVariable [MUSIC_RANDOM_TIME_BETWEEN_VAR_STR,[120,180,240]]


#define MUSIC_RANDOM_USED_TRACKS_VAR_STR "KISKA_randomMusic_usedTracks"
#define GET_MUSIC_RANDOM_USED_TRACKS MUSIC_VAR_SPACE getVariable [MUSIC_RANDOM_USED_TRACKS_VAR_STR,[]]


#define MUSIC_RANDOM_SYS_RUNNING_VAR_STR "KISKA_musicSystemIsRunning"
#define GET_MUSIC_RANDOM_MUSIC_SYS_RUNNING MUSIC_VAR_SPACE getVariable [MUSIC_RANDOM_SYS_RUNNING_VAR_STR,false]
