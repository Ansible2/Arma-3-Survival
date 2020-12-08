#define FACTION_COUNT \
	0,\
	1,\
	2,\
	3,\
	4,\
	5,\
	6,\
	7,\
	8,\
	9,\
	10,\
	11,\
	12,\
	13,\
	14,\
	15,\
	16,\
	17,\
	18,\
	19,\
	20,\
	21,\
	22,\
	23,\
	24,\
	25,\
	26,\
	27,\
	28,\
	29,\
	30,\
	31,\
	32,\
	33,\
	34,\
	35,\
	36,\
	37,\
	38,\
	39,\
	40,\
	41,\
	42,\
	43,\
	44,\
	45,\
	46,\
	47,\
	48,\
	49,\
	50,\
	51,\
	52,\
	53,\
	54,\
	55,\
	56,\
	57,\
	58,\
	59,\
	60,\
	61,\
	62,\
	63,\
	64,\
	65,\
	66

#define FACTION_STRINGS \
	"VANILLA - NATO", \
	"VANILLA - AAF", \
	"VANILLA - FIA", \
	"VANILLA - CSAT", \
	"VANILLA - CSAT URBAN", \
	"APEX - NATO PACIFIC", \
	"APEX - CTRG PACIFIC", \
	"APEX - CSAT PACIFIC", \
	"APEX - VIPER", \
	"APEX - VIPER PACIFIC", \
	"APEX - SYNDIKAT", \
	"CONTACT - NATO WOODLAND", \
	"CONTACT - LDF", \
	"CONTACT - Spetznas", \
	"OPTRE - UNSC Marines", \
	"OPTRE - ODSTs", \
	"OPTRE - UNSC Army Snow", \
	"OPTRE - United Rebel Front", \
	"OPTRE - Battle Jumpers Urban", \
	"OPTRE - Insurgents", \
	"OPTRE FC - Covenant", \
	"OPCAN - Colonial Guard Corps", \
	"OPCAN - UNSC Army Desert", \
	"OPCAN - UNSC Army Woodland", \
	"OPCAN - UNSC Marine CE-A", \
	"OPCAN - UNSC Marine Desert", \
	"OPCAN - UNSC Marine Infinite", \
	"OPCAN - UNSC Marine Woodland", \
	"OPCAN - United Rebel Army", \
	"OPCAN - Koslovics", \
	"OPCAN - Fridens Woodland", \
	"OPCAN - Fridens Desert", \
	"OPCAN - Fridens", \
	"OPCAN - Colonial Military Authority", \
	"OPCAN - Colonial Police Force", \
	"RHS AFRF - Russia MSV (EMR)", \
	"RHS AFRF - Russia MSV (Flora)", \
	"RHS AFRF - Russia VDV (EMR)", \
	"RHS AFRF - Russia VDV (EMR-Des)", \
	"RHS AFRF - Russia VDV (Flora)", \
	"RHS AFRF - Russia VDV (M-Flora)", \
	"RHS AFRF - Russia VDV (RECON)", \
	"RHS AFRF - Russia VMF (RECON)", \
	"RHS AFRF - Russia VMF (Flora)", \
	"RHS AFRF - Russia VMF (OSN)", \
	"RHS GREF - Horizon Islands Defence Force", \
	"RHS GREF - CDF Guard", \
	"RHS GREF - CDF Paratroopers", \
	"RHS GREF - CDF", \
	"RHS GREF - ChDKZ", \
	"RHS GREF - TLA", \
	"RHS USAF - US ARMY (Desert)", \
	"RHS USAF - US ARMY (Desert CRYE)", \
	"RHS USAF - US ARMY (Woodland)", \
	"RHS USAF - US ARMY (Woodland CRYE)", \
	"RHS USAF - MARSOC", \
	"RHS USAF - USMC RECON (Desert)", \
	"RHS USAF - USMC Infantry (Desert)", \
	"RHS USAF - USMC Infantry (Woodland)", \
	"RHS USAF - USMC RECON (Woodland)", \
	"Zombies & Demons - Brittle Crawlers", \
	"Zombies & Demons - Demons", \
	"Zombies & Demons - Fast Zombies", \
	"Zombies & Demons - Medium Zombies", \
	"Zombies & Demons - Slow Zombies", \
	"Zombies & Demons - Spider Zombies", \
	"Zombies & Demons - Walkers"

#define FACTION_VARS \
[ \
	NATO_UNITS, \
	AAF_UNITS, \
	FIA_UNITS, \
	CSAT_UNITS, \
	CSAT_URBAN_UNITS, \
	NATO_PACIFIC_UNITS, \
	CTRG_PACIFIC_UNITS, \
	CSAT_PACIFIC_UNITS, \
	VIPER_UNITS, \
	VIPER_PACIFIC_UNITS, \
	SYNDIKAT_UNITS, \
	NATO_WOODLAND_UNITS, \
	LDF_UNITS, \
	SPETZNAS_CONTACT_UNITS, \
	OPTRE_MARINE_UNITS, \
	OPTRE_ODST_UNITS, \
	OPTRE_ARMY_SNOW_UNITS, \
	OPTRE_URF_UNITS, \
	OPTRE_BATTLEJUMPERS_URBAN_UNITS, \
	OPTRE_INSURGENTS_UNITS, \
	OPTRE_COVENANT_UNITS, \
	OPCAN_CGC_UNITS, \
	OPCAN_ARMY_D_UNITS, \
	OPCAN_ARMY_WDL_UNITS, \
	OPCAN_MARINE_CEA_UNITS, \
	OPCAN_MARINE_DES_UNITS, \
	OPCAN_MARINE_INF_UNITS, \
	OPCAN_MARINE_WDL_UNITS, \
	OPCAN_URA_UNITS, \
	OPCAN_KOSLOVICS_UNITS, \
	OPCAN_FRIDENS_WDL_UNITS, \
	OPCAN_FRIDENS_DES_UNITS, \
	OPCAN_FRIDENS_UNITS, \
	OPCAN_CMA_UNITS, \
	OPCAN_CPF_UNITS, \
	RHS_AFRF_RUS_MSV_EMR_UNITS, \
	RHS_AFRF_RUS_MSV_FLORA_UNITS, \
	RHS_AFRF_RUS_VDV_EMR_UNITS, \
	RHS_AFRF_RUS_VDV_EMR_DES_UNITS, \
	RHS_AFRF_RUS_VDV_FLORA_UNITS, \
	RHS_AFRF_RUS_VDV_MFLORA_UNITS, \
	RHS_AFRF_RUS_VDV_RECON_UNITS, \
	RHS_AFRF_RUS_VMF_RECON_UNITS, \
	RHS_AFRF_RUS_VMF_FLORA_UNITS, \
	RHS_AFRF_RUS_VV_OSN_UNITS, \
	RHS_GREF_HIDF,\
	RHS_GREF_CDF_GUARD,\
	RHS_GREF_CDF_PARA,\
	RHS_GREF_CDF,\
	RHS_GREF_ChDKZ,\
	RHS_GREF_TLA,\
	RHS_USF_ARMY_DES_UNITS, \
	RHS_USF_ARMY_DES_CRYE_UNITS, \
	RHS_USF_ARMY_WOODLAND_UNITS, \
	RHS_USF_ARMY_WOODLAND_CRYE_UNITS, \
	RHS_USF_MARSOC_UNITS, \
	RHS_USF_USMC_DES_RECON_UNITS, \
	RHS_USF_USMC_DES_UNITS, \
	RHS_USF_USMC_WOODLAND_UNITS, \
	RHS_USF_USMC_WOODLAND_RECON_UNITS, \
	ZND_BRITLLE_CRAWLERS, \
	ZND_DEMONS, \
	ZND_FAST, \
	ZND_MEDIUM, \
	ZND_SLOW, \
	ZND_SPIDERS, \
	ZND_WALKERS \
]