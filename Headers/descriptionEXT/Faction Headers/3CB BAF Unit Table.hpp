class 3CBBAF_Woodland_Base : NATO_pacific_faction
{
	dependencies[] = { "@3CB BAF Equipment", "@3CB BAF Units", "@3CB BAF Vehicles", "@3CB BAF Weapons" };
	displayName = "";

	lightCars[] = {
		"UK3CB_BAF_Coyote_Logistics_L134A1_W_DPMW", 
		"UK3CB_BAF_Coyote_Logistics_L111A1_W_DPMW", 
		"UK3CB_BAF_Coyote_Passenger_L134A1_W_DPMW", 
		"UK3CB_BAF_Coyote_Passenger_L111A1_W_DPMW", 
		"UK3CB_BAF_Jackal2_GMG_W_DPMW", 
		"UK3CB_BAF_Jackal2_L2A1_W_DPMW", 
		"UK3CB_BAF_LandRover_WMIK_GMG_FFR_Green_B_DPMW", 
		"UK3CB_BAF_LandRover_WMIK_GPMG_FFR_Green_B_DPMW", 
		"UK3CB_BAF_LandRover_WMIK_HMG_FFR_Green_B_DPMW", 
		"UK3CB_BAF_LandRover_WMIK_Milan_FFR_Green_B_DPMW"
	};
	heavyCars[] = {
		"UK3CB_BAF_Husky_Logistics_GMG_Green_DPMW", 
		"UK3CB_BAF_Husky_Logistics_GPMG_Green_DPMW", 
		"UK3CB_BAF_Husky_Logistics_HMG_Green_DPMW", 
		"UK3CB_BAF_Husky_Passenger_GMG_Green_DPMW", 
		"UK3CB_BAF_Husky_Passenger_GPMG_Green_DPMW", 
		"UK3CB_BAF_Husky_Passenger_HMG_Green_DPMW", 
		"UK3CB_BAF_Panther_GPMG_Green_A_DPMW"
	};
	lightArmor[] = {
		"UK3CB_BAF_FV432_Mk3_GPMG_Green_DPMW", 
		"UK3CB_BAF_FV432_Mk3_RWS_Green_DPMW", 
		"UK3CB_BAF_Warrior_A3_W_Camo_MTP", 
		"UK3CB_BAF_Warrior_A3_W_Cage_Camo_MTP", 
		"UK3CB_BAF_Warrior_A3_W_Cage_MTP", 
		"UK3CB_BAF_Warrior_A3_W_MTP"
	};
	transportHelicopters[] = {
		"UK3CB_BAF_Merlin_HC3_18_GPMG_Arctic"
	};
	attackHelicopters[] = {
		"UK3CB_BAF_Apache_AH1_DPMW", 
		"UK3CB_BAF_Apache_AH1_AT_DPMW"
	};
};

class 3CBBAF_Desert_Base : NATO_faction
{
	dependencies[] = { "@3CB BAF Equipment", "@3CB BAF Units", "@3CB BAF Vehicles", "@3CB BAF Weapons" };
	displayName = "";

	lightCars[] = {
		"UK3CB_BAF_Coyote_Logistics_L134A1_D_DDPM", 
		"UK3CB_BAF_Coyote_Logistics_L111A1_D_DDPM", 
		"UK3CB_BAF_Coyote_Passenger_L134A1_D_DDPM", 
		"UK3CB_BAF_Coyote_Passenger_L111A1_D_DDPM", 
		"UK3CB_BAF_Jackal2_GMG_D_DDPM", 
		"UK3CB_BAF_Jackal2_L2A1_D_DDPM", 
		"UK3CB_BAF_LandRover_WMIK_GMG_FFR_Sand_A_DDPM", 
		"UK3CB_BAF_LandRover_WMIK_GPMG_FFR_Sand_A_DDPM", 
		"UK3CB_BAF_LandRover_WMIK_HMG_FFR_Sand_A_DDPM", 
		"UK3CB_BAF_LandRover_WMIK_Milan_FFR_Sand_A_DDPM"
	};
	heavyCars[] = {
		"UK3CB_BAF_Husky_Logistics_GMG_Sand_DDPM", 
		"UK3CB_BAF_Husky_Logistics_GPMG_Sand_DDPM", 
		"UK3CB_BAF_Husky_Logistics_HMG_Sand_DDPM", 
		"UK3CB_BAF_Husky_Passenger_GMG_Sand_DDPM", 
		"UK3CB_BAF_Husky_Passenger_GPMG_Sand_DDPM", 
		"UK3CB_BAF_Husky_Passenger_HMG_Sand_DDPM", 
		"UK3CB_BAF_Panther_GPMG_Sand_A_DDPM"
	};
	lightArmor[] = {
		"UK3CB_BAF_FV432_Mk3_GPMG_Sand_DDPM", 
		"UK3CB_BAF_FV432_Mk3_RWS_Sand_DDPM", 
		"UK3CB_BAF_Warrior_A3_D_Camo_MTP", 
		"UK3CB_BAF_Warrior_A3_D_Cage_Camo_MTP", 
		"UK3CB_BAF_Warrior_A3_D_Cage_MTP", 
		"UK3CB_BAF_Warrior_A3_D_MTP"
	};
	transportHelicopters[] = {
		"UK3CB_BAF_Merlin_HC3_18_GPMG_Arctic"
	};
	attackHelicopters[] = {
		"UK3CB_BAF_Apache_AH1_DPMW", 
		"UK3CB_BAF_Apache_AH1_AT_DPMW"
	};
};

class 3CBBAF_army_desert_faction : 3CBBAF_Desert_Base
{
	dependencies[] = { "@3CB BAF Equipment", "@3CB BAF Units", "@3CB BAF Vehicles", "@3CB BAF Weapons" };
	displayName = "3CB-BAF - Army Desert";
	infantry[] = {
		"UK3CB_BAF_MATC_DDPM", 
		"UK3CB_BAF_Rifleman_762_DDPM", 
		"UK3CB_BAF_Medic_DDPM", 
		"UK3CB_BAF_Engineer_DDPM", 
		"UK3CB_BAF_Explosive_DDPM", 
		"UK3CB_BAF_FAC_DDPM", 
		"UK3CB_BAF_FT_DDPM", 
		"UK3CB_BAF_FT_762_DDPM", 
		"UK3CB_BAF_Grenadier_DDPM", 
		"UK3CB_BAF_Grenadier_762_DDPM", 
		"UK3CB_BAF_GunnerM6_DDPM", 
		"UK3CB_BAF_GunnerStatic_DDPM", 
		"UK3CB_BAF_HeliMedic_DDPM", 
		"UK3CB_BAF_HeliCrew_DDPM", 
		"UK3CB_BAF_LSW_DDPM", 
		"UK3CB_BAF_Marksman_DDPM", 
		"UK3CB_BAF_MGGPMG_DDPM", 
		"UK3CB_BAF_MGLMG_DDPM", 
		"UK3CB_BAF_MFC_DDPM", 
		"UK3CB_BAF_Officer_DDPM", 
		"UK3CB_BAF_Pointman_DDPM", 
		"UK3CB_BAF_RO_DDPM", 
		"UK3CB_BAF_Repair_DDPM", 
		"UK3CB_BAF_Rifleman_DDPM", 
		"UK3CB_BAF_LAT_ILAW_DDPM", 
		"UK3CB_BAF_LAT_ILAW_762_DDPM", 
		"UK3CB_BAF_MAT_DDPM", 
		"UK3CB_BAF_LAT_DDPM", 
		"UK3CB_BAF_LAT_762_DDPM", 
		"UK3CB_BAF_SC_DDPM", 
		"UK3CB_BAF_Sharpshooter_DDPM", 
		"UK3CB_BAF_Medic_DDPM_REC", 
		"UK3CB_BAF_Explosive_DDPM_REC", 
		"UK3CB_BAF_FAC_DDPM_REC", 
		"UK3CB_BAF_Marksman_DDPM_REC", 
		"UK3CB_BAF_MGLMG_DDPM_REC", 
		"UK3CB_BAF_Pointman_DDPM_REC", 
		"UK3CB_BAF_SC_DDPM_REC", 
		"UK3CB_BAF_Sniper_DDPM_Ghillie_L115", 
		"UK3CB_BAF_Sniper_DDPM_Ghillie_L135", 
		"UK3CB_BAF_Spotter_DDPM_Ghillie_L129", 
		"UK3CB_BAF_Spotter_DDPM_Ghillie_L85"
	};
};
class 3CBBAF_army_artic_faction : 3CBBAF_Desert_Base
{
	dependencies[] = { "@3CB BAF Equipment", "@3CB BAF Units", "@3CB BAF Vehicles", "@3CB BAF Weapons" };
	displayName = "3CB-BAF - Army Artic";
	infantry[] = {
		"UK3CB_BAF_MATC_Arctic", 
		"UK3CB_BAF_Rifleman_762_Arctic", 
		"UK3CB_BAF_Medic_Arctic", 
		"UK3CB_BAF_Engineer_Arctic", 
		"UK3CB_BAF_Explosive_Arctic", 
		"UK3CB_BAF_FAC_Arctic", 
		"UK3CB_BAF_FT_Arctic", 
		"UK3CB_BAF_FT_762_Arctic", 
		"UK3CB_BAF_Grenadier_Arctic", 
		"UK3CB_BAF_Grenadier_762_Arctic", 
		"UK3CB_BAF_GunnerM6_Arctic", 
		"UK3CB_BAF_GunnerStatic_Arctic", 
		"UK3CB_BAF_HeliMedic_Arctic", 
		"UK3CB_BAF_LSW_Arctic", 
		"UK3CB_BAF_Marksman_Arctic", 
		"UK3CB_BAF_MGGPMG_Arctic", 
		"UK3CB_BAF_MGLMG_Arctic", 
		"UK3CB_BAF_MFC_Arctic", 
		"UK3CB_BAF_Officer_Arctic", 
		"UK3CB_BAF_Pointman_Arctic", 
		"UK3CB_BAF_RO_Arctic", 
		"UK3CB_BAF_Repair_Arctic", 
		"UK3CB_BAF_Rifleman_Arctic", 
		"UK3CB_BAF_LAT_ILAW_Arctic", 
		"UK3CB_BAF_LAT_ILAW_762_Arctic", 
		"UK3CB_BAF_MAT_Arctic", 
		"UK3CB_BAF_LAT_Arctic", 
		"UK3CB_BAF_LAT_762_Arctic", 
		"UK3CB_BAF_SC_Arctic", 
		"UK3CB_BAF_Sharpshooter_Arctic", 
		"UK3CB_BAF_Medic_Arctic_REC", 
		"UK3CB_BAF_Explosive_Arctic_REC", 
		"UK3CB_BAF_FAC_Arctic_REC", 
		"UK3CB_BAF_Marksman_Arctic_REC", 
		"UK3CB_BAF_MGLMG_Arctic_REC", 
		"UK3CB_BAF_Pointman_Arctic_REC", 
		"UK3CB_BAF_SC_Arctic_REC", 
		"UK3CB_BAF_Sniper_Arctic_Ghillie_L115", 
		"UK3CB_BAF_Sniper_Arctic_Ghillie_L135", 
		"UK3CB_BAF_Spotter_Arctic_Ghillie_L129", 
		"UK3CB_BAF_Spotter_Arctic_Ghillie_L85"
	};
};
class 3CBBAF_army_mtp_faction : 3CBBAF_Desert_Base
{
	dependencies[] = { "@3CB BAF Equipment", "@3CB BAF Units", "@3CB BAF Vehicles", "@3CB BAF Weapons" };
	displayName = "3CB-BAF - Army Multicam (MTP)";
	infantry[] = {
		"UK3CB_BAF_MATC_MTP", 
		"UK3CB_BAF_MATC_MTP_H", 
		"UK3CB_BAF_Rifleman_762_MTP", 
		"UK3CB_BAF_Rifleman_762_MTP_H", 
		"UK3CB_BAF_Medic_MTP", 
		"UK3CB_BAF_Medic_MTP_H", 
		"UK3CB_BAF_Crewman_MTP", 
		"UK3CB_BAF_Engineer_MTP", 
		"UK3CB_BAF_Engineer_MTP_H", 
		"UK3CB_BAF_Explosive_MTP", 
		"UK3CB_BAF_Explosive_MTP_H", 
		"UK3CB_BAF_FAC_MTP", 
		"UK3CB_BAF_FAC_MTP_H", 
		"UK3CB_BAF_FT_MTP", 
		"UK3CB_BAF_FT_MTP_H", 
		"UK3CB_BAF_FT_762_MTP", 
		"UK3CB_BAF_FT_762_MTP_H", 
		"UK3CB_BAF_Grenadier_MTP", 
		"UK3CB_BAF_Grenadier_MTP_H", 
		"UK3CB_BAF_Grenadier_762_MTP", 
		"UK3CB_BAF_Grenadier_762_MTP_H", 
		"UK3CB_BAF_GunnerM6_MTP", 
		"UK3CB_BAF_GunnerM6_MTP_H", 
		"UK3CB_BAF_GunnerStatic_MTP", 
		"UK3CB_BAF_GunnerStatic_MTP_H", 
		"UK3CB_BAF_HeliCrew_MTP", 
		"UK3CB_BAF_HeliMedic_MTP", 
		"UK3CB_BAF_LSW_MTP", 
		"UK3CB_BAF_LSW_MTP_H", 
		"UK3CB_BAF_Marksman_MTP", 
		"UK3CB_BAF_Marksman_MTP_H", 
		"UK3CB_BAF_MGGPMG_MTP", 
		"UK3CB_BAF_MGGPMG_MTP_H", 
		"UK3CB_BAF_MGLMG_MTP", 
		"UK3CB_BAF_MGLMG_MTP_H", 
		"UK3CB_BAF_MFC_MTP", 
		"UK3CB_BAF_MFC_MTP_H", 
		"UK3CB_BAF_Officer_MTP", 
		"UK3CB_BAF_Officer_MTP_H", 
		"UK3CB_BAF_Pointman_MTP", 
		"UK3CB_BAF_Pointman_MTP_H", 
		"UK3CB_BAF_RO_MTP", 
		"UK3CB_BAF_RO_MTP_H", 
		"UK3CB_BAF_Repair_MTP", 
		"UK3CB_BAF_Repair_MTP_H", 
		"UK3CB_BAF_Rifleman_MTP", 
		"UK3CB_BAF_Rifleman_MTP_H", 
		"UK3CB_BAF_LAT_ILAW_MTP", 
		"UK3CB_BAF_LAT_ILAW_MTP_H", 
		"UK3CB_BAF_LAT_ILAW_762_MTP", 
		"UK3CB_BAF_LAT_ILAW_762_MTP_H", 
		"UK3CB_BAF_MAT_MTP", 
		"UK3CB_BAF_MAT_MTP_H", 
		"UK3CB_BAF_LAT_MTP", 
		"UK3CB_BAF_LAT_MTP_H", 
		"UK3CB_BAF_LAT_762_MTP", 
		"UK3CB_BAF_LAT_762_MTP_H", 
		"UK3CB_BAF_SC_MTP", 
		"UK3CB_BAF_SC_MTP_H", 
		"UK3CB_BAF_Sharpshooter_MTP", 
		"UK3CB_BAF_Sharpshooter_MTP_H", 
		"UK3CB_BAF_Medic_MTP_REC", 
		"UK3CB_BAF_Medic_MTP_REC_H", 
		"UK3CB_BAF_Explosive_MTP_REC", 
		"UK3CB_BAF_Explosive_MTP_REC_H", 
		"UK3CB_BAF_FAC_MTP_REC", 
		"UK3CB_BAF_FAC_MTP_REC_H", 
		"UK3CB_BAF_Marksman_MTP_REC", 
		"UK3CB_BAF_Marksman_MTP_REC_H", 
		"UK3CB_BAF_MGLMG_MTP_REC", 
		"UK3CB_BAF_MGLMG_MTP_REC_H", 
		"UK3CB_BAF_Pointman_MTP_REC", 
		"UK3CB_BAF_Pointman_MTP_REC_H", 
		"UK3CB_BAF_SC_MTP_REC", 
		"UK3CB_BAF_SC_MTP_REC_H", 
		"UK3CB_BAF_Sniper_MTP_Ghillie_L115", 
		"UK3CB_BAF_Sniper_MTP_Ghillie_L135", 
		"UK3CB_BAF_Spotter_MTP_Ghillie_L129", 
		"UK3CB_BAF_Spotter_MTP_Ghillie_L85"
	};
};
class 3CBBAF_army_temperate_faction : 3CBBAF_Woodland_Base
{
	dependencies[] = { "@3CB BAF Equipment", "@3CB BAF Units", "@3CB BAF Vehicles", "@3CB BAF Weapons" };
	displayName = "3CB-BAF - Army Temperate";
	infantry[] = {
		"UK3CB_BAF_MATC_DPMT", 
		"UK3CB_BAF_Rifleman_762_DPMT", 
		"UK3CB_BAF_Medic_DPMT", 
		"UK3CB_BAF_Crewman_DPMT", 
		"UK3CB_BAF_Engineer_DPMT", 
		"UK3CB_BAF_Explosive_DPMT", 
		"UK3CB_BAF_FAC_DPMT", 
		"UK3CB_BAF_FT_DPMT", 
		"UK3CB_BAF_FT_762_DPMT", 
		"UK3CB_BAF_Grenadier_DPMT", 
		"UK3CB_BAF_Grenadier_762_DPMT", 
		"UK3CB_BAF_GunnerM6_DPMT", 
		"UK3CB_BAF_GunnerStatic_DPMT", 
		"UK3CB_BAF_HeliCrew_DPMT", 
		"UK3CB_BAF_HeliMedic_DPMT", 
		"UK3CB_BAF_LSW_DPMT", 
		"UK3CB_BAF_Marksman_DPMT", 
		"UK3CB_BAF_MGGPMG_DPMT", 
		"UK3CB_BAF_MGLMG_DPMT", 
		"UK3CB_BAF_MFC_DPMT", 
		"UK3CB_BAF_Officer_DPMT", 
		"UK3CB_BAF_Pointman_DPMT", 
		"UK3CB_BAF_RO_DPMT", 
		"UK3CB_BAF_Repair_DPMT", 
		"UK3CB_BAF_Rifleman_DPMT", 
		"UK3CB_BAF_LAT_ILAW_DPMT", 
		"UK3CB_BAF_LAT_ILAW_762_DPMT", 
		"UK3CB_BAF_MAT_DPMT", 
		"UK3CB_BAF_LAT_DPMT", 
		"UK3CB_BAF_LAT_762_DPMT", 
		"UK3CB_BAF_SC_DPMT", 
		"UK3CB_BAF_Sharpshooter_DPMT", 
		"UK3CB_BAF_Medic_DPMT_REC", 
		"UK3CB_BAF_Explosive_DPMT_REC", 
		"UK3CB_BAF_FAC_DPMT_REC", 
		"UK3CB_BAF_Marksman_DPMT_REC", 
		"UK3CB_BAF_MGLMG_DPMT_REC", 
		"UK3CB_BAF_Pointman_DPMT_REC", 
		"UK3CB_BAF_SC_DPMT_REC", 
		"UK3CB_BAF_Sniper_DPMT_Ghillie_L115", 
		"UK3CB_BAF_Sniper_DPMT_Ghillie_L135", 
		"UK3CB_BAF_Spotter_DPMT_Ghillie_L129", 
		"UK3CB_BAF_Spotter_DPMT_Ghillie_L85"
	};
};
class 3CBBAF_army_tropical_faction : 3CBBAF_Woodland_Base
{
	dependencies[] = { "@3CB BAF Equipment", "@3CB BAF Units", "@3CB BAF Vehicles", "@3CB BAF Weapons" };
	displayName = "3CB-BAF - Army Tropical";
	infantry[] = {
		"UK3CB_BAF_MATC_Tropical", 
		"UK3CB_BAF_Rifleman_762_Tropical", 
		"UK3CB_BAF_Medic_Tropical", 
		"UK3CB_BAF_Crewman_Tropical", 
		"UK3CB_BAF_Engineer_Tropical", 
		"UK3CB_BAF_Explosive_Tropical", 
		"UK3CB_BAF_FAC_Tropical", 
		"UK3CB_BAF_FT_Tropical", 
		"UK3CB_BAF_FT_762_Tropical", 
		"UK3CB_BAF_Grenadier_Tropical", 
		"UK3CB_BAF_Grenadier_762_Tropical", 
		"UK3CB_BAF_GunnerM6_Tropical", 
		"UK3CB_BAF_GunnerStatic_Tropical", 
		"UK3CB_BAF_HeliCrew_Tropical", 
		"UK3CB_BAF_HeliMedic_Tropical", 
		"UK3CB_BAF_LSW_Tropical", 
		"UK3CB_BAF_Marksman_Tropical", 
		"UK3CB_BAF_MGGPMG_Tropical", 
		"UK3CB_BAF_MGLMG_Tropical", 
		"UK3CB_BAF_MFC_Tropical", 
		"UK3CB_BAF_Officer_Tropical", 
		"UK3CB_BAF_Pointman_Tropical", 
		"UK3CB_BAF_RO_Tropical", 
		"UK3CB_BAF_Repair_Tropical", 
		"UK3CB_BAF_Rifleman_Tropical", 
		"UK3CB_BAF_LAT_ILAW_Tropical", 
		"UK3CB_BAF_LAT_ILAW_762_Tropical", 
		"UK3CB_BAF_MAT_Tropical", 
		"UK3CB_BAF_LAT_Tropical", 
		"UK3CB_BAF_LAT_762_Tropical", 
		"UK3CB_BAF_SC_Tropical", 
		"UK3CB_BAF_Sharpshooter_Tropical", 
		"UK3CB_BAF_Medic_Tropical_REC", 
		"UK3CB_BAF_Explosive_Tropical_REC", 
		"UK3CB_BAF_FAC_Tropical_REC", 
		"UK3CB_BAF_Marksman_Tropical_REC", 
		"UK3CB_BAF_MGLMG_Tropical_REC", 
		"UK3CB_BAF_Pointman_Tropical_REC", 
		"UK3CB_BAF_SC_Tropical_REC", 
		"UK3CB_BAF_Sniper_Tropical_Ghillie_L115", 
		"UK3CB_BAF_Sniper_Tropical_Ghillie_L135", 
		"UK3CB_BAF_Spotter_Tropical_Ghillie_L129", 
		"UK3CB_BAF_Spotter_Tropical_Ghillie_L85"
	};
};
class 3CBBAF_army_woodland_faction : 3CBBAF_Woodland_Base
{
	dependencies[] = { "@3CB BAF Equipment", "@3CB BAF Units", "@3CB BAF Vehicles", "@3CB BAF Weapons" };
	displayName = "3CB-BAF - Army Woodland";
	infantry[] = {
		"UK3CB_BAF_MATC_DPMW", 
		"UK3CB_BAF_Rifleman_762_DPMW", 
		"UK3CB_BAF_Medic_DPMW", 
		"UK3CB_BAF_Crewman_DPMW", 
		"UK3CB_BAF_Engineer_DPMW", 
		"UK3CB_BAF_Explosive_DPMW", 
		"UK3CB_BAF_FAC_DPMW", 
		"UK3CB_BAF_FT_DPMW", 
		"UK3CB_BAF_FT_762_DPMW", 
		"UK3CB_BAF_Grenadier_DPMW", 
		"UK3CB_BAF_Grenadier_762_DPMW", 
		"UK3CB_BAF_GunnerM6_DPMW", 
		"UK3CB_BAF_GunnerStatic_DPMW", 
		"UK3CB_BAF_HeliCrew_DPMW", 
		"UK3CB_BAF_HeliMedic_DPMW", 
		"UK3CB_BAF_LSW_DPMW", 
		"UK3CB_BAF_Marksman_DPMW", 
		"UK3CB_BAF_MGGPMG_DPMW", 
		"UK3CB_BAF_MGLMG_DPMW", 
		"UK3CB_BAF_MFC_DPMW", 
		"UK3CB_BAF_Officer_DPMW", 
		"UK3CB_BAF_Pointman_DPMW", 
		"UK3CB_BAF_RO_DPMW", 
		"UK3CB_BAF_Repair_DPMW", 
		"UK3CB_BAF_Rifleman_DPMW", 
		"UK3CB_BAF_LAT_ILAW_DPMW", 
		"UK3CB_BAF_LAT_ILAW_762_DPMW", 
		"UK3CB_BAF_MAT_DPMW", 
		"UK3CB_BAF_LAT_DPMW", 
		"UK3CB_BAF_LAT_762_DPMW", 
		"UK3CB_BAF_SC_DPMW", 
		"UK3CB_BAF_Sharpshooter_DPMW", 
		"UK3CB_BAF_Medic_DPMW_REC", 
		"UK3CB_BAF_Explosive_DPMW_REC", 
		"UK3CB_BAF_FAC_DPMW_REC", 
		"UK3CB_BAF_Marksman_DPMW_REC", 
		"UK3CB_BAF_MGLMG_DPMW_REC", 
		"UK3CB_BAF_Pointman_DPMW_REC", 
		"UK3CB_BAF_SC_DPMW_REC", 
		"UK3CB_BAF_Sniper_DPMW_Ghillie_L115", 
		"UK3CB_BAF_Sniper_DPMW_Ghillie_L135", 
		"UK3CB_BAF_Spotter_DPMW_Ghillie_L129", 
		"UK3CB_BAF_Spotter_DPMW_Ghillie_L85"
	};
};