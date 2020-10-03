class BLWK
{
	class Build
	{
		file = "functions\Build";
		class addBuildObjectActions 
		{};
		class addPickedUpObjectActions 
		{};
		class enableCollisionWithPlayer 
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

	class CBAP //ported CBA functions 
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
		class taskPatrol
		{};
		class vectRotate3D
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
		class faksToMedkitLoop
		{};
		class infoPanelLoop
		{};
		class keepPlayerInGroup
		{
			postInit = 1;
		};
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
		class checkDLC
		{};
		class doMagRepack
		{};
		class handleEnemyWeapons
		{};
		class isPatchLoaded
		{};
		class openShopGUI
		{};
		class randomizeWeapons
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
		class createLootMarkers
		{};
		class healPlayer
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
		class startWave
		{};
		class startWaveCountdownFinal
		{};
	};
};