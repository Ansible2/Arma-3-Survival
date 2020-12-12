class RHSAFRF_MSV_EMR
{
	displayName = "RHS AFRF - Russia MSV (EMR)";
	lightCars[] = {
		"O_LSV_02_armed_black_F",
		"B_LSV_01_armed_black_F"
	};
	heavyCars[] = {
		"rhs_tigr_sts_msv",
		"rhs_tigr_sts_3camo_msv"
	};
	lightArmor[] = {
		"rhs_btr60_msv",
		"rhs_btr70_msv",
		"rhs_btr80_msv",
		"rhs_btr80a_msv",
		"rhs_bmp1_msv",
		"rhs_bmp1d_msv",
		"rhs_bmp1k_msv",
		"rhs_bmp1p_msv",
		"rhs_bmp2e_msv",
		"rhs_bmp2_msv",
		"rhs_bmp2d_msv",
		"rhs_bmp2k_msv",
		"rhs_bmp3_msv",
		"rhs_bmp3_late_msv",
		"rhs_bmp3m_msv",
		"rhs_bmp3mera_msv",
		"rhs_brm1k_msv",
		"rhs_Ob_681_2"
	};
	heavyArmor[] = {
		"rhs_t14_tv",
		"rhs_t72ba_tv",
		"rhs_t72bb_tv",
		"rhs_t72bc_tv",
		"rhs_t72bd_tv",
		"rhs_t72be_tv",
		"rhs_t80",
		"rhs_t80a",
		"rhs_t80b",
		"rhs_t80bk",
		"rhs_t80bv",
		"rhs_t80bvk",
		"rhs_t80u",
		"rhs_t80u45m",
		"rhs_t80ue1",
		"rhs_t80uk",
		"rhs_t80um",
		"rhs_t90_tv",
		"rhs_t90a_tv",
		"rhs_t90am_tv",
		"rhs_t90saa_tv",
		"rhs_t90sab_tv",
		"rhs_t90sm_tv",
		"rhs_sprut_vdv"
	};
	transportHelicopters[] = {
		"RHS_Mi8mt_vvsc",
		"O_Heli_Light_02_unarmed_F"
	};
	cargoAircraft[] = {
		"RHS_Mi8mt_vvsc"
	};
	casAircraft[] = {
		"rhs_mig29sm_vmf",
		"RHS_Su25SM_vvsc",
		"rhs_mig29sm_vvs",
		"RHS_Su25SM_vvs",
		"RHS_T50_vvs_generic_ext"
	};
	attackHelicopters[] = {
		"O_Heli_Attack_02_dynamicLoadout_black_F",
		"rhs_mi28n_vvs"
	};
	infantry[] = {
		"rhs_msv_emr_at",
		"rhs_msv_emr_arifleman",
		"rhs_msv_emr_engineer",
		"rhs_msv_emr_grenadier_rpg",
		"rhs_msv_emr_strelok_rpg_assist",
		"rhs_msv_emr_junior_sergeant",
		"rhs_msv_emr_machinegunner",
		"rhs_msv_emr_machinegunner_assistant",
		"rhs_msv_emr_marksman",
		"rhs_msv_emr_medic",
		"rhs_msv_emr_rifleman",
		"rhs_msv_emr_grenadier",
		"rhs_msv_emr_LAT",
		"rhs_msv_emr_RShG2",
		"rhs_msv_emr_sergeant"
	};
};

class RHSAFRF_MSV_FLORA : RHSAFRF_MSV_EMR
{
	displayName = "RHS AFRF - Russia MSV (Flora)";

	infantry[] = {
		"rhs_msv_at",
		"rhs_msv_arifleman",
		"rhs_msv_engineer",
		"rhs_msv_grenadier_rpg",
		"rhs_msv_strelok_rpg_assist",
		"rhs_msv_junior_sergeant",
		"rhs_msv_machinegunner",
		"rhs_msv_machinegunner_assistant",
		"rhs_msv_marksman",
		"rhs_msv_medic",
		"rhs_msv_rifleman",
		"rhs_msv_grenadier",
		"rhs_msv_LAT",
		"rhs_msv_RShG2",
		"rhs_msv_sergeant"
	};
};

class RHSAFRF_VDV_EMR : RHSAFRF_MSV_EMR
{
	displayName = "RHS AFRF - Russia VDV (EMR)";
	
	attackHelicopters[] = {
		"O_Heli_Attack_02_dynamicLoadout_black_F",
		"rhs_mi28n_vvsc"
	};
	infantry[] = {
		"rhs_vdv_at",
		"rhs_vdv_arifleman",
		"rhs_vdv_engineer",
		"rhs_vdv_grenadier_rpg",
		"rhs_vdv_strelok_rpg_assist",
		"rhs_vdv_junior_sergeant",
		"rhs_vdv_machinegunner",
		"rhs_vdv_machinegunner_assistant",
		"rhs_vdv_marksman",
		"rhs_vdv_marksman_asval",
		"rhs_vdv_medic",
		"rhs_vdv_rifleman",
		"rhs_vdv_rifleman_asval",
		"rhs_vdv_grenadier",
		"rhs_vdv_grenadier_alt",
		"rhs_vdv_LAT",
		"rhs_vdv_RShG2",
		"rhs_vdv_rifleman_alt",
		"rhs_vdv_sergeant"
	};
};

class RHSAFRF_VDV_EMR_DES : RHSAFRF_VDV_EMR
{
	displayName = "RHS AFRF - Russia VDV (EMR-Des)";

	infantry[] = {
		"rhs_vdv_des_at",
		"rhs_vdv_des_arifleman",
		"rhs_vdv_des_engineer",
		"rhs_vdv_des_grenadier_rpg",
		"rhs_vdv_des_strelok_rpg_assist",
		"rhs_vdv_des_junior_sergeant",
		"rhs_vdv_des_machinegunner",
		"rhs_vdv_des_machinegunner_assistant",
		"rhs_vdv_des_marksman",
		"rhs_vdv_des_marksman_asval",
		"rhs_vdv_des_medic",
		"rhs_vdv_des_rifleman",
		"rhs_vdv_des_rifleman_asval",
		"rhs_vdv_des_grenadier",
		"rhs_vdv_des_LAT",
		"rhs_vdv_des_RShG2",
		"rhs_vdv_des_sergeant"
	};
};

class RHSAFRF_VDV_FLORA : RHSAFRF_VDV_EMR
{
	displayName = "RHS AFRF - Russia VDV (EMR-Des)";

	infantry[] = {
		"rhs_vdv_flora_at",
		"rhs_vdv_flora_engineer",
		"rhs_vdv_flora_grenadier_rpg",
		"rhs_vdv_flora_strelok_rpg_assist",
		"rhs_vdv_flora_junior_sergeant",
		"rhs_vdv_flora_machinegunner",
		"rhs_vdv_flora_machinegunner_assistant",
		"rhs_vdv_flora_marksman",
		"rhs_vdv_flora_medic",
		"rhs_vdv_flora_rifleman",
		"rhs_vdv_flora_grenadier",
		"rhs_vdv_flora_LAT",
		"rhs_vdv_flora_RShG2",
		"rhs_vdv_flora_sergeant"
	};
};