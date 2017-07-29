~differenceTonePitchName = {
	arg fundamentalNote, outputToStaticText;
	var note_ID, octave, pitch_name;
(
	// Calculates the harmonic's pitch
	note_ID = fundamentalNote % 12; //0 = C, 9 = A

	(
		switch ((note_ID % 12).asInteger,
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

		octave = (fundamentalNote/12).asInteger-1;

	pitch_name = (~temp_name++octave).asString;

		outputToStaticText.string_(pitch_name)
);
};

// ~differenceTonePitchName.value(fundamentalNote:~compareMIDI.value, outputToStaticText:~compareName)