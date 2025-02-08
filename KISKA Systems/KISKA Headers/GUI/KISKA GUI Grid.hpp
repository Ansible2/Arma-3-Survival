#ifndef KISKA_GUI_GRID

    #define KISKA_GUI_GRID 1

    #define KISKA_UI_GRID_X (0.5)
    #define KISKA_UI_GRID_Y (0.5)
    #define KISKA_UI_GRID_W (2.5 * pixelW * pixelGrid)
    #define KISKA_UI_GRID_H (2.5 * pixelH * pixelGrid)

    #define KISKA_POS_X(N) N * KISKA_UI_GRID_W + KISKA_UI_GRID_X
    #define KISKA_POS_Y(N) N * KISKA_UI_GRID_H + KISKA_UI_GRID_Y
    #define KISKA_POS_W(N) N * KISKA_UI_GRID_W
    #define KISKA_POS_H(N) N * KISKA_UI_GRID_H

    #define KISKA_GUI_TEXT_SIZE(MULTIPLIER) (pixelH * pixelGrid) * MULTIPLIER

#endif
