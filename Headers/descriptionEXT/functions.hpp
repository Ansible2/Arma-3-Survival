class BLWK
{
	class Player Start
	{
		file = "functions\Player Start";
		class keepPlayerLoadout
		{
			posInit = 1;
		};
		class keepPlayerInGroup
		{
			postInit = 1;
		};
		class playAreaEnforcementLoop 
		{};
	};
	
	class Server Start
	{
		file = "functions\Server Start";
		class prepareGlobals 
		{};
	};

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
}