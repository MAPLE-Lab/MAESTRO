// Load necessary function:
(~trace +/+  "data/keyboard_colour_change_array_load.scd").load;

~fNsliderAction = {
	arg instrument=nil, intensityArray, numberOfHarmonics = 16;

	/*switch(instrument,
		"cello", {intensityArray = [0.09,0.39,0.63,0.53,0.06,0.1,0.19,0.11,0.03,0.05,0.03,0.02,0.01,0.01,0.02,0]},
		"trumpet", {intensityArray = [0.05,0.13,0.24,0.36,0.49,0.37,0.29,0.15,0.17,0.12,0.11,0.08,0.05,0.03,0.02,0.01]},
		"flute", {intensityArray = [0.33,0.2,0.17,0.11,0.01,0.01,0.015,0.015,0,0,0,0,0,0,0,0]},
		"horn", {intensityArray = [1.41,1.66,0.78,0.41,0.2,0.08,0.04,0,0,0,0,0,0,0,0,0]},
		"violin", {/*~keyNoteColorChangeFunctionMeans_dataLoad.value(instrument:"violin");*/
			intensityArray = [ 0.54054702631123, 0.068467590621938, 1, 0.16113884447433, 0.051246869858784, 0.55825323274535, 0.12088821116706, 0.49444201049049, 0.18594028935867, 0.35499117316219, 0.22203284279942, 0.11725603003629, 0.072583439143776, 0.060080258180434, 0.038402992554329, 0.042742329108319 ]
},
		"marimba", {
			intensityArray = [1, 0.002498293343931, 0.0066754875664029, 0.012119440068996, 0.0015422521865415, 0.00080548359443066, 0.00016372175696808, 0, 0.0011436372384712, 0.00051213180096273, 0, 0, 0, 0, 0.00027659256076641, 0 ]

},
		"piano", {
			intensityArray = [ 1, 0.58248780075944, 0.15577414565762, 0.11264067833215, 0.052595060408237, 0.032706305852264, 0.0042492501932756, 0.015762242086883, 0.0038986211753485, 0.001041722029088, 0, 0, 0, 0, 0, 0 ]
},
		"clarinet", {//~keyNoteColorChangeFunctionMeans_dataLoad.value(instrument:"clarinet");
			intensityArray = [1, 0.02409085723696, 0.55353334747653, 0.048175654999316, 0.23906113793671, 0.02440506702672, 0.0073602296778641, 0.0036369625237363, 0.021415660336967, 0.0066310990206579, 0.011533408277349, 0.025917705684646, 0.0073102096090535, 0.0028873862831936, 0, 0 ]
},
		"voice_tenor", {
			intensityArray = [ 1, 0.16912694508562, 0.080589014927528, 0.014447971503329, 0.0072791943164136, 0.017698261403315, 0.0038661887479087, 0.0036618499585949, 0.0051744015105844, 0.0050044370656448, 0.0055498479030676, 0.0064103109484165, 0.0045265050719088, 0.0027911632213566, 0.0018771790126553, 0.0048498782407026 ]
},
		"voice_soprano", {
			intensityArray = [ 1, 0.25578978928521, 0.021768972408041, 0.0059954101329648, 0.009589050978436, 0.01621800215521, 0.0065523522917424, 0.0049100600604695, 0.003087658347019, 0.00065517360498415, 0.0007616912461533, 0.00020725960969741, 0.00034087768812463, 0.00013314769366919, 0.00081425706323563, 0.0039874971375039 ]

},
		nil, {}
	);*/


	if(instrument != nil, {
		~keyNoteColorChangeFunctionMeans_dataLoad.value(instrument:instrument);
			intensityArray = ~harmonicsMeansDataArray[1].drop(1); // Created from IF statement prior
	}, {
		"No instrument name given. See spectra_harmonic_slider_functions.scd.".postln;
	});


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