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
		class init {
			file = "SPKcode\ESVP\ESVP_init.sqf";
			postInit=1;
		};
	};
	
};
