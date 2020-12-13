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