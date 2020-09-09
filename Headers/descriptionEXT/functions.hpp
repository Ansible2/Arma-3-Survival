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
		class vectRotate3D
		{};
	};

	class Other
	{
		file = "functions\other";
		class getOnlyPlayers 
		{};
	}

	class Init
	{
		file = "function\init";
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
}