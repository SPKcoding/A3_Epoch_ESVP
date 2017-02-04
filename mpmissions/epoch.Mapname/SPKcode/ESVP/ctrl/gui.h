class SPK_ESVP_PassengersGUI {
	idd = -1;
	onLoad = "uiNamespace setVariable['SPK_ESVP_dialog',_this select 0];_dsp = uiNamespace getVariable 'SPK_ESVP_dialog';_idc3=_dsp displayCtrl 3;_idc3 ctrlEnable false;_reg=_dsp displayCtrl 4;_idc5=_dsp displayCtrl 5;_idc5 ctrlEnable false;_var=vehicle player getVariable['vehOwners',nil];if(!isNil'_var')then{if((count _var > 1)&&(getPlayerUID player isEqualTo (_var select 0)))then{_idc5 ctrlEnable true;lbClear _reg;_res = vehicle player getVariable['RegNames',[]];if(!isNil'_res' && !(_res isEqualTo []))then{{_reg lbAdd _x}forEach _res}}};call SPK_fnc_ESVP_feedCtrl;'dynamicBlur' ppEffectEnable true;'dynamicBlur' ppEffectAdjust [0.5];'dynamicBlur' ppEffectCommit 0.5;setMousePosition [0.5,0.5];";
	onUnLoad = "uiNamespace setVariable['SPK_ESVP_dialog',displayNull];'dynamicBlur' ppEffectAdjust [0];'dynamicBlur' ppEffectCommit 0.2;setMousePosition [0.5,0.5];";
	class controls {
		class SPK_ESVP_PassengersGUI: SPK_RscText {
			text = "VEHICLE PASSENGER CONTROL";
			x = 6 * GUI_GRID_W + GUI_GRID_X;
			y = 0.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 28.1 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			colorText[] = {0,0,0,1};
			colorBackground[] = {1,0.749,0,0.95};
		};
		class SPK_ESVP_bg: SPK_RscText {
			x = 6.2 * GUI_GRID_W + GUI_GRID_X;
			y = 1.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 27.7 * GUI_GRID_W;
			h = 23 * GUI_GRID_H;
			colorBackground[] = {0,0,0,0.75};
		};
		class SPK_ESVP_lb: SPK_RscListbox {
			idc = 1;
			x = 7 * GUI_GRID_W + GUI_GRID_X;
			y = 5.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 12 * GUI_GRID_W;
			h = 7 * GUI_GRID_H;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 30) * 1)";
			style = "2+16";
			colorBackground[] = {0,0,0,0.6};
			colorSelect[] = {1,1,1,1};
			colorSelect2[] = {1,1,1,1};
			colorSelectBackground2[] = {-1,-1,-1,-1};
			colorSelectBackground[] = {-1,-1,-1,-1};
			onLBDblClick="call SPK_fnc_ESVP_getData;";
		};
		class SPK_ESVP_lbTitle: SPK_RscText {
			text = "PLAYERS";
			x = 7 * GUI_GRID_W + GUI_GRID_X;
			y = 4.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 12 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0.2,1};
			style = ST_CENTER;
			shadow = 0.5;
		};
		class SPK_ESVP_selected: SPK_RscListbox {
			idc = 2;
			x = 21 * GUI_GRID_W + GUI_GRID_X;
			y = 5.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 12 * GUI_GRID_W;
			h = 7 * GUI_GRID_H;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 30) * 1)";
			style = "2+16";
			colorBackground[] = {0,0,0,0.6};
			colorText[] = {0,0.9,0,1};
			colorSelect[] = {0,0.9,0,1};
			colorSelect2[] = {0,0.9,0,1};
			colorSelectBackground2[] = {-1,-1,-1,-1};
			colorSelectBackground[] = {-1,-1,-1,-1};
		};
		class SPK_ESVP_selectedTitle: SPK_RscText {
			text = "ACCESS";
			x = 21 * GUI_GRID_W + GUI_GRID_X;
			y = 4.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 12 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0.2,1};
			style = ST_CENTER;
			shadow = 0.5;
		};
		class SPK_ESVP_closeBtn: SPK_RscButton {
			text = "CANCEL";
			x = 17.5 * GUI_GRID_W + GUI_GRID_X;
			y = 13 * GUI_GRID_H + GUI_GRID_Y;
			w = 5 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,1};
			colorBackgroundActive[] = {0.9,0.9,0.9,1};
			action="closeDialog 0";
		};
		class SPK_ESVP_acceptBtn: SPK_RscButton {
			idc = 3;
			text = "ACCEPT";
			x = 25 * GUI_GRID_W + GUI_GRID_X;
			y = 13 * GUI_GRID_H + GUI_GRID_Y;
			w = 5 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,1};
			colorBackgroundActive[] = {0.9,0.9,0.9,1};
			onMouseButtonDown="call SPK_fnc_ESVP_giveAccess;closeDialog 0;['Successfully registered selected players.',5] call Epoch_message;";
		};
		class SPK_ESVP_cursor: SPK_RscText {
			text = ">>";
			x = 19.3 * GUI_GRID_W + GUI_GRID_X;
			y = 7.9 * GUI_GRID_H + GUI_GRID_Y;
			w = 1.4 * GUI_GRID_W;
			h = 1.2 * GUI_GRID_H;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0.75};
			style = ST_CENTER;
		};
		class SPK_ESVP_borderL: SPK_RscText {
			x = 6 * GUI_GRID_W + GUI_GRID_X;
			y = 1.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 0.2 * GUI_GRID_W;
			h = 23.1 * GUI_GRID_H;
			colorBackground[] = {1,0.749,0,0.95};
		};
		class SPK_ESVP_borderR: SPK_RscText {
			x = 33.9 * GUI_GRID_W + GUI_GRID_X;
			y = 1.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 0.2 * GUI_GRID_W;
			h = 23.1 * GUI_GRID_H;
			colorBackground[] = {1,0.749,0,0.95};
		};
		class SPK_ESVP_borderB: SPK_RscText {
			x = 6.2 * GUI_GRID_W + GUI_GRID_X;
			y = 24.46 * GUI_GRID_H + GUI_GRID_Y;
			w = 27.7 * GUI_GRID_W;
			h = 0.15 * GUI_GRID_H;
			colorBackground[] = {1,0.749,0,0.95};
		};
		class SPK_ESVP_credit: SPK_RscText {
			text = "©SPK";
			x = 30.9 * GUI_GRID_W + GUI_GRID_X;
			y = 0.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 3 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			colorText[] = {1,1,1,0.5};
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 30) * 0.9)";
			style = ST_RIGHT;
		};
		class SPK_ESVP_info: SPK_RscText {
			text = "Select players you want to grant access to your vehicle:";
			x = 10.5 * GUI_GRID_W + GUI_GRID_X;
			y = 2.6 * GUI_GRID_H + GUI_GRID_Y;
			w = 19.1 * GUI_GRID_W;
			h = 0.9 * GUI_GRID_H;
			colorText[] = {1,1,1,1};
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 30) * 0.9)";
			style = ST_CENTER;
		};
		class SPK_ESVP_lb_registered: SPK_RscListbox
		{
			idc = 4;
			x = 14 * GUI_GRID_W + GUI_GRID_X;
			y = 16 * GUI_GRID_H + GUI_GRID_Y;
			w = 12 * GUI_GRID_W;
			h = 6 * GUI_GRID_H;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 30) * 1)";
			style = "2+16";
			colorBackground[] = {0,0,0,0.6};
			colorText[] = {0,0.9,0,1};
			colorSelect[] = {0,0.9,0,1};
			colorSelect2[] = {0,0.9,0,1};
			colorSelectBackground2[] = {-1,-1,-1,-1};
			colorSelectBackground[] = {-1,-1,-1,-1};
		};
		class SPK_ESVP_lbTitle_registered: SPK_RscText {
			text = "REGISTERED";
			x = 14 * GUI_GRID_W + GUI_GRID_X;
			y = 15 * GUI_GRID_H + GUI_GRID_Y;
			w = 12 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0.2,1};
			style = ST_CENTER;
			shadow = 0.5;
		};
		class SPK_ESVP_clearBtn: SPK_RscButton {
			idc = 5;
			text = "CLEAR";
			x = 17.5 * GUI_GRID_W + GUI_GRID_X;
			y = 22.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 5 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,1};
			colorBackgroundActive[] = {0.9,0.9,0.9,1};
			action="call SPK_fnc_ESVP_clearReg;";
		};
		class SPK_ESVP_refreshBtn: SPK_RscButton {
			text = "REFRESH";
			x = 10 * GUI_GRID_W + GUI_GRID_X;
			y = 13 * GUI_GRID_H + GUI_GRID_Y;
			w = 5 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,1};
			colorBackgroundActive[] = {0.9,0.9,0.9,1};
			action="call SPK_fnc_ESVP_feedCtrl;";
		};
	};
};
