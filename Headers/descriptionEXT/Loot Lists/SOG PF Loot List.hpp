#define SOG_CONDITION "(_this select 0) select [0,3] == 'vn_'"
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
