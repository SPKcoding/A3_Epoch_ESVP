class SPKcode_client {
	tag = "SPK";

	//ESVP
	class SPK_ESVP {
		file = "SPKcode\ESVP\ctrl";
		class ESVP_feedCtrl {};
		class ESVP_getData {};
		class ESVP_giveAccess {};
		class ESVP_clearReg {};
		class ESVP_checkCrew {};
		class markers {file = "SPKcode\ESVP\setMarkers.sqf";postInit=1;};
		class init {file = "SPKcode\ESVP\init.sqf";postInit=1;};
	};
};
