
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
    attachmentZ = 1;
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
    attachmentX = 0.5;
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
    rotation = 335;

    attachmentX = 0.65;
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
};
