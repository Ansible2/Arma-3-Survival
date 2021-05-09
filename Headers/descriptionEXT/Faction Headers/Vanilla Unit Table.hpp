class AAF_faction
{
	displayName = "VANILLA - AAF";
	lightCars[] = {
		"B_T_LSV_01_armed_F"
	};
	heavyCars[] = {
		"I_MRAP_03_hmg_F",
		"I_MRAP_03_gmg_F"
	};
	lightArmor[] = {
		"I_APC_Wheeled_03_cannon_F",
		"I_APC_tracked_03_cannon_F",
		"I_LT_01_cannon_F"
	};
	heavyArmor[] = {
		"I_MBT_03_cannon_F"
	};
	transportHelicopters[] = {
		"I_Heli_light_03_unarmed_F"
	};
	cargoAircraft[] = {
		"I_Heli_Transport_02_F"
	};
	casAircraft[] = {
		"I_Plane_Fighter_03_dynamicLoadout_F",
		"I_Plane_Fighter_04_F",
		"CUP_I_AV8B_DYN_AAF",
		"CUP_I_SU34_AAF"
	};
	attackHelicopters[] = {
		"O_Heli_Attack_02_dynamicLoadout_black_F"
	};
	infantry[] = {
		"I_Soldier_A_F",
		"I_Soldier_AAR_F",
		"I_support_AMG_F",
		"I_support_AMort_F",
		"I_Soldier_AAA_F",
		"I_Soldier_AAT_F",
		"I_Soldier_AR_F",
		"I_medic_F",
		"I_engineer_F",
		"I_Soldier_exp_F",
		"I_Soldier_GL_F",
		"I_support_GMG_F",
		"I_support_MG_F",
		"I_support_Mort_F",
		"I_Soldier_M_F",
		"I_soldier_mine_F",
		"I_Soldier_AA_F",
		"I_Soldier_AT_F",
		"I_Soldier_repair_F",
		"I_soldier_F",
		"I_Soldier_LAT_F",
		"I_Soldier_LAT2_F",
		"I_Soldier_lite_F",
		"I_Soldier_SL_F",
		"I_Soldier_TL_F"
	};
};

class CSAT_faction
{
	displayName = "VANILLA - CSAT";
	lightCars[] = {
		"O_LSV_02_armed_F"
	};
	heavyCars[] = {
		"O_MRAP_02_hmg_F",
		"O_MRAP_02_gmg_F"
	};
	lightArmor[] = {
		"O_APC_Wheeled_02_rcws_v2_F",
		"O_APC_Tracked_02_cannon_F"
	};
	heavyArmor[] = {
		"O_MBT_02_cannon_F",
		"O_MBT_04_cannon_F"
	};
	transportHelicopters[] = {
		"O_Heli_Light_02_unarmed_F",
		"O_Heli_Transport_04_bench_F",
		"O_Heli_Transport_04_covered_F"
	};
	cargoAircraft[] = {
		"O_Heli_Transport_04_box_F"
	};
	casAircraft[] = {
		"O_Plane_CAS_02_dynamicLoadout_F",
		"O_Plane_Fighter_02_F"
	};
	attackHelicopters[] = {
		"O_Heli_Attack_02_dynamicLoadout_F"
	};
	infantry[] = {
		"O_Soldier_A_F",
		"O_Soldier_AAR_F",
		"O_support_AMG_F",
		"O_support_AMort_F",
		"O_Soldier_AHAT_F",
		"O_Soldier_AAA_F",
		"O_Soldier_AAT_F",
		"O_Soldier_AR_F",
		"O_medic_F",
		"O_engineer_F",
		"O_soldier_exp_F",
		"O_Soldier_GL_F",
		"O_support_GMG_F",
		"O_support_MG_F",
		"O_support_Mort_F",
		"O_HeavyGunner_F",
		"O_soldier_M_F",
		"O_soldier_mine_F",
		"O_Soldier_AA_F",
		"O_Soldier_AT_F",
		"O_soldier_repair_F",
		"O_Soldier_F",
		"O_Soldier_LAT_F",
		"O_Soldier_HAT_F",
		"O_Sharpshooter_F",
		"O_Soldier_SL_F",
		"O_Soldier_TL_F",
		"O_recon_exp_F",
		"O_recon_JTAC_F",
		"O_recon_M_F",
		"O_recon_medic_F",
		"O_Pathfinder_F",
		"O_recon_F",
		"O_recon_LAT_F",
		"O_recon_TL_F"
	};
};

class CSAT_urban_faction : CSAT_faction
{
	displayName = "VANILLA - CSAT URBAN";
	attackHelicopters[] = {
		"O_Heli_Attack_02_dynamicLoadout_black_F"
	};
};

class CSAT_pacific_faction
{
	displayName = "APEX - CSAT PACIFIC";
	lightCars[] = {
		"O_T_LSV_02_armed_F"
	};
	heavyCars[] = {
		"O_T_MRAP_02_hmg_ghex_F",
		"O_T_MRAP_02_gmg_ghex_F"
	};
	lightArmor[] = {
		"O_T_APC_Wheeled_02_rcws_v2_ghex_F",
		"O_T_APC_Tracked_02_cannon_ghex_F"
	};
	heavyArmor[] = {
		"O_T_MBT_02_cannon_ghex_F",
		"O_T_MBT_04_cannon_F"
	};
	transportHelicopters[] = {
		"O_Heli_Light_02_unarmed_F"
	};
	cargoAircraft[] = {
		"O_T_VTOL_02_infantry_dynamicLoadout_F"
	};
	casAircraft[] = {
		"O_Plane_CAS_02_dynamicLoadout_F",
		"CUP_O_Su25_Dyn_CSAT_T",
		"O_Plane_Fighter_02_F"
	};
	attackHelicopters[] = {
		"O_Heli_Attack_02_dynamicLoadout_black_F",
		"CUP_O_Mi24_Mk3_CSAT_T",
		"CUP_O_Mi24_Mk4_CSAT_T"
	};
	infantry[] = {
		"O_T_Soldier_A_F",
		"O_T_Soldier_AAR_F",
		"O_T_Support_AMG_F",
		"O_T_Support_AMort_F",
		"O_T_Soldier_AHAT_F",
		"O_T_Soldier_AAA_F",
		"O_T_Soldier_AAT_F",
		"O_T_Soldier_AR_F",
		"O_T_Medic_F",
		"O_T_Engineer_F",
		"O_T_Soldier_Exp_F",
		"O_T_Soldier_GL_F",
		"O_T_Support_GMG_F",
		"O_T_Support_MG_F",
		"O_T_Support_Mort_F",
		"O_T_Soldier_M_F",
		"O_T_soldier_mine_F",
		"O_T_Soldier_AA_F",
		"O_T_Soldier_AT_F",
		"O_T_Soldier_Repair_F",
		"O_T_Soldier_F",
		"O_T_Soldier_LAT_F",
		"O_T_Soldier_HAT_F",
		"O_T_Soldier_SL_F",
		"O_T_Soldier_TL_F",
		"O_T_Recon_Exp_F",
		"O_T_Recon_JTAC_F",
		"O_T_Recon_M_F",
		"O_T_Recon_Medic_F",
		"O_T_Recon_F",
		"O_T_Recon_LAT_F",
		"O_T_Recon_TL_F",
		"O_T_Soldier_CQ_F",
		"O_T_Sniper_F",
		"O_T_ghillie_tna_F",
		"O_T_Spotter_F",
		"O_T_ghillie_spotter_tna_F"
	};
};

class VIPER_faction : CSAT_pacific_faction
{
	displayName = "APEX - VIPER";
	infantry[] = {
		"O_V_Soldier_Exp_hex_F",
		"O_V_Soldier_JTAC_hex_F",
		"O_V_Soldier_M_hex_F",
		"O_V_Soldier_hex_F",
		"O_V_Soldier_Medic_hex_F",
		"O_V_Soldier_LAT_hex_F",
		"O_V_Soldier_TL_hex_F"
	};
};

class VIPER_pacific_faction : CSAT_pacific_faction
{
	displayName = "APEX - VIPER PACIFIC";
	infantry[] = {
		"O_V_Soldier_Exp_ghex_F",
		"O_V_Soldier_JTAC_ghex_F",
		"O_V_Soldier_M_ghex_F",
		"O_V_Soldier_ghex_F",
		"O_V_Soldier_Medic_ghex_F",
		"O_V_Soldier_LAT_ghex_F",
		"O_V_Soldier_TL_ghex_F"
	};
};

class NATO_faction
{
	displayName = "VANILLA - NATO";
	lightCars[] = {
		"B_LSV_01_armed_F"
	};
	heavyCars[] = {
		"B_MRAP_01_hmg_F",
		"B_MRAP_01_gmg_F"
	};
	lightArmor[] = {
		"B_APC_Wheeled_01_cannon_F",
		"B_APC_Tracked_01_CRV_F",
		"B_APC_Tracked_01_rcws_F",
		"B_AFV_Wheeled_01_cannon_F",
		"B_AFV_Wheeled_01_up_cannon_F"
	};
	heavyArmor[] = {
		"B_MBT_01_cannon_F",
		"B_MBT_01_TUSK_F"
	};
	transportHelicopters[] = {
		"B_Heli_Transport_01_F",
		"B_Heli_Transport_03_F"
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
		"B_Soldier_A_F",
		"B_soldier_AAR_F",
		"B_support_AMort_F",
		"B_soldier_AAA_F",
		"B_soldier_AAT_F",
		"B_soldier_AR_F",
		"B_medic_F",
		"B_engineer_F",
		"B_soldier_exp_F",
		"B_Soldier_GL_F",
		"B_support_GMG_F",
		"B_support_MG_F",
		"B_support_Mort_F",
		"B_HeavyGunner_F",
		"B_soldier_M_F",
		"B_soldier_mine_F",
		"B_soldier_AA_F",
		"B_soldier_AT_F",
		"B_soldier_repair_F",
		"B_Soldier_F",
		"B_soldier_LAT_F",
		"B_soldier_LAT2_F",
		"B_Sharpshooter_F",
		"B_Soldier_SL_F",
		"B_Soldier_TL_F",
		"B_recon_exp_F",
		"B_recon_JTAC_F",
		"B_recon_M_F",
		"B_recon_medic_F",
		"B_recon_CQ_F",
		"B_recon_F",
		"B_recon_LAT_F",
		"B_Recon_Sharpshooter_F",
		"B_recon_TL_F",
		"B_Patrol_Soldier_A_F",
		"B_Patrol_Soldier_AR_F",
		"B_Patrol_Medic_F",
		"B_Patrol_Engineer_F",
		"B_Patrol_HeavyGunner_F",
		"B_Patrol_Soldier_MG_F",
		"B_Patrol_Soldier_M_F",
		"B_Patrol_Soldier_AT_F",
		"B_Patrol_Soldier_TL_F",
		"B_ghillie_spotter_ard_F",
		"B_spotter_F",
		"B_sniper_F",
		"B_ghillie_ard_F"
	};
};

class NATO_pacific_faction : NATO_faction
{
	displayName = "APEX - NATO PACIFIC";
	lightCars[] = {
		"B_T_LSV_01_armed_F"
	};
	heavyCars[] = {
		"B_T_MRAP_01_hmg_F",
		"B_T_MRAP_01_gmg_F"
	};
	lightArmor[] = {
		"B_T_APC_Wheeled_01_cannon_F",
		"B_T_APC_Tracked_01_CRV_F",
		"B_T_APC_Tracked_01_rcws_F",
		"B_T_AFV_Wheeled_01_cannon_F",
		"B_T_AFV_Wheeled_01_up_cannon_F"
	};
	heavyArmor[] = {
		"B_T_MBT_01_TUSK_F",
		"B_T_MBT_01_cannon_F"
	};
	infantry[] = {
		"B_T_Soldier_A_F",
		"B_T_Soldier_AAR_F",
		"B_T_Support_AMG_F",
		"B_T_Support_AMort_F",
		"B_T_Soldier_AAA_F",
		"B_T_Soldier_AAT_F",
		"B_T_Soldier_AR_F",
		"B_T_Medic_F",
		"B_T_Engineer_F",
		"B_T_Soldier_Exp_F",
		"B_T_Soldier_GL_F",
		"B_T_Support_GMG_F",
		"B_T_Support_MG_F",
		"B_T_Support_Mort_F",
		"B_T_soldier_M_F",
		"B_T_soldier_mine_F",
		"B_T_Soldier_AA_F",
		"B_T_Soldier_AT_F",
		"B_T_Soldier_Repair_F",
		"B_T_Soldier_F",
		"B_T_Soldier_LAT_F",
		"B_T_Soldier_LAT2_F",
		"B_T_Soldier_SL_F",
		"B_T_Soldier_TL_F",
		"B_T_Recon_Exp_F",
		"B_T_Recon_JTAC_F",
		"B_T_Recon_M_F",
		"B_T_Recon_Medic_F",
		"B_T_Recon_F",
		"B_T_Recon_LAT_F",
		"B_T_Recon_TL_F",
		"B_T_Soldier_CQ_F",
		"B_T_Sniper_F",
		"B_T_ghillie_tna_F",
		"B_T_Spotter_F",
		"B_T_ghillie_spotter_tna_F"
	};
};

class NATO_woodland_faction : NATO_pacific_faction
{
	displayName = "CONTACT - NATO WOODLAND";
	infantry[] = {
		"B_W_Soldier_A_F",
		"B_W_Soldier_AAR_F",
		"B_W_Support_AMG_F",
		"B_W_Support_AMort_F",
		"B_W_Soldier_AAA_F",
		"B_W_Soldier_AAT_F",
		"B_W_Soldier_AR_F",
		"B_W_Medic_F",
		"B_W_Engineer_F",
		"B_W_Soldier_Exp_F",
		"B_W_Soldier_GL_F",
		"B_W_Support_GMG_F",
		"B_W_Support_MG_F",
		"B_W_Support_Mort_F",
		"B_W_soldier_M_F",
		"B_W_soldier_mine_F",
		"B_W_Soldier_AA_F",
		"B_W_Soldier_AT_F",
		"B_W_RadioOperator_F",
		"B_W_Soldier_Repair_F",
		"B_W_Soldier_F",
		"B_W_Soldier_LAT_F",
		"B_W_Soldier_LAT2_F",
		"B_W_Soldier_SL_F",
		"B_W_Soldier_TL_F",
		"B_W_Soldier_CQ_F",
		"B_W_Sniper_F",
		"B_W_ghillie_wdl_F",
		"B_W_Spotter_F",
		"B_W_ghillie_spotter_wdl_F"
	};
};

class CTRG_pacific_faction : NATO_pacific_faction
{
	displayName = "APEX - CTRG PACIFIC";
	transportHelicopters[] = {
		"B_CTRG_Heli_Transport_01_sand_F",
		"B_CTRG_Heli_Transport_01_tropic_F"
	};
	infantry[] = {
		"B_CTRG_Soldier_AR_tna_F",
		"B_CTRG_Soldier_Exp_tna_F",
		"B_CTRG_Soldier_JTAC_tna_F",
		"B_CTRG_Soldier_M_tna_F",
		"B_CTRG_Soldier_Medic_tna_F",
		"B_CTRG_Soldier_LAT2_tna_F",
		"B_CTRG_Soldier_tna_F",
		"B_CTRG_Soldier_LAT_tna_F",
		"B_CTRG_Soldier_TL_tna_F",
		"B_CTRG_Soldier_AR_urb_F",
		"B_CTRG_Soldier_Exp_urb_F",
		"B_CTRG_Soldier_JTAC_urb_F",
		"B_CTRG_Soldier_M_urb_F",
		"B_CTRG_Soldier_Medic_urb_F",
		"B_CTRG_Soldier_urb_F",
		"B_CTRG_Soldier_LAT_urb_F",
		"B_CTRG_Soldier_LAT2_urb_F",
		"B_CTRG_Soldier_TL_urb_F"
	};
};

class FIA_faction
{
	displayName = "VANILLA - FIA";
	lightCars[] = {
		"I_C_Offroad_02_LMG_F",
		"I_C_Offroad_02_AT_F"
	};
	heavyCars[] = {
		"B_G_Offroad_01_armed_F",
		"B_G_Offroad_01_AT_F"
	};
	transportHelicopters[] = {
		"I_C_Heli_Light_01_civil_F"
	};
	infantry[] = {
		"B_G_Soldier_A_F",
		"B_G_Soldier_AR_F",
		"B_G_medic_F",
		"B_G_engineer_F",
		"B_G_Soldier_exp_F",
		"B_G_Soldier_GL_F",
		"B_G_Soldier_M_F",
		"B_G_Soldier_F",
		"B_G_Soldier_LAT_F",
		"B_G_Soldier_LAT2_F",
		"B_G_Soldier_lite_F",
		"B_G_Sharpshooter_F",
		"B_G_Soldier_SL_F",
		"B_G_Soldier_TL_F"
	};
};

class SYNDIKAT_faction : FIA_faction
{
	displayName = "APEX - SYNDIKAT";
	infantry[] = {
		"I_C_Soldier_Bandit_3_F",
		"I_C_Soldier_Bandit_2_F",
		"I_C_Soldier_Bandit_5_F",
		"I_C_Soldier_Bandit_6_F",
		"I_C_Soldier_Bandit_1_F",
		"I_C_Soldier_Bandit_8_F",
		"I_C_Soldier_Para_7_F",
		"I_C_Soldier_Para_2_F",
		"I_C_Soldier_Para_3_F",
		"I_C_Soldier_Para_4_F",
		"I_C_Soldier_Para_6_F",
		"I_C_Soldier_Para_8_F",
		"I_C_Soldier_Para_1_F",
		"I_C_Soldier_Para_5_F",
		"I_C_Soldier_Bandit_4_F"
	};
};

class LDF_faction
{
	displayName = "CONTACT - LDF";
	lightCars[] = {
		"I_C_Offroad_02_LMG_F",
		"B_G_Offroad_01_armed_F"
	};
	heavyCars[] = {
		"I_E_MRAP_03_gmg_F",
		"I_E_MRAP_03_hmg_F"
	};
	lightArmor[] = {
		"I_E_APC_tracked_03_cannon_F"
	};
	heavyArmor[] = {
		"O_T_MBT_04_cannon_F"
	};
	transportHelicopters[] = {
		"I_E_Heli_light_03_unarmed_F"
	};
	casAircraft[] = {
		"I_E_Plane_Fighter_04_F"
	};
	infantry[] = {
		"I_E_Soldier_A_F",
		"I_E_Soldier_AAR_F",
		"I_E_Support_AMG_F",
		"I_E_Support_AMort_F",
		"I_E_Soldier_AAA_F",
		"I_E_Soldier_AAT_F",
		"I_E_Soldier_AR_F",
		"I_E_Medic_F",
		"I_E_Engineer_F",
		"I_E_Soldier_Exp_F",
		"I_E_Soldier_GL_F",
		"I_E_Support_GMG_F",
		"I_E_Support_MG_F",
		"I_E_Support_Mort_F",
		"I_E_soldier_M_F",
		"I_E_soldier_Mine_F",
		"I_E_Soldier_AA_F",
		"I_E_Soldier_AT_F",
		"I_E_Soldier_Pathfinder_F",
		"I_E_RadioOperator_F",
		"I_E_Soldier_Repair_F",
		"I_E_Soldier_F",
		"I_E_Soldier_LAT_F",
		"I_E_Soldier_LAT2_F",
		"I_E_Soldier_lite_F",
		"I_E_Soldier_SL_F",
		"I_E_Soldier_TL_F",
		"I_E_ghillie_wdl_F",
		"I_E_ghillie_spotter_wdl_F"
	};
};

class SPETZNAS_CONTACT_faction : VIPER_pacific_faction
{
	displayName = "CONTACT - Spetznas";
	infantry[] = {
		"O_R_Soldier_TL_F",
		"O_R_Soldier_LAT_F",
		"O_R_soldier_M_F",
		"O_R_JTAC_F",
		"O_R_Soldier_GL_F",
		"O_R_soldier_exp_F",
		"O_R_medic_F",
		"O_R_Soldier_AR_F",
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
		"O_R_recon_LAT_F",
		"O_R_recon_TL_F"
	};
};
