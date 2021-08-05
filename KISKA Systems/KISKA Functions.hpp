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
	class KISKA_music
	{
		file = "KISKA Systems\KISKA Music Functions";
		class getCurrentRandomMusicTrack
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
		class randomMusic
		{};
		class setCurrentRandomMusicTrack
		{};
		class stopRandomMusicServer
		{};
		class stopRandomMusicClient
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
		class deleteAtArray
		{};
		class detectControlKeys
		{
			preinit = 1;
		};
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
		class isAdminOrHost
    	{};
		class isMainMenu
		{};
		class isPatchLoaded
		{};
		class log
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
		class str
		{};
		class supplyDrop
		{};
	};
};
