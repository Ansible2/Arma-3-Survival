class OPCAN_CGC_faction
{
	displayName = "OPCAN - Colonial Guard Corps";
	infantry[] = {
		"LM_OPCAN_CGC_SL_WDL",
		"LM_OPCAN_CGC_AutoRifleman_WDL",
		"LM_OPCAN_CGC_Breacher_WDL",
		"LM_OPCAN_CGC_Medic_WDL",
		"LM_OPCAN_CGC_GL_WDL",
		"LM_OPCAN_CGC_Marksman_WDL",
		"LM_OPCAN_CGC_Officer_WDL",
		"LM_OPCAN_CGC_Rifleman_WDL",
		"LM_OPCAN_CGC_Rifleman_AT_WDL",
		"LM_OPCAN_CGC_TL_WDL",
		"LM_OPCAN_CGC_RTO_WDL"
	};
	lightCars[] = {
		"LM_OPCAN_HOG_MG_CMA_WDL",
		"LM_OPCAN_HOG_AT_CMA_WDL",
		"LM_OPCAN_HOG_G_CMA_WDL",
		"LM_OPCAN_Meerkat_CGC_HMG"
	};
	heavyCars[] = {
		"LM_OPCAN_ARV_CMA_HMG_WDL",
		"LM_OPCAN_ARV_CMA_GMG_WDL"
	};
	lightArmor[] = {
		"LM_OPCAN_AFV102_AR_WDL",
		"LM_OPCAN_MGS_AR_WDL"
	};
	heavyArmor[] = {
		"LM_OPCAN_M808_AR_WDL"
	};
	transportHelicopters[] = {
		"LM_OPCAN_UH144_CGC"
	};
	casAircraft[] = {
		"B_Plane_Fighter_01_F",
		"B_Plane_CAS_01_dynamicLoadout_F"
	};
	attackHelicopters[] = {
		"LM_OPCAN_UH101_CGC"
	};
};

class OPCAN_UNSC_ARMY_D_faction
{
	displayName = "OPCAN - UNSC Army Desert";
	
	infantry[] = {
		"LM_OPCAN_UNSCA_Assaultman_DES",
		"LM_OPCAN_UNSCA_AutoRifleman_DES",
		"LM_OPCAN_UNSCA_Breacher_DES",
		"LM_OPCAN_UNSCA_Engineer_DES",
		"LM_OPCAN_UNSCA_GL_DES",
		"LM_OPCAN_UNSCA_Marksman_DES",
		"LM_OPCAN_UNSCA_Medic_DES",
		"LM_OPCAN_UNSCA_Officer_DES",
		"LM_OPCAN_UNSCA_Rifleman_DES",
		"LM_OPCAN_UNSCA_Rifleman_AT_DES",
		"LM_OPCAN_UNSCA_RTO_DES",
		"LM_OPCAN_UNSCA_SL_DES",
		"LM_OPCAN_UNSCA_TL_DES",
		"LM_OPCAN_UNSCA_Assaultman_DES"
	};
	lightCars[] = {
		"LM_OPCAN_HOG_MG_AR_DES",
		"LM_OPCAN_HOG_G_AR_DES"
	};
	heavyCars[] = {
		"LM_OPCAN_ARV_AR_HMG_DES",
		"LM_OPCAN_ARV_AR_GMG_DES"
	};
	lightArmor[] = {
		"LM_OPCAN_AFV102_AR_DES",
		"LM_OPCAN_MGS_AR_DES"
	};
	heavyArmor[] = {
		"LM_OPCAN_M808_AR_DES"
	};
	transportHelicopters[] = {
		"LM_OPCAN_UH144_AR_D",
		"LM_OPCAN_AV14_AR_D"
	};
	casAircraft[] = {
		"B_Plane_Fighter_01_F",
		"B_Plane_CAS_01_dynamicLoadout_F"
	};
};

class OPCAN_UNSC_ARMY_WDL_faction : OPCAN_CGC_faction
{
	displayName = "OPCAN - UNSC Army Woodland";

	lightCars[] = {
		"LM_OPCAN_HOG_G_AR_WDL",
		"LM_OPCAN_HOG_MG_AR_WDL"
	};
	heavyCars[] = {
		"LM_OPCAN_ARV_AR_HMG_WDL",
		"LM_OPCAN_ARV_AR_GMG_WDL"
	};
	transportHelicopters[] = {
		"LM_OPCAN_AV14_AR",
		"LM_OPCAN_UH144_AR"
	};
	infantry[] = {
		"LM_OPCAN_UNSCA_Assaultman_WDL",
		"LM_OPCAN_UNSCA_AutoRifleman_WDL",
		"LM_OPCAN_UNSCA_Breacher_WDL",
		"LM_OPCAN_UNSCA_Engineer_WDL",
		"LM_OPCAN_UNSCA_GL_WDL",
		"LM_OPCAN_UNSCA_Marksman_WDL",
		"LM_OPCAN_UNSCA_Medic_WDL",
		"LM_OPCAN_UNSCA_Officer_WDL",
		"LM_OPCAN_UNSCA_Rifleman_WDL",
		"LM_OPCAN_UNSCA_Rifleman_AT_WDL",
		"LM_OPCAN_UNSCA_RTO_WDL",
		"LM_OPCAN_UNSCA_SL_WDL",
		"LM_OPCAN_UNSCA_TL_WDL"
	};
};

class OPCAN_UNSC_ARMY_MIXED_faction : OPCAN_UNSC_ARMY_WDL_faction
{
	displayName = "OPCAN - UNSC Army Mixed";

	infantry[] = {
		"LM_OPCAN_UNSCA_Assaultman_MIX",
		"LM_OPCAN_UNSCA_AutoRifleman_MIX",
		"LM_OPCAN_UNSCA_Breacher_MIX",
		"LM_OPCAN_UNSCA_Engineer_MIX",
		"LM_OPCAN_UNSCA_GL_MIX",
		"LM_OPCAN_UNSCA_Marksman_MIX",
		"LM_OPCAN_UNSCA_Medic_MIX",
		"LM_OPCAN_UNSCA_Officer_MIX",
		"LM_OPCAN_UNSCA_Rifleman_MIX",
		"LM_OPCAN_UNSCA_Rifleman_AT_MIX",
		"LM_OPCAN_UNSCA_RTO_MIX",
		"LM_OPCAN_UNSCA_Sniper_MIX",
		"LM_OPCAN_UNSCA_SL_MIX",
		"LM_OPCAN_UNSCA_TL_MIX"
	};
};


class OPCAN_UNSC_MARINE_WDL_faction
{
	displayName = "OPCAN - UNSC Marine CE-A";

	lightCars[] = {
		"LM_OPCAN_HOG_G_MC_WDL",
		"LM_OPCAN_HOG_AT_MC_WDL",
		"LM_OPCAN_HOG_MG_MC_WDL"
	};
	heavyCars[] = {
		"LM_OPCAN_ARV_MC_HMG_WDL",
		"LM_OPCAN_ARV_MC_GMG_WDL"
	};
	lightArmor[] = {
		"LM_OPCAN_AFV102_MC_WDL",
		"LM_OPCAN_MGS_MC_WDL"
	};
	heavyArmor[] = {
		"LM_OPCAN_M808_MC_WDL"
	};
	transportHelicopters[] = {
		"LM_OPCAN_AV14_MC",
		"LM_OPCAN_UH144_MC"
	};
	casAircraft[] = {
		"B_Plane_Fighter_01_F",
		"B_Plane_CAS_01_dynamicLoadout_F"
	};
	infantry[] = {
		"LM_OPCAN_UNSCMC_Assaultman_WDL",
		"LM_OPCAN_UNSCMC_AutoRifleman_WDL",
		"LM_OPCAN_UNSCMC_Marksman_WDL",
		"LM_OPCAN_UNSCMC_Breacher_WDL",
		"LM_OPCAN_UNSCMC_Medic_WDL",
		"LM_OPCAN_UNSCMC_Engineer_WDL",
		"LM_OPCAN_UNSCMC_GL_WDL",
		"LM_OPCAN_UNSCMC_Officer_WDL",
		"LM_OPCAN_UNSCMC_Rifleman_WDL",
		"LM_OPCAN_UNSCMC_Rifleman_AT_WDL",
		"LM_OPCAN_UNSCMC_RTO_WDL",
		"LM_OPCAN_UNSCMC_SL_WDL",
		"LM_OPCAN_UNSCMC_TL_WDL"
	};
};

class OPCAN_UNSC_MARINE_CEA_faction : OPCAN_UNSC_MARINE_WDL_faction
{
	displayName = "OPCAN - UNSC Marine CE-A";

	infantry[] = {
		"LM_OPCAN_UNSCMC_AutoRifleman_CEA",
		"LM_OPCAN_UNSCMC_Marksman_CEA",
		"LM_OPCAN_UNSCMC_CEAeacher_CEA",
		"LM_OPCAN_UNSCMC_Medic_CEA",
		"LM_OPCAN_UNSCMC_Engineer_CEA",
		"LM_OPCAN_UNSCMC_GL_CEA",
		"LM_OPCAN_UNSCMC_Officer_CEA",
		"LM_OPCAN_UNSCMC_Rifleman_CEA",
		"LM_OPCAN_UNSCMC_Rifleman_AT_CEA",
		"LM_OPCAN_UNSCMC_RTO_CEA",
		"LM_OPCAN_UNSCMC_SL_CEA",
		"LM_OPCAN_UNSCMC_TL_CEA",
		"LM_OPCAN_UNSCMC_Assaultman_CEA"
	};
};

class OPCAN_UNSC_MARINE_DES_faction : OPCAN_UNSC_MARINE_WDL_faction
{
	displayName = "OPCAN - UNSC Marine Desert";

	infantry[] = {
		"LM_OPCAN_UNSCMC_AutoRifleman_DES",
		"LM_OPCAN_UNSCMC_Marksman_DES",
		"LM_OPCAN_UNSCMC_Breacher_DES",
		"LM_OPCAN_UNSCMC_Medic_DES",
		"LM_OPCAN_UNSCMC_Engineer_DES",
		"LM_OPCAN_UNSCMC_GL_DES",
		"LM_OPCAN_UNSCMC_Officer_DES",
		"LM_OPCAN_UNSCMC_Rifleman_DES",
		"LM_OPCAN_UNSCMC_Rifleman_AT_DES",
		"LM_OPCAN_UNSCMC_RTO_DES",
		"LM_OPCAN_UNSCMC_SL_DES",
		"LM_OPCAN_UNSCMC_TL_DES",
		"LM_OPCAN_UNSCMC_Assaultman_DES"
	};
};

class OPCAN_UNSC_MARINE_INF_faction : OPCAN_UNSC_MARINE_WDL_faction
{
	displayName = "OPCAN - UNSC Marine Infinite";

	infantry[] = {
		"LM_OPCAN_UNSCMC_AutoRifleman_INF",
		"LM_OPCAN_UNSCMC_Marksman_INF",
		"LM_OPCAN_UNSCMC_Breacher_INF",
		"LM_OPCAN_UNSCMC_GL_INF",
		"LM_OPCAN_UNSCMC_Medic_INF",
		"LM_OPCAN_UNSCMC_Engineer_INF",
		"LM_OPCAN_UNSCMC_Officer_INF",
		"LM_OPCAN_UNSCMC_Rifleman_INF",
		"LM_OPCAN_UNSCMC_Rifleman_AT_INF",
		"LM_OPCAN_UNSCMC_RTO_INF",
		"LM_OPCAN_UNSCMC_SL_INF",
		"LM_OPCAN_UNSCMC_TL_INF",
		"LM_OPCAN_UNSCMC_Assaultman_INF"
	};
};

class OPCAN_URA_faction : CSAT_pacific_faction
{
	displayName = "OPCAN - United Rebel Army";

	lightCars[] = {
		"OPTRE_M12_LRV_ins",
		"OPTRE_M12A1_LRV_ins",
		"LM_OPCAN_Meerkat_KOS_HMG"
	};
	heavyCars[] = {
		"LM_OPCAN_ARV_CMA_HMG_WDL"
	};
	lightArmor[] = {
		"I_E_APC_tracked_03_cannon_F"
	};
	heavyArmor[] = {
		"LM_OPCAN_M350_INS_WDL",
		"LM_OPCAN_MBTB_KOS"
	};
	transportHelicopters[] = {
		"OPTRE_UNSC_hornet_ins",
		"OPTRE_UNSC_falcon_black"
	};
	attackHelicopters[] = {
		"LM_OPCAN_UH101_FRI",
		"LM_OPCAN_AV92_KOS"
	};
	infantry[] = {
		"LM_OPCAN_URA_AutoRifleman",
		"LM_OPCAN_URA_Breacher",
		"LM_OPCAN_URA_Medic",
		"LM_OPCAN_URA_Engineer",
		"LM_OPCAN_URA_GL",
		"LM_OPCAN_URA_Marksman",
		"LM_OPCAN_URA_Officer",
		"LM_OPCAN_URA_Rifleman",
		"LM_OPCAN_URA_Rifleman_AT",
		"LM_OPCAN_URA_RTO",
		"LM_OPCAN_URA_SL",
		"LM_OPCAN_URA_TL"
	};
};

class OPCAN_SU_faction : OPCAN_URA_faction
{
	displayName = "OPCAN - Secessionist Union";
	lightCars[] = {
		"LM_OPCAN_Rake_SU_HMG",
		"OPTRE_M12_LRV_ins",
		"OPTRE_M12A1_LRV_ins",
		"LM_OPCAN_Meerkat_KOS_HMG"
	};
	lightArmor[] = {
		"LM_OPCAN_Fox_SU",
		"LM_OPCAN_MGS_SU"
	};
	attackHelicopters[] = {
		"LM_OPCAN_UH101_SU",
		"LM_OPCAN_AV92_KOS"
	};
	infantry[] = {
		"LM_OPCAN_SU_AutoRifleman",
		"LM_OPCAN_SU_Medic",
		"LM_OPCAN_SU_Engineer",
		"LM_OPCAN_SU_GL",
		"LM_OPCAN_SU_Marksman",
		"LM_OPCAN_SU_Officer",
		"LM_OPCAN_SU_Rifleman",
		"LM_OPCAN_SU_Rifleman_AT",
		"LM_OPCAN_SU_RTO",
		"LM_OPCAN_SU_SL",
		"LM_OPCAN_SU_TL",
		"LM_OPCAN_SU_Breacher"
	};
};

class OPCAN_KOSLOVICS_faction : OPCAN_URA_faction
{
	displayName = "OPCAN - Koslovics";

	infantry[] = {
		"LM_OPCAN_SU_AutoRifleman",
		"LM_OPCAN_SU_Medic",
		"LM_OPCAN_SU_Engineer",
		"LM_OPCAN_SU_GL",
		"LM_OPCAN_SU_Marksman",
		"LM_OPCAN_SU_Officer",
		"LM_OPCAN_SU_Rifleman",
		"LM_OPCAN_SU_Rifleman_AT",
		"LM_OPCAN_SU_RTO",
		"LM_OPCAN_SU_SL",
		"LM_OPCAN_SU_TL",
		"LM_OPCAN_SU_Breacher"
	};
};

class OPCAN_FRIDENS_faction : OPCAN_URA_faction
{
	displayName = "OPCAN - Fridens";

	lightCars[] = {
		"OPTRE_M12_LRV_ins",
		"OPTRE_M12A1_LRV_ins",
		"LM_OPCAN_Meerkat_KOS_HMG",
		"LM_OPCAN_Rake_FRI_HMG"
	};
	heavyArmor[] = {
		"LM_OPCAN_M350_FRI",
		"LM_OPCAN_MBTB_KOS"
	};
	infantry[] = {
		"LM_OPCAN_FRI_AutoRifleman",
		"LM_OPCAN_FRI_Breacher",
		"LM_OPCAN_FRI_Medic",
		"LM_OPCAN_FRI_Engineer",
		"LM_OPCAN_FRI_GL",
		"LM_OPCAN_FRI_Marksman",
		"LM_OPCAN_FRI_Officer",
		"LM_OPCAN_FRI_Rifleman",
		"LM_OPCAN_FRI_Rifleman_AT",
		"LM_OPCAN_FRI_RTO",
		"LM_OPCAN_FRI_SL",
		"LM_OPCAN_FRI_TL"
	};	
};

class OPCAN_FRIDENS_WDL_faction : OPCAN_FRIDENS_faction
{
	displayName = "OPCAN - Fridens Woodland";

	infantry[] = {
		"LM_OPCAN_FRI_Breacher_WDL",
		"LM_OPCAN_FRI_Medic_WDL",
		"LM_OPCAN_FRI_Engineer_WDL",
		"LM_OPCAN_FRI_GL_WDL",
		"LM_OPCAN_FRI_Marksman_WDL",
		"LM_OPCAN_FRI_Officer_WDL",
		"LM_OPCAN_FRI_Rifleman_WDL",
		"LM_OPCAN_FRI_Rifleman_AT_WDL",
		"LM_OPCAN_FRI_RTO_WDL",
		"LM_OPCAN_FRI_SL_WDL",
		"LM_OPCAN_FRI_TL_WDL",
		"LM_OPCAN_FRI_AutoRifleman_WDL"
	};
};

class OPCAN_FRIDENS_DES_faction : OPCAN_FRIDENS_faction
{
	displayName = "OPCAN - Fridens Desert";

	infantry[] = {
		"LM_OPCAN_FRI_AutoRifleman_DES",
		"LM_OPCAN_FRI_Breacher_DES",
		"LM_OPCAN_FRI_Medic_DES",
		"LM_OPCAN_FRI_Crewman_DES",
		"LM_OPCAN_FRI_Engineer_DES",
		"LM_OPCAN_FRI_GL_DES",
		"LM_OPCAN_FRI_Marksman_DES",
		"LM_OPCAN_FRI_Officer_DES",
		"LM_OPCAN_FRI_Rifleman_DES",
		"LM_OPCAN_FRI_Rifleman_AT_DES",
		"LM_OPCAN_FRI_RTO_DES",
		"LM_OPCAN_FRI_SL_DES",
		"LM_OPCAN_FRI_TL_DES"
	};
};

class OPCAN_CMA_faction : OPCAN_CGC_faction
{
	displayName = "OPCAN - Colonial Military Authority";

	infantry[] = {
		"LM_OPCAN_CMA_AutoRifleman",
		"LM_OPCAN_CMA_Breacher",
		"LM_OPCAN_CMA_Medic",
		"LM_OPCAN_CMA_Engineer",
		"LM_OPCAN_CMA_GL",
		"LM_OPCAN_CMA_Marksman",
		"LM_OPCAN_CMA_Officer",
		"LM_OPCAN_CMA_Rifleman",
		"LM_OPCAN_CMA_Rifleman_AT",
		"LM_OPCAN_CMA_RTO",
		"LM_OPCAN_CMA_SL",
		"LM_OPCAN_CMA_TL"
	};
};

class OPCAN_CPF_faction : OPCAN_CMA_faction
{
	displayName = "OPCAN - Colonial Police Force";

	infantry[] = {
		"LM_OPCAN_CPD_Breacher",
		"LM_OPCAN_CPD_Commissioner",
		"LM_OPCAN_CPD_Marksman",
		"LM_OPCAN_CPD_Officer_SWAT",
		"LM_OPCAN_CPD_Officer_M45",
		"LM_OPCAN_CPD_Officer_SMG",
		"LM_OPCAN_CPD_TL"
	};
};