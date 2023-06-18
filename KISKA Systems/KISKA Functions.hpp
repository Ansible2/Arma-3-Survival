class KISKA
{
	#include "KISKA Parameter Menu\Headers\param menu functions.hpp"

	class DynamicViewDistance
	{
		file = "KISKA Systems\View Distance Limiter\Functions";
		class addOpenVdlGuiDiary
		{
			postInit = 1;
		};
		class adjustVdlControls
		{};
		class findVdlPartnerControl
		{};
		class handleVdlDialogOpen
		{};
		class handleVdlGuiCheckbox
		{};
		class isVdlSystemRunning
		{};
		class openVdlDialog
		{};
		class setAllVdlButton
		{};
		class setVdlValue
		{};
		class viewDistanceLimiter
		{};
	};
	class KISKA_RandomMusic
	{
		file = "KISKA Systems\KISKA Music Functions\Random Music";
		class randomMusic_getCurrentTrack
		{};
		class randomMusic_getTrackInterval
		{};
		class randomMusic_getUnusedTracks
		{};
		class randomMusic_getUsedTracks
		{};
		class randomMusic_getVolume
		{};
		class randomMusic_isSystemRunning
		{};
		class randomMusic_setCurrentTrack
		{};
		class randomMusic_setSystemRunning
		{};
		class randomMusic_setTrackInterval
		{};
		class randomMusic_setUnusedTracks
		{};
		class randomMusic_setUsedTracks
		{};
		class randomMusic_setVolume
		{};
		class randomMusic_stopClient
		{};
		class randomMusic_stopServer
		{};
		class randomMusic
		{};
	};
	class KISKA_music
	{
		file = "KISKA Systems\KISKA Music Functions";
		class getLatestPlayedMusicID
		{};
		class getMusicDuration
		{};
		class getMusicFromClass
		{};
		class getPlayingMusic
		{};
		class isMusicPlaying
		{};
		class musicEventHandlers
		{
			preInit = 1;
		};
		class musicStartEvent
		{};
		class musicStopEvent
		{};
		class playMusic
		{};
		class stopMusic
		{};
	};
	class KISKA_sounds
	{
		file = "KISKA Systems\KISKA Sound Functions";
		class battleSound
		{};
	};
	class KISKA_utillities
	{
		file = "KISKA Systems\KISKA Utility Functions";
		class addArsenal
		{};
		class addKiskaDiaryEntry
		{};
		class CAS
		{};
		class CASattack
		{};
		class classTurretsWithGuns
		{};
		class clearWaypoints
		{};
		class countdown
		{};
		class deleteAtArray
		{};
		class deleteRandomIndex
		{};
		class detectControlKeys
		{
			preinit = 1;
		};
		class errorNotification
		{};
		class findConfigAny
		{};
		class findIfBool
		{};
		class getNearestIncriment
		{};
		class getVariableTarget
		{};
		class getVariableTarget_sendBack
		{};
    	class getVectorToTarget
		{};
		class heliLand
		{};
		class isAdminOrHost
    	{};
		class isMainMenu
		{};
		class isPatchLoaded
		{};
		class log
		{};
		class notification
		{};
		class notify
		{};
		class markBorder
		{};
		class paraTroopers
		{};
		class pushBackToArray
		{};
		class removeArsenal
		{};
		class setCrew
		{};
		class spawnVehicle
		{};
		class staticLine
		{};
		class staticLine_eject
		{};
		class str
		{};
		class supplyDrop
		{};
	};
};
