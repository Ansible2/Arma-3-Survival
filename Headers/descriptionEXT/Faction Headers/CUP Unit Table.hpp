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

class CUP_BAF_DES_faction : CUP_BAF_MTP_faction
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