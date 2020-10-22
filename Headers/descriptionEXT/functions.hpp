class BLWK
{
	class Build
	{
		file = "functions\Build";
		class addBuildableObjectActions 
		{};
		class addPickedUpObjectActions 
		{};
		class disableCollisionWithAllPlayers
		{};
		class enableCollisionWithPlayer 
		{};
		class enableCollisionWithAllPlayers
		{};
		class locality
		{};
		class moveUpOrDown
		{};
		class pickupObject 
		{};
		class placeObject 
		{};
		class purchaseObject 
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
		class bulwarkBuildingsLoop
		{};
		class createBattleAmbienceSound
		{};
		class faksToMedkitLoop
		{};
		class getHeadless
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
		class prepareBulwarkPlayer
		{};
		class prepareBulwarkServer
		{};
		class prepareGlobals
		{};
		class prepareLootClasses
		{};
		class preparePlayArea
		{};
		class prepareUnitClasses
		{};
		class selectPlayArea
		{};
	};

	class Other
	{
		file = "Functions\Other";
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
		class handleEnemyWeapons
		{};
		class openShopGUI
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

	class Que
	{
		file = "Functions\Que";
		class addtoQue
		{};
		class createFromQue
		{};
	};

	class Supports
	{
		file = "Functions\Supports";
		class callForArtillery
		{};
		class callingForSupportMaster
		{};
		class cas
		{};
		class createLootMarkers
		{};
		class cruiseMissileStrike
		{};
		class healPlayer
		{};
		class purchaseSupport
		{};
		class supportRadioGlobal
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
		class overrunBulwarkWave
		{};
	};

	class StandardWaveLibrary
	{
		file = "Functions\Wave Type Libraries\Standard Wave Library";
		class addStdEnemyHitEH
		{};
		class addStdEnemyManEHs
		{};
		class createStdWaveInfantry
		{};
		class handleDefectorWave
		{};
		class handleStandardWave
		{};
		class removeStdEnemyHitEvent
		{};
		class stdEnemyHitEvent
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
		class suicideBomberLoop
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
		class setCrew
		{};
		class setSkill
		{};
		class spawnLoot
		{};
		class stalkPlayers
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