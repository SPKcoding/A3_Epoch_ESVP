/*
	Title:			SPK_ESVP
	Author: 		Sp4rkY [https://github.com/SPKcoding]
	Description:	Extended Safezones with Vehicle Protection for Arma 3 Epoch
	Version:		0.915
	Required:		Arma 3 1.66+ / Epoch 0.4+
	File:			settings.h (serverside config)
_______________________________________________________________________________________________________________________________________________________________________________________________ */


_useRestartVehTP	= 1;								/* Enable/Disable Teleporting of vehicles out of safezones at serverstart (0: disabled | 1: enabled)									*/
_tpStyle			= 0;								/* Variant of teleporting (0: Teleport x-meters out of safezones [_tpRangeMin & _tpRangeMax] | 1: Teleport to static parking place)		*/
_tpRangeMin			= 200;								/* Minimum range (not needed if _tpStyle = 1)																							*/
_tpRangeMax			= 350;								/* Maximum range (not needed if _tpStyle = 1)																							*/
_safezoneCoords[] 	= {									/* Define your safezones here. (no comma after the last entry | !!! HAS TO BE THE SAME AS CLIENTSIDE CONFIG !!!)						*/
						{{6190.38,16842.4,0}, 250},		/* {{x,y,z}, radius} 																													*/
						{{13335.2,14508.6,0}, 250},
						{{18461.1,14269.3,0}, 250}
};
_unlockAfterVehTP	= 1;								/* Set lock state of teleported vehicles (0: no changes | 1: unlocked)																	*/
_clearAntags		= 1;								/* Enable/Disable removing of antagonists (UAV, Sappers, Snakes, Cultists) in safezones (0: disabled | 1: enabled)						*/
_antagClasses[]		= {									/* Classnames of antagonists you want to clear in safezones (no comma after the last entry)												*/
						"I_UAV_01_F",
						"Epoch_SapperB_F",
						"Epoch_Sapper_F",
						"Snake_Random_EPOCH",
						"Epoch_Cloak_F",
						"GreatWhite_F",
						"PHANTOM",
						"EPOCH_RyanZombie_1",
						"EPOCH_RyanZombie_2",
						"EPOCH_RyanZombie_3",
						"EPOCH_RyanZombie_4",
						"EPOCH_RyanZombie_5"
};
_checkWater			= 1;								/* Enable/Disable check for ships/boats in the safezones (0: disabled | 1: enabled) [should be set to 0 if using a map without water] 	*/

/***   Below only needed if _tpStyle = 1 is used   ***/
_usePplaceMrk		= 1;								/* Enable/Disable map-marker of Parking Place (0: disabled | 1: enabled)																*/
_pPlaceCoords[] 	= {23373.018,17737.408,3.1900001};	/* {x,y,z} Coordinates of Parking Place Marker 	(IMPORTANT: has to be the middle of the parking place addition)							*/
														/* 												(RECOMMENDATION: you should set a "no building area" for this!)							*/

_pPlaceSize			= 300;								/* Size of Parking Place Marker	(radius)																								*/
_pPlaceMrkText		= "Global Parking Place";			/* Markertext of Parking Place map-marker																								*/
_pPlaceVehDir		= 0;								/* Direction of all ported vehicles in every parking lot (Number)																		*/

_pLotArr[]			= {									/* Array with coordinates of Parking Lots (NO COMMA AFTER THE LAST ENTRY)																*/
						{23226.6,17551.3,0},			/* {x,y,z} coords of "Land_HelipadEmpty_F"																								*/
						{23225.3,17581.5,0},			/* {x,y,z} coords of "Land_HelipadEmpty_F"																								*/
						{23224.6,17625.2,0},			/* {x,y,z} coords of "Land_HelipadEmpty_F"																								*/
						{23249.2,17656.9,0},			/* ...																																	*/
						{23223.3,17655.4,0},
						{23222.7,17701.9,0},
						{23248.9,17703.2,0},
						{23247.2,17733.6,0},
						{23221.4,17732.1,0},
						{23252.8,17552.7,0},
						{23278.4,17553.2,0},
						{23276.6,17583.2,0},
						{23251.1,17583,0},
						{23250.8,17626.6,0},
						{23276.5,17627.1,0},
						{23274.7,17657.1,0},
						{23274.5,17703.8,0},
						{23272.7,17733.8,0},
						{23305.4,17553.3,0},
						{23304.6,17583.5,0},
						{23303.5,17627.2,0},
						{23302.7,17657.4,0},
						{23301.5,17703.9,0},
						{23300.7,17734,0},
						{23332.4,17554.3,0},
						{23331,17584.5,0},
						{23330.5,17628.2,0},
						{23329.1,17658.4,0},
						{23328.5,17704.9,0},
						{23327.1,17735.1,0},
						{23361.4,17554.9,0},
						{23360.6,17585.3,0},
						{23359.4,17628.8,0},
						{23358.7,17659.1,0},
						{23357.5,17705.5,0},
						{23356.7,17735.8,0},
						{23390.2,17555.6,0},
						{23389.1,17585.9,0},
						{23388.2,17629.5,0},
						{23387.2,17659.8,0},
						{23386.3,17706.2,0},
						{23385.2,17736.5,0},
						{23416.7,17556.6,0},
						{23416.2,17586.9,0},
						{23414.8,17630.5,0},
						{23414.3,17660.8,0},
						{23412.8,17707.2,0},
						{23412.3,17737.5,0},
						{23442.6,17557.1,0},
						{23441.8,17587.1,0},
						{23440.7,17631,0},
						{23439.8,17660.9,0},
						{23438.7,17707.7,0},
						{23437.8,17737.6,0},
						{23468.9,17558,0},
						{23467.5,17587.8,0},
						{23467,17631.8,0},
						{23465.6,17661.7,0},
						{23465,17708.5,0},
						{23463.6,17738.4,0}
};

_debugLog			= false;							/* Speaks for itself, right? (serverside RPT-log) [recommended: false, use it only if you have to]										*/