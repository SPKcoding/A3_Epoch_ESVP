/*
	Title:				SPK_ESVP
	Author:				Sp4rkY [https://github.com/SPKcoding]
	Description:		Extended Safezones with Vehicle Protection for Arma 3 Epoch
	Version:			0.89
	Required:			Arma3 1.66+ / Epoch 0.4+
	File:				config.cpp (clientside config)
____________________________________________________________________________________________________________________________________________________________________________________________________________________*/


class CfgESVP {
	class safezones {															/* Define your safezones here. Can be as many as you want. (no comma after the last entry)											*/
		_defineSafezones[] = {													/* "ID": name of safezone (used for systemChat & accessGUI) | [x,y,z]: coordinates of safezone | rad: radius in meters (Number) 	*/
							{"WEST",	{6190.38,16842.4,0}, 250},				/* {"ID", {x,y,z}, rad},																											*/
							{"CENTER",	{13335.2,14508.6,0}, 250},				/* {"ID", {x,y,z}, rad},																											*/
							{"EAST",	{18461.1,14269.3,0}, 250}				/* {"ID", {x,y,z}, rad}																												*/
		};
	};
	class options {
		_showNotes 			= true;												/* Show notifications (CfgNotifications) for entering/leaving the safezones															*/
		_showChatMsg 		= true;												/* Show systemChat messages for entering/leaving the safezones																		*/
		_useInfoMsg 		= true;												/* Show info messages while entering a safezone (true/false) 																		*/
		_useVehProt 		= true;												/* Use vehicle protection (if true, only owners can access their vehicles and it´s inventory in safezones)							*/
		_restrictDrv		= true;												/* Restrict driver seat to vehicle owner only [only if _useVehProt=true]															*/
		_useRestDrvMsg		= true;												/* Show systemChat message if joined driver seat [only if _restrictDrv=true]														*/
		_useVehLifted		= true;												/* Use check for lifted vehicles (similar to '_useVehProt' but for lifted/slingloaded vehicles) [only if _useVehProt=true]			*/
		_useSlingMsg		= true;												/* Show info messages while lifting prohibited vehicles in safezone [only if _useVehLifted=true] 									*/
		_useAccessGUI		= true;												/* Use "Access-Menu" for the driver (gain access to others to the vehicle while in safezone) [only if "_useVehProt=true"]			*/
		_usePlayerTP		= false;											/* Teleport players out of safezones at server restart to a random place in given min and max range									*/
		_pPlacePlrTP		= false;											/* Teleport players away from the parking place (if used in serverside settings) at server restart [only if "_usePlayerTP=true"]	*/
		_minRangePlrTP		= 250;												/* Minimum Range in meters the player is teleported to (should be minimum the same as the highest safezone radius) 					*/
		_maxRangePlrTP		= 350;												/* Maximum Range in meters the player is teleported to (have to be higher than "_minRangePlrTP")									*/
		_allowMelee			= false;											/* Enable|Disable melee weapons in safezones (hatchet, sledgehammer, chainsaw) [requires changes in EPOCH_fnc_playerFired.sqf]		*/
	};
	class messages {
		class notes {															/* If (_showNotes=true) customise your notification messages below. (between the quotes "")											*/
			_enter[] 		= {"EnterSZ",{"You entered a Safezone!"}};			/* first: template-name (has to be the same as defined in CfgNotifications) | second: text you want to show (for entering the SZ)	*/
			_leave[] 		= {"LeaveSZ",{"You leave the Safezone!"}};			/* first: template-name (has to be the same as defined in CfgNotifications) | second: text you want to show (for leaving the SZ)	*/
		};
		class chat {
			_chatMsgEnter 	= "[INFO] YOU ENTERED SAFEZONE:";					/* systemChat message for entering a safezone between the quotes ""	(name of safezone is automatically added)						*/
			_chatMsgLeave 	= "[INFO] YOU LEAVED SAFEZONE:";					/* systemChat message for leaving a safezone between the quotes "" (name of safezone is automatically added)						*/
			_restDrvMsg		= "[INFO] DRIVER-SEAT IS RESTRICTED TO THE OWNER";	/* systemChat message while getting ejected from driver seat [only if _restrictDrv=true]											*/
		};
		class info {
			_infoMsg1 		= "safezone: access only to your own vehicle!";		/* Info message while entering a safezone (if _useVehProt=true) [Fires only if _useInfoMsg=true]									*/
			_infoMsg2		= "safezone: take care of your vehicle!";			/* Info message while entering a safezone (if _useVehProt=false) [Fires only if _useInfoMsg=true] 									*/
			_slingMsgOwnr	= "prohibited: you are not the owner!";				/* Info message while rope gets deleted if you are not the owner of the vehicle you want to lift [only if _useVehLifted=true] 		*/
			_slingMsgSteal	= "prohibited: vehicle wasn´t purchased by you!"; 	/* Info message while rope gets deleted if you have not purchased the vehicle you want to lift [only if _useVehLifted=true] 		*/
		};
	};
	class debug {
		_debugLog			= false;											/* Speaks for itself, right? (clientside RPT-log) [recommended: false, use it only if you have to]									*/
	};
};
#include "ctrl\gui.h"
