// Sets all harmonic sliders to 0.
// Call using: ~spectraZeroSliders.value()
~spectraZeroSliders = {
	16.do({
		arg i;
		("~f" ++ (i+1) ++ "slider").interpret.valueAction_(0); //.postln;
	});
};


// Power
~spectraPowerButtonAction = {
	arg obj, instrument, fundamentalNote;
	if(obj.value == 1,
		{

			//var variable;
			//variable = SinOsc.kr(2); //unfortunately the QtGUI cannot use variables in this slider (error message)

			// Free any Dynamic sounds
			//~spectraFreeDynamicAll.value; // ATTENTION
			//~haltKey = 1;

			~spectraFreeAudioAll.value;
//~spectraFreeDynamicAll.value;
			~spectraFreeDynamicAllKeyMethod.value; // This method uses the HaltKeys directly and thus does not cause the ~button to reset to 0 every time it is used
		//	~spectraFreePowerAll.value;

			~spectraPowerButtonStatus = 1;

			~vinbutton.valueAction_(0);

			~freqslider.valueAction_(fundamentalNote.value.linlin(21,108,0,1)); //only need to affect slider to affect the number box and true sound value
			~volslider.valueAction_(0.4.value.linlin(0,1,0,1));

			if(x.isPlaying, {x.free}); // Clears previous sound

			// l.free; // Unknown purpose

			AppClock.sched(0.05, { // The delay is to ensure the Dynamic Spectra can finish before this activates; otherwise the sliders will be set to 0 because the 0 setting overprioritizes or comes after this Power set
				"AppClock for Power Spectra sent message after 0.05s.".postln;
				obj.value_(1); // The Power button seems to be reset to 0 coming off of Dynamic
				~fNsliderAction.value(instrument:instrument);
				~button.valueAction_(1); // Must come AFTER the harmonic sliders are set
				nil;
			});

		}, {
			x.free;
			~spectraPowerButtonStatus = 0;
			~button.value_(0); // Must be .value instead of .valueAction so can go directly from one button to another
			~stop_UserView.bounds_(Rect(400-(100/2)-92,65,1,1));
			~synth_menu.background_(Color(0.7569-0.1,0.1373-0.1,0.1725-0.1,1));
			~synth_menu.stringColor_(Color.black);

			//Reset to base colours when not playing
			if(~key_vis.value == 1, {
				~color_array = Array.fill(200,1);
				(~trace +/+  "data/spectra_keyboard_GUI_colours.scd").load;
			});
	});
};

~spectraFreePowerSpecify = {
	arg instrument;
	if(("~" ++ instrument ++ "PowerButton").interpret.value == 1, {("~" ++ instrument ++ "PowerButton").interpret.valueAction_(0)});
};

~spectraFreePowerSpecifyValueOnly = {
	arg instrument;
	if(("~" ++ instrument ++ "PowerButton").interpret.value == 1, {("~" ++ instrument ++ "PowerButton").interpret.value_(0)});
};

~spectraFreePowerAll = {
	if(~celloPowerButton.value == 1, {~celloPowerButton.valueAction_(0)});
	if(~trumpetPowerButton.value == 1, {~trumpetPowerButton.valueAction_(0)});
	if(~flutePowerButton.value == 1, {~flutePowerButton.valueAction_(0)});
	if(~hornPowerButton.value == 1, {~hornPowerButton.valueAction_(0)});
};




// Common Dynamic button action function
// Plays and stops the sound. Arguments give the fundamental note (as a MIDI number), the instrument selected and the number of harmonic to use. "obj" is the standard object used in multi-state Button arguments, so it has kept the same name for consistency.

~spectraDynamicButtonAction = {
	arg obj, instrument, harmonicAmount, fundamentalNote;

	"START of button action".postln;

	if(obj.value == 1, {

		(instrument + "obj.value == 1").postln;

		//~button.value.postln;
		//~haltKey.postln;

		~freqslider.valueAction_(fundamentalNote.value.linlin(21,108,0,1)); //only need to affect slider to affect the number box and true sound value
		~haltKey = 0;

		if(~instrumentGroupWoodwindsDropdown.item == "Clarinet", {
			// For clarinet expansion
			~fluteAudioHaltKey = 0;
			["~fluteAudioHaltKey", ~fluteAudioHaltKey].postln;
		},{
			// As usual before the instrument expansion
			("~" ++ instrument ++ "AudioHaltKey = 0").interpret.postln;
			[("~" ++ instrument ++ "AudioHaltKey").asString, ("~" ++ instrument ++ "AudioHaltKey").interpret].postln;
		});



		/*~haltKey.postln;
		~button.value.postln;
		"0, 0".postln;*/

		if(x.isPlaying, {x.free;});
		~spectraFreeAudioAll.value;
		/*if(~celloAudioButton.value == 1, {~celloAudioButton.valueAction_(0)});
		if(~trumpetAudioButton.value == 1, {~trumpetAudioButton.valueAction_(0)});
		if(~fluteAudioButton.value == 1, {~fluteAudioButton.valueAction_(0)});
		if(~hornAudioButton.value == 1, {~hornAudioButton.valueAction_(0)});*/

		~keyNoteColorChangeFunction_dataLoad.value(instrument:instrument);
		~call_keyNoteColorChangeFunction.value(harmonicAmount:harmonicAmount, instrument:instrument);

		~spectraFreePowerAll.value;

		//~button.value.postln;
		~button.valueAction_(1).postln;
		//~button.value.postln;

		~vinbutton.valueAction_(0);

		["Sum of keys", (~celloAudioHaltKey + ~trumpetAudioHaltKey + ~fluteAudioHaltKey + ~hornAudioHaltKey)].postln;
	},{
		(instrument + "obj.value == 0").postln;

		/*"~haltKey".postln;
		~haltKey.postln;
		"~button".postln;
		~button.value.postln;*/

		//~button.valueAction_(0); // ATTENTION
		//~button.value.postln;

		//~haltKey = 1;
				//("~" ++ instrument ++ "AudioHaltKey == 1").interpret.postln;



		if(~instrumentGroupWoodwindsDropdown.item == "Clarinet", {
			// For clarinet expansion
			~fluteAudioHaltKey = 1;
			["~fluteAudioHaltKey", ~fluteAudioHaltKey].postln;
		},{
			// As usual before the instrument expansion
			("~" ++ instrument ++ "AudioHaltKey = 1").interpret.postln;
			[("~" ++ instrument ++ "AudioHaltKey").asString, ("~" ++ instrument ++ "AudioHaltKey").interpret].postln;
		});



		/*AppClock.sched(1, {
				("~" ++ instrument ++ "AudioHaltKey = 0").interpret;
					[("~" ++ instrument ++ "AudioHaltKey").asString, ("~" ++ instrument ++ "AudioHaltKey").interpret].postln;
				});*/

				["Sum of keys", (~celloAudioHaltKey + ~trumpetAudioHaltKey + ~fluteAudioHaltKey + ~hornAudioHaltKey)].postln;

		if(
			and(
				(~celloAudioHaltKey + ~trumpetAudioHaltKey + ~fluteAudioHaltKey + ~hornAudioHaltKey) >= 3
				, ~spectraPowerButtonStatus == 0)
		, {
			~button.valueAction_(0);

		});

		//~haltKey.postln;
		"END Button off.".postln;
	});

};


~spectraFreeDynamicAll = {
	if(~fluteDynamicButton.value == 1, {~fluteDynamicButton.valueAction_(0)});
	if(~trumpetDynamicButton.value == 1, {~trumpetDynamicButton.valueAction_(0)});
	if(~hornDynamicButton.value == 1, {~hornDynamicButton.valueAction_(0)});
	if(~celloDynamicButton.value == 1, {~celloDynamicButton.valueAction_(0)});
};


~spectraFreeDynamicAllKeyMethod = {
	if(~fluteDynamicButton.value == 1, {~fluteAudioHaltKey = 1});
	if(~trumpetDynamicButton.value == 1, {~trumpetAudioHaltKey = 1});
	if(~hornDynamicButton.value == 1, {~hornAudioHaltKey = 1});
	if(~celloDynamicButton.value == 1, {~celloAudioHaltKey = 1});
};


// Actions commands for the Audio Recordings two-state buttons.

~spectraAudioButtonAction = {
	arg obj, instrument;
	var howLongPlaying;

	if(obj.value == 1, {

		// Free all other Audio sounds
		switch(instrument,
			"cello", {~trumpetAudioButton.valueAction_(0); ~fluteAudioButton.valueAction_(0); ~hornAudioButton.valueAction_(0);},
			"trumpet", {~celloAudioButton.valueAction_(0); ~fluteAudioButton.valueAction_(0); ~hornAudioButton.valueAction_(0);},
			"flute", {~celloAudioButton.valueAction_(0); ~trumpetAudioButton.valueAction_(0); ~hornAudioButton.valueAction_(0);},
			"horn", {~celloAudioButton.valueAction_(0); ~trumpetAudioButton.valueAction_(0); ~fluteAudioButton.valueAction_(0);},
		);

		// Free any Dynamic sounds
		~spectraFreeDynamicAll.value;


		// This gives a numeric Integer clock, counting up every 0.1s, starting from when the sound is played
		// It is used to nullify the command from turning the button off too early, in the case where the user turns the sound on-off-on before the first time it was played had a time to finish playing the sound
		howLongPlaying = 0;
		AppClock.sched(0, {
			howLongPlaying = howLongPlaying+1;
			//howLongPlaying.postln;
			if(
				or(~celloAudioButton.value == 1,
					or(~trumpetAudioButton.value == 1,
						or(~fluteAudioButton.value == 1,
							or(~hornAudioButton.value == 1,
								~voice_tenorAudioButton.value == 1)
							)
					)
				),

				{0.1}, {nil});
		});


		switch(instrument,
			"cello", {~celloAudioSynth = 	y = Synth.new(\celloAudio, [\out, 0, \bufnum, ~celloAudioBuffer.bufnum]);},
			"trumpet", {~trumpetAudioSynth = v = Synth.new(\trumpetAudio, [\out, 0, \bufnum, ~trumpetAudioBuffer.bufnum]);},
			"flute", {~fluteAudioSynth = 	z = Synth.new(\fluteAudio, [\out, 0, \bufnum, ~fluteAudioBuffer.bufnum]);},
			"horn", {~hornAudioSynth = 	t = Synth.new(\hornAudio, [\out, 0, \bufnum, ~hornAudioBuffer.bufnum]);},
			"voice_tenor", {~voice_tenorAudioSynth = Synth.new(\hornAudio, [\out, 0, \bufnum, ~voice_tenorAudioBuffer.bufnum]);}
		);

		/*
		z.free;
		z = Synth.new(\import2, [\out, 0, \bufnum, b.bufnum]);
		x.free;
		y.free;
		v.free;
		t.free;
		l.free;
		~button.valueAction_(0);

		x.free;
		z.free;
		v.free;
		t.free;
		l.free;*/

		// s.sendMsg("/s_new", "import3", v = s.nextNodeID, 1, 1);
		/*
		(
		s.sendBundle(0.0, //sound delay
		["/s_new", "import3", v = Synth.new(\import3, [\out, 0, \bufnum, c.bufnum])]); //sound and ID for stacking (if multiple sounds bundled)
		s.sendBundle(1, ["/n_free", v.free]);//sound ends, at least frees up memory space
		);*/

		~button.valueAction_(0); // Ensures harmonic panel and Power Spectra sounds are not playing

		~spectraFreePowerAll.value;
		/*
		~l.valueAction_(0);
		~j.valueAction_(0);
		~r.valueAction_(0);
		~k.valueAction_(0);*/

		~vinbutton.valueAction_(0);

		switch(instrument,
			"cello", {AppClock.sched(2.4, {if(howLongPlaying > 23, {~celloAudioButton.valueAction_(0); "Cello audio finished.".postln});})},
			"trumpet", {AppClock.sched(4, {if(howLongPlaying > 39, {~trumpetAudioButton.valueAction_(0); "Trumpet audio finished.".postln});})},
			"flute", {AppClock.sched(3, {if(howLongPlaying > 29, {~fluteAudioButton.valueAction_(0); "Flute audio finished.".postln});})},
			"horn", {AppClock.sched(3, {if(howLongPlaying > 29, {~hornAudioButton.valueAction_(0); "Horn audio finished.".postln});})},
			"voice_tenor", {AppClock.sched(1.5, {if(howLongPlaying > 14, {~voice_tenorAudioButton.valueAction_(0); "Tenor audio finished.".postln});})}
		);

	}, {

		("~" ++ instrument ++ "AudioSynth").interpret.free;

		/*switch(instrument,
		"cello", {~celloAudioSynth.free;},
		"trumpet", {~trumpetAudioSynth.free;},
		"cello", {~celloAudioSynth.free;},
		"cello", {~celloAudioSynth.free;},
		);*/

	});
};

~spectraFreeAudioSpecify = {
	arg instrument;
	if(("~" ++ instrument ++ "AudioButton").interpret.value == 1, {("~" ++ instrument ++ "AudioButton").interpret.valueAction_(0)});
};

~spectraFreeAudioAll = {
	if(~fluteAudioButton.value == 1, {~fluteAudioButton.valueAction_(0)}); //z.free;
	if(~trumpetAudioButton.value == 1, {~trumpetAudioButton.valueAction_(0)}); //v.free;
	if(~hornAudioButton.value == 1, {~hornAudioButton.valueAction_(0)}); //t.free;
	if(~celloAudioButton.value == 1, {~celloAudioButton.valueAction_(0)}); //y.free;
};
