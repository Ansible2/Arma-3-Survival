class PROJOP_AFRICAN_MILITIA_faction : RHSGREF_TLA_faction
{
	displayName = "PROJECT OPFOR - African Militia";

	lightCars[] = {
		"LOP_AFR_OPF_Landrover_M2",
		"LOP_AFR_OPF_Nissan_PKM"
	};
	heavyCars[] = {
		// empty
	};
	lightArmor[] = {
		"LOP_AFR_OPF_BTR60",
		"LOP_AFR_OPF_M113_W"
	};
	heavyArmor[] = {
		"LOP_AFR_OPF_T34",
		"LOP_AFR_OPF_T55",
		"LOP_AFR_OPF_T72BA",
		"LOP_AFR_OPF_T72BB"
	};
	cargoAircraft[] = {
		"RHS_AN2_B"
	};
	casAircraft[] = {
		"RHSGREF_A29B_HIDF"
	};
	infantry[] = {
		"LOP_AFR_OPF_Infantry_IED",
		"LOP_AFR_OPF_Infantry_Corpsman",
		"LOP_AFR_OPF_Infantry_GL",
		"LOP_AFR_OPF_Infantry_Rifleman_4",
		"LOP_AFR_OPF_Infantry_Rifleman",
		"LOP_AFR_OPF_Infantry_Rifleman_5",
		"LOP_AFR_OPF_Infantry_Rifleman_2",
		"LOP_AFR_OPF_Infantry_Rifleman_7",
		"LOP_AFR_OPF_Infantry_AR_2",
		"LOP_AFR_OPF_Infantry_Rifleman_8",
		"LOP_AFR_OPF_Infantry_AR",
		"LOP_AFR_OPF_Infantry_AT",
		"LOP_AFR_OPF_Infantry_Marksman",
		"LOP_AFR_OPF_Infantry_Rifleman_6",
		"LOP_AFR_OPF_Infantry_AR_Asst_2",
		"LOP_AFR_OPF_Infantry_AR_Asst",
		"LOP_AFR_OPF_Infantry_Driver",
		"LOP_AFR_OPF_Infantry_SL"		
	};
};

class PROJOP_BOKO_HAREM_faction : PROJOP_AFRICAN_MILITIA_faction
{
	displayName = "PROJECT OPFOR - Boko Harem";

	infantry[] = {
		"LOP_BH_Infantry_IED",
		"LOP_BH_Infantry_Corpsman",
		"LOP_BH_Infantry_TL",
		"LOP_BH_Infantry_Driver",
		"LOP_BH_Infantry_GL",
		"LOP_BH_Infantry_AR_2",
		"LOP_BH_Infantry_AR",
		"LOP_BH_Infantry_AR_Asst_2",
		"LOP_BH_Infantry_AR_Asst",
		"LOP_BH_Infantry_Rifleman",
		"LOP_BH_Infantry_Rifleman_lite",
		"LOP_BH_Infantry_AT",
		"LOP_BH_Infantry_Marksman",
		"LOP_BH_Infantry_SL"		
	};
};

class PROJOP_CHDKZ_faction : RHSGREF_CHDKZ
{
	displayName = "PROJECT OPFOR - ChDKZ";

	lightArmor[] = {
		"LOP_ChDKZ_BMP2D",
		"LOP_ChDKZ_BMP2",
		"LOP_ChDKZ_BMP1D",
		"LOP_ChDKZ_BMP1",
		"LOP_ChDKZ_BTR60",
		"LOP_ChDKZ_BTR70"
	};
	infantry[] = {
		"LOP_ChDKZ_Infantry_Bardak",
		"LOP_ChDKZ_Infantry_Corpsman",
		"LOP_ChDKZ_Infantry_Engineer",
		"LOP_ChDKZ_Infantry_GL",
		"LOP_ChDKZ_Infantry_AT",
		"LOP_ChDKZ_Infantry_MG",
		"LOP_ChDKZ_Infantry_MG_Asst",
		"LOP_ChDKZ_Infantry_Marksman",
		"LOP_ChDKZ_Infantry_Rifleman",
		"LOP_ChDKZ_Infantry_Rifleman_2",
		"LOP_ChDKZ_Infantry_Rifleman_3",
		"LOP_ChDKZ_Infantry_SL",
		"LOP_ChDKZ_Infantry_TL"
	};
};


class PROJOP_IRA_faction : RHSGREF_CHDKZ
{
	displayName = "PROJECT OPFOR - Irish Republic Army";

	lightCars[] = {
		"LOP_IRA_Landrover_M2",
		"LOP_IRA_Nissan_PKM"
	};
	infantry[] = {
		"LOP_IRA_Infantry_IED",
		"LOP_IRA_Infantry_TL",
		"LOP_IRA_Infantry_Rifleman_PM63",
		"LOP_IRA_Infantry_Rifleman",
		"LOP_IRA_Infantry_Rifleman_lite",
		"LOP_IRA_Infantry_GL",
		"LOP_IRA_Infantry_Corpsman",
		"LOP_IRA_Infantry_AR_Asst",
		"LOP_IRA_Infantry_AR",
		"LOP_IRA_Infantry_AT",
		"LOP_IRA_Infantry_Marksman",
		"LOP_IRA_Infantry_Rifleman_vz58",
		"LOP_IRA_Infantry_Driver",
		"LOP_IRA_Infantry_SL"
	};
};

class PROJOP_ISIS_faction : RHSGREF_CHDKZ
{
	displayName = "PROJECT OPFOR - Islamic State";

	lightCars[] = {
		"LOP_ISTS_OPF_Landrover_M2",
		"LOP_ISTS_OPF_Nissan_PKM",
		"LOP_ISTS_OPF_Offroad_M2"
	};
	heavyCars[] = {
		"LOP_ISTS_OPF_M1025_W_M2",
		"LOP_ISTS_OPF_M1025_W_Mk19"	
	};
	lightArmor[] = {
		"LOP_ISTS_OPF_BTR60",
		"LOP_ISTS_OPF_M113_W",
		"LOP_ISTS_OPF_BMP1",
		"LOP_ISTS_OPF_BMP2"
	};
	heavyArmor[] = {
		"LOP_ISTS_OPF_T34",
		"LOP_ISTS_OPF_T55",
		"LOP_ISTS_OPF_T72BA"
	};
	infantry[] = {
		"LOP_ISTS_OPF_Infantry_Engineer",
		"LOP_ISTS_OPF_Infantry_Corpsman",
		"LOP_ISTS_OPF_Infantry_TL",
		"LOP_ISTS_OPF_Infantry_Rifleman_5",
		"LOP_ISTS_OPF_Infantry_GL",
		"LOP_ISTS_OPF_Infantry_Rifleman_6",
		"LOP_ISTS_OPF_Infantry_Rifleman",
		"LOP_ISTS_OPF_Infantry_Rifleman_4",
		"LOP_ISTS_OPF_Infantry_Rifleman_3",
		"LOP_ISTS_OPF_Infantry_Rifleman_7",
		"LOP_ISTS_OPF_Infantry_AR_Asst_2",
		"LOP_ISTS_OPF_Infantry_AR_2",
		"LOP_ISTS_OPF_Infantry_AR_Asst",
		"LOP_ISTS_OPF_Infantry_AR",
		"LOP_ISTS_OPF_Infantry_Rifleman_9",
		"LOP_ISTS_OPF_Infantry_Marksman",
		"LOP_ISTS_OPF_Infantry_Rifleman_8",
		"LOP_ISTS_OPF_Infantry_AT",
		"LOP_ISTS_OPF_Infantry_SL"
	};
};

class PROJOP_KPA_faction : RHSGREF_CHDKZ
{
	displayName = "PROJECT OPFOR - Korean Peoples Army";


	lightCars[] = {
		"LOP_NK_UAZ_AGS",
		"LOP_NK_UAZ_DshKM"
	};
	heavyCars[] = {
		"rhsgref_BRDM2"
	};
	lightArmor[] = {
		"LOP_NK_BTR60",
		"LOP_NK_BTR80",
		"LOP_NK_BMP1"
	};
	heavyArmor[] = {
		"LOP_NK_T34",
		"LOP_NK_T55",
		"LOP_NK_T72BA",
		"LOP_NK_T72BB"
	};
	infantry[] = {
		"LOP_NK_Infantry_AT_Asst",
		"LOP_NK_Infantry_AT",
		"LOP_NK_Infantry_Corpsman",
		"LOP_NK_Infantry_Engineer",
		"LOP_NK_Infantry_Grenadier",
		"LOP_NK_Infantry_MG",
		"LOP_NK_Infantry_MG_Asst",
		"LOP_NK_Infantry_Marksman",
		"LOP_NK_Infantry_Rifleman",
		"LOP_NK_Infantry_Rifleman_2",
		"LOP_NK_Infantry_SL",
		"LOP_NK_Infantry_TL"
	};
};

class PROJOP_MEM_faction : PROJOP_KPA_faction
{
	displayName = "PROJECT OPFOR - Middle East Militia";

	lightCars[] = {
		"LOP_AM_OPF_Landrover_M2",
		"LOP_AM_OPF_Nissan_PKM",
		"LOP_AM_OPF_UAZ_AGS",
		"LOP_AM_OPF_UAZ_DshKM"
	};
	lightArmor[] = {
		"LOP_AM_OPF_BTR60"
	};
	infantry[] = {
		"LOP_AM_OPF_Infantry_Engineer",
		"LOP_AM_OPF_Infantry_Corpsman",
		"LOP_AM_OPF_Infantry_GL",
		"LOP_AM_OPF_Infantry_Rifleman_6",
		"LOP_AM_OPF_Infantry_Rifleman",
		"LOP_AM_OPF_Infantry_Rifleman_2",
		"LOP_AM_OPF_Infantry_Rifleman_4",
		"LOP_AM_OPF_Infantry_Rifleman_5",
		"LOP_AM_OPF_Infantry_Rifleman_7",
		"LOP_AM_OPF_Infantry_Rifleman_8",
		"LOP_AM_OPF_Infantry_AT",
		"LOP_AM_OPF_Infantry_Marksman",
		"LOP_AM_OPF_Infantry_Rifleman_9",
		"LOP_AM_OPF_Infantry_AR",
		"LOP_AM_OPF_Infantry_AR_Asst",
		"LOP_AM_OPF_Infantry_SL"
	};
};

class PROJOP_SLA_faction : RHSGREF_CDF_faction
{
	displayName = "PROJECT OPFOR - Sahrani Liberation Army";

	lightCars[] = {
		"LOP_SLA_UAZ_AGS",
		"LOP_SLA_UAZ_DshKM"		
	};
	heavyCars[] = {
		"rhsgref_BRDM2_ins"
	};
	lightArmor[] = {
		"LOP_SLA_BTR60",
		"LOP_SLA_BTR70",
		"LOP_SLA_BMP1",
		"LOP_SLA_BMP1D",
		"LOP_SLA_BMP2",
		"LOP_SLA_BMP2D"
	};
	heavyArmor[] = {
		"LOP_SLA_T72BA",
		"LOP_SLA_T72BB"
	};
	transportHelicopters[] = {
		"LOP_SLA_Mi8MTV3_UPK23"
	};
	infantry[] = {
		"LOP_SLA_Infantry_AA",
		"LOP_SLA_Infantry_AT_Asst",
		"LOP_SLA_Infantry_Corpsman",
		"LOP_SLA_Infantry_Engineer",
		"LOP_SLA_Infantry_GL",
		"LOP_SLA_Infantry_AT",
		"LOP_SLA_Infantry_MG",
		"LOP_SLA_Infantry_MG_Asst",
		"LOP_SLA_Infantry_Marksman",
		"LOP_SLA_Infantry_Rifleman",
		"LOP_SLA_Infantry_Rifleman_2",
		"LOP_SLA_Infantry_SL",
		"LOP_SLA_Infantry_TL"
	};
};

class PROJOP_SAF_faction : PROJOP_SLA_faction
{
	displayName = "PROJECT OPFOR - Syrian Armed Forces";

	heavyArmor[] = {
		"LOP_SYR_T55",
		"LOP_SYR_T72BA",
		"LOP_SYR_T72BB"
	};
	infantry[] = {
		"LOP_SYR_Infantry_AT_Asst",
		"LOP_SYR_Infantry_AT",
		"LOP_SYR_Infantry_Corpsman",
		"LOP_SYR_Infantry_Engineer",
		"LOP_SYR_Infantry_Grenadier",
		"LOP_SYR_Infantry_MG",
		"LOP_SYR_Infantry_MG_Asst",
		"LOP_SYR_Infantry_Marksman",
		"LOP_SYR_Infantry_Rifleman",
		"LOP_SYR_Infantry_Rifleman_2",
		"LOP_SYR_Infantry_SL",
		"LOP_SYR_Infantry_TL"		
	};
};

class PROJOP_TAF_faction : PROJOP_SLA_faction
{
	displayName = "PROJECT OPFOR - Takistan Armed Forces";

	lightCars[] = {
		"LOP_TKA_UAZ_AGS",
		"LOP_TKA_UAZ_DshKM"
	};
	lightArmor[] = {
		"LOP_TKA_BTR60",
		"LOP_TKA_BTR70",
		"LOP_TKA_BMP1",
		"LOP_TKA_BMP1D",
		"LOP_TKA_BMP2",
		"LOP_TKA_BMP2D"
	};
	heavyArmor[] = {
		"LOP_TKA_T34",
		"LOP_TKA_T55",
		"LOP_TKA_T72BA",
		"LOP_TKA_T72BB"
	};
	transportHelicopters[] = {
		"LOP_TKA_Mi8MTV3_UPK23"
	};

	infantry[] = {
		"LOP_TKA_Infantry_AA",
		"LOP_TKA_Infantry_Corpsman",
		"LOP_TKA_Infantry_Engineer",
		"LOP_TKA_Infantry_GL",
		"LOP_TKA_Infantry_AT",
		"LOP_TKA_Infantry_AT_Asst",
		"LOP_TKA_Infantry_MG",
		"LOP_TKA_Infantry_MG_Asst",
		"LOP_TKA_Infantry_Marksman",
		"LOP_TKA_Infantry_Rifleman",
		"LOP_TKA_Infantry_Rifleman_2",
		"LOP_TKA_Infantry_Rifleman_3",
		"LOP_TKA_Infantry_SL",
		"LOP_TKA_Infantry_TL"
	};
};

class PROJOP_NAF_faction : PROJOP_TAF_faction
{
	displayName = "PROJECT OPFOR - Novorossiya Armed Forces";

	lightCars[] = {
		"LOP_US_UAZ_AGS",
		"LOP_US_UAZ_DshKM"
	};
	lightArmor[] = {
		"LOP_US_BTR60",
		"LOP_US_BTR70",
		"LOP_US_BMP1",
		"LOP_US_BMP1D",
		"LOP_US_BMP2",
		"LOP_US_BMP2D"
	};
	heavyArmor[] = {
		"LOP_US_T72BA",
		"LOP_US_T72BB",
		"LOP_US_T72BC"
	};
	infantry[] = {
		"LOP_US_Infantry_AA",
		"LOP_US_Infantry_Engineer",
		"LOP_US_Infantry_GL",
		"LOP_US_Infantry_GL_2",
		"LOP_US_Infantry_AT",
		"LOP_US_Infantry_AT_Asst",
		"LOP_US_Infantry_SL",
		"LOP_US_Infantry_MG_3",
		"LOP_US_Infantry_MG",
		"LOP_US_Infantry_MG_2",
		"LOP_US_Infantry_MG_Asst",
		"LOP_US_Infantry_Marksman",
		"LOP_US_Infantry_Corpsman",
		"LOP_US_Infantry_Officer",
		"LOP_US_Infantry_Rifleman",
		"LOP_US_Infantry_Rifleman_2",
		"LOP_US_Infantry_Rifleman_3",
		"LOP_US_Infantry_Rifleman_4",
		"LOP_US_Infantry_TL"
	};
};

