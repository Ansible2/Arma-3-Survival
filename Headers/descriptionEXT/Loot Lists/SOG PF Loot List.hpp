#define SOG_CONDITION "(getAssetDLCInfo [_this select 0,_this select 1] select 4) isEqualTo '1227700'"
class sogpf_lootList
{
    title = "SOG PF Loot List";

    conditionWeapons = SOG_CONDITION;
    conditionClothes = SOG_CONDITION;
    conditionMagazines = SOG_CONDITION;

    patches[] = {"vn_data_f"};

    checkForDuplicates = 0;

    lootBlackList[] = {

    };

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
