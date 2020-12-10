/*
	Why use hard coded values like this?

	Well, the desire for customization and expandability by the end user.
	There could be some kind of mission setup GUI that allows you to select the factions in these places,
	It could also give you the kind of individual selection on unit spawns (e.g. exclude grenediers).
	
	While that may come in the future, I find it less tedious to just use a mission param and the following
	to achieve the level of customization I was looking for by highlighting the units in the editor and
	right-click logging their classes to the clipboard


		For vehicle array:
		// leave an index blank with "" if you don't want it defined
		"B_LSV_01_armed_F",\ 					0 // light car 
		"B_MRAP_01_hmg_F",\ 					1 // heavy car
		"B_APC_Wheeled_01_cannon_F",\ 			2 // light armour
		"B_MBT_01_cannon_F",\ 					3 // heavy armour
		"B_Heli_Transport_01_F",\ 				4 // transport Helicopter (used for door gunner)
		"B_T_VTOL_01_vehicle_F",\ 				5 // cargo aircraft (used to paradrop from and drop off arsenal)
		"B_Plane_CAS_01_dynamicLoadout_F",\ 					6 // CAS plane 
		"B_Heli_Attack_01_dynamicLoadout_F",\ 	7 // attack helicopter
		"B_T_VTOL_01_armed_F"\ 					8 // gunship (ac130 type aircraft)
*/

#define NATO_UNITS \
[ \
	"B_Soldier_A_F", \
	"B_soldier_AAR_F", \
	"B_support_AMort_F", \
	"B_soldier_AAA_F", \
	"B_soldier_AAT_F", \
	"B_soldier_AR_F", \
	"B_medic_F", \
	"B_engineer_F", \
	"B_soldier_exp_F", \
	"B_Soldier_GL_F", \
	"B_support_GMG_F", \
	"B_support_MG_F", \
	"B_support_Mort_F", \
	"B_HeavyGunner_F", \
	"B_soldier_M_F", \
	"B_soldier_mine_F", \
	"B_soldier_AA_F", \
	"B_soldier_AT_F", \
	"B_soldier_repair_F", \
	"B_Soldier_F", \
	"B_soldier_LAT_F", \
	"B_soldier_LAT2_F", \
	"B_Sharpshooter_F", \
	"B_Soldier_SL_F", \
	"B_Soldier_TL_F", \
	"B_recon_exp_F", \
	"B_recon_JTAC_F", \
	"B_recon_M_F", \
	"B_recon_medic_F", \
	"B_recon_F", \
	"B_recon_LAT_F", \
	"B_Recon_Sharpshooter_F", \
	"B_recon_TL_F", \
	"B_Patrol_Soldier_A_F", \
	"B_Patrol_Soldier_AR_F", \
	"B_Patrol_Medic_F", \
	"B_Patrol_Engineer_F", \
	"B_Patrol_HeavyGunner_F", \
	"B_Patrol_Soldier_MG_F", \
	"B_Patrol_Soldier_M_F", \
	"B_Patrol_Soldier_AT_F", \
	"B_Patrol_Soldier_TL_F", \
	[\
		"B_LSV_01_armed_F",\
		"B_MRAP_01_hmg_F",\
		"B_APC_Wheeled_01_cannon_F",\
		"B_MBT_01_cannon_F",\
		"B_Heli_Transport_01_F",\
		"B_T_VTOL_01_vehicle_F",\
		"B_Plane_CAS_01_dynamicLoadout_F",\
		"B_Heli_Attack_01_dynamicLoadout_F",\
		"B_T_VTOL_01_armed_F"\
	]\
]

#define NATO_PACIFIC_UNITS \
[ \
	"B_T_Soldier_A_F", \
	"B_T_Soldier_AAR_F", \
	"B_T_Support_AMG_F", \
	"B_T_Support_AMort_F", \
	"B_T_Soldier_AAA_F", \
	"B_T_Soldier_AAT_F", \
	"B_T_Soldier_AR_F", \
	"B_T_Medic_F", \
	"B_T_Engineer_F", \
	"B_T_Soldier_Exp_F", \
	"B_T_Soldier_GL_F", \
	"B_T_Support_GMG_F", \
	"B_T_Support_MG_F", \
	"B_T_Support_Mort_F", \
	"B_T_soldier_M_F", \
	"B_T_soldier_mine_F", \
	"B_T_Soldier_AA_F", \
	"B_T_Soldier_AT_F", \
	"B_T_Soldier_Repair_F", \
	"B_T_Soldier_F", \
	"B_T_Soldier_LAT_F", \
	"B_T_Soldier_LAT2_F", \
	"B_T_Soldier_SL_F", \
	"B_T_Soldier_TL_F", \
	"B_T_Recon_Exp_F", \
	"B_T_Recon_JTAC_F", \
	"B_T_Recon_M_F", \
	"B_T_Recon_Medic_F", \
	"B_T_Recon_F", \
	"B_T_Recon_LAT_F", \
	"B_T_Recon_TL_F", \
	["B_T_LSV_01_armed_F","B_T_MRAP_01_hmg_F","B_T_APC_Wheeled_01_cannon_F","B_MBT_01_cannon_F","B_Heli_Transport_01_F","B_T_VTOL_01_vehicle_F","B_Plane_CAS_01_dynamicLoadout_F","B_Heli_Attack_01_dynamicLoadout_F","B_T_VTOL_01_armed_F"]\
]

#define NATO_WOODLAND_UNITS \
[ \
	"B_W_Soldier_A_F", \
	"B_W_Soldier_AAR_F", \
	"B_W_Support_AMG_F", \
	"B_W_Support_AMort_F", \
	"B_W_Soldier_AAA_F", \
	"B_W_Soldier_AAT_F", \
	"B_W_Soldier_AR_F", \
	"B_W_Medic_F", \
	"B_W_Engineer_F", \
	"B_W_Soldier_Exp_F", \
	"B_W_Soldier_GL_F", \
	"B_W_Support_GMG_F", \
	"B_W_Support_MG_F", \
	"B_W_Support_Mort_F", \
	"B_W_soldier_M_F", \
	"B_W_soldier_mine_F", \
	"B_W_Soldier_AA_F", \
	"B_W_Soldier_AT_F", \
	"B_W_RadioOperator_F", \
	"B_W_Soldier_Repair_F", \
	"B_W_Soldier_F", \
	"B_W_Soldier_LAT_F", \
	"B_W_Soldier_LAT2_F", \
	"B_W_Soldier_SL_F", \
	"B_W_Soldier_TL_F", \
	["B_T_LSV_01_armed_F","B_T_MRAP_01_hmg_F","B_T_APC_Wheeled_01_cannon_F","B_MBT_01_cannon_F","B_Heli_Transport_01_F","B_T_VTOL_01_vehicle_F","B_Plane_CAS_01_dynamicLoadout_F","B_Heli_Attack_01_dynamicLoadout_F","B_T_VTOL_01_armed_F"]\
]

#define CTRG_PACIFIC_UNITS \
[ \
	"B_CTRG_Soldier_AR_tna_F", \
	"B_CTRG_Soldier_Exp_tna_F", \
	"B_CTRG_Soldier_JTAC_tna_F", \
	"B_CTRG_Soldier_M_tna_F", \
	"B_CTRG_Soldier_Medic_tna_F", \
	"B_CTRG_Soldier_LAT2_tna_F", \
	"B_CTRG_Soldier_tna_F", \
	"B_CTRG_Soldier_LAT_tna_F", \
	"B_CTRG_Soldier_TL_tna_F", \
	["B_T_LSV_01_armed_F","B_T_MRAP_01_hmg_F","B_T_APC_Wheeled_01_cannon_F","B_MBT_01_cannon_F","B_CTRG_Heli_Transport_01_sand_F","B_T_VTOL_01_vehicle_F","B_Plane_CAS_01_dynamicLoadout_F","B_Heli_Attack_01_dynamicLoadout_F","B_T_VTOL_01_armed_F"]\
]

#define CSAT_UNITS \
[ \
	"O_Soldier_A_F", \
	"O_Soldier_AAR_F", \
	"O_support_AMG_F", \
	"O_support_AMort_F", \
	"O_Soldier_AHAT_F", \
	"O_Soldier_AAA_F", \
	"O_Soldier_AAT_F", \
	"O_Soldier_AR_F", \
	"O_medic_F", \
	"O_engineer_F", \
	"O_soldier_exp_F", \
	"O_Soldier_GL_F", \
	"O_support_GMG_F", \
	"O_support_MG_F", \
	"O_support_Mort_F", \
	"O_HeavyGunner_F", \
	"O_soldier_M_F", \
	"O_soldier_mine_F", \
	"O_Soldier_AA_F", \
	"O_Soldier_AT_F", \
	"O_soldier_repair_F", \
	"O_Soldier_F", \
	"O_Soldier_LAT_F", \
	"O_Soldier_HAT_F", \
	"O_Sharpshooter_F", \
	"O_Soldier_SL_F", \
	"O_Soldier_TL_F", \
	"O_recon_exp_F", \
	"O_recon_JTAC_F", \
	"O_recon_M_F", \
	"O_recon_medic_F", \
	"O_Pathfinder_F", \
	"O_recon_F", \
	"O_recon_LAT_F", \
	"O_recon_TL_F", \
	[\
		"O_LSV_02_armed_F",\
		"O_MRAP_02_hmg_F",\
		"O_APC_Wheeled_02_rcws_v2_F",\
		"O_MBT_02_cannon_F",\
		"O_Heli_Light_02_unarmed_F",\
		"O_Heli_Transport_04_box_F",\
		"O_Plane_CAS_02_dynamicLoadout_F",\
		"O_Heli_Attack_02_dynamicLoadout_F",\
		""\
	]\
]

#define CSAT_PACIFIC_UNITS \
[ \
	"O_T_Soldier_A_F", \
	"O_T_Soldier_AAR_F", \
	"O_T_Support_AMG_F", \
	"O_T_Support_AMort_F", \
	"O_T_Soldier_AHAT_F", \
	"O_T_Soldier_AAA_F", \
	"O_T_Soldier_AAT_F", \
	"O_T_Soldier_AR_F", \
	"O_T_Medic_F", \
	"O_T_Engineer_F", \
	"O_T_Soldier_Exp_F", \
	"O_T_Soldier_GL_F", \
	"O_T_Support_GMG_F", \
	"O_T_Support_MG_F", \
	"O_T_Support_Mort_F", \
	"O_T_Soldier_M_F", \
	"O_T_soldier_mine_F", \
	"O_T_Soldier_AA_F", \
	"O_T_Soldier_AT_F", \
	"O_T_Soldier_Repair_F", \
	"O_T_Soldier_F", \
	"O_T_Soldier_LAT_F", \
	"O_T_Soldier_HAT_F", \
	"O_T_Soldier_SL_F", \
	"O_T_Soldier_TL_F", \
	"O_T_Recon_Exp_F", \
	"O_T_Recon_JTAC_F", \
	"O_T_Recon_M_F", \
	"O_T_Recon_Medic_F", \
	"O_T_Recon_F", \
	"O_T_Recon_LAT_F", \
	"O_T_Recon_TL_F", \
	["O_T_LSV_02_armed_F","O_T_MRAP_02_hmg_ghex_F","O_T_APC_Wheeled_02_rcws_v2_ghex_F","O_T_MBT_02_cannon_F","O_Heli_Light_02_unarmed_F","O_T_VTOL_02_vehicle_dynamicLoadout_F","O_Plane_CAS_02_dynamicLoadout_F","O_T_VTOL_02_infantry_dynamicLoadout_F",""]\
]


#define CSAT_URBAN_UNITS \
[\
	"O_soldierU_A_F", \
	"O_soldierU_AAR_F", \
	"O_soldierU_AAA_F", \
	"O_soldierU_AAT_F", \
	"O_soldierU_AR_F", \
	"O_soldierU_medic_F", \
	"O_engineer_U_F", \
	"O_soldierU_exp_F", \
	"O_SoldierU_GL_F", \
	"O_Urban_HeavyGunner_F", \
	"O_soldierU_M_F", \
	"O_soldierU_AA_F", \
	"O_soldierU_AT_F", \
	"O_soldierU_repair_F", \
	"O_soldierU_F", \
	"O_soldierU_LAT_F", \
	"O_Urban_Sharpshooter_F", \
	"O_SoldierU_SL_F", \
	"O_soldierU_TL_F", \
	["O_LSV_02_armed_F","O_MRAP_02_hmg_F","O_APC_Wheeled_02_rcws_v2_F","O_MBT_02_cannon_F","O_Heli_Light_02_unarmed_F","O_T_VTOL_02_vehicle_dynamicLoadout_F","O_Plane_CAS_02_dynamicLoadout_F","O_T_VTOL_02_infantry_dynamicLoadout_F",""]\
]

#define VIPER_UNITS \
[ \
	"O_V_Soldier_Exp_hex_F", \
	"O_V_Soldier_JTAC_hex_F", \
	"O_V_Soldier_M_hex_F", \
	"O_V_Soldier_hex_F", \
	"O_V_Soldier_Medic_hex_F", \
	"O_V_Soldier_LAT_hex_F", \
	"O_V_Soldier_TL_hex_F", \
	["O_LSV_02_armed_F","O_MRAP_02_hmg_F","O_APC_Wheeled_02_rcws_v2_F","","O_Heli_Light_02_unarmed_F","O_T_VTOL_02_vehicle_dynamicLoadout_F","O_Plane_CAS_02_dynamicLoadout_F"]\
]

#define VIPER_PACIFIC_UNITS \
[ \
	"O_V_Soldier_Exp_ghex_F", \
	"O_V_Soldier_JTAC_ghex_F", \
	"O_V_Soldier_M_ghex_F", \
	"O_V_Soldier_ghex_F", \
	"O_V_Soldier_Medic_ghex_F", \
	"O_V_Soldier_LAT_ghex_F", \
	"O_V_Soldier_TL_ghex_F", \
	["O_T_LSV_02_armed_F","O_T_MRAP_02_hmg_ghex_F","O_T_APC_Wheeled_02_rcws_v2_ghex_F","","O_Heli_Light_02_unarmed_F","O_T_VTOL_02_vehicle_dynamicLoadout_F","O_Plane_CAS_02_dynamicLoadout_F"]\
]

#define FIA_UNITS \
[ \
	"B_G_Soldier_A_F", \
	"B_G_Soldier_AR_F", \
	"B_G_medic_F", \
	"B_G_engineer_F", \
	"B_G_Soldier_exp_F", \
	"B_G_Soldier_GL_F", \
	"B_G_Soldier_M_F", \
	"B_G_Soldier_F", \
	"B_G_Soldier_LAT_F", \
	"B_G_Soldier_LAT2_F", \
	"B_G_Soldier_lite_F", \
	"B_G_Sharpshooter_F", \
	"B_G_Soldier_SL_F", \
	"B_G_Soldier_TL_F", \
	["B_G_Offroad_01_armed_F","B_G_Offroad_01_AT_F","","","I_C_Heli_Light_01_civil_F","",""]\
]

#define SYNDIKAT_UNITS \
[ \
	"I_C_Soldier_Bandit_3_F", \
	"I_C_Soldier_Bandit_2_F", \
	"I_C_Soldier_Bandit_5_F", \
	"I_C_Soldier_Bandit_6_F", \
	"I_C_Soldier_Bandit_1_F", \
	"I_C_Soldier_Bandit_8_F", \
	"I_C_Soldier_Para_7_F", \
	"I_C_Soldier_Para_2_F", \
	"I_C_Soldier_Para_3_F", \
	"I_C_Soldier_Para_4_F", \
	"I_C_Soldier_Para_6_F", \
	"I_C_Soldier_Para_8_F", \
	"I_C_Soldier_Para_1_F", \
	"I_C_Soldier_Para_5_F", \
	"I_C_Soldier_Bandit_4_F", \
	["I_C_Offroad_02_LMG_F","I_C_Offroad_02_AT_F","","","I_C_Heli_Light_01_civil_F","",""]\
]

#define AAF_UNITS \
[ \
	"I_Soldier_A_F", \
	"I_Soldier_AAR_F", \
	"I_support_AMG_F", \
	"I_support_AMort_F", \
	"I_Soldier_AAA_F", \
	"I_Soldier_AAT_F", \
	"I_Soldier_AR_F", \
	"I_medic_F", \
	"I_engineer_F", \
	"I_Soldier_exp_F", \
	"I_Soldier_GL_F", \
	"I_support_GMG_F", \
	"I_support_MG_F", \
	"I_support_Mort_F", \
	"I_Soldier_M_F", \
	"I_soldier_mine_F", \
	"I_Soldier_AA_F", \
	"I_Soldier_AT_F", \
	"I_Soldier_repair_F", \
	"I_soldier_F", \
	"I_Soldier_LAT_F", \
	"I_Soldier_LAT2_F", \
	"I_Soldier_lite_F", \
	"I_Soldier_SL_F", \
	"I_Soldier_TL_F", \
	["B_T_LSV_01_armed_F","I_MRAP_03_hmg_F","I_APC_Wheeled_03_cannon_F","I_MBT_03_cannon_F","I_Heli_light_03_unarmed_F","I_Heli_Transport_02_F","I_Plane_Fighter_03_dynamicLoadout_F"]\
]

#define LDF_UNITS \
[ \
	"I_E_Soldier_A_F", \
	"I_E_Soldier_AAR_F", \
	"I_E_Support_AMG_F", \
	"I_E_Support_AMort_F", \
	"I_E_Soldier_AAA_F", \
	"I_E_Soldier_AAT_F", \
	"I_E_Soldier_AR_F", \
	"I_E_Medic_F", \
	"I_E_Engineer_F", \
	"I_E_Soldier_Exp_F", \
	"I_E_Soldier_GL_F", \
	"I_E_Support_GMG_F", \
	"I_E_Support_MG_F", \
	"I_E_Support_Mort_F", \
	"I_E_soldier_M_F", \
	"I_E_soldier_Mine_F", \
	"I_E_Soldier_AA_F", \
	"I_E_Soldier_AT_F", \
	"I_E_Soldier_Pathfinder_F", \
	"I_E_RadioOperator_F", \
	"I_E_Soldier_Repair_F", \
	"I_E_Soldier_F", \
	"I_E_Soldier_LAT_F", \
	"I_E_Soldier_LAT2_F", \
	"I_E_Soldier_lite_F", \
	"I_E_Soldier_SL_F", \
	"I_E_Soldier_TL_F", \
	["B_T_LSV_01_armed_F","B_T_MRAP_01_hmg_F","I_E_APC_tracked_03_cannon_F","O_T_MBT_04_cannon_F","I_E_Heli_light_03_unarmed_F","I_E_Heli_light_03_unarmed_F",""]\
]

#define SPETZNAS_CONTACT_UNITS \
[ \
	"O_R_Soldier_TL_F", \
	"O_R_Soldier_LAT_F", \
	"O_R_soldier_M_F", \
	"O_R_JTAC_F", \
	"O_R_Soldier_GL_F", \
	"O_R_soldier_exp_F", \
	"O_R_medic_F", \
	"O_R_Soldier_AR_F", \
	"O_R_Patrol_Soldier_A_F", \
	"O_R_Patrol_Soldier_AR2_F", \
	"O_R_Patrol_Soldier_AR_F", \
	"O_R_Patrol_Soldier_Medic", \
	"O_R_Patrol_Soldier_Engineer_F", \
	"O_R_Patrol_Soldier_GL_F", \
	"O_R_Patrol_Soldier_M2_F", \
	"O_R_Patrol_Soldier_LAT_F", \
	"O_R_Patrol_Soldier_M_F", \
	"O_R_Patrol_Soldier_TL_F", \
	"O_R_recon_AR_F", \
	"O_R_recon_exp_F", \
	"O_R_recon_GL_F", \
	"O_R_recon_JTAC_F", \
	"O_R_recon_M_F", \
	"O_R_recon_medic_F", \
	"O_R_recon_LAT_F", \
	"O_R_recon_TL_F", \
	["O_T_LSV_02_armed_F","","O_T_APC_Wheeled_02_rcws_v2_ghex_F","","O_Heli_Light_02_unarmed_F","",""]\
]
