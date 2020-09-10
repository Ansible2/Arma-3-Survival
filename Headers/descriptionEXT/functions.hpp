class BLWK
{
	class Build
	{
		file = "functions\build";
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

	class CBAP
	{
		file = "functions\CBAP";
		class addWaypoint
		{};
		class clearWaypoints
		{};
		class getGroup
		{};
		class getPos
		{};
		class players
		{};
		class taskPatrol
		{};
		class vectRotate3D
		{};
	};

	class Init
	{
		file = "functions\init";
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
		class prepareGlobals
		{};
	};

	class Other
	{
		file = "functions\other";
		class civRandomGear 
		{};
	}
	
	class Points
	{
		file = "functions\Points";
		class spendPoints 
		{};
	};

	class Waves
	{
		file = "functions\waves";
		class explodeSuicideBomber
		{};
		
	};
}