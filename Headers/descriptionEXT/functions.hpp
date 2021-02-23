class BLWK
{
	class AiPathing
	{
		file = "functions\AI Pathing";
		class pathing_checkGroupStatus
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
		class addBuildableObjectActions 
		{};
		class addPickedUpObjectActions 
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
		class createBuildObjectsArray
		{};
		class createBuildObjectsHash
		{};
		class createSupportsArray
		{};
		class faksToMedkitLoop
		{};
		class infoPanelLoop
		{};
		class initClientAlias
		{};
		class initServerAlias
		{};
	/*
		class keepPlayerInGroup
		{
			//postInit = 1;
		};
	*/
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
		class prepareUnitClasses
		{};
		class selectCustomPlayArea
		{};
		class selectPlayArea
		{};
	};

	class MusicManager
	{
		file = "Functions\Music Manager";
		class musicManager_playMusic
		{};
		class musicManager_setPlayListServer
		{};
		class musicManager_updateLoadCombo
		{};
		class musicManagerOnLoad
		{};
		class musicManagerOnLoad_addAndRemoveButtons
		{};
		class musicManagerOnLoad_availableMusicList
		{};
		class musicManagerOnLoad_closeButton
		{};
		class musicManagerOnLoad_commitButton
		{};
		class musicManagerOnLoad_currentPlaylistLoop
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
		class adjustPlayerTraits
		{};
	/*	
		class checkDLC
		{};
	*/
		class doMagRepack
		{};
		class getEnemyVehicleClasses
		{};
		class getFriendlyVehicleClass
		{};
		class handleEnemyWeapons
		{};
		class handleWaitingForReviveEvent
		{};
		class hideFoliage
		{};
		class hintDroppedDelete
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
		class addRevealLootAction
		{};
		class addUnlockSupportAction
		{};
		class addWeaponBoxSpinAction
		{};
	};

	class ParameterSaving
	{
		file = "Functions\Parameter Saving";
		class addParameterDiaryEntries
		{
			postInit = 1;
		};
		class deleteSavedMissionParameters
		{};
	/*	
		class getSavedParamIndex
		{};
		class getSavedParamValue
		{};
	*/
		class paramsQuery
		{};
		class saveAllMissionParameters
		{};
	/*
		class setParam
		{};
	*/
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
		class addtoQueue
		{};
		class createFromQueue
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
		class aircraftGunner
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

	// Wave Type Librariers
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
		class paraTroopers
		{};
	};

	class StandardWaveLibrary
	{
		file = "Functions\Wave Type Libraries\Standard Wave Library";
		class addStdEnemyManEHs
		{};
		class createStdWaveInfantry
		{};
		class handleDefectorWave
		{};
		class handleKillEventPlayer
		{};
		class handleHitEventPlayer
		{};
		class handleStandardWave
		{};
		class stdEnemyHitEvent
		{};
		class stdEnemyHitEventLocal
		{};
		class stdEnemyKilledEvent
		{};
		class stdEnemyManCreateCode
		{};
		class stdEnemyVehicles
		{};
		class stdVehicleKilledEvent
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

	class TwelveHourWaveLibrary
	{
		file = "Functions\Wave Type Libraries\Twelve Hour Wave Library";
		class handleTwelveHourWave
		{};
	};

	class Waves
	{
		file = "Functions\Waves";
		class addToMustKillArray
		{};
		class cleanUpTheDead
		{};		
		class clearMustKillArray
		{};
		class decideWaveType
		{};
		class endWave
		{};
		class isWaveCleared
		{};
		class setSkill
		{};
		class spawnLoot
		{};
		class startWave
		{};
		class startWaveCountdownFinal
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
		class clearWaypoints
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
		class vectRotate3D
		{};
	};
};