if (isServer) then {
	null = [] spawn BLWK_fnc_initServerAlias;
};

null = [] spawn BLWK_fnc_initClientAlias;