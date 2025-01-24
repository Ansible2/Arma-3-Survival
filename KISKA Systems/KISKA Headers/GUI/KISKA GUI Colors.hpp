#ifndef KISKA_COLORS

	#define KISKA_COLORS 1

	#define KISKA_PROFILE_BACKGROUND_COLOR(ALPHA)\
	{\
		"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.13])",\
		"(profilenamespace getvariable ['GUI_BCG_RGB_G',0.54])",\
		"(profilenamespace getvariable ['GUI_BCG_RGB_B',0.21])",\
		ALPHA\
	}

    #define KISKA_GREY_COLOR(PERCENT,ALPHA) {PERCENT,PERCENT,PERCENT,ALPHA}

#endif
