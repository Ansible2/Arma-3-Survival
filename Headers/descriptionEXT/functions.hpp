class BLWK
{
	class AiPathing
	{
		file = "functions\AI Pathing";
		class pathing_isGroupAlive
		{};
		class pathing_checkLeaderVelocity
		{};
		class pathing_collisionLoop
		{};
		class pathing_detailedStuckCheck
		{};
		class pathing_mainLoop
		{};
	};

	class Build
	{
		file = "functions\Build";
		class addAllowDamageEH
		{};
		class addBuildableObjectActions
		{};
		class addPickedUpObjectActions
		{};
		class addRemoveRemotePurchaseEvent
		{};
		class buildEvent_onPickedUp
		{};
		class buildEvent_onPlaced
		{};
		class buildEvent_onPurchasedPostfix
		{};
		class buildEvent_onPurchasedPostNetwork
		{};
		class buildEvent_onSold
		{};
		class buildItemPurchasedEvent_remote
		{};
		class disableCollisionWithAllPlayers
		{};
		class enableCollisionWithAllPlayers
		{};
		class getBuildEvent_onPurchasedPrefix
		{};
		class moveUpOrDown
		{};
		class pickupObject
		{};
		class placeObject
		{};
		class purchaseObject
		{};
		class registerObjectPickup
		{};
		class removePickedUpObjectActions
		{};
		class resetObjectRotation
		{};
		class rotateObject
		{};
		class sellObject
		{};
	};

	class ItemReclaimer
	{
		file = "Functions\Unique Build Item Libraries\Item Reclaimer";
		class itemReclaimer_init
		{};
		class itemReclaimer_onSold
		{};
		class itemReclaimer_addActions
		{};
		class itemReclaimer_reclaim
		{};
	};

	class DragSystem
	{
		file = "Functions\Drag system";
		class addDragAction
		{};
		class addDragKilledEh
		{};
		class addReleaseDragAction
		{};
		class dragUnitEvent
		{};
		class handleReviveAfterDrag
		{};
		class initDragSystem
		{};
		class releaseDragEvent
		{};
		class removeDragAction
		{};
	};

	class Extraction
	{
		file = "Functions\Extraction";
		class callingForExtraction
		{};
		class cancelExtraction
		{};
		class extraction
		{};
		class finishedExtraction
		{};
		class teleportToExtractionSite
		{};
	};

	class Init
	{
		file = "Functions\Init Functions";
		class addDiaryEntries
		{};
		class addReviveEhs
		{};
		class arePlayersAliveLoop
		{};
		class theCrateBuildingsLoop
		{};
		class createBattleAmbienceSound
		{};
		class createBuildObjectsHash
		{};
		class createSupportsArray
		{};
		class faksToMedkitLoop
		{};
		class infoPanelLoop
		{};
		class keepPlayerLoadout
		{
			postInit = 1;
		};
		class playAreaEnforcementLoop
		{};
		class prepareTheCratePlayer
		{};
		class prepareTheCrateServer
		{};
		class prepareGlobals
		{};
		class prepareLootClasses
		{};
		class preparePlayArea
		{};
		class prepareFactionMap
		{};
		class selectCustomPlayArea
		{};
		class selectPlayArea
		{};
		class setupFactionMaps
		{};
	};


	class KiskaParameterFunctions
	{
		file = "Functions\KISKA Parameter Functions";
		class KISKAParams_populateLootWhitelists
		{};
		class KISKAParams_populateFactionList
		{};
		class KISKAParams_queueFactionChange
		{};
	};

	class MusicManager
	{
		file = "Functions\Music Manager";
		class musicManager_markAvailableMusicListEntry
		{};
		class musicManager_playMusic
		{};
		class musicManager_setPlayListServer
		{};
		class musicManager_updateLoadCombo
		{};
		class musicManager_addSongToPlaylist
		{};
		class musicManager_removeSongFromPlaylist
		{};
		class musicManagerOnLoad
		{};
		class musicManagerOnLoad_addAndRemoveButtons
		{};
		class musicManagerOnLoad_availableMusicList
		{};
		class musicManagerOnLoad_closeButton
		{};
		class musicManagerOnLoad_deleteButton
		{};
		class musicManagerOnLoad_loadControls
		{};
		class musicManagerOnLoad_pauseAndPlayButtons
		{};
		class musicManagerOnLoad_savePlaylistControls
		{};
		class musicManagerOnLoad_systemOnOffCombo
		{};
		class musicManagerOnLoad_timelineSlider
		{};
		class musicManagerOnLoad_trackSpacingControls
		{};
		class musicManagerOnLoad_volumeSlider
		{};
		class openMusicManager
		{};
	};

	class Other
	{
		file = "Functions\Other";
		class addACESupportMenuAction
		{};
		class addPlayerItems
		{};
		class addSurvivalDiaryEntry
		{};
		class adjustPlayerTraits
		{};
		class allowDamage
		{};
	/*
		class checkDLC
		{};
	*/
		class closeArsenal
		{};
		class doMagRepack
		{};
		class getEnemyVehicleClasses
		{};
		class getFriendlyVehicleClass
		{};
		class handleEnemyWeapons
		{};
		class handleUnconsciousAiEvent
		{};
		class handleWaitingForReviveEvent
		{};
		class hideFoliage
		{};
		class hintDroppedDelete
		{};
		class lootReveal
		{};
		class notifyAdminsOrHostOfError
		{};
		class optreMedicalToVanilla
		{};
		class randomizeWeapons
		{};
		class reassignCurator
		{};
		class removeReviveEhs
		{};
		class spinRandomWeaponBox
		{};
	};

	class OtherActions
	{
		file = "Functions\Other Actions";
		class addMoneyPileAction
		{};
		class addOpenShopAction
		{};
		class addRevealLootAction
		{};
		class addUnlockSupportAction
		{};
		class addWeaponBoxSpinAction
		{};
	};

	class Points
	{
		file = "functions\Points";
		class addPoints
		{};
		class createHitmarker
		{};
		class getPointsForKill
		{};
		class subtractPoints
		{};
	};

	class Queue
	{
		file = "Functions\Queue";
		class spawnQueue_add
		{};
		class spawnQueue_get
		{};
		class spawnQueue_create
		{};
		class spawnQueue_popAndCreate
		{};
	};

	class SatelliteShop
	{
		file = "Functions\Unique Build Item Libraries\Satellite Shop";
		class satelliteShop_addDeleteEvent
		{};
		class satelliteShop_init
		{};
		class satelliteShop_preparePlayer
		{};
	};

	class ShopGUI
	{
		file = "Functions\Shop GUI";
		class openShop
		{};
		class shop_adjustCommunityPoolLoop
		{};
		class shop_adjustPartnerControl
		{};
		class shop_adjustPointsLoop
		{};
		class shop_depositPointsButtonPressedEvent
		{};
		class shop_getPartnerControl
		{};
		class shop_mouseExitTreeEvent
		{};
		class shop_mouseMoveTreeEvent
		{};
		class shop_onLoadEvent
		{};
		class shop_populateBuildTree
		{};
		class shop_populateSupportTree
		{};
		class shop_purchaseForPool
		{};
		class shop_purchaseForSelf
		{};
		class shop_sellFromPoolButtonEvent
		{};
		class shop_withdrawFromPoolButtonEvent
		{};
		class shop_withdrawPointsButtonPressedEvent
		{};
	};

	class Supports
	{
		file = "Functions\Supports";
		class startAircraftGunner
		{};
		class endAircraftGunner
		{};
		class arsenalSupplyDrop
		{};
		class callForArtillery
		{};
		class callingForSupportMaster
		{};
		class createLootMarkers
		{};
		class cruiseMissileStrike
		{};
		class daisyCutter
		{};
		class healPlayer
		{};
		class passiveHelicopterGunner
		{};
		class purchaseSupport
		{};
		class reconUAV
		{};
		class supportRadioGlobal
		{};
		class updateFlareEffects
		{};
	};

	class Stalking
	{
		file = "Functions\Stalking";
		class adjustStalkable
		{};
		class canUnitBeStalked
		{};
		class getAPlayerToStalk
		{};
		class registerStalkers
		{};
		class startStalkingPlayers
		{};
		class stopStalking
		{};
	};

	// Wave Type Libraries
	class CivilianWaveLibrary
	{
		file = "Functions\Wave Type Libraries\Civilian Wave Library";
		class civiliansWave
		{};
		class civRandomGear
		{};
		class handleCivilianKilledEventPlayer
		{};
		class killedCivilianEvent
		{};
		class onCivWaveEnd
		{};
	};

	class DroneWaveLibrary
	{
		file = "Functions\Wave Type Libraries\Drone Wave Library";
		class createDroneWave
		{};
		class droneAttackLoop
		{};
		class handleDroneWave
		{};
		class onDroneWaveEnd
		{};
	};

	class HelicoperWaveLibrary
	{
		file = "Functions\Wave Type Libraries\Helicopter Wave Library";
		class handleHelicopterWave
		{};
	};

	class MortarWaveLibrary
	{
		file = "Functions\Wave Type Libraries\Mortar Wave Library";
		class createMortarWave
		{};
		class handleMortarWave
		{};
	};

	class OverrunWaveLibrary
	{
		file = "Functions\Wave Type Libraries\Overrun Wave Library";
		class handleOverrunWave
		{};
		class overrunTheCrateWave
		{};
	};

	class ParatrooperWaveLibrary
	{
		file = "Functions\Wave Type Libraries\Paratrooper Wave Library";
		class handleParatrooperWave
		{};
	};
	class StandardWaveLib
	{
		file = "Functions\Wave Type Libraries\Standard Wave Lib";
		class standardWave_generateManSpawnPosition 
		{};
		class standardWave_generateMenClassnames
		{};
		class standardWave_onManCreated
		{};
		class standardWave_onWaveInit
		{};
		class standardWave_vehicles
		{};
	};
	
	class Events
	{
		file = "Functions\Wave Type Libraries\Events";
		class event_killedEnemy
		{};
		class event_hitEnemy
		{};
	};

	class SuicideWaveLibrary
	{
		file = "Functions\Wave Type Libraries\Suicide Wave Library";
		class createSuicideWave
		{};
		class explodeSuicideBomberEvent
		{};
		class handleSuicideWave
		{};
		class playBomberAudio
		{};
		class suicideBomberLoop
		{};
	};

	class Waves
	{
		file = "Functions\Waves";
		class waves_getFunctionFromConfig
		{};
		class waves_onInitialized
		{};
		class waves_create
		{};
		
		class addToMustKillList
		{};
		class cacheEnemyMenSpawnPositions
		{};
		class cleanUpTheDead
		{};
		class clearMustKillList
		{};
		class endWave
		{};
		class getConfigForWave
		{};
		class getMustKillList
		{};
		class isWaveCleared
		{};
		class setSkill
		{};
		class spawnLoot
		{};
		class startWave
		{};
		class startWaveCountdown
		{};
	};
};

class CBAP //ported CBA functions
{
	class ported
	{
		file = "functions\CBAP";
		class addWaypoint
		{};
		class directCall
		{};
		class getArea
		{};
		class getGroup
		{};
		class getItemConfig
		{};
		class getPos
		{};
		class inheritsFrom
		{};
		class players
		{};
		class randPos
		{};
		class randPosArea
		{};
		class shuffle
		{};
		class simplifyAngle
		{};
		class simplifyAngle180
		{};
		class taskPatrol
		{};
		class vectDir
		{};
		class vectRotate3D
		{};
		class waitAndExecute
		{};
		class waitUntilAndExecute
		{};
	};
};
