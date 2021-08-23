#include "Supplements\Spartan Gear.hpp"

#define OJOO_CONDITION "private _name = toUpperANSI (_this select 0); if ('OPTRE_' in _name OR {'JTFS_' in _name} OR {'OPAEX_' in _name} OR {'LM_OPCAN' in _name}) then {true} else {false}"
#define OPTRE_CONDITION "'OPTRE_' in (toUpperANSI (_this select 0))"
#define OPTRE_OPAEX_CONDITION "private _name = toUpperANSI (_this select 0); if ('OPTRE_' in _name OR {'OPAEX_' in _name}) then {true} else {false}"
#define OPTRE_OPCAN_CONDITION "private _name = toUpperANSI (_this select 0); if ('OPTRE_' in _name OR {'LM_OPCAN' in _name}) then {true} else {false}"
#define OPTRE_OPCAN_OPAEX_CONDITION "private _name = toUpperANSI (_this select 0); if ('OPTRE_' in _name OR {'OPAEX_' in _name} OR {'LM_OPCAN' in _name}) then {true} else {false}"


class OPTRE_lootList
{
    title = "OPTRE";
    patches[] = {"OPTRE_Weapons"};

    conditionWeapons = OPTRE_CONDITION;
    conditionClothes = OPTRE_CONDITION;
    conditionMagazines = OPTRE_CONDITION;

    lootBlackList[] = {
        "OPTRE_FC_Elite_Armor_FieldMarshal",
        "OPTRE_FC_Elite_Armor_HonorGuard",
        "OPTRE_FC_Elite_Armor_HonorGuard_Ultra",
        "OPTRE_FC_Elite_Armor_Major",
        "OPTRE_FC_Elite_Armor_Minor",
        "OPTRE_FC_Elite_Armor_SpecOps",
        "OPTRE_FC_Elite_Armor_Ultra",
        "OPTRE_FC_Elite_Armor_Zealot",
        "OPTRE_FC_Elite_CombatSkin",
        "OPTRE_FC_Elite_Helmet_FieldMarshal",
        "OPTRE_FC_Elite_Helmet_HonorGuard",
        "OPTRE_FC_Elite_Helmet_HonorGuard_Ultra",
        "OPTRE_FC_Elite_Helmet_Major",
        "OPTRE_FC_Elite_Helmet_Minor",
        "OPTRE_FC_Elite_Helmet_SpecOps",
        "OPTRE_FC_Elite_Helmet_Ultra",
        "OPTRE_FC_Elite_Helmet_Zealot",
        SPARTAN_GEAR
    };

    checkForDuplicates = 0;
};


class OPTRE_OPAEX_lootList : OPTRE_lootList
{
    title = "OPTRE and OPAEX";
    patches[] = {"OPTRE_Weapons","OPAEX_Core"};

    conditionWeapons = OPTRE_OPAEX_CONDITION;
    conditionClothes = OPTRE_OPAEX_CONDITION;
    conditionMagazines = OPTRE_OPAEX_CONDITION;

    checkForDuplicates = 0;
};


class OPTRE_OPCAN_lootList : OPTRE_lootList
{
    title = "OPTRE and OPCAN";
    patches[] = {"OPTRE_Weapons","LM_OPCAN_UNSC"};

    conditionWeapons = OPTRE_OPCAN_CONDITION;
    conditionClothes = OPTRE_OPCAN_CONDITION;
    conditionMagazines = OPTRE_OPCAN_CONDITION;

    checkForDuplicates = 0;
};


class OPTRE_OPCAN_OPAEX_lootList : OPTRE_lootList
{
    title = "OPTRE, OPCAN, and OPAEX";
    patches[] = {"OPTRE_Weapons","OPAEX_Core","LM_OPCAN_UNSC"};

    conditionWeapons = OPTRE_OPCAN_OPAEX_CONDITION;
    conditionClothes = OPTRE_OPCAN_OPAEX_CONDITION;
    conditionMagazines = OPTRE_OPCAN_OPAEX_CONDITION;

    checkForDuplicates = 0;
};


class optre_jtfs_opaex_opcan_lootList : OPTRE_lootList
{
    title = "OPTRE, JTFS, OPCAN, and OPAEX Loot List";

    conditionWeapons = OJOO_CONDITION;
    conditionClothes = OJOO_CONDITION;
    conditionMagazines = OJOO_CONDITION;

    patches[] = {"OPTRE_Weapons","OPAEX_Core","LM_OPCAN_UNSC","JTFS_URF_Units"};

    checkForDuplicates = 0;

    lootWhitelist_launchers[] = {
    };

    lootWhitelist_primaries[] = {
    };

    lootWhitelist_handguns[] = {
    };

    lootWhitelist_backpacks[] = {
    };

    lootWhitelist_vests[] = {
    };

    lootWhitelist_uniforms[] = {
    };

    lootWhitelist_headgear[] = {
    };

    lootWhitelist_items[] = {
    };

    lootWhitelist_explosives[] = {
    };

};
