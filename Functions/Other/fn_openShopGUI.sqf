if (!hasInterface) exitWith {};

disableSerialization;

#define SUPPORT_DISH_NOT_FOUND_MESSAGE(CTRL)\
	CTRL lbAdd " ";\
  CTRL lbAdd "";\
  CTRL lbAdd "         A Satellite Dish must be found";\
  CTRL lbAdd "             to unlock Support Menu"; 

#define PRICE_NAME_FORMAT "%1 - %2"


createDialog "bulwarkShopDialog";
waitUntil {!isNull (findDisplay 9999);};


// buildable objects
private _buildableObjectsControl = (findDisplay 9999) displayCtrl 1500;
BLWK_buildableObjects_array apply {
  _buildableObjectsControl lbAdd format [PRICE_NAME_FORMAT, _x select 0, _x select 1];
};

// show buildable object preview
((findDisplay 9999) displayCtrl 1500) ctrlAddEventHandler ['LBSelChanged', {
  private _currentlySelectedIndex = lbCurSel 1500;
  private _previewPic = getText (configFile >> "CfgVehicles" >> ((BLWK_buildableObjects_array select _currentlySelectedIndex) select 2) >> "editorPreview");

  ctrlSetText [1502, _previewPic];
}];


// supports
private _supportsControl = (findDisplay 9999) displayCtrl 1501;
// if support dish was found, display purachasable support, else show message
if (BLWK_supportDishFound) then {
  BLWK_supports_array apply {
    _supportsControl lbAdd format [PRICE_NAME_FORMAT, _x select 0, _x select 1];
  };
} else {
  SUPPORT_DISH_NOT_FOUND_MESSAGE(_supportsControl);
};