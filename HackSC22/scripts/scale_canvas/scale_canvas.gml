// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scale_canvas(_bw, _bh, _cw, _ch, _center){
	var _aspect = (_bw / _bh);

	if ((_cw / _aspect) > _ch)
	    {
	    window_set_size((_ch *_aspect), _ch);
	    }
	else
	    {
	    window_set_size(_cw, (_cw / _aspect));
	    }
	if (_center)
	    {
	    window_center();
	    }
}