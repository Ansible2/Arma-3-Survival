#ifndef KISKA_styles
    #define KISKA_styles 1

    // Static styles
    #define KISKA_ST_POS            0x0F
    #define KISKA_ST_HPOS           0x03
    #define KISKA_ST_VPOS           0x0C
    #define KISKA_ST_LEFT           0x00
    #define KISKA_ST_RIGHT          0x01
    #define KISKA_ST_CENTER         0x02
    #define KISKA_ST_DOWN           0x04
    #define KISKA_ST_UP             0x08
    #define KISKA_ST_VCENTER        0x0C

    #define KISKA_ST_TYPE           0xF0
    #define KISKA_ST_SINGLE         0x00
    #define KISKA_ST_MULTI          0x10
    #define KISKA_ST_TITLE_BAR      0x20
    #define KISKA_ST_PICTURE        0x30
    #define KISKA_ST_FRAME          0x40
    #define KISKA_ST_BACKGROUND     0x50
    #define KISKA_ST_GROUP_BOX      0x60
    #define KISKA_ST_GROUP_BOX2     0x70
    #define KISKA_ST_HUD_BACKGROUND 0x80
    #define KISKA_ST_TILE_PICTURE   0x90
    #define KISKA_ST_WITH_RECT      0xA0
    #define KISKA_ST_LINE           0xB0
    #define KISKA_ST_UPPERCASE      0xC0
    #define KISKA_ST_LOWERCASE      0xD0

    #define KISKA_ST_SHADOW         0x100
    #define KISKA_ST_NO_RECT        0x200
    #define KISKA_ST_KEEP_ASPECT_RATIO  0x800

    // Slider styles
    #define KISKA_SL_DIR            0x400
    #define KISKA_SL_VERT           0
    #define KISKA_SL_HORZ           0x400

    #define KISKA_SL_TEXTURES       0x10

    // progress bar
    #define KISKA_ST_VERTICAL       0x01
    #define KISKA_ST_HORIZONTAL     0

    // Listbox styles
    #define KISKA_LB_TEXTURES       0x10
    #define KISKA_LB_MULTI          0x20

    // Tree styles
    #define KISKA_TR_SHOWROOT       1
    #define KISKA_TR_AUTOCOLLAPSE   2
#endif