class BLWK_factions 
{
/*
	class factionBase
	{	
		displayName = "Faction Base";
		lightCars[] = 
		{};
		heavyCars[] = 
		{};
		lightArmor[] = 
		{};
		heavyArmor[] = 
		{};
		transportHelicoprters[] = 
		{};
		cargoAircraft[] = 
		{};
		casAircraft[] = 
		{};
		attackHelicopters[] = 
		{};
		infantry[] = 
		{};
	};
*/
	class AAF_faction
	{
		displayName "VANILLA - AAF";
		lightCars[] = {
			"B_T_LSV_01_armed_F"
		};
		heavyCars[] = {
			"I_MRAP_03_hmg_F"
		};
		lightArmor[] = {
			"I_APC_Wheeled_03_cannon_F",
			"I_APC_tracked_03_cannon_F"
		};
		heavyArmor[] = {
			"I_MBT_03_cannon_F"			
		};
		transportHelicoprters[] = {
			"I_Heli_light_03_unarmed_F"
		};
		cargoAircraft[] = {
			"I_Heli_Transport_02_F"
		};
		casAircraft[] = {
			"I_Plane_Fighter_03_dynamicLoadout_F",
			"I_Plane_Fighter_04_F"
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
		lightCars[] = 
		{
			"O_LSV_02_armed_F"
		};
		heavyCars[] = 
		{
			"O_MRAP_02_hmg_F"
		};
		lightArmor[] = 
		{
			"O_APC_Wheeled_02_rcws_v2_F"
		};
		heavyArmor[] = 
		{
			"O_MBT_02_cannon_F"
		};
		transportHelicoprters[] = 
		{
			"O_Heli_Light_02_unarmed_F"
		};
		cargoAircraft[] = 
		{
			"O_Heli_Transport_04_box_F"
		};
		casAircraft[] = 
		{
			"O_Plane_CAS_02_dynamicLoadout_F"
		};
		attackHelicopters[] = 
		{
			"O_Heli_Attack_02_dynamicLoadout_F"
		};
		infantry[] = 
		{
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


		"O_Heli_Attack_02_dynamicLoadout_black_F"
	};

	class NATO_faction
	{
		displayName = "VANILLA - NATO";
		lightCars[] = 
		{
			"B_LSV_01_armed_F"
		};
		heavyCars[] = 
		{
			"B_MRAP_01_hmg_F"
		};
		lightArmor[] = 
		{
			"B_APC_Wheeled_01_cannon_F"
		};
		heavyArmor[] = 
		{
			"B_MBT_01_cannon_F"
		};
		transportHelicoprters[] = 
		{
			"B_Heli_Transport_01_F"
		};
		cargoAircraft[] = 
		{
			"B_T_VTOL_01_vehicle_F"
		};
		casAircraft[] = 
		{
			"B_Plane_CAS_01_F"
		};
		attackHelicopters[] = 
		{
			"B_Heli_Attack_01_dynamicLoadout_F"
		};
		infantry[] = 
		{
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
			"B_Patrol_Soldier_TL_F"
		};
	};
	
	class NATO_pacific_faction : NATO_faction
	{
		displayName = "APEX - NATO PACIFIC";
		lightCars[] = 
		{
			"B_T_LSV_01_armed_F"
		};
		heavyCars[] = 
		{
			"B_T_MRAP_01_hmg_F"
		};
		lightArmor[] = 
		{
			"B_T_APC_Wheeled_01_cannon_F"
		};
		heavyArmor[] = 
		{
			"B_MBT_01_cannon_F"
		};
		infantry[] = 
		{
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
			"B_T_Recon_TL_F"
		};
	};
	
	class NATO_woodland_faction : NATO_pacific_faction
	{
		displayName = "CONTACT - NATO WOODLAND";
		infantry[] = 
		{
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
			"B_W_Soldier_TL_F"
		};
	};
simulation = "shotRocket";
	class CTRG_pacific_faction : NATO_pacific_faction
	{
		displayName = "APEX - CTRG PACIFIC";
		transportHelicoprters[] = 
		{
			"B_CTRG_Heli_Transport_01_sand_F"
		};
		infantry[] = 
		{
			"B_CTRG_Soldier_AR_tna_F",
			"B_CTRG_Soldier_Exp_tna_F",
			"B_CTRG_Soldier_JTAC_tna_F",
			"B_CTRG_Soldier_M_tna_F",
			"B_CTRG_Soldier_Medic_tna_F",
			"B_CTRG_Soldier_LAT2_tna_F",
			"B_CTRG_Soldier_tna_F",
			"B_CTRG_Soldier_LAT_tna_F",
			"B_CTRG_Soldier_TL_tna_F"
		};
	};
};