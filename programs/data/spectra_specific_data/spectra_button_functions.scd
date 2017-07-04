// Power
~spectraFreePowerSpecify = {
	arg instrument;
	if(("~" ++ instrument ++ "PowerButton").interpret.value == 1, {("~" ++ instrument ++ "PowerButton").interpret.valueAction_(0)});
};


// Sets all harmonic sliders to 0.
// Call using: ~spectraZeroSliders.value()
~spectraZeroSliders = {
	16.do({
		arg i;
		("~f" ++ (i+1) ++ "slider").interpret.valueAction_(0).postln;
	});
};

// Common synth button action function
// Plays and stops the sound. Arguments give the fundamental note (as a MIDI number), the instrument selected and the number of harmonic to use. "obj" is the standard object used in multi-state Button arguments, so it has kept the same name for consistency.
~spectraDynamicButtonAction = {
	arg obj, instrument, harmonicAmount, fundamentalNote;

	if(obj.value == 1, {
		~freqslider.valueAction_(fundamentalNote.value.linlin(21,108,0,1)); //only need to affect slider to affect the number box and true sound value
		~haltKey = 0;
		~keyNoteColorChangeFunction_dataLoad.value(instrument);
		~call_keyNoteColorChangeFunction.value(harmonicAmount);

		if(x.isPlaying, {x.free;});
		if(~celloAudioButton.value == 1, {~celloAudioButton.valueAction_(0)});
		if(~trumpetAudioButton.value == 1, {~trumpetAudioButton.valueAction_(0)});
		if(~fluteAudioButton.value == 1, {~fluteAudioButton.valueAction_(0)});
		if(~hornAudioButton.value == 1, {~hornAudioButton.valueAction_(0)});

		~button.valueAction_(1);
		~l.valueAction_(0);
		~j.valueAction_(0);
		~r.valueAction_(0);
		~k.valueAction_(0);
		~vinbutton.valueAction_(0);
	},{
		~button.valueAction_(0);
		~haltKey = 1;
	});

};

// Actions commands for the Audio Recordings two-state buttons.

~spectraAudioButtonAction = {
	arg obj, instrument;
	var howLongPlaying;

	if(obj.value == 1, {

		// Free all other sounds
		switch(instrument,
			"cello", {~trumpetAudioButton.valueAction_(0); ~fluteAudioButton.valueAction_(0); ~hornAudioButton.valueAction_(0);},
			"trumpet", {~celloAudioButton.valueAction_(0); ~fluteAudioButton.valueAction_(0); ~hornAudioButton.valueAction_(0);},
			"flute", {~celloAudioButton.valueAction_(0); ~trumpetAudioButton.valueAction_(0); ~hornAudioButton.valueAction_(0);},
			"horn", {~celloAudioButton.valueAction_(0); ~trumpetAudioButton.valueAction_(0); ~fluteAudioButton.valueAction_(0);},
		);


		// This gives a numeric Integer clock, counting up every 0.1s, starting from when the sound is played
		// It is used to nullify the command from turning the button off too early, in the case where the user turns the sound on-off-on before the first time it was played had a time to finish playing the sound
		howLongPlaying = 0;
		AppClock.sched(0, {
			howLongPlaying = howLongPlaying+1;
			//howLongPlaying.postln;
			if(
				or(~celloAudioButton.value == 1,
					or(~trumpetAudioButton.value == 1,
						or(~fluteAudioButton.value == 1, ~hornAudioButton.value == 1,)
					)
				),

				{0.1}, {nil});
		});


		switch(instrument,
			"cello", {~celloAudioSynth = 	y = Synth.new(\celloAudio, [\out, 0, \bufnum, ~celloAudioBuffer.bufnum]);},
			"trumpet", {~trumpetAudioSynth = v = Synth.new(\trumpetAudio, [\out, 0, \bufnum, ~trumpetAudioBuffer.bufnum]);},
			"flute", {~fluteAudioSynth = 	z = Synth.new(\fluteAudio, [\out, 0, \bufnum, ~fluteAudioBuffer.bufnum]);},
			"horn", {~hornAudioSynth = 	t = Synth.new(\hornAudio, [\out, 0, \bufnum, ~hornAudioBuffer.bufnum]);},
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

		~button.valueAction_(0);

		~l.valueAction_(0);
		~j.valueAction_(0);
		~r.valueAction_(0);
		~k.valueAction_(0);
		~vinbutton.valueAction_(0);

		switch(instrument,
			"cello", {AppClock.sched(2.4, {if(howLongPlaying > 21, {~celloAudioButton.valueAction_(0); "Cello audio finished.".postln});})},
			"trumpet", {AppClock.sched(4, {if(howLongPlaying > 38, {~trumpetAudioButton.valueAction_(0); "Trumpet audio finished.".postln});})},
			"flute", {AppClock.sched(3, {if(howLongPlaying > 28, {~fluteAudioButton.valueAction_(0); "Flute audio finished.".postln});})},
			"horn", {AppClock.sched(3, {if(howLongPlaying > 28, {~hornAudioButton.valueAction_(0); "Horn audio finished.".postln});})}
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
