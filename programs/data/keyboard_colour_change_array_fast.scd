// Call using:
// ~keyNoteColorChangeFunction_dataUse.value(keyHarmonicNumber:#)
// where # can be any number where that harmonic's data exists in the data table (usually 1-16)
~keyNoteColorChangeFunction_dataUse = {
	arg keyHarmonicNumber, instrument, instrumentGroup;
	var keyArray, integer;

	// Get the data specific to the harmonic being used (keyHarmonicNumber)
	keyArray = ~harmonicsDataArray[keyHarmonicNumber].drop(1);
	//keyArray.postln;


	// Time-changing intensity dynamics
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



			// Instrument expansion
			//~clarinetAudioHaltKey = ~fluteAudioHaltKey;


			// Time control
			integer = integer + 1;
			if(and(integer < keyArray.size,
				//~haltKey == 0
				("~" ++ instrumentGroup ++ "AudioHaltKey == 0").interpret
			), {
				(~timeInterval.interpret);},{
				//("Data for Harmonic" + keyHarmonicNumber + "completed.").asString.postln;
				//~button.valueAction_(0);
				//~hornDynamicButton.valueAction_(0);
				//~spectraZeroSliders.value();
				//"halted".postln;

				 ("~f" ++ keyHarmonicNumber ++ "slider").interpret.valueAction_(0); //ATTENTION

				nil});
		});
	);
};




~keyNoteColorChangeFunction_soundTimer = {
	arg instrument, instrumentGroup;
	var keyArray, integer;

	(
		integer = 0;

		~temporaryDisableAutoscale = 1; // Disable the autoscale for now

		AppClock.sched(0.0,{ arg time; var keyCol;

			keyArray = ~harmonicsDataArray[0];

			~freqslider.valueAction_(~freqslider.value); // Work-around for updating the keyboard GUI

			(~trace +/+ "data/spectra_harmonics_panel_hover_enter.scd").load; // Updating live the Information panel underneath the Harmonics panel

			// Instrument expansion
			//~clarinetAudioHaltKey = ~fluteAudioHaltKey;

			// Time control
			integer = integer + 1;
			if(and(integer < keyArray.size,
				//~haltKey == 0
				("~" ++ instrumentGroup ++ "AudioHaltKey == 0").interpret
			), {
				(~timeInterval.interpret);},{
				//("Data for Harmonic" + keyHarmonicNumber + "completed.").asString.postln;

				//~button.valueAction_(0); // ATTENTION

				/*~hornDynamicButton.valueAction_(0);
				~fluteDynamicButton.valueAction_(0);
				~trumpetDynamicButton.valueAction_(0);
				~celloDynamicButton.valueAction_(0);*/
				//~spectraFreeDynamicAll.value;



				// Instrument expansion

				/*if(~instrumentGroupWoodwindsDropdown.item == "Clarinet", {
					// For clarinet expansion
					~fluteDynamicButton.value_(0);

					~fluteAudioHaltKey = 1;
					[("~" ++ instrumentGroup ++ "AudioHaltKey").asString, ("~" ++ instrumentGroup ++ "AudioHaltKey").interpret].postln;
				},{*/
					// As usual before the instrument expansion
					("~" ++ instrumentGroup ++ "DynamicButton.value_(0)").interpret; // Using .value so that the user can pick between any Dynamic Spectra buttons without having to out-click

				("~" ++ instrumentGroup ++ "AudioHaltKey = 1").interpret.postln;
		[("~" ++ instrumentGroup ++ "AudioHaltKey").asString, ("~" ++ instrumentGroup ++ "AudioHaltKey").interpret].postln;
				/*});*/


				if(and((~celloAudioHaltKey + ~trumpetAudioHaltKey + ~fluteAudioHaltKey + ~hornAudioHaltKey) == 4, ~spectraPowerButtonStatus == 0), {
			~button.valueAction_(0);
					~temporaryDisableAutoscale = 0;
		});

				/*AppClock.sched(0.01, {
				("~" ++ instrument ++ "AudioHaltKey == 1").interpret;
					[("~" ++ instrument ++ "AudioHaltKey").asString, ("~" ++ instrument ++ "AudioHaltKey").interpret].postln;
				});*/

				nil});
		});
	);

};


~call_keyNoteColorChangeFunction = {
	arg harmonicAmount, instrument, instrumentGroup;
	harmonicAmount.do({ arg item;
		//(item).postln;
		~keyNoteColorChangeFunction_dataUse.value(keyHarmonicNumber:(item+1), instrument:instrument, instrumentGroup:instrumentGroup); // Starts with keyHarmonicNumber:1
		});
	~keyNoteColorChangeFunction_soundTimer.value(instrument:instrument, instrumentGroup:instrumentGroup); // Starts the timer
};

//~call_keyNoteColorChangeFunction.value(harmonicAmount:#);
// where # can be any number up to the maximum number of harmonics to which data is available (usually 16)
// So far this begins to lag after 8 harmonics
// This manipulates the sliders of the harmonics panel in SPECTRA, which affects the sound played and the keyboard colours

//~call_keyNoteColorChangeFunction.value(harmonicAmount:1)

