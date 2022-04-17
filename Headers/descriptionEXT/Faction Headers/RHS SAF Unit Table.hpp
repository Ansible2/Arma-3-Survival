class RHSSAF_AIRBORNE_faction
{
	dependencies[] = { "@RHSSAF", "@RHSGREF", "@RHSAFRF" };
	displayName = "RHS SAF - Serbian Armed Forces (Airborne)";

	lightCars[] = {
		"rhssaf_army_o_m1151_olive_pkm",
		"rhssaf_army_o_m1025_olive_m2"
	};
	heavyCars[] = {
		"rhsgref_BRDM2_b"
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
	transportHelicopters[] = {
		"rhssaf_airforce_o_ht48",
		"rhssaf_airforce_o_ht40"
	};
	cargoAircraft[] = {
		"RHS_C130J"
	};
	casAircraft[] = {
		"rhssaf_airforce_o_l_18_101"
	};
	attackHelicopters[] = {
		"RHS_AH64D_wd"
	};
	infantry[] = {
		"rhssaf_army_o_m10_para_asst_mgun_m84",
		"rhssaf_army_o_m10_para_asst_mgun_minimi",
		"rhssaf_army_o_m10_para_asst_spec_aa",
		"rhssaf_army_o_m10_para_asst_spec_at",
		"rhssaf_army_o_m10_para_engineer",
		"rhssaf_army_o_m10_para_exp",
		"rhssaf_army_o_m10_para_medic",
		"rhssaf_army_o_m10_para_ft_lead",
		"rhssaf_army_o_m10_para_gl_ag36",
		"rhssaf_army_o_m10_para_gl_m320",
		"rhssaf_army_o_m10_para_gl_m320",
		"rhssaf_army_o_m10_para_mgun_m84",
		"rhssaf_army_o_m10_para_mgun_minimi",
		"rhssaf_army_o_m10_para_sniper_m76",
		"rhssaf_army_o_m10_para_sniper_scarH",
		"rhssaf_army_o_m10_para_spec_aa",
		"rhssaf_army_o_m10_para_spec_at",
		"rhssaf_army_o_m10_para_officer",
		"rhssaf_army_o_m10_para_repair",
		"rhssaf_army_o_m10_para_rifleman_ammo",
		"rhssaf_army_o_m10_para_rifleman_at",
		"rhssaf_army_o_m10_para_rifleman_hk416",
		"rhssaf_army_o_m10_para_rifleman_g36",
		"rhssaf_army_o_m10_para_rifleman_m21",
		"rhssaf_army_o_m10_para_sniper_m82a1",
		"rhssaf_army_o_m10_para_spotter",
		"rhssaf_army_o_m10_para_sq_lead"
	};
};

class RHSSAF_DIGITAL_faction : RHSSAF_AIRBORNE_faction
{
	displayName = "RHS SAF - Serbian Armed Forces (Digital)";

	infantry[] = {
		"rhssaf_army_o_m10_digital_asst_mgun_m84",
		"rhssaf_army_o_m10_digital_asst_spec_aa",
		"rhssaf_army_o_m10_digital_asst_spec_at",
		"rhssaf_army_o_m10_digital_engineer",
		"rhssaf_army_o_m10_digital_exp",
		"rhssaf_army_o_m10_digital_medic",
		"rhssaf_army_o_m10_digital_ft_lead",
		"rhssaf_army_o_m10_digital_gl",
		"rhssaf_army_o_m10_digital_mgun_m84",
		"rhssaf_army_o_m10_digital_sniper_m76",
		"rhssaf_army_o_m10_digital_spec_aa",
		"rhssaf_army_o_m10_digital_spec_at",
		"rhssaf_army_o_m10_digital_officer",
		"rhssaf_army_o_m10_digital_repair",
		"rhssaf_army_o_m10_digital_rifleman_ammo",
		"rhssaf_army_o_m10_digital_rifleman_at",
		"rhssaf_army_o_m10_digital_rifleman_m21",
		"rhssaf_army_o_m10_digital_rifleman_m70",
		"rhssaf_army_o_m10_digital_spotter",
		"rhssaf_army_o_m10_digital_sq_lead"
	};
};

class RHSSAF_OAKLEAF_faction : RHSSAF_AIRBORNE_faction
{
	displayName = "RHS SAF - Serbian Armed Forces (Oakleaf)";

	infantry[] = {
		"rhssaf_army_o_m10_oakleaf_asst_mgun_m84",
		"rhssaf_army_o_m10_oakleaf_asst_spec_aa",
		"rhssaf_army_o_m10_oakleaf_asst_spec_at",
		"rhssaf_army_o_m10_oakleaf_engineer",
		"rhssaf_army_o_m10_oakleaf_exp",
		"rhssaf_army_o_m10_oakleaf_medic",
		"rhssaf_army_o_m10_oakleaf_ft_lead",
		"rhssaf_army_o_m10_oakleaf_gl",
		"rhssaf_army_o_m10_oakleaf_mgun_m84",
		"rhssaf_army_o_m10_oakleaf_sniper_m76",
		"rhssaf_army_o_m10_oakleaf_spec_aa",
		"rhssaf_army_o_m10_oakleaf_spec_at",
		"rhssaf_army_o_m10_oakleaf_officer",
		"rhssaf_army_o_m10_oakleaf_repair",
		"rhssaf_army_o_m10_oakleaf_rifleman_ammo",
		"rhssaf_army_o_m10_oakleaf_rifleman_at",
		"rhssaf_army_o_m10_oakleaf_rifleman_m21",
		"rhssaf_army_o_m10_oakleaf_rifleman_m70",
		"rhssaf_army_o_m10_oakleaf_spotter",
		"rhssaf_army_o_m10_oakleaf_sq_lead"
	};
};

class RHSSAF_ALL_faction : RHSSAF_AIRBORNE_faction
{
	displayName = "RHS SAF - Serbian Armed Forces (All)";

	infantry[] = {
		"rhssaf_army_o_m10_para_asst_mgun_m84",
		"rhssaf_army_o_m10_para_asst_mgun_minimi",
		"rhssaf_army_o_m10_para_asst_spec_aa",
		"rhssaf_army_o_m10_para_asst_spec_at",
		"rhssaf_army_o_m10_para_engineer",
		"rhssaf_army_o_m10_para_exp",
		"rhssaf_army_o_m10_para_medic",
		"rhssaf_army_o_m10_para_ft_lead",
		"rhssaf_army_o_m10_para_gl_ag36",
		"rhssaf_army_o_m10_para_gl_m320",
		"rhssaf_army_o_m10_para_gl_m320",
		"rhssaf_army_o_m10_para_mgun_m84",
		"rhssaf_army_o_m10_para_mgun_minimi",
		"rhssaf_army_o_m10_para_sniper_m76",
		"rhssaf_army_o_m10_para_sniper_scarH",
		"rhssaf_army_o_m10_para_spec_aa",
		"rhssaf_army_o_m10_para_spec_at",
		"rhssaf_army_o_m10_para_officer",
		"rhssaf_army_o_m10_para_repair",
		"rhssaf_army_o_m10_para_rifleman_ammo",
		"rhssaf_army_o_m10_para_rifleman_at",
		"rhssaf_army_o_m10_para_rifleman_hk416",
		"rhssaf_army_o_m10_para_rifleman_g36",
		"rhssaf_army_o_m10_para_rifleman_m21",
		"rhssaf_army_o_m10_para_sniper_m82a1",
		"rhssaf_army_o_m10_para_spotter",
		"rhssaf_army_o_m10_para_sq_lead",
		"rhssaf_army_o_m10_digital_asst_mgun_m84",
		"rhssaf_army_o_m10_digital_asst_spec_aa",
		"rhssaf_army_o_m10_digital_asst_spec_at",
		"rhssaf_army_o_m10_digital_engineer",
		"rhssaf_army_o_m10_digital_exp",
		"rhssaf_army_o_m10_digital_medic",
		"rhssaf_army_o_m10_digital_ft_lead",
		"rhssaf_army_o_m10_digital_gl",
		"rhssaf_army_o_m10_digital_mgun_m84",
		"rhssaf_army_o_m10_digital_sniper_m76",
		"rhssaf_army_o_m10_digital_spec_aa",
		"rhssaf_army_o_m10_digital_spec_at",
		"rhssaf_army_o_m10_digital_officer",
		"rhssaf_army_o_m10_digital_repair",
		"rhssaf_army_o_m10_digital_rifleman_ammo",
		"rhssaf_army_o_m10_digital_rifleman_at",
		"rhssaf_army_o_m10_digital_rifleman_m21",
		"rhssaf_army_o_m10_digital_rifleman_m70",
		"rhssaf_army_o_m10_digital_spotter",
		"rhssaf_army_o_m10_digital_sq_lead",
		"rhssaf_army_o_m10_oakleaf_asst_mgun_m84",
		"rhssaf_army_o_m10_oakleaf_asst_spec_aa",
		"rhssaf_army_o_m10_oakleaf_asst_spec_at",
		"rhssaf_army_o_m10_oakleaf_engineer",
		"rhssaf_army_o_m10_oakleaf_exp",
		"rhssaf_army_o_m10_oakleaf_medic",
		"rhssaf_army_o_m10_oakleaf_ft_lead",
		"rhssaf_army_o_m10_oakleaf_gl",
		"rhssaf_army_o_m10_oakleaf_mgun_m84",
		"rhssaf_army_o_m10_oakleaf_sniper_m76",
		"rhssaf_army_o_m10_oakleaf_spec_aa",
		"rhssaf_army_o_m10_oakleaf_spec_at",
		"rhssaf_army_o_m10_oakleaf_officer",
		"rhssaf_army_o_m10_oakleaf_repair",
		"rhssaf_army_o_m10_oakleaf_rifleman_ammo",
		"rhssaf_army_o_m10_oakleaf_rifleman_at",
		"rhssaf_army_o_m10_oakleaf_rifleman_m21",
		"rhssaf_army_o_m10_oakleaf_rifleman_m70",
		"rhssaf_army_o_m10_oakleaf_spotter",
		"rhssaf_army_o_m10_oakleaf_sq_lead"
	};
};
