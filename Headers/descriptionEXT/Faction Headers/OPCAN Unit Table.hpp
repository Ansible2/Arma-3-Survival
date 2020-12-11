class OPCAN_CGC_faction
{
	displayName = "OPCAN - Colonial Guard Corps";
	infantry[] = {
		"LM_OPCAN_CGC_SL_WDL", \
		"LM_OPCAN_CGC_AutoRifleman_WDL", \
		"LM_OPCAN_CGC_Breacher_WDL", \
		"LM_OPCAN_CGC_Medic_WDL", \
		"LM_OPCAN_CGC_GL_WDL", \
		"LM_OPCAN_CGC_Marksman_WDL", \
		"LM_OPCAN_CGC_Officer_WDL", \
		"LM_OPCAN_CGC_Rifleman_WDL", \
		"LM_OPCAN_CGC_Rifleman_AT_WDL", \
		"LM_OPCAN_CGC_TL_WDL", \
		"LM_OPCAN_CGC_RTO_WDL" \
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
		"LM_OPCAN_UNSCA_Assaultman_DES", \
		"LM_OPCAN_UNSCA_AutoRifleman_DES", \
		"LM_OPCAN_UNSCA_Breacher_DES", \
		"LM_OPCAN_UNSCA_Engineer_DES", \
		"LM_OPCAN_UNSCA_GL_DES", \
		"LM_OPCAN_UNSCA_Marksman_DES", \
		"LM_OPCAN_UNSCA_Medic_DES", \
		"LM_OPCAN_UNSCA_Officer_DES", \
		"LM_OPCAN_UNSCA_Rifleman_DES", \
		"LM_OPCAN_UNSCA_Rifleman_AT_DES", \
		"LM_OPCAN_UNSCA_RTO_DES", \
		"LM_OPCAN_UNSCA_SL_DES", \
		"LM_OPCAN_UNSCA_TL_DES", \
		"LM_OPCAN_UNSCA_Assaultman_DES" \
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
		"LM_OPCAN_UNSCA_Assaultman_WDL", \
		"LM_OPCAN_UNSCA_AutoRifleman_WDL", \
		"LM_OPCAN_UNSCA_Breacher_WDL", \
		"LM_OPCAN_UNSCA_Engineer_WDL", \
		"LM_OPCAN_UNSCA_GL_WDL", \
		"LM_OPCAN_UNSCA_Marksman_WDL", \
		"LM_OPCAN_UNSCA_Medic_WDL", \
		"LM_OPCAN_UNSCA_Officer_WDL", \
		"LM_OPCAN_UNSCA_Rifleman_WDL", \
		"LM_OPCAN_UNSCA_Rifleman_AT_WDL", \
		"LM_OPCAN_UNSCA_RTO_WDL", \
		"LM_OPCAN_UNSCA_SL_WDL", \
		"LM_OPCAN_UNSCA_TL_WDL" \
	};
};