disableSerialization;
_dsp = uiNamespace getVariable 'SPK_ESVP_dialog';
if !(isNull _dsp)then{
	_ctrl = _dsp displayCtrl 1;
	_lbText = _ctrl lbText (_this select 1);
	_data = _ctrl getVariable['ListData',[]];
	_plr = _data select (_this select 1);
	_data deleteAt (_data find _plr);
	_ctrl lbDelete (_this select 1);
	_ctrl = _dsp displayCtrl 2;
	_data = _ctrl getVariable ['ListData',[]];
	_data pushBack _plr;
	_ctrl setVariable ['ListData',_data];
	_ctrl lbAdd _lbText;
	if !(_data isEqualTo [])then{
		_idc3 = _dsp displayCtrl 3;
		_idc3 ctrlEnable true
	}
};
true
