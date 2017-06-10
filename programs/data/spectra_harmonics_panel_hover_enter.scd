(
		if(~inspectorExists == 1, {
	~inspectorHarmonicsPanel.bounds_(Rect(10, 60, 280, 70));

	~harmonic_in_effect = ("~f"++~slider_hover++"slider").asString;

	~inspectorHarmonicsPanel_harmonic_number.value_(~slider_hover);

	(
	// Calculates the harmonic's pitch
	~note_ID = ~fundamental_note % 12; //0 = C, 9 = A

	~harmonic_adder = [0,12,19,24,28,31,34,36,38,49,41,43,44,46,47,48];

	~harmonic_ID = ~note_ID + ~harmonic_adder[~slider_hover-1];

	(
		switch ((~harmonic_ID % 12).asInteger,
			0, {~temp_name = "C"},
			1, {~temp_name = "C#"},
			2, {~temp_name = "D"},
			3, {~temp_name = "D#"},
			4, {~temp_name = "E"},
			5, {~temp_name = "F"},
			6, {~temp_name = "F#"},
			7, {~temp_name = "G"},
			8, {~temp_name = "G#"},
			9, {~temp_name = "A"},
			10, {~temp_name = "A#"},
			11, {~temp_name = "B"},

	););

	~octave = ((~fundamental_note+~harmonic_adder[~slider_hover-1])/12).asInteger-1;

	~pitch_name = (~temp_name++~octave).asString.postln;
);

	~inspectorHarmonicsPanel_pitch_number.string_(~pitch_name.asString);

	~inspectorHarmonicsPanel_intensity_number.value_(~harmonic_in_effect.interpret.value);

	~inspectorHarmonicsPanel_frequency_number.value_(~fundamental_freq*~slider_hover);

//thisFunction.value.postln; // This breaks SC

};
		);
	);
