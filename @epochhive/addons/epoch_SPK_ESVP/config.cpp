class CfgPatches {
	class epoch_SPK_ESVP {
		requiredAddons[] = {"A3_epoch_server"};
		fileName = "epoch_SPK_ESVP.pbo";
		requiredVersion = 1.60;
		version = "0.436";
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
			class preventAntags {};
			class parkingSpotAddition {};
			class parkingSpotOverhaul {};
			class initESVP_server {postInit=1;};
		};
	};
};
