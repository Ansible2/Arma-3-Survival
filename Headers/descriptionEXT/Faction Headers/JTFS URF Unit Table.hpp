

class JTFS_URF_faction
{
	displayName = "JTFS Armory - United Rebel Front"; 

	//excluding JTFS_Crewman, JTFS_Pilot_01, JTFS_Pilot_02, JTFS_Officer_01, JTFS_Officer_02
	infantry[]={
		"JTFS_Rifleman_MA5A",
		"JTFS_Grenadier",
		"JTFS_Rifleman_AT",
		"JTFS_Autorifleman",
		"JTFS_Marksman",
		"JTFS_Sniper",
		"JTFS_Medic"
	};
	/* Transport Vics? 
	// "JTFS_M813_TT"
	// "JTFS_M12_FAV_APC"
	// "JTFS_HDV134_TT"
	// "JTFS_HDV134_TT_C"
	*/
	lightCars[]={
		"JTFS_M12_LRV",
		"JTFS_M12A1_LRV" // AT rocket variant, might remove
	};
	heavyCars[]={
		"JTFS_M12R_AA", // AA rocket variant, might remove
		"JTFS_M12G1_LRV"
	};
	lightArmor[]={
		"JTFS_APC_Kamysh",
		"JTFS_APC_Mora",
		"JTFS_APC_Gorgon",
		"JTFS_APC_Marid",
		"JTFS_M412_IFV",
		"JTFS_M413_MGS"
	};
	heavyArmor[]={
		"JTFS_MBT_Kuma",
		"JTFS_MBT_Angara",
		"JTFS_MBT_AngaraK",
		"JTFS_MBT_Varsuk"
		//"JTFS_M808B_URF" commented out for obvious reasons, until the Scorpion is reasonable to fight
	};
	// Sadly, none of my transports have door guns. I noticed your example uses the same base class though, so I plugged my version in
	transportHelicopters[]={
		"JTFS_Heli_Hellcat_unarmed"
	};
	cargoAircraft[]={
		"JTFS_Plane_Xian_inf", //VTOL transport, infantry variant. JTFS_Plane_Xian_vic for vics if we ever need it.
		"JTFS_Heli_Mohawk"
		//"JTFS_Pelican_unarmed" // prone to errors in flight
		
		 
	};
	// excluded are the armed pelican, falcon, hornet, and Xi'an transport (have you seen how much ordnance that thing carries??)
	casAircraft[]={
		"JTFS_Plane_Shikra",
		"JTFS_Plane_Neophron"
	};
	attackHelicopters[]={
		"JTFS_Heli_Kajman"
	};
	// maybe I'll reskin an equivalent for the rebels.. 
	heavyGunships[]={
	};
};
