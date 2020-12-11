class OPTRE_MARINES_faction
{	
	displayName = "OPTRE - UNSC Marines";

	lightCars[] = {
		"OPTRE_M12_LRV",
		"OPTRE_M12G1_LRV",
		"OPTRE_M12A1_LRV"
	};
	lightArmor[] = {
		"OPTRE_M412_IFV_UNSC",
		"OPTRE_M413_MGS_UNSC"
	};
	heavyArmor[] = {
		"OPTRE_M808B_UNSC"
	};
	transportHelicopters[] = {
		"OPTRE_UNSC_hornet",
		"OPTRE_UNSC_falcon_unarmed"
	};
	cargoAircraft[] = {
		"B_T_VTOL_01_vehicle_F"
	};
	casAircraft[] = {
		"B_Plane_CAS_01_dynamicLoadout_F",
		"B_Plane_Fighter_01_F"
	};
	attackHelicopters[] = {
		"B_Heli_Attack_01_dynamicLoadout_F"
	};
	infantry[] = {
		"OPTRE_UNSC_Marine_Soldier_AA_Specialist", \
		"OPTRE_UNSC_Marine_Soldier_AT_Specialist", \
		"OPTRE_UNSC_Marine_Soldier_Breacher", \
		"OPTRE_UNSC_Marine_Soldier_Corpsman", \
		"OPTRE_UNSC_Marine_Soldier_Demolitions", \
		"OPTRE_UNSC_Marine_Soldier_Marksman", \
		"OPTRE_UNSC_Marine_Soldier_Engineer", \
		"OPTRE_UNSC_Marine_Soldier_ForwardObserver", \
		"OPTRE_UNSC_Marine_Soldier_Grenadier", \
		"OPTRE_UNSC_Marine_Soldier_Officer", \
		"OPTRE_UNSC_Marine_Soldier_Radioman", \
		"OPTRE_UNSC_Marine_Soldier_Rifleman_AT", \
		"OPTRE_UNSC_Marine_Soldier_Rifleman_BR", \
		"OPTRE_UNSC_Marine_Soldier_Rifleman_Light", \
		"OPTRE_UNSC_Marine_Soldier_Rifleman_AR", \
		"OPTRE_UNSC_Marine_Soldier_SquadLead", \
		"OPTRE_UNSC_Marine_Soldier_TeamLead", \
		"OPTRE_UNSC_Marine_Soldier_Autorifleman", \
		"OPTRE_UNSC_Marine_Soldier_Assist_Autorifleman" \
	};

};

class OPTRE_ODST_faction : OPTRE_MARINES_faction
{
	displayName = "OPTRE - ODSTs";
	lightCars[] = {
		"OPTRE_M12_LRV_black",
		"OPTRE_M12G1_LRV_black",
		"OPTRE_M12A1_LRV_black"
	};
	lightArmor[] = {
		"OPTRE_M412_IFV_UNSC_blk",
		"OPTRE_M413_MGS_UNSC_blk"
	};
	heavyArmor[] = {
		"OPTRE_M808B_UNSC_blk"
	};
	transportHelicopters[] = {
		"OPTRE_UNSC_hornet_black",
		"OPTRE_UNSC_falcon_black"
	};
	infantry[] = {
		"OPTRE_UNSC_ODST_Soldier_Automatic_Rifleman", \
		"OPTRE_UNSC_ODST_Soldier_DemolitionsExpert", \
		"OPTRE_UNSC_ODST_Soldier_Marksman", \
		"OPTRE_UNSC_ODST_Soldier_Paramedic", \
		"OPTRE_UNSC_ODST_Soldier_Rifleman_AT", \
		"OPTRE_UNSC_ODST_Soldier_Rifleman_BR", \
		"OPTRE_UNSC_ODST_Soldier_Rifleman_AR", \
		"OPTRE_UNSC_ODST_Soldier_Scout", \
		"OPTRE_UNSC_ODST_Soldier_Scout_AT", \
		"OPTRE_UNSC_ODST_Soldier_Scout_Sniper", \
		"OPTRE_UNSC_ODST_Soldier_TeamLeader" \
	};
};

class OPTRE_ARMY_SNOW_faction : OPTRE_MARINES_faction
{
	displayName = "OPTRE - UNSC Army Snow";
	lightCars[] = {
		"OPTRE_M12_LRV_snow",
		"OPTRE_M12G1_LRV_snow",
		"OPTRE_M12A1_LRV_snow"
	};
	transportHelicopters[] = {
		"OPTRE_UNSC_falcon_snow",
		"OPTRE_UNSC_hornet_snow"
	};
	infantry[] = {
		"OPTRE_UNSC_Army_Soldier_AA_Specialist_SNO", \
		"OPTRE_UNSC_Army_Soldier_AT_Specialist_SNO", \
		"OPTRE_UNSC_Army_Soldier_Autorifleman_SNO", \
		"OPTRE_UNSC_Army_Soldier_Breacher_SNO", \
		"OPTRE_UNSC_Army_Soldier_Demolitions_SNO", \
		"OPTRE_UNSC_Army_Soldier_Marksman_SNO", \
		"OPTRE_UNSC_Army_Soldier_Engineer_SNO", \
		"OPTRE_UNSC_Army_Soldier_ForwardObserver_SNO", \
		"OPTRE_UNSC_Army_Soldier_Grenadier_SNO", \
		"OPTRE_UNSC_Army_Soldier_Medic_SNO", \
		"OPTRE_UNSC_Army_Soldier_Officer_SNO", \
		"OPTRE_UNSC_Army_Soldier_Radioman_SNO", \
		"OPTRE_UNSC_Army_Soldier_Rifleman_AT_SNO", \
		"OPTRE_UNSC_Army_Soldier_Rifleman_BR_SNO", \
		"OPTRE_UNSC_Army_Soldier_Rifleman_Light_SNO", \
		"OPTRE_UNSC_Army_Soldier_Rifleman_AR_SNO", \
		"OPTRE_UNSC_Army_Soldier_SquadLead_SNO", \
		"OPTRE_UNSC_Army_Soldier_TeamLead_SNO", \
		"OPTRE_UNSC_Army_Soldier_Assist_Autorifleman_SNO" \
	};
};

class OPTRE_ARMY_DES_faction : OPTRE_MARINES_faction
{
	displayName = "OPTRE - UNSC Army Desert";
	lightCars[] = {
		"OPTRE_M12_LRV_tan",
		"OPTRE_M12A1_LRV_tan",
		"OPTRE_M12G1_LRV_tan"
	};
	lightArmor[] = {
		"OPTRE_M413_MGS_UNSC_tan",
		"OPTRE_M412_IFV_UNSC_tan"
	};
	heavyArmor[] = {
		"OPTRE_M413_MGS_UNSC_tan"
	};
	transportHelicopters[] = {
		"OPTRE_UNSC_falcon_tan",
		"OPTRE_UNSC_hornet_desert"
	};
	infantry[] = {
		"OPTRE_UNSC_Army_Soldier_AA_Specialist_DES",
		"OPTRE_UNSC_Army_Soldier_Assist_Autorifleman_DES",
		"OPTRE_UNSC_Army_Soldier_AT_Specialist_DES",
		"OPTRE_UNSC_Army_Soldier_Autorifleman_DES",
		"OPTRE_UNSC_Army_Soldier_Breacher_DES",
		"OPTRE_UNSC_Army_Soldier_Demolitions_DES",
		"OPTRE_UNSC_Army_Soldier_Marksman_DES",
		"OPTRE_UNSC_Army_Soldier_Engineer_DES",
		"OPTRE_UNSC_Army_Soldier_ForwardObserver_DES",
		"OPTRE_UNSC_Army_Soldier_Grenadier_DES",
		"OPTRE_UNSC_Army_Soldier_Medic_DES",
		"OPTRE_UNSC_Army_Soldier_Radioman_DES",
		"OPTRE_UNSC_Army_Soldier_Rifleman_AT_DES",
		"OPTRE_UNSC_Army_Soldier_Rifleman_BR_DES",
		"OPTRE_UNSC_Army_Soldier_Rifleman_Light_DES",
		"OPTRE_UNSC_Army_Soldier_Rifleman_AR_DES",
		"OPTRE_UNSC_Army_Soldier_Sniper_DES",
		"OPTRE_UNSC_Army_Soldier_SquadLead_DES",
		"OPTRE_UNSC_Army_Soldier_TeamLead_DES"
	};
};

class OPTRE_ARMY_OLI_faction : OPTRE_MARINES_faction
{
	displayName = "OPTRE - UNSC Army Olive";

	infantry[] = {
		"OPTRE_UNSC_Army_Soldier_AA_Specialist_OLI",
		"OPTRE_UNSC_Army_Soldier_Assist_Autorifleman_OLI",
		"OPTRE_UNSC_Army_Soldier_AT_Specialist_OLI",
		"OPTRE_UNSC_Army_Soldier_Autorifleman_OLI",
		"OPTRE_UNSC_Army_Soldier_Breacher_OLI",
		"OPTRE_UNSC_Army_Soldier_Demolitions_OLI",
		"OPTRE_UNSC_Army_Soldier_Marksman_OLI",
		"OPTRE_UNSC_Army_Soldier_Engineer_OLI",
		"OPTRE_UNSC_Army_Soldier_ForwardObserver_OLI",
		"OPTRE_UNSC_Army_Soldier_Grenadier_OLI",
		"OPTRE_UNSC_Army_Soldier_Medic_OLI",
		"OPTRE_UNSC_Army_Soldier_Radioman_OLI",
		"OPTRE_UNSC_Army_Soldier_Rifleman_AT_OLI",
		"OPTRE_UNSC_Army_Soldier_Rifleman_BR_OLI",
		"OPTRE_UNSC_Army_Soldier_Rifleman_Light_OLI",
		"OPTRE_UNSC_Army_Soldier_Rifleman_AR_OLI",
		"OPTRE_UNSC_Army_Soldier_Sniper_OLI",
		"OPTRE_UNSC_Army_Soldier_SquadLead_OLI",
		"OPTRE_UNSC_Army_Soldier_TeamLead_OLI"
	};
};

class OPTRE_ARMY_TROPICAL_faction : OPTRE_MARINES_faction
{
	displayName = "OPTRE - UNSC Army Tropical";

	infantry[] = {
		"OPTRE_UNSC_Army_Soldier_AA_Specialist_TRO",
		"OPTRE_UNSC_Army_Soldier_Assist_Autorifleman_TRO",
		"OPTRE_UNSC_Army_Soldier_AT_Specialist_TRO",
		"OPTRE_UNSC_Army_Soldier_Autorifleman_TRO",
		"OPTRE_UNSC_Army_Soldier_Breacher_TRO",
		"OPTRE_UNSC_Army_Soldier_Demolitions_TRO",
		"OPTRE_UNSC_Army_Soldier_Marksman_TRO",
		"OPTRE_UNSC_Army_Soldier_Engineer_TRO",
		"OPTRE_UNSC_Army_Soldier_ForwardObserver_TRO",
		"OPTRE_UNSC_Army_Soldier_Grenadier_TRO",
		"OPTRE_UNSC_Army_Soldier_Medic_TRO",
		"OPTRE_UNSC_Army_Soldier_Radioman_TRO",
		"OPTRE_UNSC_Army_Soldier_Rifleman_AT_TRO",
		"OPTRE_UNSC_Army_Soldier_Rifleman_BR_TRO",
		"OPTRE_UNSC_Army_Soldier_Rifleman_Light_TRO",
		"OPTRE_UNSC_Army_Soldier_Rifleman_AR_TRO",
		"OPTRE_UNSC_Army_Soldier_Sniper_TRO",
		"OPTRE_UNSC_Army_Soldier_SquadLead_TRO",
		"OPTRE_UNSC_Army_Soldier_TeamLead_TRO"
	};
};

class OPTRE_ARMY_URBAN_faction : OPTRE_ODST_faction
{
	displayName = "OPTRE - UNSC Army Urban";

	infantry[] = {
		"OPTRE_UNSC_Army_Soldier_AA_Specialist_URB",
		"OPTRE_UNSC_Army_Soldier_Assist_Autorifleman_URB",
		"OPTRE_UNSC_Army_Soldier_AT_Specialist_URB",
		"OPTRE_UNSC_Army_Soldier_Autorifleman_URB",
		"OPTRE_UNSC_Army_Soldier_Breacher_URB",
		"OPTRE_UNSC_Army_Soldier_Demolitions_URB",
		"OPTRE_UNSC_Army_Soldier_Marksman_URB",
		"OPTRE_UNSC_Army_Soldier_Engineer_URB",
		"OPTRE_UNSC_Army_Soldier_ForwardObserver_URB",
		"OPTRE_UNSC_Army_Soldier_Grenadier_URB",
		"OPTRE_UNSC_Army_Soldier_Medic_URB",
		"OPTRE_UNSC_Army_Soldier_Radioman_URB",
		"OPTRE_UNSC_Army_Soldier_Rifleman_AT_URB",
		"OPTRE_UNSC_Army_Soldier_Rifleman_BR_URB",
		"OPTRE_UNSC_Army_Soldier_Rifleman_Light_URB",
		"OPTRE_UNSC_Army_Soldier_Rifleman_AR_URB",
		"OPTRE_UNSC_Army_Soldier_Sniper_URB",
		"OPTRE_UNSC_Army_Soldier_SquadLead_URB",
		"OPTRE_UNSC_Army_Soldier_TeamLead_URB"
	};
};

class OPTRE_ARMY_WDL_faction : OPTRE_MARINES_faction
{
	displayName = "OPTRE - UNSC Army Woodland";

	infantry[] = {
		"OPTRE_UNSC_Army_Soldier_AA_Specialist_WDL",
		"OPTRE_UNSC_Army_Soldier_Assist_Autorifleman_WDL",
		"OPTRE_UNSC_Army_Soldier_AT_Specialist_WDL",
		"OPTRE_UNSC_Army_Soldier_Autorifleman_WDL",
		"OPTRE_UNSC_Army_Soldier_Breacher_WDL",
		"OPTRE_UNSC_Army_Soldier_Demolitions_WDL",
		"OPTRE_UNSC_Army_Soldier_Marksman_WDL",
		"OPTRE_UNSC_Army_Soldier_Engineer_WDL",
		"OPTRE_UNSC_Army_Soldier_ForwardObserver_WDL",
		"OPTRE_UNSC_Army_Soldier_Grenadier_WDL",
		"OPTRE_UNSC_Army_Soldier_Medic_WDL",
		"OPTRE_UNSC_Army_Soldier_Radioman_WDL",
		"OPTRE_UNSC_Army_Soldier_Rifleman_AT_WDL",
		"OPTRE_UNSC_Army_Soldier_Rifleman_BR_WDL",
		"OPTRE_UNSC_Army_Soldier_Rifleman_Light_WDL",
		"OPTRE_UNSC_Army_Soldier_Rifleman_AR_WDL",
		"OPTRE_UNSC_Army_Soldier_Sniper_WDL",
		"OPTRE_UNSC_Army_Soldier_SquadLead_WDL",
		"OPTRE_UNSC_Army_Soldier_TeamLead_WDL"
	};
};

class OPTRE_URF_faction : CSAT_pacific_faction
{
	displayName = "OPTRE - United Rebel Front";

	lightCars[] = {
		"OPTRE_M12A1_LRV_ins",
		"OPTRE_M12_LRV_ins",
		"OPTRE_M12G1_LRV"
	};
	heavyCars[] = {};
	lightArmor[] = {
		"I_E_APC_tracked_03_cannon_F"
	};
	transportHelicopters[] = {
		"OPTRE_UNSC_hornet",
		"OPTRE_UNSC_falcon_unarmed"
	};
	infantry[] = {
		"OPTRE_Ins_URF_AA_Specialist", \
		"OPTRE_Ins_URF_Assist_Autorifleman", \
		"OPTRE_Ins_URF_AT_Specialist", \
		"OPTRE_Ins_URF_Autorifleman", \
		"OPTRE_Ins_URF_Breacher", \
		"OPTRE_Ins_URF_Demolitions", \
		"OPTRE_Ins_URF_Marksman", \
		"OPTRE_Ins_URF_Engineer", \
		"OPTRE_Ins_URF_Grenadier", \
		"OPTRE_Ins_URF_Medic", \
		"OPTRE_Ins_ER_MAdvisor", \
		"OPTRE_Ins_URF_Observer", \
		"OPTRE_Ins_URF_Officer", \
		"OPTRE_Ins_URF_Radioman", \
		"OPTRE_Ins_URF_Rifleman_AT", \
		"OPTRE_Ins_URF_Rifleman_BR", \
		"OPTRE_Ins_URF_Rifleman_Light", \
		"OPTRE_Ins_URF_Rifleman_AR", \
		"OPTRE_Ins_URF_SquadLead", \
		"OPTRE_Ins_URF_TeamLead" \
	};
};

class OPTRE_BJ_URBAN_faction : OPTRE_URF_faction
{
	displayName = "OPTRE - Battle Jumpers Urban";
	infantry[] = {
		"OPTRE_Ins_BJ_Soldier_URB_Automatic_Rifleman", \
		"OPTRE_Ins_BJ_Soldier_URB_Engineer", \
		"OPTRE_Ins_BJ_Soldier_URB_Marksman", \
		"OPTRE_Ins_BJ_Soldier_URB_Rifleman_AT", \
		"OPTRE_Ins_BJ_Soldier_URB_Rifleman_BR", \
		"OPTRE_Ins_BJ_Soldier_URB_Rifleman_AR", \
		"OPTRE_Ins_BJ_Soldier_URB_Scout", \
		"OPTRE_Ins_BJ_Soldier_URB_TeamLeader", \
		"OPTRE_Ins_BJ_Soldier_URB_Corpsman" \
	};
};

class OPTRE_INSURGENTS_faction : FIA_faction
{
	displayName = "OPTRE - Insurgents";
	
	lightCars[] = {
		"OPTRE_M12A1_LRV_ins",
		"OPTRE_M12_LRV_ins",
		"OPTRE_M12G1_LRV"
	};
	infantry[] = {
		"OPTRE_Ins_ER_Farmer", \
		"OPTRE_Ins_ER_Guerilla_AR", \
		"OPTRE_Ins_ER_Hacker", \
		"OPTRE_Ins_ER_Insurgent_BR", \
		"OPTRE_Ins_ER_Militia_MG", \
		"OPTRE_Ins_ER_Rebel_AT", \
		"OPTRE_Ins_ER_Surgeon", \
		"OPTRE_Ins_ER_Terrorist", \
		"OPTRE_Ins_ER_Warlord", \
		"OPTRE_Ins_ER_Deserter_GL" \
	};
};