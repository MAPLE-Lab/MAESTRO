// Function to change the colour of the keyboard mini-modules key colours dynamically when a synthesized sound is played
// Uses the same HARMONICxINTENSITYxTIME (HIT) data that the "envelope_reader.scd" file uses
// Unfortunately only AppClock can handle the GUI code as SuperCollider places GUI work on a lower priority - this can cause lag as the time intervals are not as precise (http://modularbrains.net/dx490a/DX490A_su2010_03.1_[Timing%7CClocks].html)

// For testing:
//~fundamental_note = 21;

~keyNoteColorChangeFunction = {
arg keyHarmonicNumber;
var basePath, keyNoteID, keyHarmonicID, keyOctave, keyTempName, keyPitchName,
harmonicMIDINN,
	integer,
keyArray;
// 1 - NOTE INFORMATION
// Gets the fundamental and harmonic information
// ~fundamental_note; // 21=A1, usually this is set by the main module already (i.e. TUNING or SPECTRA)
~harmonic_adder = [0,12,19,24,28,31,34,36,38,49,41,43,44,46,47,48];
// The following adapted from a section of the MAESTRO data module "spectra_harmonics_panel_hover_enter.scd"
(
	// Calculates the harmonic's pitch
	keyNoteID = ~fundamental_note % 12; //0 = C, 9 = A

		keyHarmonicID = keyNoteID + ~harmonic_adder[keyHarmonicNumber-1];

	(
		switch ((keyHarmonicID % 12).asInteger,
			0, {keyTempName = "c"},
			1, {keyTempName = "cSHARP"},
			2, {keyTempName = "d"},
			3, {keyTempName = "dSHARP"},
			4, {keyTempName = "e"},
			5, {keyTempName = "f"},
			6, {keyTempName = "fSHARP"},
			7, {keyTempName = "g"},
			8, {keyTempName = "gSHARP"},
			9, {keyTempName = "a"},
			10, {keyTempName = "aSHARP"},
			11, {keyTempName = "b"},

	););

keyOctave = ((~fundamental_note+~harmonic_adder[keyHarmonicNumber-1])/12).asInteger-1; // While it's labelled as A1, unfortunately the original coding uses it as A0, so there is no +1 here whereas "spectra_harmonics_panel_hover_enter.scd" has the end (".asInteger-1+1").

	keyPitchName = (keyTempName++keyOctave).asString; //.postln;
);

	// The actual note number - MIDINN:
	harmonicMIDINN = ~fundamental_note + ~harmonic_adder[keyHarmonicNumber-1];


// 2 - HIT DATA
basePath = ~trace; //thisProcess.nowExecutingPath.asString.dirname; //~trace ?
~harmonicsDataArray = TabFileReader.readInterpret(~trace +/+ "R/R_working_files/harmonicMatrixScaled.txt");

keyArray = ~harmonicsDataArray[keyHarmonicNumber].drop(1);
~timeInterval = ~harmonicsDataArray[0][0];
keyArray.postln;


// 3 - AFFECT KEY COLOUR
(
	integer = 0;

AppClock.sched(0.0,{ arg time; var keyCol;
	// Change colour of StaticText
	//[integer, keyArray[integer]].postln;
	//~testBox.background_(Color.red(keyArray[integer]));

("~" ++ keyPitchName).asString.interpret.background_(Color(1,1-keyArray[integer],1-keyArray[integer])); // Direct-approach, works

			//keyHarmonicID.postln;
			//~color_array[harmonicMIDINN-1] = 1-keyArray[integer]; // Set the value

			//[keyHarmonicNumber, harmonicMIDINN, keyHarmonicID, ~color_array[harmonicMIDINN-1]].postln;

			// Call to update keyboard
			//(~trace +/+  "data/spectra_keyboard_GUI_colours_for_synth.scd").load;

	// End code
	if(integer == (keyArray.size-1), {
	(
		switch ((keyHarmonicID % 12).asInteger,
			0, {keyCol = 0},
			1, {keyCol = 1},
			2, {keyCol = 0},
			3, {keyCol = 1},
			4, {keyCol = 0},
			5, {keyCol = 0},
			6, {keyCol = 1},
			7, {keyCol = 0},
			8, {keyCol = 1},
			9, {keyCol = 0},
			10, {keyCol = 1},
			11, {keyCol = 0},

	););

		if(keyCol == 0, {
			("~" ++ keyPitchName).asString.interpret.background_(Color.white) // If white key, resets to white
		},{
			("~" ++ keyPitchName).asString.interpret.background_(Color.black) // If black key, resets to black
		});

	});

	// Time control
	integer = integer + 1;
	if(integer < keyArray.size, {
		(~timeInterval.interpret);},{
		nil});
});
);


};

// To call the function:
//~keyNoteColorChangeFunction.value(1) // The value inside the parentheses defines the value of the argument \keyHarmonicNumber

~number_of_harmonics = Array.fill(16, { arg i; i+1 }); // How many harmonics as an array/sequence - this is a common code line with "envelope_reader.scd"

//~number_of_harmonics.size; // The number of harmonics as an integer

~call_keyNoteColorChangeFunction = {
	~number_of_harmonics.size.do({ arg item;
		//(item).postln;
		~keyNoteColorChangeFunction.value(item+1); // Starts with keyHarmonicNumber:1
		});
};

//~call_keyNoteColorChangeFunction.value; // This activates the changing colours of the keyboard notes
~call_keyNoteColorChangeFunction.value
~keyNoteColorChangeFunction.value(1)

~color_array.sum