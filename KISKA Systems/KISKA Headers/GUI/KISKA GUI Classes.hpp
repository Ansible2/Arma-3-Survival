#include "KISKA GUI Colors.hpp"
#include "KISKA GUI Grid.hpp"

class KISKA_RscCloseButton : RscButtonMenu
{
    idc = -1;
    text = "";
    x = KISKA_POS_X(7.5);
    y = KISKA_POS_Y(-10);
    w = KISKA_POS_W(1);
    h = KISKA_POS_H(1);
    colorText[] = KISKA_GREY_COLOR(0,1);
    colorActive[] = KISKA_GREY_COLOR(0,1);
    textureNoShortcut = "\A3\3den\Data\Displays\Display3DEN\search_END_ca.paa";
    class ShortcutPos
    {
        left = 0;
        top = 0;
        w = KISKA_POS_W(1);
        h = KISKA_POS_H(1);
    };
    animTextureNormal = "#(argb,8,8,3)color(1,0,0,0.57)";
    animTextureDisabled = "";
    animTextureOver = "#(argb,8,8,3)color(1,0,0,0.57)";
    animTextureFocused = "";
    animTexturePressed = "#(argb,8,8,3)color(1,0,0,0.57)";
    animTextureDefault = "";
};
