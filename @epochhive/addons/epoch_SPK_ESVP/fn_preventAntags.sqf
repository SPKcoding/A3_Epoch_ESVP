_getAntags = getArray(configFile >> "CfgESVP" >> "_antagClasses");
while{true}do{
	{_antags = (_x select 0) nearEntities[_getAntags,_x select 1];{deleteVehicle _x}forEach _antags}forEach _this;
	uiSleep 6
};
true
