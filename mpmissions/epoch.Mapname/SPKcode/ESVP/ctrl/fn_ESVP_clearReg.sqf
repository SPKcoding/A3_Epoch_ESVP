disableSerialization;
_dsp = uiNamespace getVariable 'SPK_ESVP_dialog';
_reg = _dsp displayCtrl 4;
lbClear _reg;
vehicle player setVariable['vehOwners',[getPlayerUID player],true];
vehicle player setVariable['RegNames',[],true];
_crew = crew vehicle player;
{if(_x != driver vehicle player)then{_x Action['GetOut',vehicle player]}}forEach _crew;
true
