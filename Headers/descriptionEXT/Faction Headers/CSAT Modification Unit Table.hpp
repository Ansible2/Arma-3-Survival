/*
class TEC_Iran_Arid_faction
{
	displayName = "CSAT Modification Project - Iran Arid"
	
	lightCars[] = {

	};
	heavyCars[] = {

	};
	lightArmor[] = {

	};
	heavyArmor[] = {

	};
	transportHelicopters[] = {

	};
	cargoAircraft[] = {

	};
	casAircraft[] = {

	};
	attackHelicopters[] = {

	};
	infantry[] = {

	};
};
*/

class TEC_Iran_Arid_faction
{
	displayName = "CSAT Modification Project - Iran Arid";

	lightCars[] = {
		"TEC_VH_LSV_Qilin_Armed",
		"TEC_VH_Truck_Zamak_HMG",
		"TEC_VH_Truck_Zamak_Covered_HMG",
		"TEC_VH_Truck_Zamak_Covered_GMG"
	};
	heavyCars[] = {
		"TEC_VH_MRAP_Abda_GMG",
		"TEC_VH_MRAP_Abda_HMG",
		"TEC_VH_MRAP_Shir_GMG",
		"TEC_VH_MRAP_Shir_HMG"
	};
	lightArmor[] = {
		"TEC_VH_APC_Kamysh_F",
		"TEC_VH_APC_Marid_F"
	};
	heavyArmor[] = {
		"TEC_VH_Tank_Varsuk_F",
		"TEC_VH_Tank_Angara",
		"TEC_VH_Tank_Angara_Command"
	};
	transportHelicopters[] = {
		"TEC_VH_Helicopter_Orca_F",
		"TEC_VH_Helicopter_Taru_Transport_F"
	};
	cargoAircraft[] = {
		"TEC_VH_Plane_Ruk_F",
		"TEC_VH_VTOL_Xian_Infantry"
	};
	casAircraft[] = {
		"TEC_VH_Jet_Neophron_F",
		"TEC_VH_Jet_Shikra",
		"TEC_VH_Plane_Shahan_F"
	};
	attackHelicopters[] = {
		"TEC_VH_Helicopter_Kajman_F",
		"TEC_VH_VTOL_Xian_Infantry"
	};
	infantry[] = {
		"TEC_O_Soldier_A_F",
		"TEC_O_Soldier_AR_F",
		"TEC_O_Soldier_CS_F",
		"TEC_O_Medic_F",
		"TEC_O_Engineer_F",
		"TEC_O_Soldier_EW_F",
		"TEC_O_Soldier_EXP_F",
		"TEC_O_Soldier_GL_F",
		"TEC_O_Soldier_HG_F",
		"TEC_O_Soldier_M_F",
		"TEC_O_Soldier_AA_F",
		"TEC_O_Soldier_AT_F",
		"TEC_O_Officer_F",
		"TEC_O_Officer_C_F",
		"TEC_O_Soldier_Light_F",
		"TEC_O_Soldier_SMG_F",
		"TEC_O_Soldier_SS_F",
		"TEC_O_Soldier_SL_F",
		"TEC_O_Recon_EXP_F",
		"TEC_O_Soldier_Mine_F",
		"TEC_O_Soldier_RTO_F",
		"TEC_O_Soldier_Repair_F",
		"TEC_O_Soldier_F",
		"TEC_O_Soldier_LAT_F",
		"TEC_O_Soldier_HAT_F",
		"TEC_O_Soldier_TL_F",
		"TEC_O_Soldier_Patrol_F",
		"TEC_O_Recon_Engineer_F",
		"TEC_O_Recon_JTAC_F",
		"TEC_O_Recon_Medic_F",
		"TEC_O_Recon_PT_F",
		"TEC_O_Recon_F",
		"TEC_O_Recon_LAT_F",
		"TEC_O_Recon_SMG_F",
		"TEC_O_Recon_TL_F",
		"TEC_O_Soldier_AAR_F",
		"TEC_O_Support_Asst_F",
		"TEC_O_Support_Mortar_Asst_F",
		"TEC_O_Soldier_AHAT_Arid_F",
		"TEC_O_Soldier_AAA_F",
		"TEC_O_Soldier_AAT_F",
		"TEC_O_Support_SV_F",
		"TEC_O_Support_HMG_F",
		"TEC_O_Support_AHMG_F",
		"TEC_O_Support_GMG_F",
		"TEC_O_Support_AGMG_F",
		"TEC_O_Support_Mortar_F",
		"TEC_O_Support_SAA_F",
		"TEC_O_Support_SAT_F"
	};
};

class TEC_Iran_arid_CBRN_faction : TEC_Iran_Arid_faction
{
	displayName = "CSAT Modification Project - Iran Arid (CBRN)";

	infantry[] = {
		"TEC_O_Soldier_CBRN_A_F",
		"TEC_O_Soldier_CBRN_AR_F",
		"TEC_O_Soldier_CBRN_CS_F",
		"TEC_O_Medic_CBRN_F",
		"TEC_O_Crew_CBRN_F",
		"TEC_O_Engineer_CBRN_F",
		"TEC_O_Soldier_CBRN_EW_F",
		"TEC_O_Soldier_CBRN_EXP_F",
		"TEC_O_Soldier_CBRN_GL_F",
		"TEC_O_Soldier_CBRN_HG_F",
		"TEC_O_Soldier_CBRN_M_F",
		"TEC_O_Soldier_CBRN_Mine_F",
		"TEC_O_Soldier_CBRN_AA_F",
		"TEC_O_Soldier_CBRN_AT_F",
		"TEC_O_Officer_CBRN_F",
		"TEC_O_Officer_CBRN_C_F",
		"TEC_O_Soldier_CBRN_RTO_F",
		"TEC_O_Soldier_CBRN_Repair_F",
		"TEC_O_Soldier_CBRN_F",
		"TEC_O_Soldier_CBRN_LAT_F",
		"TEC_O_Soldier_CBRN_HAT_F",
		"TEC_O_Soldier_CBRN_Light_F",
		"TEC_O_Soldier_CBRN_Patrol_F",
		"TEC_O_Soldier_CBRN_SMG_F",
		"TEC_O_Soldier_CBRN_SS_F",
		"TEC_O_Soldier_CBRN_SL_F",
		"TEC_O_Soldier_CBRN_TL_F"
	};
};

class TEC_Iran_Semiarid_faction : TEC_Iran_Arid_faction
{
	displayName = "CSAT Modification Project - Iran Semiarid";

	infantry[] = {
		"TEC_O_Soldier_Semiarid_A_F",
		"TEC_O_Soldier_Semiarid_AR_F",
		"TEC_O_Soldier_Semiarid_CS_F",
		"TEC_O_Medic_Semiarid_F",
		"TEC_O_Engineer_Semiarid_F",
		"TEC_O_Soldier_Semiarid_EW_F",
		"TEC_O_Soldier_Semiarid_EXP_F",
		"TEC_O_Soldier_Semiarid_GL_F",
		"TEC_O_Soldier_Semiarid_HG_F",
		"TEC_O_Soldier_Semiarid_M_F",
		"TEC_O_Soldier_Semiarid_Mine_F",
		"TEC_O_Soldier_Semiarid_AA_F",
		"TEC_O_Soldier_Semiarid_AT_F",
		"TEC_O_Officer_Semiarid_F",
		"TEC_O_Officer_Semiarid_C_F",
		"TEC_O_Soldier_Semiarid_RTO_F",
		"TEC_O_Soldier_Semiarid_Repair_F",
		"TEC_O_Soldier_Semiarid_F",
		"TEC_O_Soldier_Semiarid_LAT_F",
		"TEC_O_Soldier_Semiarid_HAT_F",
		"TEC_O_Soldier_Semiarid_Light_F",
		"TEC_O_Soldier_Semiarid_Patrol_F",
		"TEC_O_Soldier_Semiarid_SMG_F",
		"TEC_O_Soldier_Semiarid_SS_F",
		"TEC_O_Soldier_Semiarid_SL_F",
		"TEC_O_Soldier_Semiarid_TL_F"
	};
};

class TEC_Iran_urban_faction : TEC_Iran_Arid_faction
{
	displayName = "CSAT Modification Project - Iran Urban";

	transportHelicopters[] = {
		"TEC_VH_Helicopter_Taru_Transport_SOF_F",
		"TEC_VH_Helicopter_Orca_SOF_F"
	};
	attackHelicopters[] = {
		"TEC_VH_Helicopter_Kajman_SOF_F",
		"TEC_VH_Navy_VTOL_Xian_Infantry"
	};
	cargoAircraft = {
		"TEC_VH_Plane_Ruk_F",
		"TEC_VH_Navy_VTOL_Xian_Infantry"
	};
	infantry[] = {
		"TEC_O_Soldier_Urban_A_F",
		"TEC_O_Soldier_Urban_AR_F",
		"TEC_O_Soldier_Urban_CS_F",
		"TEC_O_Medic_Urban_F",
		"TEC_O_Soldier_Urban_EW_F",
		"TEC_O_Soldier_Urban_EXP_F",
		"TEC_O_Soldier_Urban_GL_F",
		"TEC_O_Soldier_Urban_HG_F",
		"TEC_O_Soldier_Urban_M_F",
		"TEC_O_Soldier_Urban_Mine_F",
		"TEC_O_Soldier_Urban_AA_F",
		"TEC_O_Soldier_Urban_AT_F",
		"TEC_O_Officer_Urban_F",
		"TEC_O_Officer_Urban_C_F",
		"TEC_O_Soldier_Urban_RTO_F",
		"TEC_O_Soldier_Urban_Repair_F",
		"TEC_O_Soldier_Urban_F",
		"TEC_O_Soldier_Urban_LAT_F",
		"TEC_O_Soldier_Urban_HAT_F",
		"TEC_O_Soldier_Urban_Light_F",
		"TEC_O_Soldier_Urban_Patrol_F",
		"TEC_O_Soldier_Urban_SMG_F",
		"TEC_O_Soldier_Urban_SS_F",
		"TEC_O_Soldier_Urban_SL_F",
		"TEC_O_Soldier_Urban_TL_F",
		"TEC_O_Engineer_Urban_F"
	};
};

class TEC_Iran_SF_Arid_faction : TEC_Iran_Arid_faction
{
	displayName = "CSAT Modification Project - Iran Special Forces (Arid)";

	infantry[] = {
		"TEC_O_SOF_Medic_F",
		"TEC_O_SOF_EXP_F",
		"TEC_O_SOF_Engineer_F",
		"TEC_O_SOF_F",
		"TEC_O_SOF_SS_F",
		"TEC_O_SOF_HG_F",
		"TEC_O_SOF_M_F",
		"TEC_O_SOF_LAT_F",
		"TEC_O_SOF_SMG_F",
		"TEC_O_SOF_AR_F",
		"TEC_O_SOF_TL_F",
		"TEC_O_Sniper_Arid_F",
		"TEC_O_Sniper_Scout_F",
		"TEC_O_Spotter_F",
		"TEC_O_Spotter_Scout_F"
	};
};

class TEC_Iran_Viper_Arid_faction : TEC_Iran_Arid_faction
{
	displayName = "CSAT Modification Project - Iran Viper (Arid)";

	infantry[] = {
		"TEC_O_Viper_EXP_F",
		"TEC_O_Viper_JTAC_F",
		"TEC_O_Viper_M_F",
		"TEC_O_Viper_F",
		"TEC_O_Viper_LAT_F",
		"TEC_O_Viper_Medic_F",
		"TEC_O_Viper_TL_F",
		"TEC_O_Viper_Spotter_F",
		"TEC_O_Viper_Sniper_F"
	};
};