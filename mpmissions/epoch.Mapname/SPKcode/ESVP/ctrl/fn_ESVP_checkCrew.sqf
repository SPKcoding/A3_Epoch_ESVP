_vp = vehicle player;
_cr = crew _vp;
_names = [];
if(count _cr > 1)then{{if(_x != driver _vp)then{_names pushBack (name _x)}}forEach _cr};
_vp setVariable['RegNames',_names,true];
true
