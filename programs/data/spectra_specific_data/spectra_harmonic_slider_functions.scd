~fNsliderAction = {
	arg instrument=nil, intensityArray, numberOfHarmonics = 16;

	switch(instrument,
		"cello", {intensityArray = [0.09,0.39,0.63,0.53,0.06,0.1,0.19,0.11,0.03,0.05,0.03,0.02,0.01,0.01,0.02,0]},
		"trumpet", {intensityArray = [0.05,0.13,0.24,0.36,0.49,0.37,0.29,0.15,0.17,0.12,0.11,0.08,0.05,0.03,0.02,0.01]},
		"flute", {intensityArray = [0.33,0.2,0.17,0.11,0.01,0.01,0.015,0.015,0,0,0,0,0,0,0,0]},
		"horn", {intensityArray = [1.41,1.66,0.78,0.41,0.2,0.08,0.04,0,0,0,0,0,0,0,0,0]},
		nil, {}
	);
	//intensityArray = [0.5,0.2,0.6];
	numberOfHarmonics.do({
		arg item, i, j;
		j = i + 1;
		//	[i, item, j].postln;

		if(intensityArray[i] != nil, {
			("~f" ++ j ++ "slider").interpret.valueAction_(intensityArray[i].value.linlin(0,2,0,1));
		},{
			("~f" ++ j ++ "slider").interpret.valueAction_(0.asInteger.value.linlin(0,2,0,1));
		});
	});
};

//['a', 'b', 'c'].do({ arg item, i; [i, item].postln; });

//~fNsliderAction.value(instrument:"cello")


/*~array1 = [1,2]

~array1[1] != nil

~fNsliderAction.value(intensityArray:[2])*/