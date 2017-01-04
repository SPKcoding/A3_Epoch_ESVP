class CfgPatches {
	class epoch_SPK_ESVP {
		requiredAddons[] = {"A3_epoch_server","epoch_SPKcode_config"};
		fileName = "epoch_SPK_ESVP.pbo";
		requiredVersion = 1.66;
		version = "0.89";
		author[]= {"Sp4rkY"};
	};
};
class CfgESVP {
	#include "settings.h"
};
class CfgFunctions {
	class SPKcode_server {
		tag="SPK";
		class SPK_ESVP {
			file = "x\addons\epoch_SPK_ESVP";
			class ESVP_secureTP {};
			class ESVP_plrCheckPos {};
			class ESVP_loginCheck {};
			class preventAntags {};
			class parkingSpotAddition {};
			class parkingSpotOverhaul {};
			class initESVP_server {};
		};
	};
};
