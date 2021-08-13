#include "..\GUI\shopGUICommonDefines.hpp"

class BLWK_genericBuildItemBase
{
	displayName = ""; // only needed for custom names
	price = 0;
	category = OTHER_CATEGORY;
	hasAI = 0;
	rotation = 0;
	attachmentX = 0; // side to side
	attachmentY = 3; // how far out in front of you
	attachmentZ = 1; // height
	invincible = 0; // 0 false, 1 true
	keepInventory = 0; // don't clear inventory
	detectCollision = 1; // registers with ai collision script

	// text that shows when hovering over the item in the shop
	tooltip = "";

	/*
		Events
		See relevant functions in functions\Build folder for passed params
	*/
	onPurchasedPrefix = "";
	onPurchasedPostfix = "";
	onPurchasedPostNewtork = "";
	onPickedUp = "";
	onPlaced = "";
	onSold = "";
};
class BLWK_genericTurretBase: BLWK_genericBuildItemBase
{
	category = TURRETS_CATEGORY;
	attachmentX = 0;
	attachmentY = 2;
	attachmentZ = 1;
	invincible = 1;
	detectCollision = 0;

	onPurchasedPostfix = "_object enableWeaponDisassembly false;";
};
class BLWK_genericTrenchBase : BLWK_genericBuildItemBase
{
	price = 0;

	category = TRENCH_CATEGORY;
	detectCollision = 0;
	rotation = 0;

	attachmentX = 0;
	attachmentY = 0;
	attachmentZ = 0;
};
class BLWK_genericLampBase : BLWK_genericBuildItemBase
{
	category = LAMPS_CATEGORY;
	detectCollision = 0;
	invincible = 1;
};


class BLWK_buildableItems
{
	class Land_Plank_01_8m_F: BLWK_genericBuildItemBase
	{
		price = 25;
		category = PLATFORMS_CATEGORY;
		attachmentY = 6;
	};

	class Land_ConcretePanels_02_single_v1_F: BLWK_genericBuildItemBase
	{
		price = 100;
		category = PLATFORMS_CATEGORY;
		attachmentY = 5;
	};

	class Land_BagFence_End_F: BLWK_genericBuildItemBase
	{
		price = 25;
		category = SANDBAGS_CATEGORY;
	};

	class Land_Barricade_01_4m_F: BLWK_genericBuildItemBase
	{
		price = 50;
		category = WALLS_CATEGORY;
		attachmentY = 4;
		attachmentZ = 0.5;
	};

	class Land_BagFence_Short_F: BLWK_genericBuildItemBase
	{
		price = 50;
		category = SANDBAGS_CATEGORY;
	};

	class Land_BagFence_Corner_F: BLWK_genericBuildItemBase
	{
		price = 50;
		category = SANDBAGS_CATEGORY;
	};

	class Land_Obstacle_Ramp_F: BLWK_genericBuildItemBase
	{
		price = 75;
		category = VERTICAL_CATEGORY;
		rotation = 180;
	};

	class Land_BagFence_Round_F: BLWK_genericBuildItemBase
	{
		price = 80;
		category = SANDBAGS_CATEGORY;
		rotation = 180;
	};

	class Land_BagFence_Long_F: BLWK_genericBuildItemBase
	{
		price = 80;
		category = SANDBAGS_CATEGORY;
	};

	class Land_DomeDebris_01_hex_green_F: BLWK_genericBuildItemBase
	{
		price = 85;
		category = PLATFORMS_CATEGORY;
		rotation = 180;
		attachmentZ = 0.75;
	};

	class Land_SandbagBarricade_01_half_F: BLWK_genericBuildItemBase
	{
		price = 100;
		category = SANDBAGS_CATEGORY;
	};

	class Land_SandbagBarricade_01_hole_F: BLWK_genericBuildItemBase
	{
		price = 100;
		category = SANDBAGS_CATEGORY;
		attachmentZ = 1.5;
	};

	class Land_CncShelter_F: BLWK_genericBuildItemBase
	{
		price = 180;
		category = BUNKERS_CATEGORY;
		attachmentZ = 1.5;
	};

	class Land_GH_Platform_F: BLWK_genericBuildItemBase
	{
		price = 200;
		category = PLATFORMS_CATEGORY;
		attachmentY = 6;
		attachmentZ = 0.75;
	};

	class Land_Mil_WallBig_4m_F : BLWK_genericBuildItemBase
	{
		price = 250;
		category = WALLS_CATEGORY;
		rotation = 180;
		attachmentY = 4;
		attachmentZ = 2;
		invincible = 1;
	};

	class Land_PortableLight_double_F : BLWK_genericLampBase
	{
		price = 250;
		rotation = 180;
		attachmentZ = 1.1;
	};

	class Land_CncBarrierMedium4_F : BLWK_genericBuildItemBase
	{
		price = 800;
		category = WALLS_CATEGORY;
		attachmentX = 0.25;
		attachmentY = 5;
		attachmentZ = 1.2;
	};

	class Land_VR_Slope_01_F : BLWK_genericBuildItemBase
	{
		price = 400;
		category = VERTICAL_CATEGORY;
		attachmentY = 9;
		attachmentZ = 2.25;
	};

	class Land_Bunker_01_blocks_3_F : BLWK_genericBuildItemBase
	{
		price = 500;
		category = WALLS_CATEGORY;
		attachmentY = 3;
		attachmentZ = 0.5;
	};

	class Land_HBarrier_3_F : BLWK_genericBuildItemBase
	{
		price = 500;
		category = HBARR_CATEGORY;
		attachmentY = 4;
	};

	class Land_HBarrier_5_F : Land_HBarrier_3_F
	{
		price = 900;
	};

	class Land_HBarrier_Big_F : Land_HBarrier_3_F
	{
		price = 1100;
		attachmentZ = 1.5;
		attachmentY = 6;
	};

	class Land_HBarrierTower_F : Land_HBarrier_3_F
	{
		price = 3000;
		attachmentY = 9;
		attachmentZ = 3;
		rotation = 180;
	};

	class Land_PierLadder_F : BLWK_genericBuildItemBase
	{
		price = 750;
		category = VERTICAL_CATEGORY;
		attachmentX = 0.15;
		attachmentY = 2.5;
	};

	class Box_NATO_Support_F : BLWK_genericBuildItemBase
	{
		price = 800;
		category = STORAGE_CATEGORY;
		rotation = 90;
		attachmentY = 2;
		invincible = 1;
		detectCollision = 0;
	};

	class Land_GH_Stairs_F : BLWK_genericBuildItemBase
	{
		price = 750;
		category = VERTICAL_CATEGORY;
		rotation = 180;
		attachmentY = 5;
	};

	class Land_LampHalogen_F : BLWK_genericLampBase
	{
		price = 500;
		rotation = 90;
		attachmentX = 0.2;
		attachmentY = 2;
		attachmentZ = 2.75;
	};

	class Land_HBarrierWall4_F : BLWK_genericBuildItemBase
	{
		price = 1000;
		category = HBARR_CATEGORY;
		attachmentY = 5;
	};
	class Land_HBarrierWall_corner_F : Land_HBarrierWall4_F
	{
		price = 900;
	};

	class BlockConcrete_F : BLWK_genericBuildItemBase
	{
		price = 1000;
		category = PLATFORMS_CATEGORY;
		attachmentY = 8;
		attachmentZ = 0.5;
	};

	class Box_NATO_AmmoVeh_F : BLWK_genericBuildItemBase
	{
		price = 1200;
		category = STORAGE_CATEGORY;
		invincible = 1;
		detectCollision = 0;
	};

	class B_HMG_01_high_F : BLWK_genericTurretBase
	{
		price = 1500;
		attachmentX = 0.25;
		attachmentY = 2;
		attachmentZ = 2;
	};

	class Land_BagBunker_Small_F : BLWK_genericBuildItemBase
	{
		price = 1000;
		category = BUNKERS_CATEGORY;
		rotation = 180;
		attachmentY = 4;
	};

	class Land_PillboxBunker_01_hex_F : BLWK_genericBuildItemBase
	{
		price = 4500;
		category = BUNKERS_CATEGORY;
		rotation = 90;
		attachmentY = 4;
	};

	class Land_Cargo_Patrol_V3_F : BLWK_genericBuildItemBase
	{
		price = 4000;
		category = TOWERS_CATEGORY;
		rotation = 180;
		attachmentY = 6;
		attachmentZ = 5;
		invincible = 1;
		detectCollision = 0;
	};

	class B_HMG_01_A_F : BLWK_genericTurretBase
	{
		price = 3000;
		hasAI = 1;
		rotation = 180;
	};

	class Land_Bunker_01_Small_F : BLWK_genericBuildItemBase
	{
		price = 9500;
		category = BUNKERS_CATEGORY;
		rotation = 180;
		attachmentX = 0.5;
		attachmentY = 6;
		attachmentZ = 0;
	};

	class Land_Razorwire_F : BLWK_genericBuildItemBase
	{
		price = 100;
		category = OBSTACLES_CATEGORY;
		invincible = 1;
	};

	class Land_CncBarrier_F : BLWK_genericBuildItemBase
	{
		price = 100;
		category = WALLS_CATEGORY;
	};

	class Land_CncBarrierMedium_F : BLWK_genericBuildItemBase
	{
		price = 200;
		category = WALLS_CATEGORY;
	};

	class Land_HBarrierWall_corridor_F : BLWK_genericBuildItemBase
	{
		price = 400;
		category = HBARR_CATEGORY;
		rotation = 90;
		attachmentY = 5;
	};

	class Land_CzechHedgehog_01_new_F : BLWK_genericBuildItemBase
	{
		price = 100;
		category = OBSTACLES_CATEGORY;
	};

	class B_GMG_01_high_F : BLWK_genericTurretBase
	{
		price = 2000;
		attachmentZ = 2;
	};

	class B_Mortar_01_F : BLWK_genericTurretBase
	{
		price = 3000;
	};

	class B_static_AT_F : BLWK_genericTurretBase
	{
		price = 1000;
	};

	class B_static_AA_F : BLWK_genericTurretBase
	{
		price = 500;
	};

	class B_G_HMG_02_high_F : BLWK_genericTurretBase
	{
		price = 900;
		attachmentZ = 2;
	};

	class B_G_HMG_02_F : BLWK_genericTurretBase
	{
		price = 600;
		attachmentZ = 2;
	};

	class ACE_medicalSupplyCrate_advanced : BLWK_genericBuildItemBase
	{
		price = 500;
		category = STORAGE_CATEGORY;
		attachmentY = 2;
		keepInventory = 1;
		invincible = 1;
		detectCollision = 0;
	};
	class ACE_medicalSupplyCrate : BLWK_genericBuildItemBase
	{
		price = 250;
		category = STORAGE_CATEGORY;
		attachmentY = 2;
		keepInventory = 1;
		invincible = 1;
		detectCollision = 0;
	};

	class C_IDAP_supplyCrate_F : BLWK_genericBuildItemBase
	{
		displayName = "Satellite Shop";
		price = 1000;
		category = UNIQUE_CATEGORY;
		attachmentY = 2;
		attachmentZ = 1;
		invincible = 1;
		keepInventory = 0;
		detectCollision = 0;

		tooltip = "Get a secondary shop that lasts 2 full waves";

		onSold = "hint 'Shops cannot be sold'; false";
		onPurchasedPrefix = "if (BLWK_satShopOut) then {hint 'There is already a satellite shop present'; _doExit = true; _refund = true;};";
		onPurchasedPostfix = "[_object] call BLWK_fnc_satelliteShop_init";
	};

	class Land_GarbageContainer_open_F : BLWK_genericBuildItemBase
	{
		displayName = "Item Reclaimer";
		price = 900;
		category = UNIQUE_CATEGORY;
		attachmentY = 2;
		attachmentZ = 0.8;
		invincible = 1;
		detectCollision = 0;

		tooltip = "Place items inside, reclaim, and get points put into the community pool";

		onPurchasedPostfix = "_this call BLWK_fnc_itemReclaimer_init";
		onSold = "_this call BLWK_fnc_itemReclaimer_onSold";
	};

	#include "OPTRE Build Items.hpp"
	#include "RHS Build Items.hpp"
	#include "SOG PF Build Items.hpp"
};
