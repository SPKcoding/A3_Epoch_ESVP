if(getNumber(configFile >> "CfgESVP" >> "_usePplaceMrk") isEqualTo 1)then{
	_mrkSize = getNumber(configFile >> "CfgESVP" >> "_pPlaceSize");
	_mrk = createMarker ["pPlaceESVG",getArray(configFile >> "CfgESVP" >> "_pPlaceCoords")];
	_mrk setMarkerShape "ELLIPSE";
	_mrk setMarkerSize [_mrkSize,_mrkSize];
	_mrk setMarkerBrush "DiagGrid";
	_mrk setMarkerColor "ColorBlue";
	_mrkT = createMarker ["pPlaceESVGtext",getArray(configFile >> "CfgESVP" >> "_pPlaceCoords")];
	_mrkT setMarkerShape "ICON";
	_mrkT setMarkerSize [0.5,0.5];
	_mrkT setMarkerType "mil_dot";
	_mrkT setMarkerColor "ColorBlue";
	_mrkT setMarkerText (getText(configFile >> "CfgESVP" >> "_pPlaceMrkText"))
};
{
	createVehicle ["Land_HelipadEmpty_F",_x,[],0,"CAN_COLLIDE"]
}forEach (getArray(configFile >> "CfgESVP" >> "_pLotArr"));
true