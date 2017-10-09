~differenceTonePitchName = {
	arg fundamentalNote, outputToStaticText;
	var note_ID, octave, pitch_name;
(
	// Calculates the harmonic's pitch
	note_ID = fundamentalNote % 12; //0 = C, 9 = A

	(
		switch ((note_ID % 12).asInteger,
			0, {~temp_name = "C"},
			1, {~temp_name = "Db"}, //C#
			2, {~temp_name = "D"},
			3, {~temp_name = "Eb"}, //D#
			4, {~temp_name = "E"},
			5, {~temp_name = "F"},
			6, {~temp_name = "Gb"}, //F#
			7, {~temp_name = "G"},
			8, {~temp_name = "Ab"}, //G#
			9, {~temp_name = "A"},
			10, {~temp_name = "Bb"}, //A#
			11, {~temp_name = "B"},

	););

		octave = (fundamentalNote/12).asInteger-1;

	pitch_name = (~temp_name++octave).asString;

		if(octave > 0, { // 200 selected arbitrarily, error gives 2147483647 due to 32-bit error
			octave.postln;
			outputToStaticText.string_(pitch_name)
		},{
			outputToStaticText.string_("NaN");
		});
);
};

// ~differenceTonePitchName.value(fundamentalNote:~compareMIDI.value, outputToStaticText:~compareName)