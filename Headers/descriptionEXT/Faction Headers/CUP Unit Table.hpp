class CUP_ACR_DES_faction
{
	displayName = "CUP - Army of the Czech Republic (Desert)";

	lightCars[] = {
		"CUP_B_LR_MG_CZ_W",
		"CUP_B_UAZ_MG_ACR",
		"CUP_B_LR_Special_Des_CZ_D",
		"CUP_B_LR_Special_CZ_W"
	};
	heavyCars[] = {
		"CUP_B_HMMWV_DSHKM_GPK_ACR",
		"CUP_B_HMMWV_M2_GPK_ACR",
		"CUP_B_Dingo_CZ_Des",
		"CUP_B_Dingo_GL_CZ_Des",
		"CUP_B_BRDM2_HQ_CZ_Des"
	};
	lightArmor[] = {
		"CUP_B_BRDM2_CZ_Des",
		"CUP_B_BMP2_CZ_Des",
		"CUP_B_BMP_HQ_CZ_Des"
	};
	heavyArmor[] = {
		"CUP_B_T72_CZ"
	};
	transportHelicopters[] = {
		"CUP_B_Mi171Sh_Unarmed_ACR"
	};
	cargoAircraft[] = {
		"CUP_B_C130J_USMC"
	};
	casAircraft[] = {
		"CUP_B_L39_CZ",
		"CUP_B_L39_CZ_GREY"
	};
	attackHelicopters[] = {
		"O_Heli_Attack_02_dynamicLoadout_black_F",
		"CUP_I_Mi24_Mk3_ION",
		"CUP_I_Mi24_Mk4_ION"
	};
	infantry[] = {
		"CUP_B_CZ_Soldier_ARPG_DES",
		"CUP_B_CZ_Soldier_AMG_DES",
		"CUP_B_CZ_Engineer_DES",
		"CUP_B_CZ_ExplosiveSpecialist_DES",
		"CUP_B_CZ_Soldier_805_GL_DES",
		"CUP_B_CZ_Soldier_MG_DES",
		"CUP_B_CZ_Soldier_Marksman_DES",
		"CUP_B_CZ_Medic_DES",
		"CUP_B_CZ_Soldier_DES",
		"CUP_B_CZ_Soldier_AR_DES",
		"CUP_B_CZ_Soldier_AT_DES",
		"CUP_B_CZ_Soldier_Backpack_DES",
		"CUP_B_CZ_Soldier_805_DES",
		"CUP_B_CZ_Soldier_Light_DES",
		"CUP_B_CZ_Soldier_RPG_DES",
		"CUP_B_CZ_Sniper_DES",
		"CUP_B_CZ_Spotter_DES",
		"CUP_B_CZ_Soldier_SL_DES"
	};
};

class CUP_ACR_WDL_faction : CUP_ACR_DES_faction
{
	displayName = "CUP - Army of the Czech Republic (Woodland)";

	lightCars[] = {
		"CUP_B_LR_MG_CZ_W",
		"CUP_B_UAZ_MG_ACR",
		"CUP_B_LR_Special_CZ_W"
	};
	heavyCars[] = {
		"CUP_B_BRDM2_HQ_CZ",
		"CUP_B_HMMWV_M2_GPK_ACR",
		"CUP_B_HMMWV_DSHKM_GPK_ACR",
		"CUP_B_Dingo_CZ_Wdl",
		"CUP_B_Dingo_GL_CZ_Wdl"
	};
	lightArmor[] = {
		"CUP_B_BRDM2_CZ",
		"CUP_B_BMP2_CZ",
		"CUP_B_BMP_HQ_CZ"
	};
	infantry[] = {
		"CUP_B_CZ_Soldier_ARPG_WDL",
		"CUP_B_CZ_Soldier_AMG_WDL",
		"CUP_B_CZ_Soldier_AR_WDL",
		"CUP_B_CZ_Engineer_WDL",
		"CUP_B_CZ_ExplosiveSpecialist_WDL",
		"CUP_B_CZ_Soldier_805_GL_WDL",
		"CUP_B_CZ_Soldier_MG_WDL",
		"CUP_B_CZ_Soldier_Marksman_WDL",
		"CUP_B_CZ_Medic_WDL",
		"CUP_B_CZ_Soldier_WDL",
		"CUP_B_CZ_Soldier_AT_WDL",
		"CUP_B_CZ_Soldier_backpack_WDL",
		"CUP_B_CZ_Soldier_805_WDL",
		"CUP_B_CZ_Soldier_Light_WDL",
		"CUP_B_CZ_Soldier_RPG_WDL",
		"CUP_B_CZ_Sniper_WDL",
		"CUP_B_CZ_Spotter_WDL",
		"CUP_B_CZ_Soldier_SL_WDL"
	};
};

class CUP_ACR_SF_DES_faction : CUP_ACR_DES_faction
{
	displayName = "CUP - Army of the Czech Republic Special Forces (Desert)";

	infantry[] = {
		"CUP_B_CZ_SpecOps_DES",
		"CUP_B_CZ_SpecOps_Exp_DES",
		"CUP_B_CZ_SpecOps_GL_DES",
		"CUP_B_CZ_SpecOps_MG_DES",
		"CUP_B_CZ_SpecOps_Recon_DES",
		"CUP_B_CZ_SpecOps_Scout_DES",
		"CUP_B_CZ_SpecOps_TL_DES"
	};
};

class CUP_ACR_SF_WDL_faction : CUP_ACR_WDL_faction
{
	displayName = "CUP - Army of the Czech Republic Special Forces (Woodland)";

	infantry[] = {
		"CUP_B_CZ_SpecOps_WDL",
		"CUP_B_CZ_SpecOps_Exp_WDL",
		"CUP_B_CZ_SpecOps_GL_WDL",
		"CUP_B_CZ_SpecOps_MG_WDL",
		"CUP_B_CZ_SpecOps_Recon_WDL",
		"CUP_B_CZ_SpecOps_Scout_WDL",
		"CUP_B_CZ_SpecOps_TL_WDL"
	};
};

class CUP_BAF_MTP_faction
{
	displayName = "CUP - British Armed Forces (Multicam)";
	
	lightCars[] = {
		"CUP_B_BAF_Coyote_GMG_D",
		"CUP_B_BAF_Coyote_L2A1_D",
		"CUP_B_Jackal2_L2A1_GB_D",
		"CUP_B_Jackal2_GMG_GB_D",
		"CUP_B_LR_Special_GMG_GB_D",
		"CUP_B_LR_Special_M2_GB_D",
		"CUP_B_LR_MG_GB_D"
	};
	heavyCars[] = {
		"CUP_B_Mastiff_GMG_GB_D",
		"CUP_B_Mastiff_HMG_GB_D",
		"CUP_B_Mastiff_LMG_GB_D",
		"CUP_B_Ridgback_GMG_GB_D",
		"CUP_B_Ridgback_HMG_GB_D",
		"CUP_B_Ridgback_LMG_GB_D",
		"CUP_B_Wolfhound_GMG_GB_D",
		"CUP_B_Wolfhound_HMG_GB_D",
		"CUP_B_Wolfhound_LMG_GB_D"
	};
	lightArmor[] = {
		"CUP_B_FV432_Bulldog_GB_D_RWS",
		"CUP_B_FV432_Bulldog_GB_D",
		"CUP_B_FV510_GB_D",
		"CUP_B_FV510_GB_D_SLAT",
		"CUP_B_MCV80_GB_D",
		"CUP_B_MCV80_GB_D_SLAT"
	};
	heavyArmor[] = {
		"CUP_B_Challenger2_Desert_BAF",
		"CUP_B_Challenger2_2CD_BAF"
	};
	transportHelicopters[] = {
		"CUP_B_CH47F_GB",
		"CUP_B_MH47E_GB",
		"CUP_B_AW159_Unarmed_GB",
		"CUP_B_Merlin_HC3_Armed_GB",
		"CUP_B_SA330_Puma_HC2_BAF",
		"CUP_B_SA330_Puma_HC1_BAF",
		"CUP_B_Merlin_HC4_GB",
		"CUP_B_Merlin_HC3_GB"
	};
	cargoAircraft[] = {
		"CUP_B_C130J_GB"
	};
	casAircraft[] = {
		"CUP_B_GR9_DYN_GB",
		"CUP_B_F35B_BAF"
	};
	attackHelicopters[] = {
		"CUP_B_AH1_DL_BAF"
	};
	infantry[] = {
		"CUP_B_BAF_Soldier_AmmoBearer_MTP",
		"CUP_B_BAF_Soldier_AsstAutoRifleman_MTP",
		"CUP_B_BAF_Soldier_AsstGunnerArty_MTP",
		"CUP_B_BAF_Soldier_AsstGunnerGMG_MTP",
		"CUP_B_BAF_Soldier_AsstGunnerHMG_MTP",
		"CUP_B_BAF_Soldier_AsstAA_MTP",
		"CUP_B_BAF_Soldier_AsstAT_MTP",
		"CUP_B_BAF_Soldier_AutoRifleman_MTP",
		"CUP_B_BAF_Soldier_Medic_MTP",
		"CUP_B_BAF_Soldier_Engineer_MTP",
		"CUP_B_BAF_Soldier_Explosive_MTP",
		"CUP_B_BAF_Soldier_Grenadier_MTP",
		"CUP_B_BAF_Soldier_GunnerArty_MTP",
		"CUP_B_BAF_Soldier_GunnerGMG_MTP",
		"CUP_B_BAF_Soldier_GunnerHMG_MTP",
		"CUP_B_BAF_Soldier_HeavyGunner_MTP",
		"CUP_B_BAF_Soldier_Marksman_MTP",
		"CUP_B_BAF_Soldier_Mine_MTP",
		"CUP_B_BAF_Soldier_AA_MTP",
		"CUP_B_BAF_Soldier_AT_MTP",
		"CUP_B_BAF_Soldier_Officer_MTP",
		"CUP_B_BAF_Soldier_Paratrooper_MTP",
		"CUP_B_BAF_Soldier_Repair_MTP",
		"CUP_B_BAF_Soldier_Rifleman_MTP",
		"CUP_BAF_Soldier_MTP_Base",
		"CUP_B_BAF_Soldier_RiflemanAT_MTP",
		"CUP_B_BAF_Soldier_RiflemanLAT_MTP",
		"CUP_B_BAF_Soldier_RiflemanLite_MTP",
		"CUP_B_BAF_Soldier_SharpShooter_MTP",
		"CUP_B_BAF_Sniper_AS50_TWS_MTP",
		"CUP_B_BAF_Sniper_AS50_MTP",
		"CUP_B_BAF_Sniper_MTP",
		"CUP_B_BAF_Spotter_MTP",
		"CUP_B_BAF_Spotter_L85TWS_MTP",
		"CUP_B_BAF_Soldier_SquadLeader_MTP",
		"CUP_B_BAF_Soldier_TeamLeader_MTP"
	};
};

class CUP_BAF_DES_faction : CUP_BAF_MTP_faction
{
	displayName = "CUP - British Armed Forces (Desert)";

	infantry[] = {
		"CUP_B_BAF_Soldier_AmmoBearer_DDPM",
		"CUP_B_BAF_Soldier_AsstAutoRifleman_DDPM",
		"CUP_B_BAF_Soldier_AsstGunnerArty_DDPM",
		"CUP_B_BAF_Soldier_AsstGunnerGMG_DDPM",
		"CUP_B_BAF_Soldier_AsstGunnerHMG_DDPM",
		"CUP_B_BAF_Soldier_AsstAA_DDPM",
		"CUP_B_BAF_Soldier_AsstAT_DDPM",
		"CUP_B_BAF_Soldier_AutoRifleman_DDPM",
		"CUP_B_BAF_Soldier_Medic_DDPM",
		"CUP_B_BAF_Soldier_Engineer_DDPM",
		"CUP_B_BAF_Soldier_Explosive_DDPM",
		"CUP_B_BAF_Soldier_Grenadier_DDPM",
		"CUP_B_BAF_Soldier_GunnerArty_DDPM",
		"CUP_B_BAF_Soldier_GunnerGMG_DDPM",
		"CUP_B_BAF_Soldier_GunnerHMG_DDPM",
		"CUP_B_BAF_Soldier_HeavyGunner_DDPM",
		"CUP_B_BAF_Soldier_Marksman_DDPM",
		"CUP_B_BAF_Soldier_Mine_DDPM",
		"CUP_B_BAF_Soldier_AA_DDPM",
		"CUP_B_BAF_Soldier_AT_DDPM",
		"CUP_B_BAF_Soldier_Officer_DDPM",
		"CUP_B_BAF_Soldier_Paratrooper_DDPM",
		"CUP_B_BAF_Soldier_Repair_DDPM",
		"CUP_B_BAF_Soldier_Rifleman_DDPM",
		"CUP_B_BAF_Soldier_RiflemanAT_DDPM",
		"CUP_B_BAF_Soldier_RiflemanLAT_DDPM",
		"CUP_B_BAF_Soldier_RiflemanLite_DDPM",
		"CUP_B_BAF_Soldier_SharpShooter_DDPM",
		"CUP_B_BAF_Sniper_AS50_TWS_DDPM",
		"CUP_B_BAF_Sniper_AS50_DDPM",
		"CUP_B_BAF_Sniper_DDPM",
		"CUP_B_BAF_Spotter_DDPM",
		"CUP_B_BAF_Spotter_L85TWS_DDPM",
		"CUP_B_BAF_Soldier_SquadLeader_DDPM",
		"CUP_B_BAF_Soldier_TeamLeader_DDPM"
	};
};

class CUP_BAF_WDL_faction : CUP_BAF_MTP_faction
{
	displayName = "CUP - British Armed Forces (Woodland)";

	lightCars[] = {
		"CUP_B_BAF_Coyote_GMG_W",
		"CUP_B_BAF_Coyote_L2A1_W",
		"CUP_B_Jackal2_GMG_GB_W",
		"CUP_B_Jackal2_L2A1_GB_W",
		"CUP_B_LR_Special_GMG_GB_W",
		"CUP_B_LR_Special_M2_GB_W",
		"CUP_B_LR_MG_GB_W"
	};
	heavyCars[] = {
		"CUP_B_Mastiff_GMG_GB_W",
		"CUP_B_Mastiff_HMG_GB_W",
		"CUP_B_Mastiff_LMG_GB_W",
		"CUP_B_Ridgback_GMG_GB_W",
		"CUP_B_Ridgback_HMG_GB_W",
		"CUP_B_Ridgback_LMG_GB_W",
		"CUP_B_Wolfhound_GMG_GB_W",
		"CUP_B_Wolfhound_HMG_GB_W",
		"CUP_B_Wolfhound_LMG_GB_W"
	};
	lightArmor[] = {
		"CUP_B_FV432_Bulldog_GB_W_RWS",
		"CUP_B_FV432_Bulldog_GB_W",
		"CUP_B_FV510_GB_W_SLAT",
		"CUP_B_FV510_GB_W",
		"CUP_B_MCV80_GB_W_SLAT",
		"CUP_B_MCV80_GB_W"
	};
	heavyArmor[] = {
		"CUP_B_Challenger2_Woodland_BAF",
		"CUP_B_Challenger2_2CW_BAF"
	};
	infantry[] = {
		"CUP_B_BAF_Soldier_AmmoBearer_DPM",
		"CUP_B_BAF_Soldier_AsstAutoRifleman_DPM",
		"CUP_B_BAF_Soldier_AsstGunnerArty_DPM",
		"CUP_B_BAF_Soldier_AsstGunnerGMG_DPM",
		"CUP_B_BAF_Soldier_AsstGunnerHMG_DPM",
		"CUP_B_BAF_Soldier_AsstAA_DPM",
		"CUP_B_BAF_Soldier_AsstAT_DPM",
		"CUP_B_BAF_Soldier_AutoRifleman_DPM",
		"CUP_B_BAF_Soldier_Medic_DPM",
		"CUP_B_BAF_Soldier_Engineer_DPM",
		"CUP_B_BAF_Soldier_Explosive_DPM",
		"CUP_B_BAF_Soldier_Grenadier_DPM",
		"CUP_B_BAF_Soldier_GunnerArty_DPM",
		"CUP_B_BAF_Soldier_GunnerGMG_DPM",
		"CUP_B_BAF_Soldier_GunnerHMG_DPM",
		"CUP_B_BAF_Soldier_HeavyGunner_DPM",
		"CUP_B_BAF_Soldier_Marksman_DPM",
		"CUP_B_BAF_Soldier_Mine_DPM",
		"CUP_B_BAF_Soldier_AA_DPM",
		"CUP_B_BAF_Soldier_AT_DPM",
		"CUP_B_BAF_Soldier_Officer_DPM",
		"CUP_B_BAF_Soldier_Paratrooper_DPM",
		"CUP_B_BAF_Soldier_Repair_DPM",
		"CUP_B_BAF_Soldier_Rifleman_DPM",
		"CUP_B_BAF_Soldier_RiflemanAT_DPM",
		"CUP_B_BAF_Soldier_RiflemanLAT_DPM",
		"CUP_B_BAF_Soldier_RiflemanLite_DPM",
		"CUP_B_BAF_Soldier_SharpShooter_DPM",
		"CUP_B_BAF_Sniper_AS50_TWS_DPM",
		"CUP_B_BAF_Sniper_AS50_DPM",
		"CUP_B_BAF_Sniper_DPM",
		"CUP_B_BAF_Spotter_DPM",
		"CUP_B_BAF_Spotter_L85TWS_DPM",
		"CUP_B_BAF_Soldier_SquadLeader_DPM",
		"CUP_B_BAF_Soldier_TeamLeader_DPM"		
	};
};

class CUP_GER_DES_faction
{
	displayName = "CUP - Bundeswehr (Desert)";
	
	lightCars[] = {
		"CUP_B_LR_Special_GMG_GB_D",
		"CUP_B_LR_Special_M2_GB_D",
		"CUP_B_LR_MG_GB_D"
	};
	heavyCars[] = {
		"CUP_B_Dingo_GL_GER_Des",
		"CUP_B_Dingo_GER_Des"
	};
	lightArmor[] = {
		"CUP_B_Boxer_GMG_GER_DES",
		"CUP_B_Boxer_HMG_GER_DES"
	};
	heavyArmor[] = {
		"CUP_B_Leopard2A6DST_GER"
	};
	transportHelicopters[] = {
		"CUP_B_UH1D_GER_KSK_Des",
		"CUP_B_UH1D_slick_GER_KSK_Des"
	};
	cargoAircraft[] = {
		"CUP_B_C130J_USMC"
	};
	casAircraft[] = {
		"CUP_B_F35B_BAF"
	};
	attackHelicopters[] = {
		//"O_Heli_Attack_02_dynamicLoadout_black_F"
		"CUP_B_AH1_DL_BAF"
	};

	infantry[] = {
		"CUP_B_GER_BW_Soldier_AA",
		"CUP_B_GER_BW_Soldier_Ammo",
		"CUP_B_GER_BW_Soldier_AAA",
		"CUP_B_GER_BW_Soldier_AAT",
		"CUP_B_GER_BW_Soldier_AT",
		"CUP_B_GER_BW_Soldier_PZF_AT",
		"CUP_B_GER_BW_Soldier_Engineer",
		"CUP_B_GER_BW_Soldier_GL",
		"CUP_B_GER_BW_Soldier_MG",
		"CUP_B_GER_BW_Soldier_MG3",
		"CUP_B_GER_BW_Soldier_Marksman",
		"CUP_B_GER_BW_Medic",
		"CUP_B_GER_BW_Soldier",
		"CUP_B_GER_BW_Soldier_Scout",
		"CUP_B_GER_BW_Soldier_Sniper",
		"CUP_B_GER_BW_Soldier_TL"
	};
};

class CUP_GER_WDL_faction : CUP_GER_DES_faction
{
	displayName = "CUP - Bundeswehr (Woodland)";
	
	lightCars[] = {
		"CUP_B_LR_Special_GMG_GB_W",
		"CUP_B_LR_Special_M2_GB_W",
		"CUP_B_LR_MG_GB_W"
	};
	heavyCars[] = {
		"CUP_B_Dingo_GL_GER_Wdl",
		"CUP_B_Dingo_GER_Wdl"
	};
	lightArmor[] = {
		"CUP_B_Boxer_GMG_GER_WDL",
		"CUP_B_Boxer_HMG_GER_WDL"
	};
	heavyArmor[] = {
		"CUP_B_Leopard2A6_GER"
	};
	transportHelicopters[] = {
		"CUP_B_UH1D_GER_KSK",
		"CUP_B_UH1D_slick_GER_KSK"
	};

	infantry[] = {
		"CUP_B_GER_BW_Fleck_Soldier_AA",
		"CUP_B_GER_BW_Fleck_Soldier_Ammo",
		"CUP_B_GER_BW_Fleck_Soldier_AAA",
		"CUP_B_GER_BW_Fleck_Soldier_AAT",
		"CUP_B_GER_BW_Fleck_Soldier_AT",
		"CUP_B_GER_BW_Fleck_Soldier_PZF_AT",
		"CUP_B_GER_BW_Fleck_Soldier_Engineer",
		"CUP_B_GER_BW_Fleck_Soldier_GL",
		"CUP_B_GER_BW_Fleck_Soldier_MG",
		"CUP_B_GER_BW_Fleck_Soldier_MG3",
		"CUP_B_GER_BW_Fleck_Soldier_Marksman",
		"CUP_B_GER_BW_Fleck_Medic",
		"CUP_B_GER_BW_Fleck_Soldier",
		"CUP_B_GER_BW_Fleck_Soldier_Scout",
		"CUP_B_GER_BW_Fleck_Soldier_Sniper",
		"CUP_B_GER_BW_Fleck_Soldier_TL"
	};
};

class CUP_GER_KSK_DES_faction : CUP_GER_DES_faction
{
	displayName = "CUP - Bundeswehr KSK (Desert)";

	infantry[] = {
		"CUP_B_GER_Soldier_AA",
		"CUP_B_GER_Soldier_Ammo",
		"CUP_B_GER_Operator_EXP",
		"CUP_B_GER_Operator_GL",
		"CUP_B_GER_Operator_Medic",
		"CUP_B_GER_Operator",
		"CUP_B_GER_Operator_TL",
		"CUP_B_GER_Soldier_AAA",
		"CUP_B_GER_Soldier_AAT",
		"CUP_B_GER_Soldier_AT",
		"CUP_B_GER_Soldier_Engineer",
		"CUP_B_GER_Soldier_GL",
		"CUP_B_GER_Soldier_MG",
		"CUP_B_GER_Soldier_MG3",
		"CUP_B_GER_Medic",
		"CUP_B_GER_Soldier",
		"CUP_B_GER_Soldier_Scout",
		"CUP_B_GER_Soldier_Sniper",
		"CUP_B_GER_Soldier_TL"
	};
};

class CUP_GER_KSK_WDL_faction : CUP_GER_WDL_faction
{
	displayName = "CUP - Bundeswehr KSK (Woodland)";

	infantry[] = {
		"CUP_B_GER_Fleck_Soldier_AA",
		"CUP_B_GER_Fleck_Soldier_Ammo",
		"CUP_B_GER_Fleck_Operator_EXP",
		"CUP_B_GER_Fleck_Operator_GL",
		"CUP_B_GER_Fleck_Operator_Medic",
		"CUP_B_GER_Fleck_Operator",
		"CUP_B_GER_Fleck_Operator_TL",
		"CUP_B_GER_Fleck_Soldier_AAA",
		"CUP_B_GER_Fleck_Soldier_AAT",
		"CUP_B_GER_Fleck_Soldier_AT",
		"CUP_B_GER_Fleck_Soldier_Engineer",
		"CUP_B_GER_Fleck_Soldier_GL",
		"CUP_B_GER_Fleck_Soldier_MG",
		"CUP_B_GER_Fleck_Soldier_MG3",
		"CUP_B_GER_Fleck_Medic",
		"CUP_B_GER_Fleck_Soldier",
		"CUP_B_GER_Fleck_Soldier_Scout",
		"CUP_B_GER_Fleck_Soldier_Sniper",
		"CUP_B_GER_Fleck_Soldier_TL"	
	};
};

class CUP_CDF_DES_faction
{
	displayName = "CUP - Chernarus Defense Forces (Desert)";
	
	lightCars[] = {
		"CUP_B_UAZ_AGS30_CDF",
		"CUP_B_UAZ_MG_CDF"
	};
	heavyCars[] = {
		"CUP_B_BRDM2_CDF",
		"CUP_B_BRDM2_HQ_CDF"
	};
	lightArmor[] = {
		"CUP_B_BMP2_CDF",
		"CUP_B_BMP_HQ_CDF",
		"CUP_B_BTR60_CDF",
		"CUP_B_BTR80_CDF",
		"CUP_B_BTR80A_CDF",
		"CUP_B_MTLB_pk_CDF"
	};
	heavyArmor[] = {
		"CUP_B_T72_CDF"
	};
	transportHelicopters[] = {
		"CUP_B_Mi17_CDF"
	};
	cargoAircraft[] = {
		"CUP_O_C47_SLA"
	};
	casAircraft[] = {
		"CUP_B_Su25_Dyn_CDF",
		"CUP_B_SU34_CDF"
	};
	attackHelicopters[] = {
		"CUP_I_Mi24_Mk3_ION",
		"CUP_I_Mi24_Mk4_ION"
	};
	
	infantry[] = {
		"CUP_B_CDF_Soldier_AA_DST",
		"CUP_B_CDF_Soldier_AAT_DST",
		"CUP_B_CDF_Soldier_AMG_DST",
		"CUP_B_CDF_Soldier_LAT_DST",
		"CUP_B_CDF_Soldier_AR_DST",
		"CUP_B_CDF_Engineer_DST",
		"CUP_B_CDF_Soldier_GL_DST",
		"CUP_B_CDF_Soldier_MG_DST",
		"CUP_B_CDF_Soldier_Marksman_DST",
		"CUP_B_CDF_Medic_DST",
		"CUP_B_CDF_Militia_DST",
		"CUP_B_CDF_Officer_DST",
		"CUP_B_CDF_Soldier_DST",
		"CUP_B_CDF_Soldier_RPG18_DST",
		"CUP_B_CDF_Sniper_DST",
		"CUP_B_CDF_Spotter_DST",
		"CUP_B_CDF_Soldier_TL_DST"
	};
};

class CUP_CDF_FST_faction : CUP_CDF_DES_faction
{
	displayName = "CUP - Chernarus Defense Forces (Forest)";

	infantry[] = {
		"CUP_B_CDF_Soldier_LAT_FST",
		"CUP_B_CDF_Soldier_AA_FST",
		"CUP_B_CDF_Soldier_AAT_FST",
		"CUP_B_CDF_Soldier_AMG_FST",
		"CUP_B_CDF_Soldier_AR_FST",
		"CUP_B_CDF_Engineer_FST",
		"CUP_B_CDF_Soldier_GL_FST",
		"CUP_B_CDF_Soldier_MG_FST",
		"CUP_B_CDF_Soldier_Marksman_FST",
		"CUP_B_CDF_Medic_FST",
		"CUP_B_CDF_Militia_FST",
		"CUP_B_CDF_Officer_FST",
		"CUP_B_CDF_Soldier_FST",
		"CUP_B_CDF_Soldier_RPG18_FST",
		"CUP_B_CDF_Sniper_FST",
		"CUP_B_CDF_Spotter_FST",
		"CUP_B_CDF_Soldier_TL_FST"
	};
};

class CUP_CDF_MNT_faction : CUP_CDF_DES_faction
{
	displayName = "CUP - Chernarus Defense Forces (Mountain)";

	infantry[] = {
		"CUP_B_CDF_Spotter_MNT",
		"CUP_B_CDF_Soldier_AA_MNT",
		"CUP_B_CDF_Soldier_AAT_MNT",
		"CUP_B_CDF_Soldier_AMG_MNT",
		"CUP_B_CDF_Soldier_LAT_MNT",
		"CUP_B_CDF_Soldier_AR_MNT",
		"CUP_B_CDF_Engineer_MNT",
		"CUP_B_CDF_Soldier_GL_MNT",
		"CUP_B_CDF_Soldier_MG_MNT",
		"CUP_B_CDF_Soldier_Marksman_MNT",
		"CUP_B_CDF_Medic_MNT",
		"CUP_B_CDF_Militia_MNT",
		"CUP_B_CDF_Officer_MNT",
		"CUP_B_CDF_Soldier_MNT",
		"CUP_B_CDF_Soldier_RPG18_MNT",
		"CUP_B_CDF_Sniper_MNT",
		"CUP_B_CDF_Soldier_TL_MNT"
	};
};

class CUP_CDF_SNW_faction : CUP_CDF_DES_faction
{
	displayName = "CUP - Chernarus Defense Forces (Snow)";

	infantry[] = {
		"CUP_B_CDF_Soldier_TL_SNW",
		"CUP_B_CDF_Soldier_AA_SNW",
		"CUP_B_CDF_Soldier_AAT_SNW",
		"CUP_B_CDF_Soldier_AMG_SNW",
		"CUP_B_CDF_Soldier_LAT_SNW",
		"CUP_B_CDF_Soldier_AR_SNW",
		"CUP_B_CDF_Engineer_SNW",
		"CUP_B_CDF_Soldier_GL_SNW",
		"CUP_B_CDF_Soldier_MG_SNW",
		"CUP_B_CDF_Soldier_Marksman_SNW",
		"CUP_B_CDF_Medic_SNW",
		"CUP_B_CDF_Militia_SNW",
		"CUP_B_CDF_Officer_SNW",
		"CUP_B_CDF_Soldier_SNW",
		"CUP_B_CDF_Soldier_RPG18_SNW",
		"CUP_B_CDF_Sniper_SNW",
		"CUP_B_CDF_Spotter_SNW"
	};
};

class CUP_HIL_faction
{
	displayName = "CUP - Horizon Islands Legion";

	lightCars[] = {
		"CUP_B_M151_M2_HIL"
	};
	heavyCars[] = {
		"CUP_B_HMMWV_M2_GPK_NATO_T"
	};
	lightArmor[] = {
		"CUP_B_Boxer_GMG_HIL",
		"CUP_B_Boxer_HMG_HIL"
	};
	heavyArmor[] = {
		"CUP_B_Leopard2A6_HIL"
	};
	transportHelicopters[] = {
		"CUP_B_CH47F_HIL",
		"CUP_B_AW159_Unarmed_HIL"
	};
	cargoAircraft[] = {
		"CUP_B_C130J_USMC"
	};
	casAircraft[] = {
		"CUP_B_JAS39_HIL"
	};
	attackHelicopters[] = {
		"CUP_B_AH1_DL_BAF"
	};

	infantry[] = {
		"CUP_B_HIL_SL",
		"CUP_B_HIL_Soldier_AAT",
		"CUP_B_HIL_AMG",
		"CUP_B_HIL_Engineer",
		"CUP_B_HIL_GL",
		"CUP_B_HIL_MMG",
		"CUP_B_HIL_M",
		"CUP_B_HIL_Medic",
		"CUP_B_HIL_Soldier_AA",
		"CUP_B_HIL_Soldier_HAT",
		"CUP_B_HIL_Officer",
		"CUP_B_HIL_Soldier",
		"CUP_B_HIL_Soldier_LAT",
		"CUP_B_HIL_Soldier_MAT",
		"CUP_B_HIL_Soldier_Light"
	};
};

class CUP_HIL_RECON_faction
{
	displayName = "CUP - Horizon Islands Legion (Recon)";

	infantry[] = {
		"CUP_B_HIL_Engineer_Recon",
		"CUP_B_HIL_GL_Recon",
		"CUP_B_HIL_MMG_Recon",
		"CUP_B_HIL_M_Recon",
		"CUP_B_HIL_Soldier_HAT_Recon",
		"CUP_B_HIL_Medic_Recon",
		"CUP_B_HIL_Soldier_MAT_Recon",
		"CUP_B_HIL_Soldier_Recon",
		"CUP_B_HIL_Soldier_LAT_Recon",
		"CUP_B_HIL_SL_Recon"
	};
};

class CUP_HIL_RES_faction
{
	displayName = "CUP - Horizon Islands Legion (Reservists)";

	infantry[] = {
		"CUP_B_HIL_SL_Res",
		"CUP_B_HIL_AMG_Res",
		"CUP_B_HIL_Engineer_Res",
		"CUP_B_HIL_GL_Res",
		"CUP_B_HIL_MMG_Res",
		"CUP_B_HIL_M_Res",
		"CUP_B_HIL_Medic_Res",
		"CUP_B_HIL_Officer_Res",
		"CUP_B_HIL_Soldier_Res",
		"CUP_B_HIL_Soldier_MAT_Res",
		"CUP_B_HIL_Soldier_HAT_Res",
		"CUP_B_HIL_Soldier_LAT_Res",
		"CUP_B_HIL_Soldier_Light_Res"
	};
};

class CUP_HIL_SF_faction
{
	displayName = "CUP - Horizon Islands Legion (Special Forces)";

	infantry[] = {
		"CUP_B_HIL_SL_SF",
		"CUP_B_HIL_Soldier_SF",
		"CUP_B_HIL_Soldier_LAT_SF",
		"CUP_B_HIL_Engineer_SF",
		"CUP_B_HIL_GL_SF",
		"CUP_B_HIL_MMG_SF",
		"CUP_B_HIL_M_SF",
		"CUP_B_HIL_Medic_SF",
		"CUP_B_HIL_Soldier_HAT_SF",
		"CUP_B_HIL_Soldier_PM_SF",
		"CUP_B_HIL_Soldier_MAT_SF",
		"CUP_B_HIL_Scout_SF",
		"CUP_B_HIL_Scout_MP5_SF",
		"CUP_B_HIL_Scout_MP7_SF"
	};
};

class CUP_USARMY_base
{
	displayName = "CUP - US ARMY Base";

	transportHelicopters[] = {
		"CUP_B_CH47F_USA",
		"CUP_B_UH60M_US"
	};
	attackHelicopters[] = {
		"CUP_B_AH64D_DL_USA",
		"CUP_B_AH64_DL_USA"
	};
	cargoAircraft[] = {
		"CUP_B_C130J_USMC"
	};
	casAircraft[] = {
		"CUP_B_A10_DYN_USA"
	};
};

class CUP_USARMY_DES_base : CUP_USARMY_base
{
	displayName = displayName "CUP - US ARMY Base (Desert)";

	lightCars[] = {
		"CUP_B_HMMWV_MK19_USA",
		"CUP_B_HMMWV_M2_USA",
		"CUP_B_HMMWV_SOV_M2_USA",
		"CUP_B_HMMWV_SOV_USA",
		"CUP_B_M1165_GMV_USA"		
	};
	heavyCars[] = {
		"CUP_B_HMMWV_Crows_M2_USA",
		"CUP_B_HMMWV_Crows_MK19_USA",
		"CUP_B_HMMWV_M2_GPK_USA",
		"CUP_B_M1151_M2_USA",
		"CUP_B_M1151_Deploy_USA",
		"CUP_B_M1151_Mk19_USA",
		"CUP_B_RG31_Mk19_USA",
		"CUP_B_RG31E_M2_USA",
		"CUP_B_RG31_M2_USA",
		"CUP_B_RG31_M2_GC_USA"
	};
	lightArmor[] = {
		"CUP_B_M1126_ICV_M2_Desert",
		"CUP_B_M1126_ICV_MK19_Desert",
		"CUP_B_M1128_MGS_Desert",
		"CUP_B_M1130_CV_M2_Desert",
		"CUP_B_M113_desert_USA",
		"CUP_B_M2Bradley_USA_D",
		"CUP_B_M2A3Bradley_USA_D",
		"CUP_B_M7Bradley_USA_D"
	};
	heavyArmor[] = {
		"CUP_B_M1A1_DES_US_Army",
		"CUP_B_M1A2_TUSK_MG_DES_US_Army"
	};
};

class CUP_USARMY_WDL_base : CUP_USARMY_base
{
	displayName = displayName "CUP - US ARMY Base (Woodland)";

	lightCars[] = {
		"CUP_B_M1165_GMV_WDL_USA",
		"CUP_B_HMMWV_SOV_NATO_T",
		"CUP_B_HMMWV_SOV_M2_NATO_T",
		"CUP_B_HMMWV_M2_NATO_T",
		"CUP_B_HMMWV_MK19_NATO_T"
	};
	heavyCars[] = {
		"CUP_B_RG31_M2_OD_GC_USA",
		"CUP_B_RG31_M2_OD_USA",
		"CUP_B_RG31E_M2_OD_USA",
		"CUP_B_RG31_Mk19_OD_USA",
		"CUP_B_M1151_Mk19_WDL_USA",
		"CUP_B_M1151_Deploy_WDL_USA",
		"CUP_B_M1151_M2_WDL_USA",
		"CUP_B_HMMWV_M2_GPK_NATO_T",
		"CUP_B_HMMWV_Crows_MK19_NATO_T",
		"CUP_B_HMMWV_Crows_M2_NATO_T"
	};
	lightArmor[] = {
		"CUP_B_M1126_ICV_M2_Woodland",
		"CUP_B_M1126_ICV_MK19_Woodland",
		"CUP_B_M1128_MGS_Woodland",
		"CUP_B_M113_USA",
		"CUP_B_M1130_CV_M2_Woodland",
		"CUP_B_M2Bradley_USA_W",
		"CUP_B_M2A3Bradley_USA_W",
		"CUP_B_M7Bradley_USA_W"
	};
	heavyArmor[] = {
		"CUP_B_M1A1_Woodland_US_Army",
		"CUP_B_M1A2_TUSK_MG_US_Army"
	};
};

class CUP_USARMY_OCP_DES_faction : CUP_USARMY_DES_base
{
	displayName = "CUP - US Army OCP (Desert)";

	infantry[] = {
		"CUP_B_US_Soldier_TL_OCP",
		"CUP_B_US_Soldier_AAT_OCP",
		"CUP_B_US_Soldier_AHAT_OCP",
		"CUP_B_US_Soldier_AAR_OCP",
		"CUP_B_US_Soldier_AMG_OCP",
		"CUP_B_US_Soldier_AT_OCP",
		"CUP_B_US_Soldier_HAT_OCP",
		"CUP_B_US_Soldier_AR_OCP",
		"CUP_B_US_Soldier_Engineer_OCP",
		"CUP_B_US_Soldier_Engineer_EOD_OCP",
		"CUP_B_US_Soldier_GL_OCP",
		"CUP_B_US_Soldier_MG_OCP",
		"CUP_B_US_Soldier_Marksman_OCP",
		"CUP_B_US_Soldier_Marksman_EBR_OCP",
		"CUP_B_US_Medic_OCP",
		"CUP_B_US_Soldier_AA_OCP",
		"CUP_B_US_Soldier_OCP",
		"CUP_B_US_Soldier_ACOG_OCP",
		"CUP_B_US_Soldier_LAT_OCP",
		"CUP_B_US_Soldier_Backpack_OCP",
		"CUP_B_US_Soldier_Engineer_Sapper_OCP",
		"CUP_B_US_Sniper_OCP",
		"CUP_B_US_Sniper_M107_OCP",
		"CUP_B_US_Sniper_M110_TWS_OCP",
		"CUP_B_US_Spotter_OCP",
		"CUP_B_US_Soldier_SL_OCP"
	};
};

class CUP_USARMY_OCP_WDL_faction : CUP_USARMY_WDL_base
{
	displayName = "CUP - US Army OCP (Woodland)";

	infantry[] = {
		"CUP_B_US_Soldier_TL_OCP",
		"CUP_B_US_Soldier_AAT_OCP",
		"CUP_B_US_Soldier_AHAT_OCP",
		"CUP_B_US_Soldier_AAR_OCP",
		"CUP_B_US_Soldier_AMG_OCP",
		"CUP_B_US_Soldier_AT_OCP",
		"CUP_B_US_Soldier_HAT_OCP",
		"CUP_B_US_Soldier_AR_OCP",
		"CUP_B_US_Soldier_Engineer_OCP",
		"CUP_B_US_Soldier_Engineer_EOD_OCP",
		"CUP_B_US_Soldier_GL_OCP",
		"CUP_B_US_Soldier_MG_OCP",
		"CUP_B_US_Soldier_Marksman_OCP",
		"CUP_B_US_Soldier_Marksman_EBR_OCP",
		"CUP_B_US_Medic_OCP",
		"CUP_B_US_Soldier_AA_OCP",
		"CUP_B_US_Soldier_OCP",
		"CUP_B_US_Soldier_ACOG_OCP",
		"CUP_B_US_Soldier_LAT_OCP",
		"CUP_B_US_Soldier_Backpack_OCP",
		"CUP_B_US_Soldier_Engineer_Sapper_OCP",
		"CUP_B_US_Sniper_OCP",
		"CUP_B_US_Sniper_M107_OCP",
		"CUP_B_US_Sniper_M110_TWS_OCP",
		"CUP_B_US_Spotter_OCP",
		"CUP_B_US_Soldier_SL_OCP"
	};
};

class CUP_USARMY_OEFCP_DES_faction : CUP_USARMY_DES_base
{
	displayName = "CUP - US Army OEF-CP (Desert)";

	infantry[] = {
		"CUP_B_US_Soldier_TL_OEFCP",
		"CUP_B_US_Soldier_AAT_OEFCP",
		"CUP_B_US_Soldier_AHAT_OEFCP",
		"CUP_B_US_Soldier_AAR_OEFCP",
		"CUP_B_US_Soldier_AMG_OEFCP",
		"CUP_B_US_Soldier_AT_OEFCP",
		"CUP_B_US_Soldier_HAT_OEFCP",
		"CUP_B_US_Soldier_AR_OEFCP",
		"CUP_B_US_Soldier_Engineer_OEFCP",
		"CUP_B_US_Soldier_Engineer_EOD_OEFCP",
		"CUP_B_US_Soldier_GL_OEFCP",
		"CUP_B_US_Soldier_MG_OEFCP",
		"CUP_B_US_Soldier_Marksman_OEFCP",
		"CUP_B_US_Soldier_Marksman_EBR_OEFCP",
		"CUP_B_US_Medic_OEFCP",
		"CUP_B_US_Soldier_AA_OEFCP",
		"CUP_B_US_Soldier_OEFCP",
		"CUP_B_US_Soldier_ACOG_OEFCP",
		"CUP_B_US_Soldier_LAT_OEFCP",
		"CUP_B_US_Soldier_Backpack_OEFCP",
		"CUP_B_US_Soldier_Engineer_Sapper_OEFCP",
		"CUP_B_US_Sniper_OEFCP",
		"CUP_B_US_Sniper_M107_OEFCP",
		"CUP_B_US_Sniper_M110_TWS_OEFCP",
		"CUP_B_US_Spotter_OEFCP",
		"CUP_B_US_Soldier_SL_OEFCP"
	};
};

class CUP_USARMY_OEFCP_WDL_faction : CUP_USARMY_WDL_base
{
	displayName = "CUP - US Army OEF-CP (Woodland)";

	infantry[] = {
		"CUP_B_US_Soldier_TL_OEFCP",
		"CUP_B_US_Soldier_AAT_OEFCP",
		"CUP_B_US_Soldier_AHAT_OEFCP",
		"CUP_B_US_Soldier_AAR_OEFCP",
		"CUP_B_US_Soldier_AMG_OEFCP",
		"CUP_B_US_Soldier_AT_OEFCP",
		"CUP_B_US_Soldier_HAT_OEFCP",
		"CUP_B_US_Soldier_AR_OEFCP",
		"CUP_B_US_Soldier_Engineer_OEFCP",
		"CUP_B_US_Soldier_Engineer_EOD_OEFCP",
		"CUP_B_US_Soldier_GL_OEFCP",
		"CUP_B_US_Soldier_MG_OEFCP",
		"CUP_B_US_Soldier_Marksman_OEFCP",
		"CUP_B_US_Soldier_Marksman_EBR_OEFCP",
		"CUP_B_US_Medic_OEFCP",
		"CUP_B_US_Soldier_AA_OEFCP",
		"CUP_B_US_Soldier_OEFCP",
		"CUP_B_US_Soldier_ACOG_OEFCP",
		"CUP_B_US_Soldier_LAT_OEFCP",
		"CUP_B_US_Soldier_Backpack_OEFCP",
		"CUP_B_US_Soldier_Engineer_Sapper_OEFCP",
		"CUP_B_US_Sniper_OEFCP",
		"CUP_B_US_Sniper_M107_OEFCP",
		"CUP_B_US_Sniper_M110_TWS_OEFCP",
		"CUP_B_US_Spotter_OEFCP",
		"CUP_B_US_Soldier_SL_OEFCP"
	};
};

class CUP_USARMY_SF_DES_faction : CUP_USARMY_DES_base
{
	displayName = "CUP - US Army Special Forces (Desert)";

	transportHelicopters[] = {
		"CUP_B_MH47E_USA",
		"CUP_B_UH60M_US",
		"CUP_B_MH6J_USA",
		"CUP_B_MH6M_USA"
	};
	infantry[] = {
		"CUP_B_US_SpecOps_UAV",
		"CUP_B_US_SpecOps_AR",
		"CUP_B_US_SpecOps_JTAC",
		"CUP_B_US_SpecOps_MG",
		"CUP_B_US_SpecOps_M",
		"CUP_B_US_SpecOps_Medic",
		"CUP_B_US_SpecOps",
		"CUP_B_US_SpecOps_Assault",
		"CUP_B_US_SpecOps_M14",
		"CUP_B_US_SpecOps_Night",
		"CUP_B_US_SpecOps_SD",
		"CUP_B_US_SpecOps_TL"
	};
};

class CUP_USARMY_SF_WDL_faction : CUP_USARMY_WDL_base
{
	displayName = "CUP - US Army Special Forces (Woodland)";
	
	transportHelicopters[] = {
		"CUP_B_MH47E_USA",
		"CUP_B_UH60M_US",
		"CUP_B_MH6J_USA",
		"CUP_B_MH6M_USA"
	};
	infantry[] = {
		"CUP_B_US_SpecOps_UAV",
		"CUP_B_US_SpecOps_AR",
		"CUP_B_US_SpecOps_JTAC",
		"CUP_B_US_SpecOps_MG",
		"CUP_B_US_SpecOps_M",
		"CUP_B_US_SpecOps_Medic",
		"CUP_B_US_SpecOps",
		"CUP_B_US_SpecOps_Assault",
		"CUP_B_US_SpecOps_M14",
		"CUP_B_US_SpecOps_Night",
		"CUP_B_US_SpecOps_SD",
		"CUP_B_US_SpecOps_TL"
	};
};

class CUP_USARMY_UCP_DES_faction : CUP_USARMY_DES_base
{
	displayName = "CUP - US Army UCP (Desert)";

	infantry[] = {
		"CUP_B_US_Soldier_TL_UCP",
		"CUP_B_US_Soldier_AAT_UCP",
		"CUP_B_US_Soldier_AHAT_UCP",
		"CUP_B_US_Soldier_AAR_UCP",
		"CUP_B_US_Soldier_AMG_UCP",
		"CUP_B_US_Soldier_AT_UCP",
		"CUP_B_US_Soldier_HAT_UCP",
		"CUP_B_US_Soldier_AR_UCP",
		"CUP_B_US_Soldier_Engineer_UCP",
		"CUP_B_US_Soldier_Engineer_EOD_UCP",
		"CUP_B_US_Soldier_GL_UCP",
		"CUP_B_US_Soldier_MG_UCP",
		"CUP_B_US_Soldier_Marksman_UCP",
		"CUP_B_US_Soldier_Marksman_EBR_UCP",
		"CUP_B_US_Medic_UCP",
		"CUP_B_US_Soldier_AA_UCP",
		"CUP_B_US_Soldier_UCP",
		"CUP_B_US_Soldier_ACOG_UCP",
		"CUP_B_US_Soldier_LAT_UCP",
		"CUP_B_US_Soldier_Backpack_UCP",
		"CUP_B_US_Soldier_Engineer_Sapper_UCP",
		"CUP_B_US_Sniper_UCP",
		"CUP_B_US_Sniper_M107_UCP",
		"CUP_B_US_Sniper_M110_TWS_UCP",
		"CUP_B_US_Spotter_UCP",
		"CUP_B_US_Soldier_SL_UCP"
	};
};

class CUP_USARMY_UCP_WDL_faction : CUP_USARMY_WDL_base
{
	displayName = "CUP - US Army UCP (Woodland)";

	infantry[] = {
		"CUP_B_US_Soldier_TL_UCP",
		"CUP_B_US_Soldier_AAT_UCP",
		"CUP_B_US_Soldier_AHAT_UCP",
		"CUP_B_US_Soldier_AAR_UCP",
		"CUP_B_US_Soldier_AMG_UCP",
		"CUP_B_US_Soldier_AT_UCP",
		"CUP_B_US_Soldier_HAT_UCP",
		"CUP_B_US_Soldier_AR_UCP",
		"CUP_B_US_Soldier_Engineer_UCP",
		"CUP_B_US_Soldier_Engineer_EOD_UCP",
		"CUP_B_US_Soldier_GL_UCP",
		"CUP_B_US_Soldier_MG_UCP",
		"CUP_B_US_Soldier_Marksman_UCP",
		"CUP_B_US_Soldier_Marksman_EBR_UCP",
		"CUP_B_US_Medic_UCP",
		"CUP_B_US_Soldier_AA_UCP",
		"CUP_B_US_Soldier_UCP",
		"CUP_B_US_Soldier_ACOG_UCP",
		"CUP_B_US_Soldier_LAT_UCP",
		"CUP_B_US_Soldier_Backpack_UCP",
		"CUP_B_US_Soldier_Engineer_Sapper_UCP",
		"CUP_B_US_Sniper_UCP",
		"CUP_B_US_Sniper_M107_UCP",
		"CUP_B_US_Sniper_M110_TWS_UCP",
		"CUP_B_US_Spotter_UCP",
		"CUP_B_US_Soldier_SL_UCP"
	};
};

class CUP_USMC_base
{
	displayName = "CUP - USMC Base";

	transportHelicopters[] = {
		"CUP_B_UH1Y_Gunship_Dynamic_USMC",
		"CUP_B_CH53E_USMC",
		"CUP_B_MH60S_USMC",
		"CUP_B_UH60S_USN"
	};
	casAircraft[] = {
		"CUP_B_AV8B_DYN_USMC",
		"CUP_B_F35B_USMC"
	};
	cargoAircraft[] = {
		"CUP_B_C130J_USMC",
		"CUP_B_MV22_USMC"
	};
	attackHelicopters[] = {
		"CUP_B_AH64D_DL_USA",
		"CUP_B_AH64_DL_USA"
	};
};

class CUP_USMC_DES_base : CUP_USMC_base
{
	displayName = "CUP - USMC Base (Desert)";

	lightCars[] = {
		"CUP_B_M1165_GMV_DSRT_USMC",
		"CUP_B_HMMWV_MK19_USA",
		"CUP_B_HMMWV_M2_USA",
		"CUP_B_HMMWV_SOV_M2_USA",
		"CUP_B_HMMWV_SOV_USA"
	};
	heavyCars[] = {
		"CUP_B_M1151_M2_DSRT_USMC",
		"CUP_B_M1151_Deploy_DSRT_USMC",
		"CUP_B_M1151_Mk19_DSRT_USMC",
		"CUP_B_RG31_Mk19_USMC",
		"CUP_B_RG31E_M2_USMC",
		"CUP_B_RG31_M2_USMC",
		"CUP_B_RG31_M2_GC_USMC"
	};
	lightArmor[] = {
		"CUP_B_LAV25_desert_USMC",
		"CUP_B_LAV25M240_desert_USMC",
		"CUP_B_AAV_USMC"
	};
	heavyArmor[] = {
		"CUP_B_M1A1_DES_USMC",
		"CUP_B_M1A2_TUSK_MG_DES_USMC"
	};
};

class CUP_USMC_WDL_base : CUP_USMC_base
{
	displayName = "CUP - USMC Base (Woodland)";

	lightCars[] = {
		"CUP_B_HMMWV_M1114_USMC",
		"CUP_B_HMMWV_MK19_USMC",
		"CUP_B_HMMWV_M2_USMC",
		"CUP_B_M1165_GMV_USMC",
		"CUP_B_HMMWV_SOV_NATO_T",
		"CUP_B_HMMWV_SOV_M2_NATO_T"
	};
	heavyCars[] = {
		"CUP_B_M1151_Deploy_USMC",
		"CUP_B_M1151_Mk19_USMC",
		"CUP_B_RG31_Mk19_OD_USMC",
		"CUP_B_RG31E_M2_OD_USMC",
		"CUP_B_RG31_M2_OD_USMC",
		"CUP_B_RG31_M2_OD_GC_USMC"
	};
	lightArmor[] = {
		"CUP_B_AAV_USMC",
		"CUP_B_LAV25_USMC",
		"CUP_B_LAV25M240_USMC",
		"CUP_B_LAV25M240_green"
	};
	heavyArmor[] = {
		"CUP_B_M1A1_Woodland_USMC",
		"CUP_B_M1A2_TUSK_MG_USMC"
	};
};

class CUP_USMC_DES_faction : CUP_USMC_DES_base
{
	displayName = "CUP - USMC (Desert)";

	infantry[] = {
		"CUP_B_USMC_Soldier_UAV_des",
		"CUP_B_USMC_Soldier_HAT_des",
		"CUP_B_USMC_Soldier_AT_des",
		"CUP_B_USMC_Soldier_AR_des",
		"CUP_B_USMC_Medic_des",
		"CUP_B_USMC_Engineer_des",
		"CUP_B_USMC_Soldier_GL_des",
		"CUP_B_USMC_Soldier_MG_des",
		"CUP_B_USMC_Soldier_Marksman_des",
		"CUP_B_USMC_Soldier_AA_des",
		"CUP_B_USMC_Soldier_des",
		"CUP_B_USMC_SpecOps_SD_des",
		"CUP_B_USMC_Soldier_LAT_des",
		"CUP_B_USMC_SpecOps_des",
		"CUP_B_USMC_Sniper_M40A3_des",
		"CUP_B_USMC_Sniper_M107_des",
		"CUP_B_USMC_Spotter_des",
		"CUP_B_USMC_Soldier_SL_des",
		"CUP_B_USMC_Soldier_TL_des"
	};
};

class CUP_USMC_WDL_faction : CUP_USMC_WDL_base
{
	displayName = "CUP - USMC (Woodland)";

	infantry[] = {
		"CUP_B_USMC_Soldier_TL",
		"CUP_B_USMC_Soldier_HAT",
		"CUP_B_USMC_Soldier_AT",
		"CUP_B_USMC_Soldier_AR",
		"CUP_B_USMC_Medic",
		"CUP_B_USMC_Engineer",
		"CUP_B_USMC_Soldier_GL",
		"CUP_B_USMC_Soldier_MG",
		"CUP_B_USMC_Soldier_Marksman",
		"CUP_B_USMC_Soldier_AA",
		"CUP_B_USMC_Soldier",
		"CUP_B_USMC_SpecOps_SD",
		"CUP_B_USMC_Soldier_LAT",
		"CUP_B_USMC_SpecOps",
		"CUP_B_USMC_Sniper_M40A3",
		"CUP_B_USMC_Sniper_M107",
		"CUP_B_USMC_Spotter",
		"CUP_B_USMC_Soldier_SL"
	};
};

class CUP_USMC_FR_DES_faction : CUP_USMC_DES_base
{
	displayName = "CUP - USMC Force Recon (Desert)";

	infantry[] = {
		"CUP_B_FR_Soldier_UAV_DES",
		"CUP_B_FR_Soldier_Assault_GL_DES",
		"CUP_B_FR_Soldier_Assault_DES",
		"CUP_B_FR_Commander_DES",
		"CUP_B_FR_Medic_DES",
		"CUP_B_FR_Soldier_Exp_DES",
		"CUP_B_FR_Soldier_Operator_DES",
		"CUP_B_FR_Soldier_GL_DES",
		"CUP_B_FR_Soldier_AR_DES",
		"CUP_B_FR_Soldier_Marksman_DES",
		"CUP_B_FR_Saboteur_DES",
		"CUP_B_FR_Soldier_TL_DES"
	};
};

class CUP_USMC_FR_WDL_faction : CUP_USMC_WDL_base
{
	displayName = "CUP - USMC Force Recon (Woodland)";

	infantry[] = {
		"CUP_B_FR_Soldier_Assault_GL",
		"CUP_B_FR_Soldier_Assault",
		"CUP_B_FR_Commander",
		"CUP_B_FR_Medic",
		"CUP_B_FR_Soldier_Exp",
		"CUP_B_FR_Soldier_Operator",
		"CUP_B_FR_Soldier_GL",
		"CUP_B_FR_Soldier_AR",
		"CUP_B_FR_Soldier_Marksman",
		"CUP_B_FR_Saboteur",
		"CUP_B_FR_Soldier_TL",
		"CUP_B_FR_Soldier_UAV"
	};
};

class CUP_USMC_FROG_DES_faction : CUP_USMC_DES_base
{
	displayName = "CUP - USMC FROG (Desert)";

	infantry[] = {
		"CUP_B_FR_Soldier_UAV_DES",
		"CUP_B_FR_Soldier_Assault_GL_DES",
		"CUP_B_FR_Soldier_Assault_DES",
		"CUP_B_FR_Commander_DES",
		"CUP_B_FR_Medic_DES",
		"CUP_B_FR_Soldier_Exp_DES",
		"CUP_B_FR_Soldier_Operator_DES",
		"CUP_B_FR_Soldier_GL_DES",
		"CUP_B_FR_Soldier_AR_DES",
		"CUP_B_FR_Soldier_Marksman_DES",
		"CUP_B_FR_Saboteur_DES",
		"CUP_B_FR_Soldier_TL_DES"
	};
};

class CUP_USMC_FROG_WDL_faction : CUP_USMC_WDL_base
{
	displayName = "CUP - USMC FROG (Woodland)";

	infantry[] = {
		"CUP_B_USMC_Soldier_HAT_FROG_DES",
		"CUP_B_USMC_Soldier_AT_FROG_DES",
		"CUP_B_USMC_Soldier_AR_FROG_DES",
		"CUP_B_USMC_Medic_FROG_DES",
		"CUP_B_USMC_Engineer_FROG_DES",
		"CUP_B_USMC_Soldier_GL_FROG_DES",
		"CUP_B_USMC_Soldier_MG_FROG_DES",
		"CUP_B_USMC_Soldier_Marksman_FROG_DES",
		"CUP_B_USMC_Soldier_AA_FROG_DES",
		"CUP_B_USMC_Officer_FROG_DES",
		"CUP_B_USMC_Soldier_RTO_FROG_DES",
		"CUP_B_USMC_Soldier_FROG_DES",
		"CUP_B_USMC_Soldier_LAT_FROG_DES",
		"CUP_B_USMC_Soldier_SL_FROG_DES",
		"CUP_B_USMC_Soldier_TL_FROG_DES",
		"CUP_B_USMC_Soldier_UAV_FROG_DES"
	};
};

class CUP_USMC_MARSOC_DES_faction : CUP_USMC_DES_base
{
	displayName = "CUP - MARSOC (Desert)";

	infantry[] = {
		"CUP_B_USMC_MARSOC_Medic_DA",
		"CUP_B_USMC_MARSOC_AR_DA",
		"CUP_B_USMC_MARSOC_AR",
		"CUP_B_USMC_MARSOC_CC",
		"CUP_B_USMC_MARSOC_CC_DA",
		"CUP_B_USMC_MARSOC_EL",
		"CUP_B_USMC_MARSOC_EL_DA",
		"CUP_B_USMC_MARSOC_Marksman",
		"CUP_B_USMC_MARSOC_Marksman_DA",
		"CUP_B_USMC_MARSOC_OC",
		"CUP_B_USMC_MARSOC_OC_DA",
		"CUP_B_USMC_MARSOC",
		"CUP_B_USMC_MARSOC_DA",
		"CUP_B_USMC_MARSOC_TC",
		"CUP_B_USMC_MARSOC_TC_DA",
		"CUP_B_USMC_MARSOC_TL",
		"CUP_B_USMC_MARSOC_TL_DA",
		"CUP_B_USMC_MARSOC_Medic"
	};
};

class CUP_USMC_MARSOC_WDL_faction : CUP_USMC_WDL_base
{
	displayName = "CUP - MARSOC (Woodland)";

	infantry[] = {
		"CUP_B_USMC_MARSOC_Medic_DA",
		"CUP_B_USMC_MARSOC_AR_DA",
		"CUP_B_USMC_MARSOC_AR",
		"CUP_B_USMC_MARSOC_CC",
		"CUP_B_USMC_MARSOC_CC_DA",
		"CUP_B_USMC_MARSOC_EL",
		"CUP_B_USMC_MARSOC_EL_DA",
		"CUP_B_USMC_MARSOC_Marksman",
		"CUP_B_USMC_MARSOC_Marksman_DA",
		"CUP_B_USMC_MARSOC_OC",
		"CUP_B_USMC_MARSOC_OC_DA",
		"CUP_B_USMC_MARSOC",
		"CUP_B_USMC_MARSOC_DA",
		"CUP_B_USMC_MARSOC_TC",
		"CUP_B_USMC_MARSOC_TC_DA",
		"CUP_B_USMC_MARSOC_TL",
		"CUP_B_USMC_MARSOC_TL_DA",
		"CUP_B_USMC_MARSOC_Medic"
	};
};

class CUP_AFRF_base
{
	displayName = "CUP - Armed Forces of the Russian Federation Base";

	lightCars[] = {
		"CUP_O_UAZ_AGS30_RU",
		"CUP_O_UAZ_MG_RU"
	};
	heavyCars[] = {
		"CUP_O_BRDM2_RUS",
		"CUP_O_BRDM2_HQ_RUS",
		"CUP_O_GAZ_Vodnik_PK_RU",
		"CUP_O_GAZ_Vodnik_AGS_RU",
		"CUP_O_GAZ_Vodnik_BPPU_RU",
		"CUP_O_GAZ_Vodnik_KPVT_RU"
	};
	heavyArmor[] = {
		"CUP_O_T72_RU",
		"CUP_O_T90_RU"
	};
	transportHelicopters[] = {
		"CUP_O_Mi8AMT_RU",
		"CUP_O_Ka60_Grey_RU"
	};
	cargoAircraft[] = {
		"CUP_O_Mi8AMT_RU"
	};
	casAircraft[] = {
		"CUP_O_Su25_Dyn_RU",
		"CUP_O_SU34_RU"
	};
	attackHelicopters[] = {
		"O_Heli_Attack_02_dynamicLoadout_black_F"
	};
};

class CUP_AFRF_WDL_base : CUP_AFRF_base
{
	displayName = "CUP - Armed Forces of the Russian Federation Base (WDL)";

	lightArmor[] = {
		"CUP_O_BMP2_RU",
		"CUP_O_BMP_HQ_RU",
		"CUP_O_BMP3_RU",
		"CUP_O_BTR60_Green_RU",
		"CUP_O_BTR80_CAMO_RU",
		"CUP_O_BTR80_GREEN_RU",
		"CUP_O_BTR80A_CAMO_RU",
		"CUP_O_BTR80A_GREEN_RU"
	};
};

class CUP_AFRF_DES_base : CUP_AFRF_base
{
	displayName = "CUP - Armed Forces of the Russian Federation Base (DES)";

	lightArmor[] = {
		"CUP_O_BMP2_RU",
		"CUP_O_BMP_HQ_RU",
		"CUP_O_BMP3_RU",
		"CUP_O_BTR60_RU",
		"CUP_O_BTR80_DESERT_RU",
		"CUP_O_BTR80A_DESERT_RU",
		"CUP_O_BTR90_RU"
	};
};

class CUP_AFRF_SNW_base : CUP_AFRF_base
{
	displayName = "CUP - Armed Forces of the Russian Federation Base (SNW)";

	lightArmor[] = {
		"CUP_O_BTR60_Winter_RU",
		"CUP_O_BTR80_WINTER_RU",
		"CUP_O_BTR80A_WINTER_RU"
	};
};

class CUP_AFRF_ARID_base : CUP_AFRF_base
{
	displayName = "CUP - Armed Forces of the Russian Federation Base (ARID)";

	lightArmor[] = {
		"CUP_O_BTR60_RU",
		"CUP_O_BTR90_RU",
		"CUP_O_BMP3_RU",
		"CUP_O_BMP_HQ_RU",
		"CUP_O_BMP2_RU"
	};
};

class CUP_AFRF_MSV_MODERN_faction : CUP_AFRF_WDL_base
{
	displayName = "CUP - Armed Forces of the Russian Federation (MSV - Modern - EMR)";

	infantry[] = {
		"CUP_O_RU_Soldier_TL_M_EMR",
		"CUP_O_RU_Soldier_AR_M_EMR",
		"CUP_O_RU_Engineer_M_EMR",
		"CUP_O_RU_Explosive_Specialist_M_EMR",
		"CUP_O_RU_Soldier_GL_M_EMR",
		"CUP_O_RU_Soldier_MG_M_EMR",
		"CUP_O_RU_Soldier_Marksman_M_EMR",
		"CUP_O_RU_Medic_M_EMR",
		"CUP_O_RU_Soldier_AA_M_EMR",
		"CUP_O_RU_Soldier_HAT_M_EMR",
		"CUP_O_RU_Officer_M_EMR",
		"CUP_O_RU_Soldier_M_EMR",
		"CUP_O_RU_Soldier_LAT_M_EMR",
		"CUP_O_RU_Soldier_AT_M_EMR",
		"CUP_O_RU_Soldier_Saiga_M_EMR",
		"CUP_O_RU_Sniper_M_EMR",
		"CUP_O_RU_Sniper_KSVK_M_EMR",
		"CUP_O_RU_Spotter_M_EMR",
		"CUP_O_RU_Soldier_SL_M_EMR"
	};
};

class CUP_AFRF_VDV_MODERN_faction : CUP_AFRF_WDL_base
{
	displayName = "CUP - Armed Forces of the Russian Federation (VDV - Modern - EMR)";

	infantry[] = {
		"CUP_O_RU_Soldier_AR_VDV_M_EMR",
		"CUP_O_RU_Engineer_VDV_M_EMR",
		"CUP_O_RU_Explosive_Specialist_VDV_M_EMR",
		"CUP_O_RU_Soldier_GL_VDV_M_EMR",
		"CUP_O_RU_Soldier_MG_VDV_M_EMR",
		"CUP_O_RU_Soldier_Marksman_VDV_M_EMR",
		"CUP_O_RU_Medic_VDV_M_EMR",
		"CUP_O_RU_Soldier_AA_VDV_M_EMR",
		"CUP_O_RU_Soldier_HAT_VDV_M_EMR",
		"CUP_O_RU_Officer_VDV_M_EMR",
		"CUP_O_RU_Soldier_VDV_M_EMR",
		"CUP_O_RU_Soldier_LAT_VDV_M_EMR",
		"CUP_O_RU_Soldier_AT_VDV_M_EMR",
		"CUP_O_RU_Soldier_Saiga_VDV_M_EMR",
		"CUP_O_RU_Sniper_VDV_M_EMR",
		"CUP_O_RU_Sniper_KSVK_VDV_M_EMR",
		"CUP_O_RU_Spotter_VDV_M_EMR",
		"CUP_O_RU_Soldier_SL_VDV_M_EMR",
		"CUP_O_RU_Soldier_TL_VDV_M_EMR"
	};
};

class CUP_AFRF_MSV_EMR_faction : CUP_AFRF_WDL_base
{
	displayName = "CUP - Armed Forces of the Russian Federation (MSV - EMR)";

	infantry[] = {
		"CUP_O_RU_Soldier_AR_EMR",
		"CUP_O_RU_Engineer_EMR",
		"CUP_O_RU_Explosive_Specialist_EMR",
		"CUP_O_RU_Soldier_GL_EMR",
		"CUP_O_RU_Soldier_MG_EMR",
		"CUP_O_RU_Soldier_Marksman_EMR",
		"CUP_O_RU_Medic_EMR",
		"CUP_O_RU_Soldier_AA_EMR",
		"CUP_O_RU_Soldier_HAT_EMR",
		"CUP_O_RU_Officer_EMR",
		"CUP_O_RU_Soldier_EMR",
		"CUP_O_RU_Soldier_LAT_EMR",
		"CUP_O_RU_Soldier_AT_EMR",
		"CUP_O_RU_Soldier_Saiga_EMR",
		"CUP_O_RU_Sniper_EMR",
		"CUP_O_RU_Sniper_KSVK_EMR",
		"CUP_O_RU_Spotter_EMR",
		"CUP_O_RU_Soldier_SL_EMR",
		"CUP_O_RU_Soldier_TL_EMR"
	};
};

class CUP_AFRF_MSV_TTSKO_faction : CUP_AFRF_DES_base
{
	displayName = "CUP - Armed Forces of the Russian Federation (MSV - TTsKO)";

	infantry[] = {
		"CUP_O_RU_Soldier_AR",
		"CUP_O_RU_Engineer",
		"CUP_O_RU_Explosive_Specialist",
		"CUP_O_RU_Soldier_GL",
		"CUP_O_RU_Soldier_MG",
		"CUP_O_RU_Soldier_Marksman",
		"CUP_O_RU_Medic",
		"CUP_O_RU_Soldier_AA",
		"CUP_O_RU_Soldier_HAT",
		"CUP_O_RU_Officer",
		"CUP_O_RU_Soldier",
		"CUP_O_RU_Soldier_LAT",
		"CUP_O_RU_Soldier_AT",
		"CUP_O_RU_Soldier_Saiga",
		"CUP_O_RU_Sniper",
		"CUP_O_RU_Sniper_KSVK",
		"CUP_O_RU_Spotter",
		"CUP_O_RU_Soldier_SL",
		"CUP_O_RU_Soldier_TL"
	};
};

class CUP_AFRF_MSV_VSR93_faction : CUP_AFRF_WDL_base
{
	displayName = "CUP - Armed Forces of the Russian Federation (MSV - VSR-93)";

	infantry[] = {
		"CUP_O_RU_Soldier_AAR_MSV_VSR93",
		"CUP_O_RU_Soldier_AAT_MSV_VSR93",
		"CUP_O_RU_Soldier_AR_MSV_VSR93",
		"CUP_O_RU_Soldier_Medic_MSV_VSR93",
		"CUP_O_RU_Soldier_Engineer_MSV_VSR93",
		"CUP_O_RU_Soldier_Exp_MSV_VSR93",
		"CUP_O_RU_Soldier_GL_MSV_VSR93",
		"CUP_O_RU_Soldier_MG_MSV_VSR93",
		"CUP_O_RU_Soldier_Marksman_MSV_VSR93",
		"CUP_O_RU_Soldier_AA_MSV_VSR93",
		"CUP_O_RU_Soldier_MSV_VSR93",
		"CUP_O_RU_Soldier_AT_MSV_VSR93",
		"CUP_O_RU_Soldier_HAT_MSV_VSR93",
		"CUP_O_RU_Soldier_LAT_MSV_VSR93",
		"CUP_O_RU_Soldier_Lite_MSV_VSR93",
		"CUP_O_RU_Soldier_SL_MSV_VSR93",
		"CUP_O_RU_Soldier_TL_MSV_VSR93"
	};
};

class CUP_AFRF_MVD_faction : CUP_AFRF_DES_base
{
	displayName = "CUP - Armed Forces of the Russian Federation (MVD)";

	infantry[] = {
		"CUP_O_MVD_Soldier_MG",
		"CUP_O_MVD_Soldier_Marksman",
		"CUP_O_MVD_Soldier",
		"CUP_O_MVD_Soldier_GL",
		"CUP_O_MVD_Soldier_AT",
		"CUP_O_MVD_Sniper",
		"CUP_O_MVD_Soldier_TL"
	};
};

class CUP_AFRF_RATNIK_AUT_faction : CUP_AFRF_ARID_base
{
	displayName = "CUP - Armed Forces of the Russian Federation (Ratnik - Autumn)";

	infantry[] = {
		"CUP_O_RU_Soldier_A_Ratnik_Autumn",
		"CUP_O_RU_Soldier_AAR_Ratnik_Autumn",
		"CUP_O_RU_Soldier_AHAT_Ratnik_Autumn",
		"CUP_O_RU_Soldier_AAT_Ratnik_Autumn",
		"CUP_O_RU_Soldier_AR_Ratnik_Autumn",
		"CUP_O_RU_Soldier_Medic_Ratnik_Autumn",
		"CUP_O_RU_Soldier_Engineer_Ratnik_Autumn",
		"CUP_O_RU_Soldier_Exp_Ratnik_Autumn",
		"CUP_O_RU_Soldier_GL_Ratnik_Autumn",
		"CUP_O_RU_Soldier_MG_Ratnik_Autumn",
		"CUP_O_RU_Soldier_Marksman_Ratnik_Autumn",
		"CUP_O_RU_Soldier_AA_Ratnik_Autumn",
		"CUP_O_RU_Soldier_LAT_Ratnik_Autumn",
		"CUP_O_RU_Recon_Marksman_Ratnik_Autumn",
		"CUP_O_RU_Recon_Exp_Ratnik_Autumn",
		"CUP_O_RU_Recon_Medic_Ratnik_Autumn",
		"CUP_O_RU_Recon_Ratnik_Autumn",
		"CUP_O_RU_Recon_LAT_Ratnik_Autumn",
		"CUP_O_RU_Recon_TL_Ratnik_Autumn",
		"CUP_O_RU_Soldier_Repair_Ratnik_Autumn",
		"CUP_O_RU_Soldier_Ratnik_Autumn",
		"CUP_O_RU_Soldier_AT_Ratnik_Autumn",
		"CUP_O_RU_Soldier_HAT_Ratnik_Autumn",
		"CUP_O_RU_Soldier_Lite_Ratnik_Autumn",
		"CUP_O_RU_Soldier_SL_Ratnik_Autumn",
		"CUP_O_RU_Soldier_TL_Ratnik_Autumn"
	};
};

class CUP_AFRF_RATNIK_BD_faction : CUP_AFRF_ARID_base
{
	displayName = "CUP - Armed Forces of the Russian Federation (Ratnik - Beige Digital)";

	infantry[] = {
		"CUP_O_RU_Soldier_A_Ratnik_BeigeDigital",
		"CUP_O_RU_Soldier_AAR_Ratnik_BeigeDigital",
		"CUP_O_RU_Soldier_AHAT_Ratnik_BeigeDigital",
		"CUP_O_RU_Soldier_AAT_Ratnik_BeigeDigital",
		"CUP_O_RU_Soldier_AR_Ratnik_BeigeDigital",
		"CUP_O_RU_Soldier_Medic_Ratnik_BeigeDigital",
		"CUP_O_RU_Soldier_Engineer_Ratnik_BeigeDigital",
		"CUP_O_RU_Soldier_Exp_Ratnik_BeigeDigital",
		"CUP_O_RU_Soldier_GL_Ratnik_BeigeDigital",
		"CUP_O_RU_Soldier_MG_Ratnik_BeigeDigital",
		"CUP_O_RU_Soldier_Marksman_Ratnik_BeigeDigital",
		"CUP_O_RU_Soldier_AA_Ratnik_BeigeDigital",
		"CUP_O_RU_Soldier_LAT_Ratnik_BeigeDigital",
		"CUP_O_RU_Recon_Exp_Ratnik_BeigeDigital",
		"CUP_O_RU_Recon_Marksman_Ratnik_BeigeDigital",
		"CUP_O_RU_Recon_Medic_Ratnik_BeigeDigital",
		"CUP_O_RU_Recon_Ratnik_BeigeDigital",
		"CUP_O_RU_Recon_LAT_Ratnik_BeigeDigital",
		"CUP_O_RU_Recon_TL_Ratnik_BeigeDigital",
		"CUP_O_RU_Soldier_Repair_Ratnik_BeigeDigital",
		"CUP_O_RU_Soldier_Ratnik_BeigeDigital",
		"CUP_O_RU_Soldier_AT_Ratnik_BeigeDigital",
		"CUP_O_RU_Soldier_HAT_Ratnik_BeigeDigital",
		"CUP_O_RU_Soldier_Lite_Ratnik_BeigeDigital",
		"CUP_O_RU_Soldier_SL_Ratnik_BeigeDigital",
		"CUP_O_RU_Soldier_TL_Ratnik_BeigeDigital"
	};
};

class CUP_AFRF_RATNIK_DES_faction : CUP_AFRF_DES_base
{
	displayName = "CUP - Armed Forces of the Russian Federation (Ratnik - Desert)";

	infantry[] = {
		"CUP_O_RU_Soldier_A_Ratnik_Desert",
		"CUP_O_RU_Soldier_AAR_Ratnik_Desert",
		"CUP_O_RU_Soldier_AHAT_Ratnik_Desert",
		"CUP_O_RU_Soldier_AAT_Ratnik_Desert",
		"CUP_O_RU_Soldier_AR_Ratnik_Desert",
		"CUP_O_RU_Soldier_Medic_Ratnik_Desert",
		"CUP_O_RU_Soldier_Engineer_Ratnik_Desert",
		"CUP_O_RU_Soldier_Exp_Ratnik_Desert",
		"CUP_O_RU_Soldier_GL_Ratnik_Desert",
		"CUP_O_RU_Soldier_MG_Ratnik_Desert",
		"CUP_O_RU_Soldier_Marksman_Ratnik_Desert",
		"CUP_O_RU_Soldier_AA_Ratnik_Desert",
		"CUP_O_RU_Soldier_LAT_Ratnik_Desert",
		"CUP_O_RU_Recon_Exp_Ratnik_Desert",
		"CUP_O_RU_Recon_Marksman_Ratnik_Desert",
		"CUP_O_RU_Recon_Medic_Ratnik_Desert",
		"CUP_O_RU_Recon_Ratnik_Desert",
		"CUP_O_RU_Recon_LAT_Ratnik_Desert",
		"CUP_O_RU_Recon_TL_Ratnik_Desert",
		"CUP_O_RU_Soldier_Repair_Ratnik_Desert",
		"CUP_O_RU_Soldier_Ratnik_Desert",
		"CUP_O_RU_Soldier_AT_Ratnik_Desert",
		"CUP_O_RU_Soldier_HAT_Ratnik_Desert",
		"CUP_O_RU_Soldier_Lite_Ratnik_Desert",
		"CUP_O_RU_Soldier_SL_Ratnik_Desert",
		"CUP_O_RU_Soldier_TL_Ratnik_Desert"
	};
};

class CUP_AFRF_RATNIK_SUM_faction : CUP_AFRF_WDL_base
{
	displayName = "CUP - Armed Forces of the Russian Federation (Ratnik - Summer)";

	infantry[] = {
		"CUP_O_RU_Soldier_A_Ratnik_Summer",
		"CUP_O_RU_Soldier_AAR_Ratnik_Summer",
		"CUP_O_RU_Soldier_AHAT_Ratnik_Summer",
		"CUP_O_RU_Soldier_AAT_Ratnik_Summer",
		"CUP_O_RU_Soldier_AR_Ratnik_Summer",
		"CUP_O_RU_Soldier_Medic_Ratnik_Summer",
		"CUP_O_RU_Soldier_Engineer_Ratnik_Summer",
		"CUP_O_RU_Soldier_Exp_Ratnik_Summer",
		"CUP_O_RU_Soldier_GL_Ratnik_Summer",
		"CUP_O_RU_Soldier_MG_Ratnik_Summer",
		"CUP_O_RU_Soldier_Marksman_Ratnik_Summer",
		"CUP_O_RU_Soldier_AA_Ratnik_Summer",
		"CUP_O_RU_Soldier_LAT_Ratnik_Summer",
		"CUP_O_RU_Recon_Exp_Ratnik_Summer",
		"CUP_O_RU_Recon_Marksman_Ratnik_Summer",
		"CUP_O_RU_Recon_Medic_Ratnik_Summer",
		"CUP_O_RU_Recon_Ratnik_Summer",
		"CUP_O_RU_Recon_LAT_Ratnik_Summer",
		"CUP_O_RU_Recon_TL_Ratnik_Summer",
		"CUP_O_RU_Soldier_Repair_Ratnik_Summer",
		"CUP_O_RU_Soldier_Ratnik_Summer",
		"CUP_O_RU_Soldier_AT_Ratnik_Summer",
		"CUP_O_RU_Soldier_HAT_Ratnik_Summer",
		"CUP_O_RU_Soldier_Lite_Ratnik_Summer",
		"CUP_O_RU_Soldier_SL_Ratnik_Summer",
		"CUP_O_RU_Soldier_TL_Ratnik_Summer"
	};
};

class CUP_AFRF_RATNIK_SNW_faction : CUP_AFRF_SNW_base
{
	displayName = "CUP - Armed Forces of the Russian Federation (Ratnik - Winter)";

	infantry[] = {
		"CUP_O_RU_Soldier_A_Ratnik_Winter",
		"CUP_O_RU_Soldier_AAR_Ratnik_Winter",
		"CUP_O_RU_Soldier_AHAT_Ratnik_Winter",
		"CUP_O_RU_Soldier_AAT_Ratnik_Winter",
		"CUP_O_RU_Soldier_AR_Ratnik_Winter",
		"CUP_O_RU_Soldier_Medic_Ratnik_Winter",
		"CUP_O_RU_Soldier_Engineer_Ratnik_Winter",
		"CUP_O_RU_Soldier_Exp_Ratnik_Winter",
		"CUP_O_RU_Soldier_GL_Ratnik_Winter",
		"CUP_O_RU_Soldier_MG_Ratnik_Winter",
		"CUP_O_RU_Soldier_Marksman_Ratnik_Winter",
		"CUP_O_RU_Soldier_AA_Ratnik_Winter",
		"CUP_O_RU_Soldier_LAT_Ratnik_Winter",
		"CUP_O_RU_Recon_Exp_Ratnik_Winter",
		"CUP_O_RU_Recon_Marksman_Ratnik_Winter",
		"CUP_O_RU_Recon_Medic_Ratnik_Winter",
		"CUP_O_RU_Recon_Ratnik_Winter",
		"CUP_O_RU_Recon_LAT_Ratnik_Winter",
		"CUP_O_RU_Recon_TL_Ratnik_Winter",
		"CUP_O_RU_Soldier_Repair_Ratnik_Winter",
		"CUP_O_RU_Soldier_Ratnik_Winter",
		"CUP_O_RU_Soldier_AT_Ratnik_Winter",
		"CUP_O_RU_Soldier_HAT_Ratnik_Winter",
		"CUP_O_RU_Soldier_Lite_Ratnik_Winter",
		"CUP_O_RU_Soldier_SL_Ratnik_Winter",
		"CUP_O_RU_Soldier_TL_Ratnik_Winter"
	};
};

class CUP_AFRF_SPETSNAZ_AUT_faction : CUP_AFRF_ARID_base
{
	displayName = "CUP - Armed Forces of the Russian Federation (Spetsnaz - Autumn)";

	infantry[] = {
		"CUP_O_RUS_Saboteur_Autumn",
		"CUP_O_RUS_Soldier_Marksman_Autumn",
		"CUP_O_RUS_Commander_Autumn",
		"CUP_O_RUS_SpecOps_Autumn",
		"CUP_O_RUS_SpecOps_Night_Autumn",
		"CUP_O_RUS_SpecOps_SD_Autumn",
		"CUP_O_RUS_SpecOps_Scout_Autumn",
		"CUP_O_RUS_SpecOps_Scout_Night_Autumn",
		"CUP_O_RUS_Soldier_TL_Autumn",
		"CUP_O_RUS_Soldier_GL_Autumn"
	};
};

class CUP_AFRF_SPETSNAZ_SUM_faction : CUP_AFRF_WDL_base
{
	displayName = "CUP - Armed Forces of the Russian Federation (Spetsnaz - Summer)";

	infantry[] = {
		"CUP_O_RUS_Saboteur",
		"CUP_O_RUS_Soldier_GL",
		"CUP_O_RUS_Soldier_Marksman",
		"CUP_O_RUS_Commander",
		"CUP_O_RUS_SpecOps",
		"CUP_O_RUS_SpecOps_Night",
		"CUP_O_RUS_SpecOps_SD",
		"CUP_O_RUS_SpecOps_Scout",
		"CUP_O_RUS_SpecOps_Scout_Night",
		"CUP_O_RUS_Soldier_TL"
	};
};

class CUP_AFRF_VDV_EMR_faction : CUP_AFRF_WDL_base
{
	displayName = "CUP - Armed Forces of the Russian Federation (VDV - EMR)";

	infantry[] = {
		"CUP_O_RU_Soldier_AR_VDV_EMR",
		"CUP_O_RU_Engineer_VDV_EMR",
		"CUP_O_RU_Explosive_Specialist_VDV_EMR",
		"CUP_O_RU_Soldier_GL_VDV_EMR",
		"CUP_O_RU_Soldier_MG_VDV_EMR",
		"CUP_O_RU_Soldier_Marksman_VDV_EMR",
		"CUP_O_RU_Medic_VDV_EMR",
		"CUP_O_RU_Soldier_AA_VDV_EMR",
		"CUP_O_RU_Soldier_HAT_VDV_EMR",
		"CUP_O_RU_Officer_VDV_EMR",
		"CUP_O_RU_Soldier_VDV_EMR",
		"CUP_O_RU_Soldier_LAT_VDV_EMR",
		"CUP_O_RU_Soldier_AT_VDV_EMR",
		"CUP_O_RU_Soldier_Saiga_VDV_EMR",
		"CUP_O_RU_Sniper_VDV_EMR",
		"CUP_O_RU_Sniper_KSVK_VDV_EMR",
		"CUP_O_RU_Spotter_VDV_EMR",
		"CUP_O_RU_Soldier_SL_VDV_EMR",
		"CUP_O_RU_Soldier_TL_VDV_EMR"
	};
};

class CUP_AFRF_VDV_TTSKO_faction : CUP_AFRF_DES_base
{
	displayName = "CUP - Armed Forces of the Russian Federation (VDV - TTsKO)";

	infantry[] = {
		"CUP_O_RU_Soldier_AR_VDV",
		"CUP_O_RU_Engineer_VDV",
		"CUP_O_RU_Explosive_Specialist_VDV",
		"CUP_O_RU_Soldier_GL_VDV",
		"CUP_O_RU_Soldier_MG_VDV",
		"CUP_O_RU_Soldier_Marksman_VDV",
		"CUP_O_RU_Medic_VDV",
		"CUP_O_RU_Soldier_AA_VDV",
		"CUP_O_RU_Soldier_HAT_VDV",
		"CUP_O_RU_Officer_VDV",
		"CUP_O_RU_Soldier_VDV",
		"CUP_O_RU_Soldier_LAT_VDV",
		"CUP_O_RU_Soldier_AT_VDV",
		"CUP_O_RU_Soldier_Saiga_VDV",
		"CUP_O_RU_Sniper_VDV",
		"CUP_O_RU_Sniper_KSVK_VDV",
		"CUP_O_RU_Spotter_VDV",
		"CUP_O_RU_Soldier_SL_VDV",
		"CUP_O_RU_Soldier_TL_VDV"
	};
};

class CUP_CHDKZ_faction
{
	displayName = "CUP - Chernarus Movement of the Red Star";

	lightCars[] = {
		"CUP_O_Datsun_PK",
		"CUP_O_Datsun_PK_Random",
		"CUP_O_Datsun_4seat",
		"CUP_O_Hilux_AGS30_CHDKZ",
		"CUP_O_Hilux_DSHKM_CHDKZ",
		"CUP_O_Hilux_zu23_CHDKZ",
		"CUP_O_UAZ_AGS30_CHDKZ",
		"CUP_O_UAZ_MG_CHDKZ"
	};
	heavyCars[] = {
		"CUP_O_BRDM2_HQ_CHDKZ"
	};
	lightArmor[] = {
		"CUP_O_BMP2_CHDKZ",
		"CUP_O_BMP_HQ_CHDKZ",
		"CUP_O_BRDM2_CHDKZ",
		"CUP_O_BTR60_CHDKZ",
		"CUP_O_BTR80_CHDKZ",
		"CUP_O_BTR80A_CHDKZ",
		"CUP_O_MTLB_pk_ChDKZ"
	};
	heavyArmor[] = {
		"CUP_O_T55_CHDKZ",
		"CUP_O_T72_CHDKZ"
	};
	transportHelicopters[] = {
		"CUP_O_Mi8_CHDKZ"
	};
	cargoAircraft[] = {
		"CUP_O_AN2_TK",
		"CUP_O_C47_SLA"
	};
	casAircraft[] = {
		"CUP_O_Su25_Dyn_RU"
	};
	attackHelicopters[] = {
		"CUP_I_Mi24_Mk3_ION",
		"CUP_I_Mi24_Mk4_ION"
	};

	infantry[] = {
		"CUP_O_INS_Woodlander1",
		"CUP_O_INS_Soldier_AA",
		"CUP_O_INS_Soldier_Ammo",
		"CUP_O_INS_Soldier_AT",
		"CUP_O_INS_Soldier_AR",
		"CUP_O_INS_Story_Lopotev",
		"CUP_O_INS_Commander",
		"CUP_O_INS_Soldier_Engineer",
		"CUP_O_INS_Soldier_GL",
		"CUP_O_INS_Soldier_MG",
		"CUP_O_INS_Medic",
		"CUP_O_INS_Officer",
		"CUP_O_INS_Soldier",
		"CUP_O_INS_Soldier_AK74",
		"CUP_O_INS_Soldier_LAT",
		"CUP_O_INS_Saboteur",
		"CUP_O_INS_Soldier_Exp",
		"CUP_O_INS_Sniper",
		"CUP_O_INS_Villager3",
		"CUP_O_INS_Woodlander3",
		"CUP_O_INS_Woodlander2",
		"CUP_O_INS_Worker2",
		"CUP_O_INS_Villager4"
	};	
};

class CUP_SLA_base
{
	displayName = "CUP - Sahrani Liberation Army Base";

	lightCars[] = {
		"CUP_O_UAZ_AGS30_SLA",
		"CUP_O_UAZ_MG_SLA"
	};
	heavyCars[] = {
		"CUP_O_BRDM2_SLA",
		"CUP_O_BRDM2_HQ_SLA"
	};
	lightArmor[] = {
		"CUP_O_BMP2_SLA",
		"CUP_O_BMP_HQ_sla",
		"CUP_O_BTR60_SLA",
		"CUP_O_BTR80_SLA",
		"CUP_O_BTR80A_SLA",
		"CUP_O_MTLB_pk_SLA"
	};
	heavyArmor[] = {
		"CUP_O_T55_SLA",
		"CUP_O_T72_SLA"
	};
	transportHelicopters[] = {
		"CUP_O_UH1H_SLA",
		"CUP_O_Mi8_SLA_1"
	};
	cargoAircraft[] = {
		"CUP_O_C47_SLA"
	};
	casAircraft[] = {
		"CUP_O_Su25_Dyn_SLA",
		"CUP_O_SU34_SLA"
	};
	attackHelicopters[] = {
		"CUP_B_AH64_DL_USA",
		"CUP_B_AH64D_DL_USA"
	};
};

class CUP_SLA_FOREST_faction : CUP_SLA_base
{
	displayName = "CUP - Sahrani Liberation Army (Forest)";

	infantry[] = {
		"CUP_O_sla_Soldier_AKS_74_GOSHAWK",
		"CUP_O_sla_Soldier_AA",
		"CUP_O_sla_Soldier_AAT",
		"CUP_O_sla_Soldier_AMG",
		"CUP_O_sla_Soldier_HAT",
		"CUP_O_sla_Soldier_AR",
		"CUP_O_sla_Engineer",
		"CUP_O_sla_Soldier_GL",
		"CUP_O_sla_Soldier_MG",
		"CUP_O_sla_Medic",
		"CUP_O_sla_Officer",
		"CUP_O_sla_Soldier",
		"CUP_O_SLA_Soldier_Backpack",
		"CUP_O_sla_Soldier_LAT",
		"CUP_O_sla_Soldier_AT",
		"CUP_O_sla_Sniper",
		"CUP_O_sla_Sniper_KSVK",
		"CUP_O_SLA_Sniper_SVD_Night",
		"CUP_O_sla_Soldier_AKS_Night",
		"CUP_O_SLA_Spotter",
		"CUP_O_sla_Soldier_SL",
		"CUP_O_sla_SpecOps_Demo",
		"CUP_O_sla_SpecOps_LAT",
		"CUP_O_sla_SpecOps",
		"CUP_O_sla_SpecOps_MG",
		"CUP_O_sla_SpecOps_TL"
	};
};

class CUP_SLA_DESERT_faction : CUP_SLA_base
{
	displayName = "CUP - Sahrani Liberation Army (Desert)";

	infantry[] = {
		"CUP_O_sla_Sniper_KSVK_desert",
		"CUP_O_sla_Soldier_AA_desert",
		"CUP_O_sla_Soldier_AAT_desert",
		"CUP_O_sla_Soldier_AMG_desert",
		"CUP_O_sla_Soldier_HAT_desert",
		"CUP_O_sla_Soldier_AR_desert",
		"CUP_O_sla_Engineer_desert",
		"CUP_O_sla_Soldier_GL_desert",
		"CUP_O_sla_Soldier_MG_desert",
		"CUP_O_sla_Medic_desert",
		"CUP_O_sla_Officer_desert",
		"CUP_O_sla_soldier_desert",
		"CUP_O_SLA_Soldier_Backpack_desert",
		"CUP_O_sla_Soldier_LAT_desert",
		"CUP_O_sla_Soldier_AT_desert",
		"CUP_O_sla_Sniper_desert",
		"CUP_O_SLA_Sniper_SVD_Night_desert",
		"CUP_O_sla_Soldier_AKS_Night_desert",
		"CUP_O_sla_Soldier_AKS_74_GOSHAWK_desert",
		"CUP_O_SLA_Spotter_desert",
		"CUP_O_sla_Soldier_SL_desert"
	};
};

class CUP_SLA_MILITIA_faction : CUP_SLA_base
{
	displayName = "CUP - Sahrani Liberation Army (Militia)";

	infantry[] = {
		"CUP_O_sla_Soldier_militia",
		"CUP_O_sla_Soldier_AAT_militia",
		"CUP_O_sla_Soldier_AMG_militia",
		"CUP_O_sla_Soldier_AR_militia",
		"CUP_O_SLA_Soldier_Backpack_militia",
		"CUP_O_sla_Engineer_militia",
		"CUP_O_sla_Soldier_GL_militia",
		"CUP_O_sla_Soldier_MG_militia",
		"CUP_O_sla_Medic_militia",
		"CUP_O_sla_Soldier_AA_militia",
		"CUP_O_sla_Officer_militia",
		"CUP_O_sla_Soldier_SL_militia",
		"CUP_O_sla_Soldier_LAT_militia",
		"CUP_O_sla_Soldier_AT_militia"
	};
};

class CUP_SLA_URBAN_faction : CUP_SLA_base
{
	displayName = "CUP - Sahrani Liberation Army (Urban)";

	infantry[] = {
		"CUP_O_sla_Soldier_SL_urban",
		"CUP_O_sla_Soldier_AA_urban",
		"CUP_O_sla_Soldier_AAT_urban",
		"CUP_O_sla_Soldier_AMG_urban",
		"CUP_O_sla_Soldier_HAT_urban",
		"CUP_O_sla_Soldier_AR_urban",
		"CUP_O_sla_Engineer_urban",
		"CUP_O_sla_Soldier_GL_urban",
		"CUP_O_sla_Soldier_MG_urban",
		"CUP_O_sla_Medic_urban",
		"CUP_O_sla_Officer_urban",
		"CUP_O_sla_Soldier_urban",
		"CUP_O_SLA_Soldier_Backpack_urban",
		"CUP_O_sla_Soldier_LAT_urban",
		"CUP_O_sla_Soldier_AT_urban",
		"CUP_O_sla_Sniper_urban",
		"CUP_O_sla_Sniper_KSVK_urban",
		"CUP_O_SLA_Sniper_SVD_Night_urban",
		"CUP_O_sla_Soldier_AKS_Night_urban",
		"CUP_O_sla_Soldier_AKS_74_GOSHAWK_urban",
		"CUP_O_SLA_Spotter_urban"
	};
};

class CUP_TKA_faction
{
	displayName = "CUP - Takistani Army";

	lightCars[] = {
		"CUP_O_LR_MG_TKA",
		"CUP_O_UAZ_AGS30_TKA",
		"CUP_O_UAZ_MG_TKA"
	};
	heavyCars[] = {
		"CUP_O_BRDM2_HQ_TKA",
		"CUP_O_BTR40_MG_TKA"
	};
	lightArmor[] = {
		"CUP_O_BMP1_TKA",
		"CUP_O_BMP1P_TKA",
		"CUP_O_BMP2_TKA",
		"CUP_O_BMP_HQ_TKA",
		"CUP_O_BRDM2_TKA",
		"CUP_O_BTR60_TK",
		"CUP_O_BTR80_TK",
		"CUP_O_BTR80A_TK",
		"CUP_O_M113_TKA",
		"CUP_O_MTLB_pk_TKA"
	};
	heavyArmor[] = {
		"CUP_O_T34_TKA",
		"CUP_O_T55_TK",
		"CUP_O_T72_TKA"
	};
	transportHelicopters[] = {
		"CUP_O_UH1H_TKA",
		"CUP_O_Mi17_TK"
	};
	cargoAircraft[] = {
		"CUP_O_C130J_TKA"
	};
	casAircraft[] = {
		"CUP_O_L39_TK",
		"CUP_O_Su25_Dyn_TKA"
	};
	attackHelicopters[] = {
		"CUP_B_AH64_DL_USA",
		"CUP_B_AH64D_DL_USA"
	};
	
	infantry[] = {
		"CUP_O_TK_Soldier_SL",
		"CUP_O_TK_Soldier_AA",
		"CUP_O_TK_Soldier_AAT",
		"CUP_O_TK_Soldier_AMG",
		"CUP_O_TK_Soldier_HAT",
		"CUP_O_TK_Soldier_AR",
		"CUP_O_TK_Commander",
		"CUP_O_TK_Engineer",
		"CUP_O_TK_Soldier_GL",
		"CUP_O_TK_Soldier_MG",
		"CUP_O_TK_Soldier_M",
		"CUP_O_TK_Medic",
		"CUP_O_TK_Officer",
		"CUP_O_TK_Soldier",
		"CUP_O_TK_Soldier_Backpack",
		"CUP_O_TK_Soldier_LAT",
		"CUP_O_TK_Soldier_AT",
		"CUP_O_TK_Sniper",
		"CUP_O_TK_Sniper_KSVK",
		"CUP_O_TK_Sniper_SVD_Night",
		"CUP_O_TK_Soldier_AKS_Night",
		"CUP_O_TK_Soldier_FNFAL_Night",
		"CUP_O_TK_Soldier_AKS_74_GOSHAWK",
		"CUP_O_TK_Spotter",
		"CUP_O_TK_SpecOps_MG",
		"CUP_O_TK_SpecOps",
		"CUP_O_TK_SpecOps_TL"
	};
};

class CUP_TKM_faction
{
	displayName = "CUP - Takistani Militia";

	lightCars[] = {
		"CUP_O_Hilux_AGS30_TK_INS",
		"CUP_O_Hilux_DSHKM_TK_INS",
		"CUP_O_Hilux_M2_TK_INS",
		"CUP_O_LR_MG_TKM"
	};
	heavyCars[] = {
		"CUP_I_BTR40_MG_TKG",
		"CUP_O_Hilux_BMP1_TK_INS",
		"CUP_O_Hilux_btr60_TK_INS",
		"CUP_O_Hilux_armored_AGS30_TK_INS",
		"CUP_O_Hilux_armored_DSHKM_TK_INS",
		"CUP_O_Hilux_armored_M2_TK_INS",
		"CUP_I_BRDM2_HQ_TK_Gue"
	};
	lightArmor[] = {
		"CUP_O_MTLB_pk_TK_MILITIA",
		"CUP_O_Hilux_armored_BMP1_TK_INS",
		"CUP_O_Hilux_armored_BTR60_TK_INS",
		"CUP_I_BRDM2_TK_Gue",
		"CUP_I_BMP1_TK_GUE"
	};
	heavyArmor[] = {
		"CUP_I_T34_TK_GUE",
		"CUP_I_T55_TK_GUE"
	};
	transportHelicopters[] = {
		"CUP_I_UH1H_TK_GUE"
	};
	cargoAircraft[] = {
		"CUP_O_AN2_TK"
	};
	casAircraft[] = {
		"CUP_O_L39_TK"
	};
	attackHelicopters[] = {
		"CUP_I_Mi24_Mk3_ION",
		"CUP_I_Mi24_Mk4_ION"
	};

	infantry[] = {
		"CUP_O_TK_INS_Commander",
		"CUP_O_TK_INS_Soldier_AA",
		"CUP_O_TK_INS_Soldier_AR",
		"CUP_O_TK_INS_Guerilla_Medic",
		"CUP_O_TK_INS_Soldier_MG",
		"CUP_O_TK_INS_Bomber",
		"CUP_O_TK_INS_Mechanic",
		"CUP_O_TK_INS_Soldier_GL",
		"CUP_O_TK_INS_Soldier",
		"CUP_O_TK_INS_Soldier_FNFAL",
		"CUP_O_TK_INS_Soldier_Enfield",
		"CUP_O_TK_INS_Soldier_AAT",
		"CUP_O_TK_INS_Soldier_AT",
		"CUP_O_TK_INS_Sniper",
		"CUP_O_TK_INS_Soldier_TL"
	};	
};

class CUP_PMC_faction
{
	displayName = "CUP - ION PMC";

	lightCars[] = {
		"CUP_I_SUV_Armored_ION",
		"CUP_I_4WD_LMG_ION",
		"CUP_I_LSV_02_Minigun_ION"
	};
	heavyCars[] = {
		"CUP_I_FENNEK_GMG_ION",
		"CUP_I_FENNEK_HMG_ION",
		"CUP_I_MATV_GMG_ION",
		"CUP_I_MATV_HMG_ION",
		"CUP_I_RG31_Mk19_ION",
		"CUP_I_RG31E_M2_ION",
		"CUP_I_RG31_M2_ION",
		"CUP_I_RG31_M2_GC_ION"
	};
	lightArmor[] = {
		"CUP_I_BTR80_ION",
		"CUP_I_BTR80A_ION"
	};
	heavyArmor[] = {
		"CUP_B_Challenger2_Woodland_BAF"
	};
	transportHelicopters[] = {
		"CUP_I_Ka60_GL_Blk_ION",
		"CUP_I_MH6M_ION",
		"CUP_I_Ka60_Blk_ION"
	};
	cargoAircraft[] = {
		"CUP_C_C47_CIV"
	};
	casAircraft[] = {
		"CUP_B_L39_CZ_GREY"
	};
	attackHelicopters[] = {
		"CUP_I_Mi24_Mk3_ION",
		"CUP_I_Mi24_Mk4_ION"
	};
	
	infantry[] = {
		"CUP_I_PMC_Soldier_TL",
		"CUP_I_PMC_Bodyguard_AA12",
		"CUP_I_PMC_Bodyguard_M4",
		"CUP_I_PMC_Contractor1",
		"CUP_I_PMC_Contractor2",
		"CUP_I_PMC_Sniper",
		"CUP_I_PMC_Medic",
		"CUP_I_PMC_Soldier_MG",
		"CUP_I_PMC_Soldier_MG_PKM",
		"CUP_I_PMC_Soldier_AT",
		"CUP_I_PMC_Engineer",
		"CUP_I_PMC_Soldier_M4A3",
		"CUP_I_PMC_Soldier",
		"CUP_I_PMC_Soldier_GL",
		"CUP_I_PMC_Soldier_GL_M16A2",
		"CUP_I_PMC_Crew",
		"CUP_I_PMC_Sniper_KSVK",
		"CUP_I_PMC_Soldier_AA"
	};
};	

class CUP_PMC_ARTIC_faction : CUP_PMC_faction
{
	displayName = "CUP - ION PMC (Artic)";

	heavyCars[] = {
		"CUP_I_RG31_Mk19_W_ION",
		"CUP_I_RG31E_M2_W_ION",
		"CUP_I_RG31_M2_W_ION",
		"CUP_I_RG31_M2_W_GC_ION",
		"CUP_I_MATV_HMG_ION",
		"CUP_I_MATV_GMG_ION",
		"CUP_I_FENNEK_HMG_ION",
		"CUP_I_FENNEK_GMG_ION"
	};
	heavyArmor[] = {
		"CUP_B_Challenger2_Snow_BAF"
	};
	infantry[] = {
		"CUP_I_PMC_Winter_Soldier",
		"CUP_I_PMC_Winter_Sniper",
		"CUP_I_PMC_Winter_Medic",
		"CUP_I_PMC_Winter_Soldier_MG",
		"CUP_I_PMC_Winter_Soldier_MG_PKM",
		"CUP_I_PMC_Winter_Soldier_AT",
		"CUP_I_PMC_Winter_Engineer",
		"CUP_I_PMC_Winter_Soldier_M4A3",
		"CUP_I_PMC_Winter_Soldier_GL",
		"CUP_I_PMC_Winter_Crew",
		"CUP_I_PMC_Winter_Sniper_KSVK",
		"CUP_I_PMC_Winter_Soldier_AA",
		"CUP_I_PMC_Winter_Soldier_TL"
	};
};

class CUP_NAPA_faction : CUP_CHDKZ_faction
{
	displayName = "CUP - National Party of Chernarus";

	lightCars[] = {
		"CUP_I_Datsun_PK",
		"CUP_I_Datsun_PK_Random",
		"CUP_I_Datsun_4seat",
		"CUP_I_Hilux_AGS30_NAPA",
		"CUP_I_Hilux_DSHKM_NAPA",
		"CUP_I_Hilux_armored_AGS30_NAPA",
		"CUP_I_Hilux_armored_DSHKM_NAPA"
	};
	heavyCars[] = {
		"CUP_I_BRDM2_HQ_NAPA",
		"CUP_I_Hilux_BMP1_NAPA",
		"CUP_I_Hilux_btr60_NAPA",
		"CUP_I_Hilux_armored_BMP1_NAPA",
		"CUP_I_Hilux_armored_BTR60_NAPA"
	};
	lightArmor[] = {
		"CUP_I_BMP2_NAPA",
		"CUP_I_BMP_HQ_NAPA",
		"CUP_I_BRDM2_NAPA",
		"CUP_I_MTLB_pk_NAPA"
	};
	heavyArmor[] = {
		"CUP_I_T34_NAPA",
		"CUP_I_T55_NAPA",
		"CUP_I_T72_NAPA"
	};

	infantry[] = {
		"CUP_I_GUE_Commander",
		"CUP_I_GUE_Soldier_AA",
		"CUP_I_GUE_Ammobearer",
		"CUP_I_GUE_Soldier_AR",
		"CUP_I_GUE_Officer",
		"CUP_I_GUE_Crew",
		"CUP_I_GUE_Soldier_GL",
		"CUP_I_GUE_Sniper",
		"CUP_I_GUE_Soldier_MG",
		"CUP_I_GUE_Engineer",
		"CUP_I_GUE_Medic",
		"CUP_I_GUE_Pilot",
		"CUP_I_GUE_Soldier_AKS74",
		"CUP_I_GUE_Soldier_AKM",
		"CUP_I_GUE_Soldier_AKSU",
		"CUP_I_GUE_Soldier_LAT",
		"CUP_I_GUE_Soldier_AT",
		"CUP_I_GUE_Soldier_AA2",
		"CUP_I_GUE_Saboteur",
		"CUP_I_GUE_Soldier_Scout",
		"CUP_I_GUE_Farmer",
		"CUP_I_GUE_Forester",
		"CUP_I_GUE_Gamekeeper",
		"CUP_I_GUE_Local",
		"CUP_I_GUE_Villager",
		"CUP_I_GUE_Woodman"
	};
};

class CUP_RACS_base
{
	displayName = "CUP - Royal Army Corps of Sahrani";

	lightCars[] = {
		"CUP_I_LR_MG_RACS"
	};
	heavyCars[] = {
		"CUP_B_HMMWV_Crows_M2_USA",
		"CUP_B_HMMWV_Crows_MK19_USA"
	};
	lightArmor[] = {
		"CUP_I_AAV_RACS",
		"CUP_I_LAV25_RACS",
		"CUP_I_LAV25M240_RACS",
		"CUP_I_M113_RACS",
		"CUP_I_M113_RACS_URB"
	};
	heavyArmor[] = {
		"CUP_I_M60A3_RACS",
		"CUP_I_M60A3_TTS_RACS",
		"CUP_I_T72_RACS"
	};
	transportHelicopters[] = {
		"CUP_I_UH60L_RACS",
		"CUP_I_CH47F_RACS",
		"CUP_I_UH1H_RACS"
	};
	cargoAircraft[] = {
		"CUP_I_C130J_RACS"
	};
	casAircraft[] = {
		"CUP_I_JAS39_RACS"
	};
	attackHelicopters[] = {
		"CUP_I_Mi24_Mk3_ION",
		"CUP_I_Mi24_Mk4_ION"
	};
};
class CUP_RACS_DES_faction : CUP_RACS_base
{
	displayName = "CUP - Royal Army Corps of Sahrani (Desert)";

	infantry[] = {
		"CUP_I_RACS_SL",
		"CUP_I_RACS_Soldier_AA",
		"CUP_I_RACS_Soldier_AAT",
		"CUP_I_RACS_Soldier_AMG",
		"CUP_I_RACS_Soldier_MAT",
		"CUP_I_RACS_AR",
		"CUP_I_RACS_Engineer",
		"CUP_I_RACS_GL",
		"CUP_I_RACS_Soldier_HAT",
		"CUP_I_RACS_MMG",
		"CUP_I_RACS_M",
		"CUP_I_RACS_Medic",
		"CUP_I_RACS_Officer",
		"CUP_I_RACS_Soldier",
		"CUP_I_RACS_Soldier_Light",
		"CUP_I_RACS_Soldier_LAT",
		"CUP_I_RACS_Sniper"
	};
};
class CUP_RACS_JUNGLE_faction : CUP_RACS_base
{
	displayName = "CUP - Royal Army Corps of Sahrani (Jungle)";

	infantry[] = {
		"CUP_I_RACS_M_Mech",
		"CUP_I_RACS_Soldier_AA_Mech",
		"CUP_I_RACS_Soldier_AAT_Mech",
		"CUP_I_RACS_Soldier_AMG_Mech",
		"CUP_I_RACS_Soldier_MAT_Mech",
		"CUP_I_RACS_AR_Mech",
		"CUP_I_RACS_Engineer_Mech",
		"CUP_I_RACS_GL_Mech",
		"CUP_I_RACS_Soldier_HAT_Mech",
		"CUP_I_RACS_MMG_Mech",
		"CUP_I_RACS_Medic_Mech",
		"CUP_I_RACS_Officer_Mech",
		"CUP_I_RACS_Soldier_Mech",
		"CUP_I_RACS_Soldier_Light_Mech",
		"CUP_I_RACS_Soldier_LAT_Mech",
		"CUP_I_RACS_Sniper_Mech",
		"CUP_I_RACS_SL_Mech"
	};
};
class CUP_RACS_URBAN_faction : CUP_RACS_base
{
	displayName = "CUP - Royal Army Corps of Sahrani (Urban)";

	infantry[] = {
		"CUP_I_RACS_SL_Urban",
		"CUP_I_RACS_Soldier_AA_Urban",
		"CUP_I_RACS_Soldier_AAT_Urban",
		"CUP_I_RACS_Soldier_AMG_Urban",
		"CUP_I_RACS_Soldier_MAT_Urban",
		"CUP_I_RACS_AR_Urban",
		"CUP_I_RACS_Engineer_Urban",
		"CUP_I_RACS_GL_Urban",
		"CUP_I_RACS_Soldier_HAT_Urban",
		"CUP_I_RACS_MMG_Urban",
		"CUP_I_RACS_M_Urban",
		"CUP_I_RACS_Medic_Urban",
		"CUP_I_RACS_Officer_Urban",
		"CUP_I_RACS_Soldier_Urban",
		"CUP_I_RACS_Soldier_Light_Urban",
		"CUP_I_RACS_Soldier_LAT_Urban",
		"CUP_I_RACS_Sniper_Urban"
	};
};
class CUP_RACS_WDL_faction : CUP_RACS_base
{
	displayName = "CUP - Royal Army Corps of Sahrani (Woodland)";

	infantry[] = {
		"CUP_I_RACS_SL_wdl",
		"CUP_I_RACS_Soldier_AA_wdl",
		"CUP_I_RACS_Soldier_AAT_wdl",
		"CUP_I_RACS_Soldier_AMG_wdl",
		"CUP_I_RACS_Soldier_MAT_wdl",
		"CUP_I_RACS_AR_wdl",
		"CUP_I_RACS_Engineer_wdl",
		"CUP_I_RACS_GL_wdl",
		"CUP_I_RACS_Soldier_HAT_wdl",
		"CUP_I_RACS_MMG_wdl",
		"CUP_I_RACS_M_wdl",
		"CUP_I_RACS_Medic_wdl",
		"CUP_I_RACS_Officer_wdl",
		"CUP_I_RACS_Soldier_wdl",
		"CUP_I_RACS_Soldier_Light_wdl",
		"CUP_I_RACS_Soldier_LAT_wdl",
		"CUP_I_RACS_Sniper_wdl",
		"CUP_I_RACS_RoyalCommando",
		"CUP_I_RACS_RoyalGuard",
		"CUP_I_RACS_RoyalMarksman"
	};
};

class CUP_TKL_faction : CUP_TKM_faction
{
	displayName = "CUP - Takistani Locals";

	infantry[] = {
		"CUP_I_TK_GUE_Commander",
		"CUP_I_TK_GUE_Soldier_AA",
		"CUP_I_TK_GUE_Soldier_AR",
		"CUP_I_TK_GUE_Guerilla_Medic",
		"CUP_I_TK_GUE_Demo",
		"CUP_I_TK_GUE_Soldier",
		"CUP_I_TK_GUE_Soldier_AK_47S",
		"CUP_I_TK_GUE_Soldier_HAT",
		"CUP_I_TK_GUE_Guerilla_Enfield",
		"CUP_I_TK_GUE_Soldier_GL",
		"CUP_I_TK_GUE_Soldier_M16A2",
		"CUP_I_TK_GUE_Soldier_AAT",
		"CUP_I_TK_GUE_Soldier_LAT",
		"CUP_I_TK_GUE_Soldier_AT",
		"CUP_I_TK_GUE_Sniper",
		"CUP_I_TK_GUE_Mechanic",
		"CUP_I_TK_GUE_Soldier_MG",
		"CUP_I_TK_GUE_Soldier_TL"
	};
};

class CUP_UN_DES_faction
{
	displayName = "CUP - United Nations (Desert)";

	lightCars[] = {
		"CUP_I_UAZ_AGS30_UN",
		"CUP_I_UAZ_MG_UN"
	};
	heavyCars[] = {
		"CUP_I_BRDM2_UN",
		"CUP_I_BRDM2_HQ_UN"
	};
	lightArmor[] = {
		"CUP_I_BMP2_UN",
		"CUP_I_BMP_HQ_UN",
		"CUP_I_BTR60_UN",
		"CUP_I_BTR80_UN",
		"CUP_I_BTR80A_UN",
		"CUP_I_M113_UN",
		"CUP_I_MTLB_pk_UN"
	};
	heavyArmor[] = {
		"CUP_B_Challenger2_Snow_BAF"
	};
	transportHelicopters[] = {
		"CUP_I_Mi17_UN"
	};
	cargoAircraft[] = {
		"CUP_B_C130J_USMC"
	};
	casAircraft[] = {
		"CUP_B_L39_CZ_GREY"
	};
	attackHelicopters[] = {
		"CUP_I_Mi24_Mk3_UN",
		"CUP_I_Mi24_Mk4_UN"
	};

	infantry[] = {
		"CUP_I_UN_CDF_Soldier_SL_DST",
		"CUP_I_UN_CDF_Soldier_AAT_DST",
		"CUP_I_UN_CDF_Soldier_AMG_DST",
		"CUP_I_UN_CDF_Guard_DST",
		"CUP_I_UN_CDF_Soldier_AR_DST",
		"CUP_I_UN_CDF_Soldier_GL_DST",
		"CUP_I_UN_CDF_Soldier_MG_DST",
		"CUP_I_UN_CDF_Officer_DST",
		"CUP_I_UN_CDF_Soldier_DST",
		"CUP_I_UN_CDF_Soldier_Backpack_DST",
		"CUP_I_UN_CDF_Soldier_Light_DST",
		"CUP_I_UN_CDF_Soldier_LAT_DST",
		"CUP_I_UN_CDF_Soldier_AT_DST"		
	};
};

class CUP_UN_FOREST_faction : CUP_UN_DES_faction
{
	displayName = "CUP - United Nations (Forest)";

	infantry[] = {
		"CUP_I_UN_CDF_Soldier_SL_FST",
		"CUP_I_UN_CDF_Soldier_AAT_FST",
		"CUP_I_UN_CDF_Soldier_AMG_FST",
		"CUP_I_UN_CDF_Guard_FST",
		"CUP_I_UN_CDF_Soldier_AR_FST",
		"CUP_I_UN_CDF_Soldier_GL_FST",
		"CUP_I_UN_CDF_Soldier_MG_FST",
		"CUP_I_UN_CDF_Officer_FST",
		"CUP_I_UN_CDF_Soldier_FST",
		"CUP_I_UN_CDF_Soldier_Backpack_FST",
		"CUP_I_UN_CDF_Soldier_Light_FST",
		"CUP_I_UN_CDF_Soldier_LAT_FST",
		"CUP_I_UN_CDF_Soldier_AT_FST"
	};
};

class CUP_UN_MNT_faction : CUP_UN_DES_faction
{
	displayName = "CUP - United Nations (Mountain)";

	infantry[] = {
		"CUP_I_UN_CDF_Soldier_SL_MNT",
		"CUP_I_UN_CDF_Soldier_AAT_MNT",
		"CUP_I_UN_CDF_Soldier_AMG_MNT",
		"CUP_I_UN_CDF_Guard_MNT",
		"CUP_I_UN_CDF_Soldier_AR_MNT",
		"CUP_I_UN_CDF_Soldier_GL_MNT",
		"CUP_I_UN_CDF_Soldier_MG_MNT",
		"CUP_I_UN_CDF_Officer_MNT",
		"CUP_I_UN_CDF_Soldier_MNT",
		"CUP_I_UN_CDF_Soldier_Backpack_MNT",
		"CUP_I_UN_CDF_Soldier_Light_MNT",
		"CUP_I_UN_CDF_Soldier_LAT_MNT",
		"CUP_I_UN_CDF_Soldier_AT_MNT"
	};
};