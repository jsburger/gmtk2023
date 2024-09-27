function curve_sample(curve, t, channel = "curve1"){
	return animcurve_channel_evaluate(animcurve_get_channel(curve, channel), t);
}