#include "supportDefines.hpp"

#define SUPPORT_CURSOR "\a3\Ui_f\data\IGUI\Cfg\Cursors\iconCursorSupport_ca.paa"
#define ARTILLERY_ICON "\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\artillery_ca.paa"
#define ATTACK_ICON "\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\attack_ca.paa"
#define CALL_ICON "\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\call_ca.paa"
#define CAS_ICON "\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\cas_ca.paa"
#define CAS_HELI_ICON"\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\casheli_ca.paa"
#define DEFEND_ICON "\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\defend_ca.paa"
#define INTRUCTOR_ICON "\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\instructor_ca.paa"
#define MORTAR_ICON "\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\mortar_ca.paa"
#define SUPPLY_DROP_ICON "\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\supplydrop_ca.paa"
#define TRANSPORT_ICON "\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\transport_ca.paa"

#define CALL_SUPPORT_MASTER(CLASS) "[_this select 0,_this select 1,"#CLASS"] call BLWK_fnc_callingForSupportMaster"

/*
// expression arguments

[caller, pos, target, is3D, id]
    caller: Object - unit which called the item, usually player
    pos: Array in format Position - cursor position
    target: Object - cursor target
    is3D: Boolean - true when in 3D scene, false when in map
    id: String - item ID as returned by BIS_fnc_addCommMenuItem function
*/

class basicSupport
{
    text = "I'm a support!";
    subMenu = "";
    expression = "";
    icon = CALL_ICON;
    curosr = SUPPORT_CURSOR;
    enable = "1";
    removeAfterExpressionCall = 1;
};

// cruise missile
class CRUISE_MISSILE_CLASS : basicSupport
{
    text = CRUISE_MISSILE_TEXT;
    expression = CALL_SUPPORT_MASTER(CRUISE_MISSILE_CLASS);
    icon = CAS_ICON;
};

// 155 artillery
class ARTILLERY_STRIKE_155MM_HE_CLASS : basicSupport
{
    text = ARTILLERY_STRIKE_155MM_HE_TEXT;
    expression = CALL_SUPPORT_MASTER(ARTILLERY_STRIKE_155MM_HE_CLASS);
    icon = ARTILLERY_ICON;
};
class ARTILLERY_STRIKE_155MM_CLUSTER_CLASS : basicSupport
{
    text = ARTILLERY_STRIKE_155MM_CLUSTER_TEXT;
    expression = CALL_SUPPORT_MASTER(ARTILLERY_STRIKE_155MM_CLUSTER_CLASS);
    icon = ARTILLERY_ICON;
};
class ARTILLERY_STRIKE_155MM_MINES_CLASS : basicSupport
{
    text = ARTILLERY_STRIKE_155MM_MINES_TEXT;
    expression = CALL_SUPPORT_MASTER(ARTILLERY_STRIKE_155MM_MINES_CLASS);
    icon = ARTILLERY_ICON;
};
class ARTILLERY_STRIKE_155MM_AT_MINES_CLASS : basicSupport
{
    text = ARTILLERY_STRIKE_155MM_AT_MINES_TEXT;
    expression = CALL_SUPPORT_MASTER(ARTILLERY_STRIKE_155MM_AT_MINES_CLASS);
    icon = ARTILLERY_ICON;
};

// mortars
class MORTAR_STRIKE_82MM_HE_CLASS : basicSupport
{
    text = MORTAR_STRIKE_82MM_HE_TEXT;
    expression = CALL_SUPPORT_MASTER(MORTAR_STRIKE_82MM_HE_CLASS);
    icon = MORTAR_ICON;
};
class MORTAR_STRIKE_82MM_SMOKE_CLASS : basicSupport
{
    text = MORTAR_STRIKE_82MM_SMOKE_TEXT;
    expression = CALL_SUPPORT_MASTER(MORTAR_STRIKE_82MM_SMOKE_CLASS);
    icon = MORTAR_ICON;
};
class MORTAR_STRIKE_82MM_FLARE_CLASS : basicSupport
{
    text = MORTAR_STRIKE_82MM_FLARE_TEXT;
    expression = CALL_SUPPORT_MASTER(MORTAR_STRIKE_82MM_FLARE_CLASS);
    icon = MORTAR_ICON;
};

// 120mm cannon
class CANNON_120MM_HE_CLASS : basicSupport
{
    text = CANNON_120MM_HE_TEXT;
    expression = CALL_SUPPORT_MASTER(CANNON_120MM_HE_CLASS);
    icon = ARTILLERY_ICON;
};
class CANNON_120MM_CLUSTER_CLASS : basicSupport
{
    text = CANNON_120MM_CLUSTER_TEXT;
    expression = CALL_SUPPORT_MASTER(CANNON_120MM_CLUSTER_CLASS);
    icon = ARTILLERY_ICON;
};
class CANNON_120MM_AT_MINES_CLASS : basicSupport
{
    text = CANNON_120MM_AT_MINES_TEXT;
    expression = CALL_SUPPORT_MASTER(CANNON_120MM_AT_MINES_CLASS);
    icon = ARTILLERY_ICON;
};
class CANNON_120MM_MINES_CLASS : basicSupport
{
    text = CANNON_120MM_MINES_TEXT;
    expression = CALL_SUPPORT_MASTER(CANNON_120MM_MINES_CLASS);
    icon = ARTILLERY_ICON;
};
class CANNON_120MM_SMOKE_CLASS : basicSupport
{
    text = CANNON_120MM_SMOKE_TEXT;
    expression = CALL_SUPPORT_MASTER(CANNON_120MM_SMOKE_CLASS);
    icon = ARTILLERY_ICON;
};


class SUPPLY_ARSENAL_DROP_CLASS : basicSupport
{
    text = SUPPLY_ARSENAL_DROP_TEXT;
    expression = CALL_SUPPORT_MASTER(SUPPLY_ARSENAL_DROP_CLASS);
    icon = ARTILLERY_ICON;
};




/*
class paraDrop
{
    text = "Paratroops";
    submenu = "";
    expression = "[_this select 0, _this select 1, 'paraTroop', 'B_T_VTOL_01_vehicle_F'] remoteExec ['killPoints_fnc_support', 2];";
    icon = "\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\attack_ca.paa";
    cursor = "\a3\Ui_f\data\IGUI\Cfg\Cursors\iconCursorSupport_ca.paa";
    enable = "1";
    removeAfterExpressionCall = 1;
};

class reconUAV
{
    text = "Recon UAV";
    submenu = "";
    expression = "[_this select 0, _this select 1, 'reconUAV', 'B_UAV_01_F'] remoteExec ['killPoints_fnc_support', 2];";
    icon = "\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\defend_ca.paa";
    cursor = "\a3\Ui_f\data\IGUI\Cfg\Cursors\iconCursorSupport_ca.paa";
    enable = "1";
    removeAfterExpressionCall = 1;
};

class airStrike
{
    text = "Missle CAS";
    submenu = "";
    expression = "[_this select 0, _this select 1, 'airStrike', 'B_Plane_CAS_01_DynamicLoadout_F'] remoteExec ['killPoints_fnc_support', 2];";
    icon = "\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\cas_ca.paa";
    cursor = "\a3\Ui_f\data\IGUI\Cfg\Cursors\iconCursorSupport_ca.paa";
    enable = "1";
    removeAfterExpressionCall = 1;
};

class ragePack
{
    text = "Rage Stimpack";
    submenu = "";
    expression = "[_this select 0, _this select 1, 'ragePack'] remoteExec ['killPoints_fnc_support', 2];";
    icon = "\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\transport_ca.paa";
    cursor = "\a3\Ui_f\data\IGUI\Cfg\Cursors\iconCursorSupport_ca.paa";
    enable = "1";
    removeAfterExpressionCall = 1;
};

class armaKart
{
    text = "ARMAKART TM";
    submenu = "";
    expression = "[_this select 0, _this select 1, 'armaKart'] remoteExec ['killPoints_fnc_support', 2];";
    icon = "\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\transport_ca.paa";
    cursor = "\a3\Ui_f\data\IGUI\Cfg\Cursors\iconCursorSupport_ca.paa";
    enable = "1";
    removeAfterExpressionCall = 1;
};

class mindConGas
{
    text = "Mind Control Gas";
    submenu = "";
    expression = "[_this select 0, _this select 1, 'mindConGas'] remoteExec ['killPoints_fnc_support', 2];";
    icon = "\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\call_ca.paa";
    cursor = "\a3\Ui_f\data\IGUI\Cfg\Cursors\iconCursorSupport_ca.paa";
    enable = "1";
    removeAfterExpressionCall = 1;
};

class droneControl
{
    text = "Predator Drone";
    submenu = "";
    expression = "[_this select 0, _this select 1, 'droneControl'] remoteExec ['killPoints_fnc_support', 2];";
    icon = "\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\cas_ca.paa";
    cursor = "\a3\Ui_f\data\IGUI\Cfg\Cursors\iconCursorSupport_ca.paa";
    enable = "1";
    removeAfterExpressionCall = 1;
};

class mineField
{
    text = "Mine Field";
    submenu = "";
    expression = "[_this select 0, _this select 1, 'mineField'] remoteExec ['killPoints_fnc_support', 2];";
    icon = "\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\Artillery_ca.paa";
    cursor = "\a3\Ui_f\data\IGUI\Cfg\Cursors\iconCursorSupport_ca.paa";
    enable = "1";
    removeAfterExpressionCall = 1;
};

class telePlode
{
    text = "Emergency Teleport";
    submenu = "";
    expression = "[_this select 0, _this select 1,'telePlode'] remoteExec ['killPoints_fnc_support', 2];";
    icon = "\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\transport_ca.paa";
    cursor = "\a3\Ui_f\data\IGUI\Cfg\Cursors\iconCursorSupport_ca.paa";
    enable = "1";
    removeAfterExpressionCall = 1;
};
*/