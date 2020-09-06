class BLWK
{
	class Player Start
	{
		file = "functions\Player Start";
		class playAreaEnforcementLoop {};
	};
	
	class Server Start
	{
		file = "functions\Server Start";
		class prepareGlobals {};
	};

	class Build
	{
		file = "functions\build";
		class sell {};
        class pickup {};
        class drop {};
        class reset{};
		class moveUpOrDown {};
        class place {};
	}
}