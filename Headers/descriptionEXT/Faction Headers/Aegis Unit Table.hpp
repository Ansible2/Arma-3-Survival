// BAF Bases
class AEGIS_BAF_base : NATO_faction
{
	heavyCars[] = {
		"B_A_MRAP_03_gmg_F",
		"B_A_MRAP_03_hmg_F"
	};
	lightArmor[] = {
		"B_A_APC_tracked_03_cannon_F"
	};
	transportHelicopters[] = {
		"B_A_Heli_Transport_02_F",
		"B_A_Heli_light_03_unarmed_F"
	};
	casAircraft[] = {
		"B_A_Plane_Fighter_05_F",
		"B_A_Plane_Fighter_05_Stealth_F"
	};
	attackHelicopters[] = {
		"B_A_Heli_Attack_01_dynamicLoadout_F"
	};
};
class AEGIS_BAF_pacific_base : NATO_pacific_faction
{
	heavyCars[] = {
		"B_A_MRAP_03_gmg_tna_F",
		"B_A_MRAP_03_hmg_tna_F"
	};
	lightArmor[] = {
		"B_A_APC_tracked_03_cannon_tna_F"
	};
};

// BAF Factions
class AEGIS_BAF_faction : AEGIS_BAF_base
{	
	displayName = "Aegis - British Armed Forces";
	
	infantry[] = {
		"B_A_Soldier_A_F",
		"B_A_Soldier_AAR_F",
		"B_A_Support_AMG_F",
		"B_A_Support_AMort_F",
		"B_A_Soldier_AAA_F",
		"B_A_Soldier_AAT_F",
		"B_A_Soldier_AR_F",
		"B_A_Medic_F",
		"B_A_Engineer_F",
		"B_A_Soldier_Exp_F",
		"B_A_Soldier_GL_F",
		"B_A_Support_GMG_F",
		"B_A_Support_MG_F",
		"B_A_Support_Mort_F",
		"B_A_HeavyGunner_F",
		"B_A_soldier_M_F",
		"B_A_soldier_mine_F",
		"B_A_Soldier_AA_F",
		"B_A_Soldier_AT_F",
		"B_A_RadioOperator_F",
		"B_A_Soldier_Repair_F",
		"B_A_Soldier_F",
		"B_A_Soldier_LAT_F",
		"B_A_Soldier_Lite_F",
		"B_A_Soldier_CQ_F",
		"B_A_Soldier_SL_F",
		"B_A_Soldier_TL_F",
		"B_A_Recon_AR_F",
		"B_A_Recon_Exp_F",
		"B_A_Recon_GL_F",
		"B_A_Recon_MG_F",
		"B_A_Recon_JTAC_F",
		"B_A_Recon_M_F",
		"B_A_Recon_Medic_F",
		"B_A_Recon_F",
		"B_A_Recon_LAT_F",
		"B_A_Recon_CQ_F",
		"B_A_Recon_Sharpshooter_F",
		"B_A_Recon_TL_F",
		"B_A_ghillie_ard_F",
		"B_A_ghillie_spotter_ard_F"		
	};
};

class AEGIS_BAF_pacific_faction : AEGIS_BAF_pacific_base
{
	displayName = "Aegis - British Armed Forces (Pacific)";

	infantry[] = {
		"B_A_Soldier_A_tna_F",
		"B_A_Soldier_AAR_tna_F",
		"B_A_Support_AMG_tna_F",
		"B_A_Support_AMort_tna_F",
		"B_A_Soldier_AAA_tna_F",
		"B_A_Soldier_AAT_tna_F",
		"B_A_Soldier_AR_tna_F",
		"B_A_Medic_tna_F",
		"B_A_Engineer_tna_F",
		"B_A_Soldier_Exp_tna_F",
		"B_A_Soldier_GL_tna_F",
		"B_A_Support_GMG_tna_F",
		"B_A_Support_MG_tna_F",
		"B_A_Support_Mort_tna_F",
		"B_A_HeavyGunner_tna_F",
		"B_A_soldier_M_tna_F",
		"B_A_soldier_mine_tna_F",
		"B_A_Soldier_AA_tna_F",
		"B_A_Soldier_AT_tna_F",
		"B_A_RadioOperator_tna_F",
		"B_A_Soldier_Repair_tna_F",
		"B_A_Soldier_tna_F",
		"B_A_Soldier_LAT_tna_F",
		"B_A_Soldier_Lite_tna_F",
		"B_A_Soldier_CQ_tna_F",
		"B_A_Soldier_SL_tna_F",
		"B_A_Soldier_TL_tna_F",
		"B_A_Recon_AR_tna_F",
		"B_A_Recon_Exp_tna_F",
		"B_A_Recon_GL_tna_F",
		"B_A_Recon_MG_tna_F",
		"B_A_Recon_JTAC_tna_F",
		"B_A_Recon_M_tna_F",
		"B_A_Recon_Medic_tna_F",
		"B_A_Recon_tna_F",
		"B_A_Recon_LAT_tna_F",
		"B_A_Recon_CQ_tna_F",
		"B_A_Recon_Sharpshooter_tna_F",
		"B_A_Recon_TL_tna_F",
		"B_A_ghillie_tna_F",
		"B_A_ghillie_spotter_tna_F"
	};
};

class AEGIS_BAF_woodland_faction : AEGIS_BAF_pacific_base
{
	displayName = "Aegis - British Armed Forces (Woodland)";
	
	infantry[] = {
		"B_A_Soldier_A_wdl_F",
		"B_A_Soldier_AAR_wdl_F",
		"B_A_Support_AMG_wdl_F",
		"B_A_Support_AMort_wdl_F",
		"B_A_Soldier_AAA_wdl_F",
		"B_A_Soldier_AAT_wdl_F",
		"B_A_Soldier_AR_wdl_F",
		"B_A_Medic_wdl_F",
		"B_A_Engineer_wdl_F",
		"B_A_Soldier_Exp_wdl_F",
		"B_A_Soldier_GL_wdl_F",
		"B_A_Support_GMG_wdl_F",
		"B_A_Support_MG_wdl_F",
		"B_A_Support_Mort_wdl_F",
		"B_A_HeavyGunner_wdl_F",
		"B_A_soldier_M_wdl_F",
		"B_A_soldier_mine_wdl_F",
		"B_A_Soldier_AA_wdl_F",
		"B_A_Soldier_AT_wdl_F",
		"B_A_RadioOperator_wdl_F",
		"B_A_Soldier_Repair_wdl_F",
		"B_A_Soldier_wdl_F",
		"B_A_Soldier_LAT_wdl_F",
		"B_A_Soldier_Lite_wdl_F",
		"B_A_Soldier_CQ_wdl_F",
		"B_A_Soldier_SL_wdl_F",
		"B_A_Soldier_TL_wdl_F",
		"B_A_Recon_AR_wdl_F",
		"B_A_Recon_Exp_wdl_F",
		"B_A_Recon_GL_wdl_F",
		"B_A_Recon_MG_wdl_F",
		"B_A_Recon_JTAC_wdl_F",
		"B_A_Recon_M_wdl_F",
		"B_A_Recon_Medic_wdl_F",
		"B_A_Recon_wdl_F",
		"B_A_Recon_LAT_wdl_F",
		"B_A_Recon_CQ_wdl_F",
		"B_A_Recon_Sharpshooter_wdl_F",
		"B_A_Recon_TL_wdl_F",
		"B_A_ghillie_wdl_F",
		"B_A_ghillie_spotter_wdl_F"
	};
};


// CTRG
class AEGIS_CTRG_medit_faction : NATO_faction
{
	displayName = "Aegis - CTRG (Mediterranean)";

	lightCars[] = {
		"B_CTRG_LSV_01_armed_sand_F"
	};
	transportHelicopters[] = {
		"B_CTRG_Heli_Transport_01_sand_F"
	};
};


// CSAT
class AEGIS_Argana_faction : CSAT_faction
{
	displayName = "Aegis - CSAT Argana (Desert)";

	casAircraft[] = {
		"O_A_Plane_Fighter_03_dynamicLoadout_F"
	};
	infantry[] = {
		"O_A_soldier_A_F",
		"O_A_soldier_AR_F",
		"O_A_medic_F",
		"O_A_soldier_TL_F",
		"O_A_engineer_F",
		"O_A_soldier_GL_F",
		"O_A_soldier_M_F",
		"O_A_soldier_AA_F",
		"O_A_soldier_AT_F",
		"O_A_officer_F",
		"O_A_RadioOperator_F",
		"O_A_soldier_F",
		"O_A_soldier_LAT_F",
		"O_A_soldier_SL_F"
	};
};

class AEGIS_China_faction : CSAT_pacific_faction
{
	displayName = "Aegis - China (CSAT Pacific)";

	casAircraft[] = {
		"O_T_Plane_CAS_02_dynamicLoadout_ghex_F",
		"O_T_Plane_Fighter_02_ghex_F",
		"O_T_Plane_Fighter_02_Stealth_ghex_F"
	};
	cargoAircraft[] = {
		"O_T_Plane_Transport_01_infantry_ghex_F"
	};
};

class AEGIS_Iran_faction : CSAT_faction
{
	displayName = "Aegis - Iranian Armed Forces (CSAT Arid)";

	casAircraft[] = {
		"O_Plane_CAS_02_dynamicLoadout_F",
		"O_Plane_Fighter_02_F",
		"O_Plane_Fighter_02_Stealth_F"
	};
	cargoAircraft[] = {
		"O_Plane_Transport_01_infantry_F"
	};
};

class AEGIS_Russia_faction
{
	displayName = "Aegis - Russia";

	lightCars[] = {
		"O_R_LSV_02_armed_F"
	};
	heavyCars[] = {
		"O_R_MRAP_02_gmg_F",
		"O_R_MRAP_02_hmg_F"
	};
	lightArmor[] = {
		"O_R_APC_Tracked_02_cannon_F",
		"O_R_APC_Wheeled_02_rcws_v2_F"
	};
	heavyArmor[] = {
		"O_R_MBT_02_cannon_F",
		"O_R_MBT_04_cannon_F",
		"O_R_MBT_04_command_F"
	};
	transportHelicopters[] = {
		"O_R_Heli_Light_02_unarmed_F",
		"O_R_Heli_Transport_04_covered_F"
	};
	cargoAircraft[] = {
		"O_T_Plane_Transport_01_infantry_ghex_F"
	};
	casAircraft[] = {
		"O_R_Plane_CAS_02_dynamicLoadout_F",
		"O_R_Plane_Fighter_02_F",
		"O_R_Plane_Fighter_02_Stealth_F"
	};
	attackHelicopters[] = {
		"O_R_Heli_Attack_02_dynamicLoadout_F"
	};

	infantry[] = {
		"O_R_Soldier_A_F",
		"O_R_Soldier_AAR_F",
		"O_R_support_AMG_F",
		"O_R_support_AMort_F",
		"O_R_Soldier_AHAT_F",
		"O_R_Soldier_AAA_F",
		"O_R_Soldier_AAT_F",
		"O_R_Soldier_AR_F",
		"O_R_medic_F",
		"O_R_engineer_F",
		"O_R_soldier_exp_F",
		"O_R_Soldier_GL_F",
		"O_R_support_GMG_F",
		"O_R_support_MG_F",
		"O_R_support_Mort_F",
		"O_R_soldier_M_F",
		"O_R_soldier_mine_F",
		"O_R_soldier_AA_F",
		"O_R_soldier_AT_F",
		"O_R_officer_F",
		"O_R_RadioOperator_F",
		"O_R_Soldier_F",
		"O_R_Soldier_LAT_F",
		"O_R_Soldier_HAT_F",
		"O_R_Soldier_lite_F",
		"O_R_Soldier_CQ_F",
		"O_R_Soldier_SL_F",
		"O_R_Soldier_TL_F",
		"O_R_Patrol_Soldier_A_F",
		"O_R_Patrol_Soldier_AR2_F",
		"O_R_Patrol_Soldier_AR_F",
		"O_R_Patrol_Soldier_Medic",
		"O_R_Patrol_Soldier_Engineer_F",
		"O_R_Patrol_Soldier_GL_F",
		"O_R_Patrol_Soldier_M2_F",
		"O_R_Patrol_Soldier_LAT_F",
		"O_R_Patrol_Soldier_M_F",
		"O_R_Patrol_Soldier_TL_F",
		"O_R_recon_AR_F",
		"O_R_recon_exp_F",
		"O_R_recon_GL_F",
		"O_R_recon_JTAC_F",
		"O_R_recon_M_F",
		"O_R_recon_medic_F",
		"O_R_recon_F",
		"O_R_recon_LAT_F",
		"O_R_recon_CQ_F",
		"O_R_sniper_F",
		"O_R_recon_TL_F",
		"O_R_ghillie_wdl_F",
		"O_R_spotter_F",
		"O_R_ghillie_spotter_wdl_F"
	};
};

class AEGIS_Russia_arid_faction : AEGIS_Russia_faction
{
	displayName = "Aegis - Russia (Arid)";

	cargoAircraft[] = {
		"O_Plane_Transport_01_infantry_F"
	};
	infantry[] = {
		"O_R_Soldier_A_ard_F",
		"O_R_Soldier_AAR_ard_F",
		"O_R_support_AMG_ard_F",
		"O_R_support_AMort_ard_F",
		"O_R_Soldier_AHAT_ard_F",
		"O_R_Soldier_AAA_ard_F",
		"O_R_Soldier_AAT_ard_F",
		"O_R_soldier_AR_ard_F",
		"O_R_medic_ard_F",
		"O_R_engineer_ard_F",
		"O_R_soldier_exp_ard_F",
		"O_R_Soldier_GL_ard_F",
		"O_R_support_GMG_ard_F",
		"O_R_support_MG_ard_F",
		"O_R_support_Mort_ard_F",
		"O_R_soldier_M_ard_F",
		"O_R_soldier_mine_ard_F",
		"O_R_soldier_AA_ard_F",
		"O_R_soldier_AT_ard_F",
		"O_R_officer_ard_F",
		"O_R_RadioOperator_ard_F",
		"O_R_soldier_repair_ard_F",
		"O_R_Soldier_ard_F",
		"O_R_Soldier_LAT_ard_F",
		"O_R_Soldier_HAT_ard_F",
		"O_R_Soldier_lite_ard_F",
		"O_R_Soldier_CQ_ard_F",
		"O_R_Soldier_SL_ard_F",
		"O_R_Soldier_TL_ard_F",
		"O_R_recon_AR_ard_F",
		"O_R_recon_exp_ard_F",
		"O_R_recon_GL_ard_F",
		"O_R_recon_JTAC_ard_F",
		"O_R_recon_M_ard_F",
		"O_R_recon_medic_ard_F",
		"O_R_recon_ard_F",
		"O_R_recon_LAT_ard_F",
		"O_R_recon_CQ_ard_F",
		"O_R_recon_TL_ard_F",
		"O_R_sniper_ard_F",
		"O_R_spotter_ard_F",
		"O_R_ghillie_spotter_ard_F",
		"O_R_ghillie_ard_F"
	};
};

class AEGIS_AAF_faction : AAF_faction
{
	displayName = "Aegis - AAF";

	cargoAircraft[] = {
		"I_Plane_Transport_01_infantry_F"
	};
	attackHelicopters[] = {
		"I_Heli_Attack_03_F"
	};
};