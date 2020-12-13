class RHSGREF_HIDF_faction
{
	displayName = "RHS GREF - Horizon Islands Defence Force";

	lightCars[] = {
		"rhsgref_hidf_m1025_m2",
		"rhsgref_hidf_m1025_mk19"
	};
	heavyCars[] = {
		"rhsusf_m1240a1_m2crows_usarmy_wd",
		"rhsusf_m1240a1_mk19crows_usarmy_wd"
	};
	lightArmor[] = {
		"rhsgref_hidf_m113a3_mk19",
		"rhsgref_hidf_m113a3_m2"
	};
	transportHelicopters[] = {
		"rhs_uh1h_hidf_gunship"
	};
	cargoAircraft[] = {
		"RHS_C130J"
	};
	casAircraft[] = {
		"RHSGREF_A29B_HIDF"
	};
	attackHelicopters[] = {
		"RHS_AH64D_wd"
	};
	infantry[] = {
		"rhsgref_hidf_autorifleman",
		"rhsgref_hidf_autorifleman_assist",
		"rhsgref_hidf_medic",
		"rhsgref_hidf_grenadier",
		"rhsgref_hidf_machinegunner",
		"rhsgref_hidf_machinegunner_assist",
		"rhsgref_hidf_marksman",
		"rhsgref_hidf_rifleman",
		"rhsgref_hidf_rifleman_m72",
		"rhsgref_hidf_sniper",
		"rhsgref_hidf_squadleader",
		"rhsgref_hidf_teamleader"
	};
};
//O_Heli_Attack_02_dynamicLoadout_black_F
class RHSGREF_CDF_faction
{
	displayName = "RHS GREF - CDF";
	
	lightCars[] = {
		"rhsgref_cdf_b_reg_uaz_ags",
		"rhsgref_cdf_b_reg_uaz_dshkm"
	};
	heavyCars[] = {
		"rhsgref_BRDM2_b"
	};
	lightArmor[] = {
		"rhsgref_cdf_b_bmd1",
		"rhsgref_cdf_b_bmd1k",
		"rhsgref_cdf_b_bmd1p",
		"rhsgref_cdf_b_bmd1pk",
		"rhsgref_cdf_b_bmd2",
		"rhsgref_cdf_b_bmd2k",
		"rhsgref_cdf_b_bmp1",
		"rhsgref_cdf_b_bmp1d",
		"rhsgref_cdf_b_bmp1k",
		"rhsgref_cdf_b_bmp1p",
		"rhsgref_cdf_b_bmp2e",
		"rhsgref_cdf_b_bmp2",
		"rhsgref_cdf_b_bmp2d",
		"rhsgref_cdf_b_bmp2k",
		"rhsgref_cdf_b_btr60",
		"rhsgref_cdf_b_btr70",
		"rhsgref_cdf_b_btr80"
	};
	heavyArmor[] = {
		"rhsgref_cdf_b_t72ba_tv",
		"rhsgref_cdf_b_t72bb_tv",
		"rhsgref_cdf_b_t80b_tv",
		"rhsgref_cdf_b_t80bv_tv"
	};
	transportHelicopters[] = {
		"rhsgref_cdf_b_reg_Mi17Sh"
	};
	cargoAircraft[] = {
		"RHS_AN2_B"
	};
	casAircraft[] = {
		"rhs_l39_cdf_b_cdf",
		"rhsgref_cdf_b_mig29s",
		"rhsgref_cdf_b_su25"
	};
	attackHelicopters[] = {
		"rhs_mi28n_vvsc"
	};
	infantry[] = {
		"rhsgref_cdf_b_reg_specialist_aa",
		"rhsgref_cdf_b_reg_grenadier_rpg",
		"rhsgref_cdf_b_reg_engineer",
		"rhsgref_cdf_b_reg_machinegunner",
		"rhsgref_cdf_b_reg_marksman",
		"rhsgref_cdf_b_reg_medic",
		"rhsgref_cdf_b_reg_rifleman",
		"rhsgref_cdf_b_reg_rifleman_akm",
		"rhsgref_cdf_b_reg_rifleman_aks74",
		"rhsgref_cdf_b_reg_grenadier",
		"rhsgref_cdf_b_reg_rifleman_lite",
		"rhsgref_cdf_b_reg_rifleman_rpg75",
		"rhsgref_cdf_b_reg_squadleader"
	};
};

class RHSGREF_CDF_GUARD_faction : RHSGREF_CDF_faction
{
	displayName = "RHS GREF - CDF Guard";

	infantry[] = {
		"rhsgref_cdf_b_ngd_grenadier_rpg",
		"rhsgref_cdf_b_ngd_engineer",
		"rhsgref_cdf_b_ngd_machinegunner",
		"rhsgref_cdf_b_ngd_medic",
		"rhsgref_cdf_b_ngd_rifleman",
		"rhsgref_cdf_b_ngd_rifleman_ak74",
		"rhsgref_cdf_b_ngd_grenadier",
		"rhsgref_cdf_b_ngd_rifleman_lite",
		"rhsgref_cdf_b_ngd_rifleman_rpg75",
		"rhsgref_cdf_b_ngd_squadleader"
	};
};

class RHSGREF_CDF_PARA_faction : RHSGREF_CDF_faction
{
	displayName = "RHS GREF - CDF Paratroopers";

	infantry[] = {
		"rhsgref_cdf_b_para_grenadier",
		"rhsgref_cdf_b_para_grenadier_rpg",
		"rhsgref_cdf_b_para_autorifleman",
		"rhsgref_cdf_b_para_engineer",
		"rhsgref_cdf_b_para_machinegunner",
		"rhsgref_cdf_b_para_marksman",
		"rhsgref_cdf_b_para_medic",
		"rhsgref_cdf_b_para_rifleman_lite",
		"rhsgref_cdf_b_para_squadleader"
	};
};

class RHSGREF_CHDKZ
{
	displayName = "RHS GREF - ChDKZ";

	lightCars[] = {
		"rhsgref_ins_uaz_ags",
		"rhsgref_ins_uaz_dshkm"
	};
	heavyCars[] = {
		"rhsgref_BRDM2_ins"
	};
	lightArmor[] = {
		"rhsgref_ins_btr60",
		"rhsgref_ins_btr70",
		"rhsgref_ins_bmd1",
		"rhsgref_ins_bmd1p",
		"rhsgref_ins_bmd2",
		"rhsgref_ins_bmp1",
		"rhsgref_ins_bmp1d",
		"rhsgref_ins_bmp1k",
		"rhsgref_ins_bmp1p",
		"rhsgref_ins_bmp2e",
		"rhsgref_ins_bmp2",
		"rhsgref_ins_bmp2d",
		"rhsgref_ins_bmp2k"
	};
	heavyArmor[] = {
		"rhsgref_ins_t72ba",
		"rhsgref_ins_t72bb",
		"rhsgref_ins_t72bc"
	};
	transportHelicopters[] = {
		"RHS_Mi8mt_vdv"
	};
	cargoAircraft[] = {
		"RHS_AN2_B"
	};
	casAircraft[] = {
		"RHS_Su25SM_vvsc"
	};
	attackHelicopters[] = {
		"rhs_mi28n_vvsc"
	};
	infantry[] = {
		"rhsgref_ins_specialist_aa",
		"rhsgref_ins_grenadier_rpg",
		"rhsgref_ins_machinegunner",
		"rhsgref_ins_medic",
		"rhsgref_ins_militiaman_mosin",
		"rhsgref_ins_squadleader",
		"rhsgref_ins_rifleman",
		"rhsgref_ins_rifleman_akm",
		"rhsgref_ins_rifleman_aks74",
		"rhsgref_ins_rifleman_aksu",
		"rhsgref_ins_grenadier",
		"rhsgref_ins_rifleman_RPG26",
		"rhsgref_ins_saboteur",
		"rhsgref_ins_engineer",
		"rhsgref_ins_sniper",
		"rhsgref_ins_spotter"
	};
};

class RHSGREF_TLA_faction : RHSGREF_CHDKZ
{
	displayName = "RHS GREF - Tanoan Liberation Army";

	lightCars[] = {
		"rhsgref_tla_offroad_armed"
	};
	lightArmor[] = {
		"rhsgref_tla_btr60"
	};
	infantry[] = {
		"rhsgref_tla_specialist_at",
		"rhsgref_tla_squadleader",
		"rhsgref_tla_grenadier",
		"rhsgref_tla_rifleman",
		"rhsgref_tla_rifleman_akms",
		"rhsgref_tla_rifleman_l1a1",
		"rhsgref_tla_rifleman_m1",
		"rhsgref_tla_rifleman_m14",
		"rhsgref_tla_rifleman_M16",
		"rhsgref_tla_rifleman_pm63",
		"rhsgref_tla_rifleman_rpg75",
		"rhsgref_tla_rifleman_vz58",
		"rhsgref_tla_machinegunner",
		"rhsgref_tla_machinegunner_mg42",
		"rhsgref_tla_marksman_m14",
		"rhsgref_tla_mechanic",
		"rhsgref_tla_medic",
		"rhsgref_tla_saboteur"
	};
};

class RHSGREF_NAPA_MILITIA_faction
{
	displayName = "RHS GREF - NAPA Militia";

	lightCars[] = {
		"rhsgref_nat_uaz_ags",
		"rhsgref_nat_uaz_dshkm"
	};
	heavyCars[] = {
		"rhsgref_BRDM2_b"
	};
	lightArmor[] = {
		"rhsgref_nat_btr70"
	};
	heavyArmor[] = {
		"rhsgref_ins_t72bc"
	};
	transportHelicopters[] = {
		"rhsgref_cdf_b_reg_Mi17Sh"
	};
	cargoAircraft[] = {
		"RHS_AN2_B"
	};
	casAircraft[] = {
		"RHSGREF_A29B_HIDF"
	};
	attackHelicopters[] = {
		"rhs_mi28n_vvsc"
	};
	infantry[] = {
		"rhsgref_nat_specialist_aa",
		"rhsgref_nat_grenadier_rpg",
		"rhsgref_nat_commander",
		"rhsgref_nat_hunter",
		"rhsgref_nat_machinegunner",
		"rhsgref_nat_machinegunner_mg42",
		"rhsgref_nat_medic",
		"rhsgref_nat_militiaman_kar98k",
		"rhsgref_nat_rifleman_akms",
		"rhsgref_nat_rifleman_aks74",
		"rhsgref_nat_grenadier",
		"rhsgref_nat_rifleman_mp44",
		"rhsgref_nat_rifleman",
		"rhsgref_nat_rifleman_vz58",
		"rhsgref_nat_saboteur",
		"rhsgref_nat_scout",
		"rhsgref_nat_warlord"
	};
};

class RHSGREF_NAPA_PARA_faction : RHSGREF_NAPA_MILITIA_faction
{
	displayName = "RHS GREF - NAPA Paramilitary";

	infantry[] = {
		"rhsgref_nat_pmil_specialist_aa",
		"rhsgref_nat_pmil_grenadier_rpg",
		"rhsgref_nat_pmil_commander",
		"rhsgref_nat_pmil_machinegunner",
		"rhsgref_nat_pmil_hunter",
		"rhsgref_nat_pmil_medic",
		"rhsgref_nat_pmil_rifleman_akm",
		"rhsgref_nat_pmil_rifleman_aksu",
		"rhsgref_nat_pmil_grenadier",
		"rhsgref_nat_pmil_rifleman",
		"rhsgref_nat_pmil_saboteur",
		"rhsgref_nat_pmil_scout"
	};
};