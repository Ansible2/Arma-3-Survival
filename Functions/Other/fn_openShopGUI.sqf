/* ----------------------------------------------------------------------------
Function: BLWK_fnc_openShopGUI

Description:
	Opens the dialog or GUI of the bulwark to let you purchase
	 supports and build objects.

	Executed from an action added in "BLWK_fnc_prepareBulwarkPlayer"

Parameters:
	NONE

Returns:
	NOTHING

Examples:
    (begin example)

		null = [] spawn BLWK_fnc_openShopGUI;

    (end)

Author(s):
	Hilltop(Willtop) & omNomios,
	KillerStudio,
	Modified by: Ansible2 // Cipher
---------------------------------------------------------------------------- */
if (!hasInterface OR {!canSuspend}) exitWith {};

disableSerialization;

// CIPHER COMMENT: this message method is a litle dumb and should be changed to just a dedicated text box on top that is either shown or not
#define SUPPORT_DISH_NOT_FOUND_MESSAGE(CTRL)\
	CTRL lbAdd " ";\
	CTRL lbAdd "";\
	CTRL lbAdd "         A Satellite Dish must be found";\
	CTRL lbAdd "             to unlock Support Menu"; 

#define PRICE_NAME_FORMAT "%1 - %2"
#define SHOP_DIALOG_IDD 9999

createDialog "bulwarkShopDialog";
waitUntil {!isNull (findDisplay SHOP_DIALOG_IDD)};


// buildable objects
private _buildableObjectsControl = (findDisplay SHOP_DIALOG_IDD) displayCtrl 1500;
private _displayNameTemp = "";
BLWK_buildableObjects_array apply {
	_displayNameTemp = [configFile >> "cfgVehicles" >> (_x select 1)] call BIS_fnc_displayName;
	_buildableObjectsControl lbAdd format [PRICE_NAME_FORMAT,_x select 0,_displayNameTemp];
};

// show buildable object preview
((findDisplay SHOP_DIALOG_IDD) displayCtrl 1500) ctrlAddEventHandler ['LBSelChanged', {
	private _currentlySelectedIndex = lbCurSel 1500;
  	private _previewPic = getText (configFile >> "CfgVehicles" >> ((BLWK_buildableObjects_array select _currentlySelectedIndex) select 1) >> "editorPreview");

  	ctrlSetText [1502, _previewPic];
}];


// supports
private _supportsControl = (findDisplay SHOP_DIALOG_IDD) displayCtrl 1501;
// if support dish was found, display purchasable support, else show message
if (BLWK_supportDishFound) then {
	private "_nameOfSupport"; 
	BLWK_supports_array apply {
		_nameOfSupport = getText(missionConfigFile >> "cfgCommunicationMenu" >> (_x select 1) >> "text");
		_supportsControl lbAdd format [PRICE_NAME_FORMAT, _x select 0,_nameOfSupport];
	};
} else {
  	SUPPORT_DISH_NOT_FOUND_MESSAGE(_supportsControl);
};







/*
	#define WALLS_CATEGORY "Walls"
	#define PLATFORMS_CATEGORY "Platforms"
	#define SANDBAGS_CATEGORY "Sandbags"
	#define OBSTACLES_CATEGORY "Obstacles"
	#define LAMPS_CATEGORY "Lamps"
	#define TOWERS_CATEGORY "Towers"
	#define BUNKERS_CATEGORY "Bunkers"
	#define VERTICAL_CATEGORY "Ramps & Stairs"
	#define TURRETS_CATEGORY "Turrets"
	#define STORAGE_CATEGORY "Storage"

	BLWK_buildableObjects_array = [
		//1. Price //2. ClassName //3. Does it have AI? //4. attachment info (when you buy an object) [defaultRotation,attachToArray] 5. is it indestructable? (default: false)
		//Cipher Comment The object radius is used to prevent AI from glitching through and triggers suicide bombers.......that seems dumb
		[25,   "Land_Plank_01_8m_F",PLATFORMS_CATEGORY,                false, [0, [0,6,1]]],
		[25,   "Land_BagFence_End_F",WALLS_CATEGORY,                false, [0, [0,3,1]]],
		[50,   "Land_Barricade_01_4m_F",WALLS_CATEGORY,            false, [0, [0,4,0.5]]],
		[50,   "Land_BagFence_Short_F",SANDBAGS_CATEGORY,              false, [0, [0,3,1]]],
		[50,   "Land_BagFence_Corner_F",SANDBAGS_CATEGORY,             false, [0, [0,3,1]]],
		[75,   "Land_Obstacle_Ramp_F",OBSTACLES_CATEGORY,              false, [180, [0,3,1]]],
		[80,   "Land_BagFence_Round_F", SANDBAGS_CATEGORY ,            false, [180, [0,3,1]]],
		[80,   "Land_BagFence_Long_F",SANDBAGS_CATEGORY,               false, [0, [0,3,1]]],
		[85,   "Land_DomeDebris_01_hex_green_F",OBSTACLES_CATEGORY,    false, [180, [0,3,0.75]]],
		[100,  "Land_SandbagBarricade_01_half_F",SANDBAGS_CATEGORY,   false, [0, [0,3,1]]],
		[150,  "Land_SandbagBarricade_01_hole_F",SANDBAGS_CATEGORY,   false, [0, [0,3,1.5]]],
		[180,  "Land_CncShelter_F",BUNKERS_CATEGORY,                 false, [0, [0,3,1.5]]],
		[200,  "Land_GH_Platform_F",PLATFORMS_CATEGORY,                false, [0, [0,6,0.75]]],
		[250,  "Land_Mil_WallBig_4m_F",WALLS_CATEGORY,             false, [180, [0,4,2]]],
		[260,  "Land_PortableLight_double_F",LAMPS_CATEGORY,       false, [180, [0,3,1.1]]],
		[300,  "Land_CncBarrierMedium4_F",WALLS_CATEGORY,          false, [0, [0.25,5,1.2]]],
		[400,  "Land_VR_Slope_01_F",VERTICAL_CATEGORY,                false, [0, [0,9,2.25]]],
		[500,  "Land_Bunker_01_blocks_3_F",WALLS_CATEGORY,         false, [0, [0,3,0.5]]], 
		[500,  "Land_HBarrier_3_F",WALLS_CATEGORY,                 false, [0, [0,4,1]]],
		[750,  "Land_PierLadder_F",VERTICAL_CATEGORY,                 false, [0, [0.15,2.5,1]]],
		[800,  "Box_NATO_Support_F",STORAGE_CATEGORY,                false, [90, [0,2,1]]],    
		[950,  "Land_GH_Stairs_F",VERTICAL_CATEGORY,                  false, [180, [0,5,1]]],
		[1000, "Land_LampHalogen_F",LAMPS_CATEGORY,  false, [90, [0.2,2,2.75]]],
		[1000, "Land_HBarrierWall4_F",WALLS_CATEGORY,              false, [0, [0,5,1]]],   
		[1000, "BlockConcrete_F",WALLS_CATEGORY,                   false, [0, [0,8,0.5]]],
		[1200, "Box_NATO_AmmoVeh_F",STORAGE_CATEGORY,                false, [0, [0,3,1]]],
		[2500, "B_HMG_01_high_F",TURRETS_CATEGORY,   false, [0, [0.25,2,2]], true],
		[3000, "Land_BagBunker_Small_F",BUNKERS_CATEGORY,            false, [180, [0,4,1]]],
		[4500, "Land_PillboxBunker_01_hex_F",BUNKERS_CATEGORY,       false, [90, [0,4,1]]],
		[6000, "Land_Cargo_Patrol_V3_F",TOWERS_CATEGORY,            false, [180, [0,6,5]]],
		[7500, "B_HMG_01_A_F",TURRETS_CATEGORY,                      true,  [180, [0.25,2,2]], true],
		[9500, "Land_Bunker_01_Small_F",BUNKERS_CATEGORY,            false, [180, [0.5,6,0]]],
		[100, "Land_Razorwire_F",OBSTACLES_CATEGORY,                   false, [0, [0,3,1]]],
		[100, "Land_CncBarrier_F",WALLS_CATEGORY,                  false, [0, [0,3,1]]],
		[200, "Land_CncBarrierMedium_F",WALLS_CATEGORY,            false, [0, [0,3,1]]],
		[400, "Land_HBarrierWall_corridor_F",WALLS_CATEGORY,       false, [90, [0,5,1]]],
		[100, "Land_CzechHedgehog_01_new_F",OBSTACLES_CATEGORY,        false, [0, [0,3,1]]]
	];

	BLWK_fnc_popList = {
		params ["_tv"];

		private _categoriesList = [];

		private ["_displayName_temp","_category_temp","_value","_class","_categoryIndex","_itemIndex","_itemPath","_itemText"];
		BLWK_buildableObjects_array apply {
			_value = _x select 0;
			_class = _x select 1;
			
			_category_temp = _x select 2;
			_categoryIndex = _categoriesList findIf {_x == _category_temp};
			if (_categoryIndex isEqualTo -1) then {
				_categoryIndex = _tv tvAdd [[],_category_temp];
				_categoriesList pushBack _category_temp;
			};

			_displayName_temp = [configFile >> "cfgVehicles" >> _class] call BIS_fnc_displayName;
			// add item to list
			_itemText = format ["%1 - %2",_value,_displayName_temp];
			_itemIndex = _tv tvAdd [[_categoryIndex],_itemText];
			
			_itemPath = [_categoryIndex,_itemIndex];
			_tv tvSetValue [_itemPath,_value];
			_tv tvSetTooltip [_itemPath,_class];		
		};

	};
	#define BLWK_SHOP_PREVIEW_IDC 97918
	BLWK_fnc_exitMouseEvent = {
		params ["_tv"];

		// find out if something is currently selected
		private _fn_setImagePathDefault = {
			_imagePath = "preview.paa";
		};
		private _path = tvCurSel _tv;
		private "_imagePath";
		if (_path isEqualTo []) then {
			call _fn_setImagePathDefault; // go to default image if nothing selected
		} else {
			private _class = _tv tvToolTip _path;
			if (_class isEqualTo "") then { // in the event that the selected item is a category
				call _fn_setImagePathDefault;
			} else {
				_imagePath = getText (configFile >> "CfgVehicles" >> _class >> "editorPreview");
			};
		};
		
		private _display = ctrlParent _tv;
		private _imageCtrl = _display displayCtrl BLWK_SHOP_PREVIEW_IDC;
		_imageCtrl ctrlSetText _imagePath;
	};
	BLWK_fnc_onMouseMoveEvent = {
		params ["_tv","_path"];

		private _fn_setImagePathDefault = {
			_imagePath = "preview.paa";
		};
		private _class = _tv tvToolTip _path;
		private "_imagePath";
		if (_class isEqualTo "") then { // check if what we're over is a category
			_path = tvCurSel _tv;
			_class = _tv tvToolTip _path;
			if (_class isEqualTo "") then { // check if something is selected
				call _fn_setImagePathDefault;
			} else {
				_imagePath = getText (configFile >> "CfgVehicles" >> _class >> "editorPreview");
			};
		} else {
			_imagePath = getText (configFile >> "CfgVehicles" >> _class >> "editorPreview");
		};

		private _display = ctrlParent _tv;
		private _imageCtrl = _display displayCtrl BLWK_SHOP_PREVIEW_IDC;
		_imageCtrl ctrlSetText _imagePath;
	};
*/