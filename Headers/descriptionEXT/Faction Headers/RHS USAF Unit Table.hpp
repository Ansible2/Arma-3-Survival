class RHSUSF_ARMY_DES_faction
{
	dependencies[] = { "@RHSUSAF" };
	displayName = "RHS USAF - US ARMY (Desert)";
	lightCars[] = {
		"rhsusf_m1025_d_m2",
		"rhsusf_m1025_d_Mk19",
		"rhsusf_m1043_d_m2",
		"rhsusf_m1043_d_mk19",
		"rhsusf_m1151_m2_v1_usarmy_d",
		"rhsusf_m1151_m2_lras3_v1_usarmy_d",
		"rhsusf_m1151_m240_v1_usarmy_d",
		"rhsusf_m1151_mk19_v1_usarmy_d",
		"rhsusf_m1151_m2_v2_usarmy_d",
		"rhsusf_m1151_m240_v2_usarmy_d",
		"rhsusf_m1151_mk19_v2_usarmy_d"
	};
	heavyCars[] = {
		"rhsusf_m1151_m2crows_usarmy_d",
		"rhsusf_m1151_mk19crows_usarmy_d",
		"rhsusf_M1220_M153_M2_usarmy_d",
		"rhsusf_M1220_M153_MK19_usarmy_d",
		"rhsusf_M1220_M2_usarmy_d",
		"rhsusf_M1220_MK19_usarmy_d",
		"rhsusf_M1230_M2_usarmy_d",
		"rhsusf_M1230_MK19_usarmy_d",
		"rhsusf_M1232_M2_usarmy_d",
		"rhsusf_M1232_MK19_usarmy_d",
		"rhsusf_M1237_M2_usarmy_d",
		"rhsusf_M1237_MK19_usarmy_d",
		"rhsusf_m1240a1_m2_usarmy_d",
		"rhsusf_m1240a1_m240_usarmy_d",
		"rhsusf_m1240a1_mk19_usarmy_d",
		"rhsusf_m1240a1_m2_uik_usarmy_d",
		"rhsusf_m1240a1_m240_uik_usarmy_d",
		"rhsusf_m1240a1_mk19_uik_usarmy_d",
		"rhsusf_m1240a1_m2crows_usarmy_d",
		"rhsusf_m1240a1_mk19crows_usarmy_d"
	};
	lightArmor[] = {
		"rhsusf_M1117_D",
		"RHS_M2A2",
		"RHS_M2A2_BUSKI",
		"RHS_M2A3",
		"RHS_M2A3_BUSKI",
		"RHS_M2A3_BUSKIII",
		"RHS_M6",
		"rhsusf_stryker_m1126_m2_d",
		"rhsusf_stryker_m1126_mk19_d",
		"rhsusf_stryker_m1132_m2_d",
		"rhsusf_stryker_m1132_m2_np_d",
		"rhsusf_m113d_usarmy",
		"rhsusf_m113d_usarmy_M240",
		"rhsusf_m113d_usarmy_MK19"
	};
	heavyArmor[] = {
		"rhsusf_m1a1aimd_usarmy",
		"rhsusf_m1a1aim_tuski_d",
		"rhsusf_m1a2sep1d_usarmy",
		"rhsusf_m1a2sep1tuskid_usarmy",
		"rhsusf_m1a2sep1tuskiid_usarmy"
	};
	transportHelicopters[] = {
		"RHS_CH_47F_10",
		"RHS_CH_47F_light",
		"RHS_UH60M_d"
	};
	cargoAircraft[] = {
		"RHS_C130J"
	};
	casAircraft[] = {
		"B_Plane_CAS_01_dynamicLoadout_F",
		"RHS_A10"
	};
	attackHelicopters[] = {
		"RHS_AH64D"
	};
	infantry[] = {
		"rhsusf_army_ocp_javelin_assistant",
		"rhsusf_army_ocp_javelin",
		"rhsusf_army_ocp_autorifleman",
		"rhsusf_army_ocp_autoriflemana",
		"rhsusf_army_ocp_medic",
		"rhsusf_army_ocp_engineer",
		"rhsusf_army_ocp_explosives",
		"rhsusf_army_ocp_fso",
		"rhsusf_army_ocp_grenadier",
		"rhsusf_army_ocp_jfo",
		"rhsusf_army_ocp_machinegunner",
		"rhsusf_army_ocp_machinegunnera",
		"rhsusf_army_ocp_marksman",
		"rhsusf_army_ocp_rifleman",
		"rhsusf_army_ocp_riflemanat",
		"rhsusf_army_ocp_rifleman_m16",
		"rhsusf_army_ocp_rifleman_m4",
		"rhsusf_army_ocp_sniper",
		"rhsusf_army_ocp_sniper_m24sws",
		"rhsusf_army_ocp_squadleader",
		"rhsusf_army_ocp_teamleader",
		"rhsusf_army_ocp_rifleman_m590"
	};
};

class RHSUSF_ARMY_DES_CRYE_faction : RHSUSF_ARMY_DES_faction
{
	dependencies[] = { "@RHSUSAF" };
	displayName = "RHS USAF - US ARMY (Desert CRYE)";

	infantry[] = {
		"rhsusf_army_ocp_arb_maaws",
		"rhsusf_army_ocp_arb_autorifleman",
		"rhsusf_army_ocp_arb_autoriflemana",
		"rhsusf_army_ocp_arb_rifleman_m590",
		"rhsusf_army_ocp_arb_medic",
		"rhsusf_army_ocp_arb_engineer",
		"rhsusf_army_ocp_arb_grenadier",
		"rhsusf_army_ocp_arb_machinegunner",
		"rhsusf_army_ocp_arb_machinegunnera",
		"rhsusf_army_ocp_arb_marksman",
		"rhsusf_army_ocp_arb_rifleman",
		"rhsusf_army_ocp_arb_riflemanat",
		"rhsusf_army_ocp_rifleman_arb_m16",
		"rhsusf_army_ocp_arb_squadleader",
		"rhsusf_army_ocp_arb_teamleader"
	};
};

class RHSUSF_ARMY_WDL_faction : RHSUSF_ARMY_DES_faction
{
	dependencies[] = { "@RHSUSAF" };
	displayName = "RHS USAF - US ARMY (Woodland)";

	lightCars[] = {
		"rhsusf_m1025_w_m2",
		"rhsusf_m1025_w_mk19",
		"rhsusf_m1043_w_m2",
		"rhsusf_m1043_w_mk19",
		"rhsusf_m1151_m2_v1_usarmy_wd",
		"rhsusf_m1151_m2_lras3_v1_usarmy_wd",
		"rhsusf_m1151_m240_v1_usarmy_wd",
		"rhsusf_m1151_mk19_v1_usarmy_wd",
		"rhsusf_m1151_m2_v2_usarmy_wd",
		"rhsusf_m1151_m240_v2_usarmy_wd",
		"rhsusf_m1151_mk19_v2_usarmy_wd"
	};
	heavyCars[] = {
		"rhsusf_m1151_m2crows_usarmy_wd",
		"rhsusf_m1151_mk19crows_usarmy_wd",
		"rhsusf_M1220_M153_M2_usarmy_wd",
		"rhsusf_M1220_M153_MK19_usarmy_wd",
		"rhsusf_M1220_M2_usarmy_wd",
		"rhsusf_M1220_MK19_usarmy_wd",
		"rhsusf_M1230_M2_usarmy_wd",
		"rhsusf_M1230_MK19_usarmy_wd",
		"rhsusf_M1232_M2_usarmy_wd",
		"rhsusf_M1232_MK19_usarmy_wd",
		"rhsusf_M1237_M2_usarmy_wd",
		"rhsusf_M1237_MK19_usarmy_wd",
		"rhsusf_m1240a1_m2_usarmy_wd",
		"rhsusf_m1240a1_m240_usarmy_wd",
		"rhsusf_m1240a1_mk19_usarmy_wd",
		"rhsusf_m1240a1_m2_uik_usarmy_wd",
		"rhsusf_m1240a1_m240_uik_usarmy_wd",
		"rhsusf_m1240a1_mk19_uik_usarmy_wd",
		"rhsusf_m1240a1_m2crows_usarmy_wd",
		"rhsusf_m1240a1_mk19crows_usarmy_wd"
	};
	lightArmor[] = {
		"rhsusf_M1117_O",
		"rhsusf_stryker_m1126_m2_wd",
		"rhsusf_stryker_m1126_mk19_wd",
		"rhsusf_stryker_m1127_m2_wd",
		"rhsusf_stryker_m1132_m2_np_wd",
		"rhsusf_stryker_m1132_m2_wd",
		"rhsusf_m113_usarmy",
		"rhsusf_m113_usarmy_M2_90",
		"rhsusf_m113_usarmy_M240",
		"rhsusf_m113_usarmy_MK19",
		"rhsusf_m113_usarmy_MK19_90",
		"RHS_M2A2_wd",
		"RHS_M2A2_BUSKI_WD",
		"RHS_M2A3_wd",
		"RHS_M2A3_BUSKI_wd",
		"RHS_M2A3_BUSKIII_wd",
		"RHS_M6_wd",
		"rhsusf_M1117_W"
	};
	heavyArmor[] = {
		"rhsusf_m1a1aimwd_usarmy",
		"rhsusf_m1a1aim_tuski_wd",
		"rhsusf_m1a2sep1wd_usarmy",
		"rhsusf_m1a2sep1tuskiwd_usarmy",
		"rhsusf_m1a2sep1tuskiiwd_usarmy"
	};
	transportHelicopters[] = {
		"RHS_CH_47F",
		"RHS_UH60M"
	};
	infantry[] = {
		"rhsusf_army_ocp_javelin_assistant",
		"rhsusf_army_ocp_javelin",
		"rhsusf_army_ocp_autorifleman",
		"rhsusf_army_ocp_autoriflemana",
		"rhsusf_army_ocp_medic",
		"rhsusf_army_ocp_engineer",
		"rhsusf_army_ocp_explosives",
		"rhsusf_army_ocp_fso",
		"rhsusf_army_ocp_grenadier",
		"rhsusf_army_ocp_jfo",
		"rhsusf_army_ocp_machinegunner",
		"rhsusf_army_ocp_machinegunnera",
		"rhsusf_army_ocp_marksman",
		"rhsusf_army_ocp_rifleman",
		"rhsusf_army_ocp_riflemanat",
		"rhsusf_army_ocp_rifleman_m16",
		"rhsusf_army_ocp_rifleman_m4",
		"rhsusf_army_ocp_sniper",
		"rhsusf_army_ocp_sniper_m24sws",
		"rhsusf_army_ocp_squadleader",
		"rhsusf_army_ocp_teamleader",
		"rhsusf_army_ocp_rifleman_m590"
	};
};

class RHSUSF_ARMY_WDL_CRYE_faction : RHSUSF_ARMY_DES_faction
{
	dependencies[] = { "@RHSUSAF" };
	displayName = "RHS USAF - US ARMY (Woodland CRYE)";

	infantry[] = {
		"rhsusf_army_ocp_arb_maaws",
		"rhsusf_army_ocp_arb_autorifleman",
		"rhsusf_army_ocp_arb_autoriflemana",
		"rhsusf_army_ocp_arb_rifleman_m590",
		"rhsusf_army_ocp_arb_medic",
		"rhsusf_army_ocp_arb_engineer",
		"rhsusf_army_ocp_arb_grenadier",
		"rhsusf_army_ocp_arb_machinegunner",
		"rhsusf_army_ocp_arb_machinegunnera",
		"rhsusf_army_ocp_arb_marksman",
		"rhsusf_army_ocp_arb_rifleman",
		"rhsusf_army_ocp_arb_riflemanat",
		"rhsusf_army_ocp_rifleman_arb_m16",
		"rhsusf_army_ocp_arb_squadleader",
		"rhsusf_army_ocp_arb_teamleader"
	};
};

class RHSUSF_ARMY_DES_UCP_faction : RHSUSF_ARMY_DES_faction
{
	dependencies[] = { "@RHSUSAF" };
	displayName = "RHS USAF - US ARMY (Desert UCP)";

	infantry[] = {
		"rhsusf_army_ucp_aa",
		"rhsusf_army_ucp_javelin_assistant",
		"rhsusf_army_ucp_javelin",
		"rhsusf_army_ucp_maaws",
		"rhsusf_army_ucp_autorifleman",
		"rhsusf_army_ucp_autoriflemana",
		"rhsusf_army_ucp_rifleman_m590",
		"rhsusf_army_ucp_medic",
		"rhsusf_army_ucp_engineer",
		"rhsusf_army_ucp_explosives",
		"rhsusf_army_ucp_fso",
		"rhsusf_army_ucp_grenadier",
		"rhsusf_army_ucp_jfo",
		"rhsusf_army_ucp_machinegunner",
		"rhsusf_army_ucp_machinegunnera",
		"rhsusf_army_ucp_marksman",
		"rhsusf_army_ucp_officer",
		"rhsusf_army_ucp_rifleman",
		"rhsusf_army_ucp_riflemanl",
		"rhsusf_army_ucp_riflemanat",
		"rhsusf_army_ucp_rifleman_m16",
		"rhsusf_army_ucp_rifleman_m4",
		"rhsusf_army_ucp_sniper",
		"rhsusf_army_ucp_sniper_m24sws",
		"rhsusf_army_ucp_squadleader",
		"rhsusf_army_ucp_teamleader"
	};
};

class RHSUSF_ARMY_WDL_UCP_faction : RHSUSF_ARMY_WDL_faction
{
	dependencies[] = { "@RHSUSAF" };
	displayName = "RHS USAF - US ARMY (Woodland UCP)";

	infantry[] = {
		"rhsusf_army_ucp_aa",
		"rhsusf_army_ucp_javelin_assistant",
		"rhsusf_army_ucp_javelin",
		"rhsusf_army_ucp_maaws",
		"rhsusf_army_ucp_autorifleman",
		"rhsusf_army_ucp_autoriflemana",
		"rhsusf_army_ucp_rifleman_m590",
		"rhsusf_army_ucp_medic",
		"rhsusf_army_ucp_engineer",
		"rhsusf_army_ucp_explosives",
		"rhsusf_army_ucp_fso",
		"rhsusf_army_ucp_grenadier",
		"rhsusf_army_ucp_jfo",
		"rhsusf_army_ucp_machinegunner",
		"rhsusf_army_ucp_machinegunnera",
		"rhsusf_army_ucp_marksman",
		"rhsusf_army_ucp_officer",
		"rhsusf_army_ucp_rifleman",
		"rhsusf_army_ucp_riflemanl",
		"rhsusf_army_ucp_riflemanat",
		"rhsusf_army_ucp_rifleman_m16",
		"rhsusf_army_ucp_rifleman_m4",
		"rhsusf_army_ucp_sniper",
		"rhsusf_army_ucp_sniper_m24sws",
		"rhsusf_army_ucp_squadleader",
		"rhsusf_army_ucp_teamleader"
	};
};

class RHSUSF_ARMY_DES_UCP_CRYE_faction : RHSUSF_ARMY_DES_faction
{
	dependencies[] = { "@RHSUSAF" };
	displayName = "RHS USAF - US ARMY (Desert UCP CRYE)";

	infantry[] = {
		"rhsusf_army_ucp_arb_maaws",
		"rhsusf_army_ucp_arb_autorifleman",
		"rhsusf_army_ucp_arb_autoriflemana",
		"rhsusf_army_ucp_arb_rifleman_m590",
		"rhsusf_army_ucp_arb_medic",
		"rhsusf_army_ucp_arb_engineer",
		"rhsusf_army_ucp_arb_grenadier",
		"rhsusf_army_ucp_arb_machinegunner",
		"rhsusf_army_ucp_arb_machinegunnera",
		"rhsusf_army_ucp_arb_marksman",
		"rhsusf_army_ucp_arb_rifleman",
		"rhsusf_army_ucp_arb_riflemanl",
		"rhsusf_army_ucp_arb_riflemanat",
		"rhsusf_army_ucp_rifleman_arb_m16",
		"rhsusf_army_ucp_arb_squadleader",
		"rhsusf_army_ucp_arb_teamleader"
	};
};

class RHSUSF_ARMY_WDL_UCP_CRYE_faction : RHSUSF_ARMY_WDL_faction
{
	dependencies[] = { "@RHSUSAF" };
	displayName = "RHS USAF - US ARMY (Woodland UCP CRYE)";

	infantry[] = {
		"rhsusf_army_ucp_arb_maaws",
		"rhsusf_army_ucp_arb_autorifleman",
		"rhsusf_army_ucp_arb_autoriflemana",
		"rhsusf_army_ucp_arb_rifleman_m590",
		"rhsusf_army_ucp_arb_medic",
		"rhsusf_army_ucp_arb_engineer",
		"rhsusf_army_ucp_arb_grenadier",
		"rhsusf_army_ucp_arb_machinegunner",
		"rhsusf_army_ucp_arb_machinegunnera",
		"rhsusf_army_ucp_arb_marksman",
		"rhsusf_army_ucp_arb_rifleman",
		"rhsusf_army_ucp_arb_riflemanl",
		"rhsusf_army_ucp_arb_riflemanat",
		"rhsusf_army_ucp_rifleman_arb_m16",
		"rhsusf_army_ucp_arb_squadleader",
		"rhsusf_army_ucp_arb_teamleader"
	};
};

class RHSUSF_USMC_DES_faction
{
	dependencies[] = { "@RHSUSAF" };
	displayName = "RHS USAF - USMC Infantry (Desert)";

	lightCars[] = {
		"rhsusf_m1025_d_s_m2",
		"rhsusf_m1025_d_s_Mk19",
		"rhsusf_m1043_d_s_m2",
		"rhsusf_m1043_d_s_mk19",
		"rhsusf_m1151_m2_v3_usmc_d",
		"rhsusf_m1151_m240_v3_usmc_d",
		"rhsusf_m1151_mk19_v3_usmc_d"
	};
	heavyCars[] = {
		"rhsusf_m1151_m2crows_usmc_d",
		"rhsusf_m1151_mk19crows_usmc_d",
		"rhsusf_CGRCAT1A2_M2_usmc_d",
		"rhsusf_CGRCAT1A2_Mk19_usmc_d",
		"rhsusf_M1232_MC_M2_usmc_d",
		"rhsusf_M1232_MC_MK19_usmc_d",
		"rhsusf_m1240a1_m2_usmc_d",
		"rhsusf_m1240a1_m240_usmc_d",
		"rhsusf_m1240a1_mk19_usmc_d",
		"rhsusf_m1240a1_m2crows_usmc_d",
		"rhsusf_m1240a1_mk19crows_usmc_d"
	};
	heavyArmor[] = {
		"rhsusf_m1a1fep_d"
	};
	transportHelicopters[] = {
		"RHS_UH1Y",
		"rhsusf_CH53E_USMC_D"
	};
	cargoAircraft[] = {
		"RHS_C130J"
	};
	casAircraft[] = {
		"RHS_A10",
		"B_Plane_CAS_01_dynamicLoadout_F",
		"B_Plane_Fighter_01_F"
	};
	attackHelicopters[] = {
		"RHS_AH64DGrey"
	};
	infantry[] = {
		"rhsusf_usmc_marpat_d_smaw",
		"rhsusf_usmc_marpat_d_javelin_assistant",
		"rhsusf_usmc_marpat_d_javelin",
		"rhsusf_usmc_marpat_d_autorifleman_m249",
		"rhsusf_usmc_marpat_d_autorifleman",
		"rhsusf_usmc_marpat_d_autorifleman_m249_ass",
		"rhsusf_usmc_marpat_d_rifleman_m590",
		"rhsusf_usmc_marpat_d_engineer",
		"rhsusf_usmc_marpat_d_marksman",
		"rhsusf_usmc_marpat_d_explosives",
		"rhsusf_usmc_marpat_d_fso",
		"rhsusf_usmc_marpat_d_grenadier",
		"rhsusf_usmc_marpat_d_jfo",
		"rhsusf_usmc_marpat_d_machinegunner",
		"rhsusf_usmc_marpat_d_machinegunner_ass",
		"rhsusf_usmc_marpat_d_rifleman_light",
		"rhsusf_usmc_marpat_d_riflemanat",
		"rhsusf_usmc_marpat_d_rifleman",
		"rhsusf_usmc_marpat_d_rifleman_m4",
		"rhsusf_usmc_marpat_d_rifleman_law",
		"rhsusf_usmc_marpat_d_sniper_m110",
		"rhsusf_usmc_marpat_d_sniper",
		"rhsusf_usmc_marpat_d_spotter",
		"rhsusf_usmc_marpat_d_squadleader",
		"rhsusf_usmc_marpat_d_teamleader",
		"rhsusf_navy_marpat_d_medic"
	};
};

class RHSUSF_USMC_WDL_faction : RHSUSF_USMC_DES_faction
{
	dependencies[] = { "@RHSUSAF" };
	displayName = "RHS USAF - USMC Infantry (Woodland)";
	lightCars[] = {
		"rhsusf_m1025_w_s_m2",
		"rhsusf_m1025_w_s_Mk19",
		"rhsusf_m1043_w_s_m2",
		"rhsusf_m1043_w_s_mk19",
		"rhsusf_m1151_m2_v3_usmc_wd",
		"rhsusf_m1151_m240_v3_usmc_wd",
		"rhsusf_m1151_mk19_v3_usmc_wd"
	};
	heavyCars[] = {
		"rhsusf_m1151_m2crows_usmc_wd",
		"rhsusf_m1151_mk19crows_usmc_wd",
		"rhsusf_CGRCAT1A2_M2_usmc_wd",
		"rhsusf_CGRCAT1A2_Mk19_usmc_wd",
		"rhsusf_M1232_MC_M2_usmc_wd",
		"rhsusf_M1232_MC_MK19_usmc_wd",
		"rhsusf_m1240a1_m2_usmc_wd",
		"rhsusf_m1240a1_m240_usmc_wd",
		"rhsusf_m1240a1_mk19_usmc_wd",
		"rhsusf_m1240a1_m2crows_usmc_wd",
		"rhsusf_m1240a1_mk19crows_usmc_wd"
	};
	heavyArmor[] = {
		"rhsusf_m1a1fep_wd",
		"rhsusf_m1a1fep_od",
		"rhsusf_m1a1hc_wd"
	};
	infantry[] = {
		"rhsusf_usmc_marpat_wd_smaw",
		"rhsusf_usmc_marpat_wd_javelin_assistant",
		"rhsusf_usmc_marpat_wd_javelin",
		"rhsusf_usmc_marpat_wd_autorifleman_m249",
		"rhsusf_usmc_marpat_wd_autorifleman",
		"rhsusf_usmc_marpat_wd_autorifleman_m249_ass",
		"rhsusf_usmc_marpat_wd_rifleman_m590",
		"rhsusf_usmc_marpat_wd_engineer",
		"rhsusf_usmc_marpat_wd_marksman",
		"rhsusf_usmc_marpat_wd_explosives",
		"rhsusf_usmc_marpat_wd_fso",
		"rhsusf_usmc_marpat_wd_grenadier",
		"rhsusf_usmc_marpat_wd_jfo",
		"rhsusf_usmc_marpat_wd_machinegunner",
		"rhsusf_usmc_marpat_wd_machinegunner_ass",
		"rhsusf_usmc_marpat_wd_rifleman_light",
		"rhsusf_usmc_marpat_wd_riflemanat",
		"rhsusf_usmc_marpat_wd_rifleman",
		"rhsusf_usmc_marpat_wd_rifleman_m4",
		"rhsusf_usmc_marpat_wd_rifleman_law",
		"rhsusf_usmc_marpat_wd_sniper_m110",
		"rhsusf_usmc_marpat_wd_sniper",
		"rhsusf_usmc_marpat_wd_spotter",
		"rhsusf_usmc_marpat_wd_squadleader",
		"rhsusf_usmc_marpat_wd_teamleader",
		"rhsusf_navy_marpat_wd_medic"
	};
};

class RHSUSF_USMC_WDL_RECON_faction : RHSUSF_USMC_WDL_faction
{
	dependencies[] = { "@RHSUSAF" };
	displayName = "RHS USAF - USMC RECON (Woodland)";

	infantry[] = {
		"rhsusf_usmc_recon_marpat_wd_machinegunner_m249",
		"rhsusf_usmc_recon_marpat_wd_machinegunner_m249_fast",
		"rhsusf_usmc_recon_marpat_wd_machinegunner_m249_lite",
		"rhsusf_usmc_recon_marpat_wd_autorifleman",
		"rhsusf_usmc_recon_marpat_wd_autorifleman_fast",
		"rhsusf_usmc_recon_marpat_wd_autorifleman_lite",
		"rhsusf_usmc_recon_marpat_wd_machinegunner",
		"rhsusf_usmc_recon_marpat_wd_marksman",
		"rhsusf_usmc_recon_marpat_wd_marksman_fast",
		"rhsusf_usmc_recon_marpat_wd_marksman_lite",
		"rhsusf_usmc_recon_marpat_wd_officer",
		"rhsusf_usmc_recon_marpat_wd_rifleman",
		"rhsusf_usmc_recon_marpat_wd_rifleman_fast",
		"rhsusf_usmc_recon_marpat_wd_rifleman_lite",
		"rhsusf_usmc_recon_marpat_wd_rifleman_at",
		"rhsusf_usmc_recon_marpat_wd_rifleman_at_fast",
		"rhsusf_usmc_recon_marpat_wd_rifleman_at_lite",
		"rhsusf_usmc_recon_marpat_wd_teamleader",
		"rhsusf_usmc_recon_marpat_wd_teamleader_fast",
		"rhsusf_usmc_recon_marpat_wd_teamleader_lite",
		"rhsusf_navy_sarc_w",
		"rhsusf_navy_sarc_w_fast"
	};
};

class RHSUSF_USMC_DES_RECON_faction : RHSUSF_USMC_DES_faction
{
	dependencies[] = { "@RHSUSAF" };
	displayName = "RHS USAF - USMC RECON (Desert)";

	infantry[] = {
		"rhsusf_usmc_recon_marpat_d_machinegunner_m249",
		"rhsusf_usmc_recon_marpat_d_machinegunner_m249_fast",
		"rhsusf_usmc_recon_marpat_d_machinegunner_m249_lite",
		"rhsusf_usmc_recon_marpat_d_autorifleman",
		"rhsusf_usmc_recon_marpat_d_autorifleman_fast",
		"rhsusf_usmc_recon_marpat_d_autorifleman_lite",
		"rhsusf_usmc_recon_marpat_d_machinegunner",
		"rhsusf_usmc_recon_marpat_d_marksman",
		"rhsusf_usmc_recon_marpat_d_marksman_fast",
		"rhsusf_usmc_recon_marpat_d_marksman_lite",
		"rhsusf_usmc_recon_marpat_d_rifleman",
		"rhsusf_usmc_recon_marpat_d_officer",
		"rhsusf_usmc_recon_marpat_d_rifleman_fast",
		"rhsusf_usmc_recon_marpat_d_rifleman_lite",
		"rhsusf_usmc_recon_marpat_d_rifleman_at",
		"rhsusf_usmc_recon_marpat_d_rifleman_at_fast",
		"rhsusf_usmc_recon_marpat_d_rifleman_at_lite",
		"rhsusf_usmc_recon_marpat_d_teamleader",
		"rhsusf_usmc_recon_marpat_d_teamleader_fast",
		"rhsusf_usmc_recon_marpat_d_teamleader_lite",
		"rhsusf_navy_sarc_d",
		"rhsusf_navy_sarc_d_fast"
	};
};

class RHSUSF_MARSOC_faction : RHSUSF_USMC_DES_faction
{
	dependencies[] = { "@RHSUSAF" };
	displayName = "RHS USAF - MARSOC";
	lightCars[] = {
		"rhsusf_M1084A1R_SOV_M2_D_fmtv_socom",
		"rhsusf_M1078A1R_SOV_M2_D_fmtv_socom"
	};
	heavyCars[] = {
		"rhsusf_M1238A1_M2_socom_d",
		"rhsusf_M1238A1_Mk19_socom_d",
		"rhsusf_M1239_M2_socom_d",
		"rhsusf_M1239_MK19_socom_d",
		"rhsusf_M1239_M2_Deploy_socom_d",
		"rhsusf_M1239_MK19_Deploy_socom_d",
		"rhsusf_m1245_m2crows_socom_d",
		"rhsusf_m1245_mk19crows_socom_d",
		"rhsusf_m1245_m2crows_socom_deploy",
		"rhsusf_m1245_mk19crows_socom_deploy"
	};
	transportHelicopters[] = {
		"RHS_UH1Y_d",
		"RHS_MELB_MH6M"
	};
	infantry[] = {
		"rhsusf_army_ocp_arb_maaws",
		"rhsusf_army_ocp_arb_autorifleman",
		"rhsusf_army_ocp_arb_autoriflemana",
		"rhsusf_army_ocp_arb_rifleman_m590",
		"rhsusf_army_ocp_arb_medic",
		"rhsusf_army_ocp_arb_engineer",
		"rhsusf_army_ocp_arb_grenadier",
		"rhsusf_army_ocp_arb_machinegunner",
		"rhsusf_army_ocp_arb_machinegunnera",
		"rhsusf_army_ocp_arb_marksman",
		"rhsusf_army_ocp_arb_rifleman",
		"rhsusf_army_ocp_arb_riflemanat",
		"rhsusf_army_ocp_rifleman_arb_m16",
		"rhsusf_army_ocp_arb_squadleader",
		"rhsusf_army_ocp_arb_teamleader"
	};
};