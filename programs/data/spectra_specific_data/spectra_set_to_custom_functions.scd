~setToCustomFunction = {
if(and(~synth_menu.item != "Instruments", ~synth_menu.item != "Custom"), {
		var intensityArray;

		// Obtain current value of the slider position
		intensityArray = Array.fill(16, {
		arg i, j;
		j = i+1;
		("~f" ++ j ++ "slider").interpret.value
	});

	//	intensityArray.postln;

		// Compare to what it should be
		if(and(~synth_menu.item == "Sine", intensityArray != [ 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ]), {
~synth_menu.value_(4)
		});

		if(and(~synth_menu.item == "Square", intensityArray != [ 0.5, 0, 0.16, 0, 0.09, 0, 0.065, 0, 0.055, 0, 0.04, 0, 0.03, 0, 0.035, 0 ]), {
~synth_menu.value_(4)
		});

		// Doesn't work yet
		if(and(~synth_menu.item == "Sawtooth", ~intensityArray != [ 0.5, 0.25, 0.16666666666667, 0.125, 0.1, 0.083333333333333, 0.071428571428571, 0.0625, 0.055555555555556, 0.05, 0.045454545454545, 0.041666666666667, 0.038461538461538, 0.035714285714286, 0.033333333333333, 0.03125 ]), {
~synth_menu.value_(4)
		});

});
}


	/*"if(and(~synth_menu.item !=" + ("Instruments").asCompileString ++ ", ~synth_menu.item !=" + ("Custom").asCompileString ++ "), {~synth_menu.value_(4)});".postln

AppClock.sched(1,{

if(and(~synth_menu.item !=" + ("Instruments").asCompileString ++ ", ~synth_menu.item !=" + ("Custom").asCompileString ++ "), {~synth_menu.value_(4)});

});

~intensityArray*/

	~intensityArray =

Array.fill(16, {
		arg i, j;
		j = i+1;
		("~f" ++ j ++ "slider").interpret.value
	})