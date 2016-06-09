/*
	Title:			SPK_ESVP
	Author: 		Sp4rkY [https://github.com/SPKcoding]
	Description:	Extended Safezones with Vehicle Protection for Arma 3 Epoch
	Version:		0.443
	File:			config.sqf (clientside config)
_______________________________________________________________________________________________________________________________________________________________________________________________________ */


_defineSafezones = [													/* Define your safezones here. (no comma after the last entry)																	*/
//EXAMPLE: [ "NAME", [x,y,z], rad]										/* "NAME": name of safezone used for systemChat (no spaces) | [x,y,z]: coordinates of safezone | rad: radius in meters (Number) */
	["WEST",	[6190.38,16842.4,0],	250],							/* ["NAME", [x,y,z], radius] 																									*/
	["CENTER",	[13335.2,14508.6,0],	250],							/* ["NAME", [x,y,z], radius] 																									*/
	["EAST",	[18461.1,14269.3,0],	250],							/* ["NAME", [x,y,z], radius] 																									*/
	["SOUTH",	[10929.8,7623.15,0],	250]							/* ["NAME", [x,y,z], radius] 																									*/
];
showNotesESVP = true;													/* Enable/Disable notifications (CfgNotifications) for entering/leaving the safezones											*/
showNoteESVP={if(_this)then[{											/* If (_showNotification = true) customise your notification messages below. (between the quotes "")							*/
	["EnterSZ",["You entered a Safezone!"]]								/* first: template-name (has to be the same as defined in CfgNotifications) | second: text you want to show (can be anything)	*/ call BIS_fnc_showNotification},{
	["LeaveSZ",["You leave the Safezone!"]]								/* first: template-name (has to be the same as defined in CfgNotifications) | second: text you want to show (can be anything)	*/ call BIS_fnc_showNotification
}]};

showSystemchatESVP = true;												/* Enable/Disable systemChat messages for entering/leaving the safezones														*/
chatMsgEnter 	= "[INFO] YOU ENTERED SAFEZONE:";						/* systemChat message for entering a safezone between the quotes ""	(name of safezone is automatically added at the end)		*/
chatMsgLeave 	= "[INFO] YOU LEAVED SAFEZONE:";						/* systemChat message for leaving a safezone between the quotes "" (name of safezone is automatically added at the end)			*/

useVehProt 		= true;													/* Enable/Disable vehicle protection (if true, only owners can access their vehicles and it´s inventory in safezones)			*/
useInfoMsg 		= true;													/* Enable/Disable info messages (true/false) 																					*/
defineInfoMsg 	= "In safezones you only can access owned vehicles!";	/* Change the info message to your wishes (between the quotes)																	*/
