if(getText(missionConfigFile >> 'CfgESVP' >> 'options' >> '_useMarkers') isEqualTo str(true))then{
	_zones = getArray(missionConfigFile >> 'CfgESVP' >> 'safezones' >> '_defineSafezones');
    _col1 = getText(missionConfigFile >> 'CfgESVP' >> 'markers' >> '_mainColor');
    _col2 = getText(missionConfigFile >> 'CfgESVP' >> 'markers' >> '_textColor');
    _type = getText(missionConfigFile >> 'CfgESVP' >> 'markers' >> '_textMrkType');
    _brush = getText(missionConfigFile >> 'CfgESVP' >> 'markers' >> '_brush') isEqualTo str(true);
    _style = getText(missionConfigFile >> 'CfgESVP' >> 'markers' >> '_brushStyle');
    _unique = getText(missionConfigFile >> 'CfgESVP' >> 'markers' >> '_useUniqueName') isEqualTo str(true);
    _uName = getText(missionConfigFile >> 'CfgESVP' >> 'markers' >> '_uniqueName');
    _pref = getText(missionConfigFile >> 'CfgESVP' >> 'markers' >> '_prefix') isEqualTo str(true);
    _txt = getText(missionConfigFile >> 'CfgESVP' >> 'markers' >> '_useTextMarker') isEqualTo str(true);
    _text = {
        params['_id','_pref'];
        _ret = "";
        if(_pref)then[{_ret = format['%1 %2',getText(missionConfigFile >> 'CfgESVP' >> 'markers' >> '_prefixName'),_id]},{_ret = _id}];
        _ret
    };
    for "_z" from 0 to (count _zones) -1 do{
        _mrk1 = createMarker [format['%1__%2_1',(_zones select _z)select 0,(_zones select _z)select 1],(_zones select _z)select 1];
        _mrk1 setmarkertype 'empty';
        _mrk1 setmarkercolor _col1;
        _mrk1 setMarkerSize [(_zones select _z)select 2,(_zones select _z)select 2];
        _mrk1 setMarkerShape 'ELLIPSE';
        if(_brush)then{_mrk1 setMarkerBrush _style};
        if(_txt)then{
            _mrk2 = createMarker [format['%1__%2_2',(_zones select _z)select 0,(_zones select _z)select 1],(_zones select _z)select 1];
            _mrk2 setmarkertype _type;
            _mrk2 setmarkercolor _col2;
            _mrk2 setMarkerSize [1,1];
            _mrk2 setMarkerText (if(_unique)then[{_uName},{[(_zones select _z)select 0,_pref] call _text}])
        }
    }
};
