// Call using:
// ~keyNoteColorChangeFunction_dataUse.value(keyHarmonicNumber:#)
// where # can be any number where that harmonic's data exists in the data table (usually 1-16)
~keyNoteColorChangeFunction_dataUse = {
	arg keyHarmonicNumber;
	var keyArray, integer;

	// Get the data specific to the harmonic being used (keyHarmonicNumber)
	keyArray = ~harmonicsDataArray[keyHarmonicNumber].drop(1);
	//keyArray.postln;


	// Time dynamics
	(
		integer = 0;

		AppClock.sched(0.0,{ arg time; var keyCol;

			//keyArray[integer].postln;


			("~f" ++ keyHarmonicNumber ++ "slider").interpret.value_(keyArray[integer]); // Avoid valueAction to reduce lag so it's not calling to update  freq/GUI redundantly

			// But to set a sound value need to use this line:
			if(
				x.isPlaying,
				{x.set(

					("\\" ++ "f" ++ keyHarmonicNumber).interpret, keyArray[integer].value.linlin(0,1,0,2);

			)});


			// Time control
			integer = integer + 1;
			if(and(integer < keyArray.size, ~haltKey == 0), {
				(~timeInterval.interpret);},{
				//("Data for Harmonic" + keyHarmonicNumber + "completed.").asString.postln;
				//~button.valueAction_(0);
				//~hornSynthButton.valueAction_(0);
				//~spectraZeroSliders.value();
				//"halted".postln;
				("~f" ++ keyHarmonicNumber ++ "slider").interpret.value_(0);
				nil});
		});
	);
};




~keyNoteColorChangeFunction_soundTimer = {
	var keyArray, integer;

	(
		integer = 0;

		AppClock.sched(0.0,{ arg time; var keyCol;

			keyArray = ~harmonicsDataArray[0];

~freqslider.valueAction_(~freqslider.value); // Work-around for updating

			// Time control
			integer = integer + 1;
			if(and(integer < keyArray.size, ~haltKey == 0), {
				(~timeInterval.interpret);},{
				//("Data for Harmonic" + keyHarmonicNumber + "completed.").asString.postln;
				~button.valueAction_(0);
				~hornSynthButton.valueAction_(0);
				~fluteSynthButton.valueAction_(0);
				~trumpetSynthButton.valueAction_(0);
				~celloSynthButton.valueAction_(0);
				nil});
		});
	);

};


~call_keyNoteColorChangeFunction = {
	arg harmonicAmount;
	harmonicAmount.do({ arg item;
		//(item).postln;
		~keyNoteColorChangeFunction_dataUse.value(item+1); // Starts with keyHarmonicNumber:1
		});
	~keyNoteColorChangeFunction_soundTimer.value(); // Starts the timer
};

//~call_keyNoteColorChangeFunction.value(harmonicAmount:#);
// where # can be any number up to the maximum number of harmonics to which data is available (usually 16)
// So far this begins to lag after 8 harmonics
// This manipulates the sliders of the harmonics panel in SPECTRA, which affects the sound played and the keyboard colours

//~call_keyNoteColorChangeFunction.value(harmonicAmount:1)

