
class vn_o_nva_spiderhole_03 : BLWK_genericTurretBase
{
    price = 200;
    attachmentY = 4;
    attachmentZ = 0;
    invincible = 1;
    rotation = 270;
    onPurchasedPostfix = "";
    tooltip = "Small trench to hide in";
};
class vn_o_nva_spiderhole_01 : vn_o_nva_spiderhole_03
{
    price = 100;
    rotation = 0;
};
class vn_o_nva_spiderhole_02 : vn_o_nva_spiderhole_01
{
};

class vn_o_nva_65_static_d44 : BLWK_genericTurretBase
{
    price = 1000;
    attachmentY = 4;
    attachmentZ = 0;
};
class vn_o_nva_65_static_mortar_type63 : BLWK_genericTurretBase
{
    price = 6000;

    attachmentX = 0.35;
    attachmentY = 2;
    attachmentZ = 1;
};
class vn_o_nva_65_static_mortar_type53 : B_Mortar_01_F
{
    attachmentX = 0.75;
    attachmentY = 2;
    attachmentZ = 1.5;
};

class vn_o_nva_65_static_rpd_high : BLWK_genericTurretBase
{
    price = 500;

    attachmentX = 0.25;
    attachmentY = 2;
    attachmentZ = 2;
};
class vn_o_nva_65_static_pk_low : BLWK_genericTurretBase
{
    price = 300;
    attachmentX = 0.25;
    attachmentY = 2;
    attachmentZ = 2;
};
class vn_o_nva_65_static_pk_high : vn_o_nva_65_static_rpd_high
{
    price = 600;
};
class vn_o_nva_65_static_dshkm_low_01 : BLWK_genericTurretBase
{
    price = 600;
    rotation = 0;

    attachmentX = 0.5;
    attachmentY = 2;
    attachmentZ = 2;
};
class vn_o_nva_65_static_dshkm_low_02 : vn_o_nva_65_static_dshkm_low_01
{
    price = 500;
};
class vn_o_nva_65_static_dshkm_high_01 : BLWK_genericTurretBase
{
    price = 700;
    attachmentX = 0.2;
    attachmentY = 2;
    attachmentZ = 2;
};
class vn_o_nva_static_dshkm_high_02 : vn_o_nva_65_static_dshkm_high_01
{
};

class vn_b_army_static_m101_01 : vn_o_nva_65_static_d44
{
};
class vn_b_army_static_tow : BLWK_genericTurretBase
{
    price = 1000;
    attachmentX = 0.2;
    attachmentY = 3;
    attachmentZ = 2;
};

class vn_b_army_static_m1919a6 : BLWK_genericTurretBase
{
    price = 250;
    attachmentX = 0.2;
    attachmentY = 2;
    attachmentZ = 2;
};
class vn_b_army_static_m1919a4_low : BLWK_genericTurretBase
{
    price = 300;
    attachmentX = 0.3;
    attachmentY = 2;
    attachmentZ = 2;
};
class vn_b_army_static_m2_low : vn_b_army_static_m1919a4_low
{
    price = 500;
};
class vn_b_army_static_m60_low : vn_b_army_static_m1919a4_low
{
    price = 200;
};
class vn_b_army_static_mortar_m29 : vn_o_nva_65_static_mortar_type53
{
    attachmentX = 0;
};
class vn_b_army_static_m1919a4_high : vn_b_army_static_m1919a4_low
{
    price = 600;
};
class vn_b_army_static_m2_high : vn_b_army_static_m1919a4_low
{
    price = 700;
};
class vn_b_army_static_m60_high : vn_b_army_static_m1919a4_low
{
    price = 350;
    attachmentX = 0.15;
};


class Land_vn_b_trench_firing_04 : BLWK_genericTrenchBase
{
    price = 900;
    rotation = 270;
    attachmentY = 7;
};
class Land_vn_b_trench_firing_05 : Land_vn_b_trench_firing_04
{
    price = 1100;
};
class Land_vn_b_trench_firing_01 : Land_vn_b_trench_firing_04
{
    price = 8000;
    rotation = 270;

    attachmentX = -1;
    attachmentY = 13;
    attachmentZ = 2;
};
class Land_vn_b_trench_firing_03 : Land_vn_b_trench_firing_04
{
    price = 600;
    rotation = 90;
};
class Land_vn_b_trench_end_01 : Land_vn_b_trench_firing_03
{
    price = 250;
};
class Land_vn_b_trench_bunker_02_01 : Land_vn_b_trench_firing_04
{
    price = 2000;

    attachmentY = 15;
    attachmentZ = 1;
};
class Land_vn_b_trench_bunker_03_01 : Land_vn_b_trench_bunker_02_01
{
    price = 2750;
};
class Land_vn_b_trench_bunker_04_01 : Land_vn_b_trench_firing_04
{
    price = 10000;

    attachmentX = -2;
    attachmentY = 12;
    attachmentZ = 2;
};
class Land_vn_b_foxhole_01 : BLWK_genericTrenchBase
{
    price = 400;
    rotation = 180;

    attachmentX = 0;
    attachmentY = 8;
    attachmentZ = 0.5
};


class Land_vn_pillboxbunker_02_hex_f : BLWK_genericBuildItemBase
{
    price = 5200;
    rotation = 90;
    category = BUNKERS_CATEGORY;
    detectCollision = 1;
    attachmentX = 0;
    attachmentY = 6;
    attachmentZ = 2.2;
};
class Land_vn_pillboxbunker_01_big_f : Land_vn_pillboxbunker_02_hex_f
{
    price = 10000;

    attachmentX = 1;
    attachmentY = 10;
    attachmentZ = 1;
};


class Land_vn_usaf_revetment_01 : BLWK_genericBuildItemBase
{
    price = 375;
    category = REVETMENT_CATEGORY;
    rotation = 90;
    detectCollision = 1;
    attachmentX = 0;
    attachmentY = 5;
    attachmentZ = 0;
};
class Land_vn_usaf_revetment_1 : Land_vn_usaf_revetment_01
{
    price = 650;
    attachmentY = 7;
};
class Land_vn_usaf_revetment_low_2 : Land_vn_usaf_revetment_01
{
    price = 750;
    rotation = 0;
    attachmentY = 6;
};
class Land_vn_usaf_revetment_low_3 : Land_vn_usaf_revetment_low_2
{
    price = 1125;
    attachmentY = 8;
};


class Land_vn_b_tower_01 : BLWK_genericBuildItemBase
{
    price = 1000;
    category = TOWERS_CATEGORY;
    rotation = 0;
    detectCollision = 0;
    invincible = 1;
    attachmentX = 0;
    attachmentY = 8;
    attachmentZ = 2.5;
};
class Land_vn_b_trench_corner_01 : BLWK_genericTrenchBase
{
    price = 500;

    detectCollision = 1
    attachmentX = 0;
    attachmentY = 5;
    attachmentZ = 1;
};
class Land_vn_b_trench_stair_01 : Land_vn_b_trench_corner_01
{
    price = 200;
    rotation = 180;
    category = VERTICAL_CATEGORY;
};

class Land_vn_b_trench_20_01 : BLWK_genericTrenchBase
{
    price = 2000;
    rotation = 90;

    attachmentX = 0;
    attachmentY = 14;
    attachmentZ = -0.3;
};
class Land_vn_b_trench_20_02 : Land_vn_b_trench_20_01
{
    price = 1000;
    attachmentX = 3;
};
class Land_vn_b_trench_45_01 : BLWK_genericTrenchBase
{
    price = 1400;
    rotation = 270;

    attachmentX = -1;
    attachmentY = 10;
    attachmentZ = -0.3;
};
class Land_vn_b_trench_45_02 : Land_vn_b_trench_45_01
{
    price = 700;
};
class Land_vn_b_trench_05_01 : Land_vn_b_trench_45_01
{
    price = 1000;
    attachmentX = 0;
    attachmentY = 8;
};
class Land_vn_b_trench_05_03 : Land_vn_b_trench_05_01
{
    price = 1100;
};
class Land_vn_b_trench_05_02 : Land_vn_b_trench_05_01
{
    price = 500;
    attachmentX = -3;
};
class Land_vn_b_trench_90_01 : Land_vn_b_trench_45_01
{
    price = 1600;
    attachmentX = 3;
    attachmentY = 10;
    rotation = 180;
};
class Land_vn_b_trench_90_02 : Land_vn_b_trench_90_01
{
    price = 800;
};
class Land_vn_b_trench_cross_01 : Land_vn_b_trench_45_01
{
    price = 1800;
    attachmentX = -1;
    attachmentY = 10;
};
class Land_vn_b_trench_cross_02 : Land_vn_b_trench_cross_01
{
    price = 900;
    attachmentX = 0.5;
    attachmentY = 8;
    rotation = 180;
};
class Land_vn_b_trench_tee_01 : Land_vn_b_trench_cross_02
{
    price = 1000;
    attachmentX = 0;
    attachmentY = 11;
};
class Land_vn_b_trench_firing_02 : Land_vn_b_trench_cross_02
{
    price = 1000;
    attachmentX = -3;
    attachmentY = 11;
    rotation = 270;
};
