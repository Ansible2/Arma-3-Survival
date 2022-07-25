class SOGPF_usArmy
{
    dependencies[] = { "VN" };
    displayName = "S.O.G. PF - US Army";

    lightCars[] = {
        "vn_b_wheeled_m151_mg_02",
        "vn_b_wheeled_m151_mg_03"
    };
    heavyCars[] = {
        "vn_b_wheeled_m151_mg_04"
    };

    lightArmor[] = {
        "vn_b_wheeled_m54_mg_01",
        "vn_b_wheeled_m54_mg_03"
    };
    heavyArmor[] = {
        "vn_b_armor_m41_01_01"
    };

    transportHelicopters[] = {
        "vn_b_air_uh1c_03_01",
        "vn_b_air_uh1c_02_03",
        "vn_b_air_uh1c_07_02",
        "vn_b_air_uh1c_02_02",
        "vn_b_air_uh1c_01_01",
        "vn_b_air_uh1d_02_02"
    };
    cargoAircraft[] = {
        "vn_b_air_uh1d_01_02",
        "vn_b_air_uh1d_01_01",
        "vn_b_air_uh1d_01_03"
    };

    casAircraft[] = {
        "vn_b_air_f4c_cas",
        "vn_b_air_f100d_cas"
    };
    attackHelicopters[] = {
        "vn_b_air_ah1g_04",
        "vn_b_air_ah1g_09"
    };
    infantry[] = {
        "vn_b_men_army_02",
        "vn_b_men_army_12",
        "vn_b_men_army_05",
        "vn_b_men_army_04",
        "vn_b_men_army_07",
        "vn_b_men_army_17",
        "vn_b_men_army_31",
        "vn_b_men_army_30",
        "vn_b_men_army_06",
        "vn_b_men_army_27",
        "vn_b_men_army_10",
        "vn_b_men_army_03",
        "vn_b_men_army_22",
        "vn_b_men_army_01",
        "vn_b_men_army_15",
        "vn_b_men_army_16",
        "vn_b_men_army_18",
        "vn_b_men_army_19",
        "vn_b_men_army_20",
        "vn_b_men_army_21",
        "vn_b_men_army_08",
        "vn_b_men_army_09",
        "vn_b_men_army_11"
    };
};

class SOGPF_usmc : SOGPF_usArmy
{
    dependencies[] = { "VN" };
    displayName = "S.O.G. PF - USMC";

    heavyArmor[] = {
        "vn_b_armor_m41_01_02"
    };
    transportHelicopters[] = {
        "vn_b_air_uh1c_07_04",
        "vn_b_air_uh1c_02_04",
        "vn_b_air_uh1c_01_04",
        "vn_b_air_uh1d_02_04",
        "vn_b_air_ch34_03_01",
        "vn_b_air_uh1c_01_05",
        "vn_b_air_uh1d_02_05",
        "vn_b_air_uh1c_07_05"
    };
    cargoAircraft[] = {
        "vn_b_air_uh1d_01_05",
        "vn_b_air_uh1d_01_04"
    };
    casAircraft[] = {
        "vn_b_air_f4b_navy_cas",
        "vn_b_air_f4b_usmc_cas"
    };
    attackHelicopters[] = {
        "vn_b_air_ah1g_04_usmc",
        "vn_b_air_ah1g_09_usmc"
    };
};

class SOGPF_SEAL_det_bravo : SOGPF_usmc
{
    dependencies[] = { "VN" };
    displayName = "S.O.G. PF - SEALs Detachment Bravo";

    infantry[] = {
        "vn_b_men_seal_38",
        "vn_b_men_seal_22",
        "vn_b_men_seal_41",
        "vn_b_men_seal_19",
        "vn_b_men_seal_40",
        "vn_b_men_seal_21",
        "vn_b_men_seal_37",
        "vn_b_men_seal_20",
        "vn_b_men_seal_39",
        "vn_b_men_seal_18"
    };
};

class SOGPF_SEAL_team : SOGPF_usmc
{
    dependencies[] = { "VN" };
    displayName = "S.O.G. PF - SEAL Team";

    infantry[] = {
        "vn_b_men_seal_10",
        "vn_b_men_seal_11",
        "vn_b_men_seal_14",
        "vn_b_men_seal_15",
        "vn_b_men_seal_07",
        "vn_b_men_seal_03",
        "vn_b_men_seal_09",
        "vn_b_men_seal_08",
        "vn_b_men_seal_12",
        "vn_b_men_seal_05",
        "vn_b_men_seal_16",
        "vn_b_men_seal_17",
        "vn_b_men_seal_13",
        "vn_b_men_seal_02",
        "vn_b_men_seal_06",
        "vn_b_men_seal_04",
        "vn_b_men_seal_01"
    };
};

class SOGPF_mikeForce : SOGPF_usArmy
{
    dependencies[] = { "VN" };
    displayName = "S.O.G. PF - Mike Force";

    infantry[] = {
        "vn_b_men_sf_19",
        "vn_b_men_sf_22",
        "vn_b_men_sf_03",
        "vn_b_men_sf_08",
        "vn_b_men_sf_07",
        "vn_b_men_sf_11",
        "vn_b_men_sf_17",
        "vn_b_men_sf_05",
        "vn_b_men_sf_15",
        "vn_b_men_sf_16",
        "vn_b_men_sf_18",
        "vn_b_men_sf_12",
        "vn_b_men_sf_13",
        "vn_b_men_sf_21",
        "vn_b_men_sf_02",
        "vn_b_men_sf_10",
        "vn_b_men_sf_20",
        "vn_b_men_sf_06",
        "vn_b_men_sf_14",
        "vn_b_men_sf_04",
        "vn_b_men_sf_09",
        "vn_b_men_sf_01"
    };
};

class SOGPF_usNavy : SOGPF_usmc
{
    dependencies[] = { "VN" };
    displayName = "S.O.G. PF - US Navy";

    infantry[] = {
        "vn_b_men_navy_02",
        "vn_b_men_navy_01",
        "vn_b_men_navy_03",
        "vn_b_men_navy_05",
        "vn_b_men_navy_06",
        "vn_b_men_navy_09",
        "vn_b_men_navy_07",
        "vn_b_men_navy_08",
        "vn_b_men_navy_04"
    };
};

class SOGPF_macvSOG : SOGPF_usArmy
{
    dependencies[] = { "VN" };
    displayName = "S.O.G. PF - MACV-SOG";

    transportHelicopters[] = {
        "vn_b_air_uh1c_07_07",
        "vn_b_air_uh1c_02_07",
        "vn_b_air_uh1c_01_07",
        "vn_b_air_uh1d_02_07"
    };
    cargoAircraft[] = {
        "vn_b_air_uh1d_01_07"
    };
    infantry[] = {
        "vn_b_men_sog_25",
        "vn_b_men_sog_22",
        "vn_b_men_sog_08",
        "vn_b_men_sog_23",
        "vn_b_men_sog_07",
        "vn_b_men_sog_11",
        "vn_b_men_sog_06",
        "vn_b_men_sog_16",
        "vn_b_men_sog_18",
        "vn_b_men_sog_12",
        "vn_b_men_sog_21",
        "vn_b_men_sog_10",
        "vn_b_men_sog_20",
        "vn_b_men_sog_02",
        "vn_b_men_sog_14",
        "vn_b_men_sog_03",
        "vn_b_men_sog_15",
        "vn_b_men_sog_01",
        "vn_b_men_sog_13",
        "vn_b_men_sog_26",
        "vn_b_men_sog_05",
        "vn_b_men_sog_17",
        "vn_b_men_sog_27",
        "vn_b_men_sog_09",
        "vn_b_men_sog_19",
        "vn_b_men_sog_04",
        "vn_b_men_sog_24"
    };
};

class SOGPF_lrrp : SOGPF_usArmy
{
    dependencies[] = { "VN" };
    displayName = "S.O.G. PF - Long Range Reconnaissance Patrol";

    infantry[] = {
        "vn_b_men_lrrp_01",
        "vn_b_men_lrrp_03",
        "vn_b_men_lrrp_08",
        "vn_b_men_lrrp_09",
        "vn_b_men_lrrp_05",
        "vn_b_men_lrrp_02",
        "vn_b_men_lrrp_06",
        "vn_b_men_lrrp_07",
        "vn_b_men_lrrp_04"
    };
};

class SOGPF_campStrikeForce : SOGPF_usArmy
{
    dependencies[] = { "VN" };
    displayName = "S.O.G. PF - Camp Strike Force";

    infantry[] = {
        "vn_b_men_cidg_01",
        "vn_b_men_cidg_22",
        "vn_b_men_cidg_03",
        "vn_b_men_cidg_08",
        "vn_b_men_cidg_07",
        "vn_b_men_cidg_11",
        "vn_b_men_cidg_17",
        "vn_b_men_cidg_05",
        "vn_b_men_cidg_15",
        "vn_b_men_cidg_16",
        "vn_b_men_cidg_18",
        "vn_b_men_cidg_12",
        "vn_b_men_cidg_02",
        "vn_b_men_cidg_10",
        "vn_b_men_cidg_20",
        "vn_b_men_cidg_06",
        "vn_b_men_cidg_14",
        "vn_b_men_cidg_19",
        "vn_b_men_cidg_04",
        "vn_b_men_cidg_09",
        "vn_b_men_cidg_21",
        "vn_b_men_cidg_13"
    };
};



class SOGPF_NVA_dacCong
{
    dependencies[] = { "VN" };
    displayName = "S.O.G. PF - NVA Dac Cong";

    lightCars[] = {
        "vn_o_wheeled_z157_mg_01_nva65"
    };
    heavyCars[] = {
        "vn_o_wheeled_btr40_mg_01_nva65",
        "vn_o_wheeled_btr40_mg_02"
    };
    lightArmor[] = {
        "vn_o_armor_type63_01_nva65"
    };
    heavyArmor[] = {
        "vn_o_armor_m41_01"
    };
    transportHelicopters[] = {
        "vn_o_air_mi2_01_01",
        "vn_o_air_mi2_01_02"
    };
    cargoAircraft[] = {
        "vn_o_air_mi2_01_01",
        "vn_o_air_mi2_01_02"
    };
    casAircraft[] = {
        "vn_o_air_mig19_cas"
    };
    attackHelicopters[] = {
        "vn_b_air_ah1g_05_usmc"
    };

    infantry[] = {
        "vn_o_men_nva_dc_14",
        "vn_o_men_nva_dc_07",
        "vn_o_men_nva_dc_11",
        "vn_o_men_nva_dc_10",
        "vn_o_men_nva_dc_08",
        "vn_o_men_nva_dc_16",
        "vn_o_men_nva_dc_15",
        "vn_o_men_nva_dc_17",
        "vn_o_men_nva_dc_01",
        "vn_o_men_nva_dc_06",
        "vn_o_men_nva_dc_03",
        "vn_o_men_nva_dc_04",
        "vn_o_men_nva_dc_02",
        "vn_o_men_nva_dc_05",
        "vn_o_men_nva_dc_13",
        "vn_o_men_nva_dc_09",
        "vn_o_men_nva_dc_12"
    };
};

class SOGPF_NVA_inf_65_field : SOGPF_NVA_dacCong
{
    dependencies[] = { "VN" };
    displayName = "S.O.G. PF - NVA 65 (Field)";

    infantry[] = {
        "vn_o_men_nva_65_28",
        "vn_o_men_nva_65_21",
        "vn_o_men_nva_65_25",
        "vn_o_men_nva_65_24",
        "vn_o_men_nva_65_22",
        "vn_o_men_nva_65_33",
        "vn_o_men_nva_65_32",
        "vn_o_men_nva_65_34",
        "vn_o_men_nva_65_15",
        "vn_o_men_nva_65_20",
        "vn_o_men_nva_65_17",
        "vn_o_men_nva_65_16",
        "vn_o_men_nva_65_19",
        "vn_o_men_nva_65_18",
        "vn_o_men_nva_65_27",
        "vn_o_men_nva_65_23"
    };
};

class SOGPF_NVA_inf_65 : SOGPF_NVA_dacCong
{
    dependencies[] = { "VN" };
    displayName = "S.O.G. PF - NVA 65";

    infantry[] = {
        "vn_o_men_nva_65_14",
        "vn_o_men_nva_65_07",
        "vn_o_men_nva_65_11",
        "vn_o_men_nva_65_10",
        "vn_o_men_nva_65_08",
        "vn_o_men_nva_65_30",
        "vn_o_men_nva_65_29",
        "vn_o_men_nva_65_31",
        "vn_o_men_nva_65_01",
        "vn_o_men_nva_65_06",
        "vn_o_men_nva_65_03",
        "vn_o_men_nva_65_02",
        "vn_o_men_nva_65_05",
        "vn_o_men_nva_65_04",
        "vn_o_men_nva_65_13",
        "vn_o_men_nva_65_09",
        "vn_o_men_nva_65_12"
    };
};

class SOGPF_NVA_field : SOGPF_NVA_dacCong
{
    dependencies[] = { "VN" };
    displayName = "S.O.G. PF - NVA (Field)";

    infantry[] = {
        "vn_o_men_nva_44",
        "vn_o_men_nva_28",
        "vn_o_men_nva_36",
        "vn_o_men_nva_21",
        "vn_o_men_nva_25",
        "vn_o_men_nva_24",
        "vn_o_men_nva_22",
        "vn_o_men_nva_34",
        "vn_o_men_nva_33",
        "vn_o_men_nva_35",
        "vn_o_men_nva_15",
        "vn_o_men_nva_20",
        "vn_o_men_nva_17",
        "vn_o_men_nva_16",
        "vn_o_men_nva_19",
        "vn_o_men_nva_18",
        "vn_o_men_nva_27",
        "vn_o_men_nva_23",
        "vn_o_men_nva_26"
    };
};

class SOGPF_NVA : SOGPF_NVA_dacCong
{
    dependencies[] = { "VN" };
    displayName = "S.O.G. PF - NVA";

    infantry[] = {
        "vn_o_men_nva_43",
        "vn_o_men_nva_14",
        "vn_o_men_nva_32",
        "vn_o_men_nva_07",
        "vn_o_men_nva_11",
        "vn_o_men_nva_10",
        "vn_o_men_nva_08",
        "vn_o_men_nva_30",
        "vn_o_men_nva_29",
        "vn_o_men_nva_31",
        "vn_o_men_nva_01",
        "vn_o_men_nva_06",
        "vn_o_men_nva_03",
        "vn_o_men_nva_02",
        "vn_o_men_nva_05",
        "vn_o_men_nva_04",
        "vn_o_men_nva_13",
        "vn_o_men_nva_09",
        "vn_o_men_nva_12"
    };
};

class SOGPF_VPN_marines : SOGPF_NVA_dacCong
{
    dependencies[] = { "VN" };
    displayName = "S.O.G. PF - VPN Marines";

    heavyCars[] = {
        "vn_o_wheeled_btr40_mg_02_nva65",
        "vn_o_wheeled_btr40_mg_01"
    };
    transportHelicopters[] = {
        "vn_o_air_mi2_01_03"
    };
    cargoAircraft[] = {
        "vn_o_air_mi2_01_03"
    };
    infantry[] = {
        "vn_o_men_nva_marine_14",
        "vn_o_men_nva_marine_07",
        "vn_o_men_nva_marine_11",
        "vn_o_men_nva_marine_10",
        "vn_o_men_nva_marine_08",
        "vn_o_men_nva_marine_01",
        "vn_o_men_nva_marine_06",
        "vn_o_men_nva_marine_03",
        "vn_o_men_nva_marine_02",
        "vn_o_men_nva_marine_05",
        "vn_o_men_nva_marine_04",
        "vn_o_men_nva_marine_13",
        "vn_o_men_nva_marine_09",
        "vn_o_men_nva_marine_12"
    };
};

class SOGPF_VPN_navy : SOGPF_VPN_marines
{
    dependencies[] = { "VN" };
    displayName = "S.O.G. PF - VPN Navy";

    infantry[] = {
        "vn_o_men_nva_navy_14",
        "vn_o_men_nva_navy_07",
        "vn_o_men_nva_navy_11",
        "vn_o_men_nva_navy_10",
        "vn_o_men_nva_navy_08",
        "vn_o_men_nva_navy_01",
        "vn_o_men_nva_navy_04",
        "vn_o_men_nva_navy_06",
        "vn_o_men_nva_navy_05",
        "vn_o_men_nva_navy_02",
        "vn_o_men_nva_navy_03",
        "vn_o_men_nva_navy_13",
        "vn_o_men_nva_navy_09",
        "vn_o_men_nva_navy_12"
    };
};

class SOGPF_VC_local : SOGPF_VPN_marines
{
    dependencies[] = { "VN" };
    displayName = "S.O.G. PF - Viet Cong (Local)";

    heavyArmor[] = {
        "vn_o_armor_m41_02_vcmf"
    };
    infantry[] = {
        "vn_o_men_vc_local_14",
        "vn_o_men_vc_local_28",
        "vn_o_men_vc_local_07",
        "vn_o_men_vc_local_21",
        "vn_o_men_vc_local_11",
        "vn_o_men_vc_local_25",
        "vn_o_men_vc_local_32",
        "vn_o_men_vc_local_10",
        "vn_o_men_vc_local_24",
        "vn_o_men_vc_local_31",
        "vn_o_men_vc_local_08",
        "vn_o_men_vc_local_22",
        "vn_o_men_vc_local_29",
        "vn_o_men_vc_local_01",
        "vn_o_men_vc_local_15",
        "vn_o_men_vc_local_16",
        "vn_o_men_vc_local_02",
        "vn_o_men_vc_local_20",
        "vn_o_men_vc_local_06",
        "vn_o_men_vc_local_04",
        "vn_o_men_vc_local_18",
        "vn_o_men_vc_local_03",
        "vn_o_men_vc_local_17",
        "vn_o_men_vc_local_05",
        "vn_o_men_vc_local_19",
        "vn_o_men_vc_local_27",
        "vn_o_men_vc_local_13",
        "vn_o_men_vc_local_09",
        "vn_o_men_vc_local_23",
        "vn_o_men_vc_local_30",
        "vn_o_men_vc_local_12",
        "vn_o_men_vc_local_26"
    };
};

class SOGPF_VC_main : SOGPF_VPN_marines
{
    dependencies[] = { "VN" };
    displayName = "S.O.G. PF - Viet Cong (Main Force)";

    infantry[] = {
        "vn_o_men_vc_14",
        "vn_o_men_vc_07",
        "vn_o_men_vc_11",
        "vn_o_men_vc_10",
        "vn_o_men_vc_08",
        "vn_o_men_vc_16",
        "vn_o_men_vc_15",
        "vn_o_men_vc_17",
        "vn_o_men_vc_01",
        "vn_o_men_vc_04",
        "vn_o_men_vc_05",
        "vn_o_men_vc_03",
        "vn_o_men_vc_02",
        "vn_o_men_vc_06",
        "vn_o_men_vc_13",
        "vn_o_men_vc_09",
        "vn_o_men_vc_12"
    };
};

class SOGPF_VC_regional : SOGPF_VPN_marines
{
    dependencies[] = { "VN" };
    displayName = "S.O.G. PF - Viet Cong (Regional)";

    infantry[] = {
        "vn_o_men_vc_regional_14",
        "vn_o_men_vc_regional_07",
        "vn_o_men_vc_regional_11",
        "vn_o_men_vc_regional_10",
        "vn_o_men_vc_regional_08",
        "vn_o_men_vc_regional_01",
        "vn_o_men_vc_regional_04",
        "vn_o_men_vc_regional_03",
        "vn_o_men_vc_regional_02",
        "vn_o_men_vc_regional_06",
        "vn_o_men_vc_regional_05",
        "vn_o_men_vc_regional_13",
        "vn_o_men_vc_regional_09",
        "vn_o_men_vc_regional_12"
    };
};


class SOGPF_ARVN : SOGPF_usArmy
{
    dependencies[] = { "VN" };
    displayName = "S.O.G. PF - ARVN";

    lightCars[] = {
        "vn_i_wheeled_m151_mg_01",
        "vn_i_wheeled_m151_mg_01_mp"
    };
    lightArmor[] = {
        "vn_i_armor_type63_01"
    };
    heavyArmor[] = {
        "vn_i_armor_m41_01"
    };
    cargoAircraft[] = {
        "vn_i_air_uh1d_01_01"
    };
    transportHelicopters[] = {
        "vn_i_air_ch34_02_01",
        "vn_i_air_uh1d_02_01",
        "vn_i_air_uh1c_07_01"
    };

    infantry[] = {
        "vn_i_men_army_12",
        "vn_i_men_army_05",
        "vn_i_men_army_04",
        "vn_i_men_army_07",
        "vn_i_men_army_17",
        "vn_i_men_army_06",
        "vn_i_men_army_11",
        "vn_i_men_army_10",
        "vn_i_men_army_03",
        "vn_i_men_army_01",
        "vn_i_men_army_22",
        "vn_i_men_army_15",
        "vn_i_men_army_16",
        "vn_i_men_army_18",
        "vn_i_men_army_19",
        "vn_i_men_army_20",
        "vn_i_men_army_21",
        "vn_i_men_army_08",
        "vn_i_men_army_09",
        "vn_i_men_army_02"
    };
};

class SOGPF_ARVN_lldb : SOGPF_ARVN
{
    dependencies[] = { "VN" };
    displayName = "S.O.G. PF - ARVN LLDB (Special Forces)";

    transportHelicopters[] = {
        "vn_i_air_ch34_02_02",
        "vn_i_air_uh1d_02_01",
        "vn_i_air_uh1c_07_01"
    };

    infantry[] = {
        "vn_i_men_sf_12",
        "vn_i_men_sf_05",
        "vn_i_men_sf_04",
        "vn_i_men_sf_07",
        "vn_i_men_sf_06",
        "vn_i_men_sf_11",
        "vn_i_men_sf_10",
        "vn_i_men_sf_03",
        "vn_i_men_sf_01",
        "vn_i_men_sf_08",
        "vn_i_men_sf_09",
        "vn_i_men_sf_02"
    };
};

class SOGPF_ARVN_rangers : SOGPF_ARVN
{
    dependencies[] = { "VN" };
    displayName = "S.O.G. PF - ARVN Rangers";

    infantry[] = {
        "vn_i_men_ranger_12",
        "vn_i_men_ranger_13",
        "vn_i_men_ranger_05",
        "vn_i_men_ranger_04",
        "vn_i_men_ranger_07",
        "vn_i_men_ranger_17",
        "vn_i_men_ranger_06",
        "vn_i_men_ranger_11",
        "vn_i_men_ranger_10",
        "vn_i_men_ranger_03",
        "vn_i_men_ranger_01",
        "vn_i_men_ranger_15",
        "vn_i_men_ranger_16",
        "vn_i_men_ranger_18",
        "vn_i_men_ranger_19",
        "vn_i_men_ranger_20",
        "vn_i_men_ranger_21",
        "vn_i_men_ranger_08",
        "vn_i_men_ranger_09",
        "vn_i_men_ranger_02"
    };
};


class SOGPF_ROK_army_65 : SOGPF_usArmy
{
    dependencies[] = { "VN" };
    displayName = "S.O.G. PF - Republic Of Korea Army (65)";

    infantry[] = {
        "vn_b_men_rok_army_65_16",
        "vn_b_men_rok_army_65_12",
        "vn_b_men_rok_army_65_05",
        "vn_b_men_rok_army_65_04",
        "vn_b_men_rok_army_65_07",
        "vn_b_men_rok_army_65_17",
        "vn_b_men_rok_army_65_06",
        "vn_b_men_rok_army_65_27",
        "vn_b_men_rok_army_65_10",
        "vn_b_men_rok_army_65_03",
        "vn_b_men_rok_army_65_01",
        "vn_b_men_rok_army_65_15",
        "vn_b_men_rok_army_65_18",
        "vn_b_men_rok_army_65_19",
        "vn_b_men_rok_army_65_20",
        "vn_b_men_rok_army_65_21",
        "vn_b_men_rok_army_65_08",
        "vn_b_men_rok_army_65_09",
        "vn_b_men_rok_army_65_11",
        "vn_b_men_rok_army_65_02",
        "vn_b_men_rok_army_65_14",
        "vn_b_men_rok_army_65_13",
        "vn_b_men_rok_army_65_31",
        "vn_b_men_rok_army_65_30"
    };

    lightCars[] = {
        "vn_b_wheeled_m151_mg_01_rok_army",
        "vn_b_wheeled_m151_mg_02_rok_army"
    };

    lightArmor[] = {
        "vn_b_armor_m113_acav_04_rok_army",
        "vn_b_armor_m113_acav_02_rok_army",
        "vn_b_armor_m113_acav_01_rok_army",
        "vn_b_armor_m113_acav_06_rok_army",
        "vn_b_armor_m113_acav_03_rok_army",
        "vn_b_armor_m113_acav_05_rok_army"
    };
};

class SOGPF_ROK_army_68 : SOGPF_ROK_army_65
{
    displayName = "S.O.G. PF - Republic Of Korea Army (68)";

    infantry[] = {
        "vn_b_men_rok_army_68_13",
        "vn_b_men_rok_army_68_16",
        "vn_b_men_rok_army_68_12",
        "vn_b_men_rok_army_68_05",
        "vn_b_men_rok_army_68_04",
        "vn_b_men_rok_army_68_07",
        "vn_b_men_rok_army_68_17",
        "vn_b_men_rok_army_68_06",
        "vn_b_men_rok_army_68_27",
        "vn_b_men_rok_army_68_10",
        "vn_b_men_rok_army_68_03",
        "vn_b_men_rok_army_68_01",
        "vn_b_men_rok_army_68_15",
        "vn_b_men_rok_army_68_18",
        "vn_b_men_rok_army_68_19",
        "vn_b_men_rok_army_68_20",
        "vn_b_men_rok_army_68_21",
        "vn_b_men_rok_army_68_08",
        "vn_b_men_rok_army_68_09",
        "vn_b_men_rok_army_68_11",
        "vn_b_men_rok_army_68_02",
        "vn_b_men_rok_army_68_23",
        "vn_b_men_rok_army_68_24",
        "vn_b_men_rok_army_68_25"
    };
};

class SOGPF_ROK_marines_65 : SOGPF_usmc
{
    displayName = "S.O.G. PF - Republic Of Korea Marines (65)";
    infantry[] = {
        "vn_b_men_rok_marine_65_14",
        "vn_b_men_rok_marine_65_12",
        "vn_b_men_rok_marine_65_03",
        "vn_b_men_rok_marine_65_05",
        "vn_b_men_rok_marine_65_04",
        "vn_b_men_rok_marine_65_07",
        "vn_b_men_rok_marine_65_17",
        "vn_b_men_rok_marine_65_06",
        "vn_b_men_rok_marine_65_10",
        "vn_b_men_rok_marine_65_01",
        "vn_b_men_rok_marine_65_15",
        "vn_b_men_rok_marine_65_16",
        "vn_b_men_rok_marine_65_18",
        "vn_b_men_rok_marine_65_19",
        "vn_b_men_rok_marine_65_20",
        "vn_b_men_rok_marine_65_21",
        "vn_b_men_rok_marine_65_08",
        "vn_b_men_rok_marine_65_09",
        "vn_b_men_rok_marine_65_11",
        "vn_b_men_rok_marine_65_02",
        "vn_b_men_rok_marine_65_30",
        "vn_b_men_rok_marine_65_31",
        "vn_b_men_rok_marine_65_13"
    };

    lightCars[] = {
        "vn_b_wheeled_m151_mg_01_rok_army",
        "vn_b_wheeled_m151_mg_02_rok_army"
    };
};

class SOGPF_ROK_marines_68 : SOGPF_ROK_marines_65
{
    displayName = "S.O.G. PF - Republic Of Korea Marines (68)";

    infantry[] = {
        "vn_b_men_rok_marine_68_02",
        "vn_b_men_rok_marine_68_12",
        "vn_b_men_rok_marine_68_11",
        "vn_b_men_rok_marine_68_03",
        "vn_b_men_rok_marine_68_14",
        "vn_b_men_rok_marine_68_13",
        "vn_b_men_rok_marine_68_05",
        "vn_b_men_rok_marine_68_04",
        "vn_b_men_rok_marine_68_07",
        "vn_b_men_rok_marine_68_17",
        "vn_b_men_rok_marine_68_31",
        "vn_b_men_rok_marine_68_30",
        "vn_b_men_rok_marine_68_06",
        "vn_b_men_rok_marine_68_10",
        "vn_b_men_rok_marine_68_01",
        "vn_b_men_rok_marine_68_15",
        "vn_b_men_rok_marine_68_16",
        "vn_b_men_rok_marine_68_18",
        "vn_b_men_rok_marine_68_19",
        "vn_b_men_rok_marine_68_20",
        "vn_b_men_rok_marine_68_21",
        "vn_b_men_rok_marine_68_09",
        "vn_b_men_rok_marine_68_08"
    };
};


// TODO: Laos, New Zealand, Austrailia, Pathet Lao
