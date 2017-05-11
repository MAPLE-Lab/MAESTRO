//Here begins the note-specific calculation for distance
(
//Is the harmonic-end a different color than the one being deviated (currently just measures against the fundamental, need to find the variable that says the MIDINN of the harmonic being deviated)? If so, -10 pixels (because usually 10 pixels); else don't do any subtraction

~black_end = if(~array_note_color[~fslider.value.linlin(0,1,21,108)+~deviant_maximum-21] != ~array_note_color[~fslider.value.linlin(0,1,21,108)+~current_harmonic_MIDINN-21],
				{-10},
				{-10}
			);
// Count the number of black and white keys
(
~max_val = ~deviant_maximum+1; //How many semitones to consider
~fund; //Fundamental
~fundamental_note;
~array_fund = ~fundamental_note-21;

				~array_note_color[(~array_fund+~current_harmonic_MIDINN).asInteger..(~array_fund+~max_val-1).asInteger]; //The -1 is necessary because computer counts from 0, not 1

//Counts the number of black keys
				~black_count = ~array_note_color[(~array_fund
					+~current_harmonic_MIDINN
				).asInteger..(~array_fund
					+~current_harmonic_MIDINN
					+~max_val-1).asInteger].sum;

//Counts the number of white keys
~white_count = ~max_val- ~black_count;

/*
[
	"Array used",
	~array_note_color[(~array_fund
						+~current_harmonic_MIDINN).asInteger..(~array_fund
						+~current_harmonic_MIDINN
						+~max_val-1).asInteger],
	"# of black",
	~black_count,
	"# of white",
	~white_count
].postln
*/
);


			//Checks if there are any double-whites (i.e. B-C and E-F)
(
~adder = 0;
~bonus = ~array_note_color[(~array_fund
						+~current_harmonic_MIDINN).asInteger..(~array_fund
						+~current_harmonic_MIDINN
						+~max_val-1).asInteger].do({
	arg i, seq;
	~prev = seq-1;
	~curr = seq;
	/*[i,seq, ~prev, ~curr].postln;*/

	if(~array_note_color[(~array_fund+~current_harmonic_MIDINN+~curr).asInteger] == 0,
		{
			if(~array_note_color[(~array_fund+~current_harmonic_MIDINN+~prev).asInteger] == 0,
				{~adder = ~adder + 1;
					/*~adder.postln;
					"added".postln;*/
				},
				{"do nothingB"/*.postln*/});
		},
		{"do nothingA"/*.postln*/});

});

);


//What is the maximum distance the red dot can move? It is the number of white keys * 20px - number of black keys * 10px
//~deviant_scale = (~white_count*20)-(~black_count*10)+(~adder*20)+~black_end;

//New model
~basic_sum = ((~white_count+~black_count)*10);

~special_sum = switch (~adder,
				0, 0,
				1, 0,
				2, 10);

~case_whole_tone_starts_white = if(~array_note_color[~fslider.value.linlin(0,1,21,108)+~current_harmonic_MIDINN-21] == 0, //Starts on white
				{if(~white_count == 2, //Two white keys
					{if(~array_note_color[~fslider.value.linlin(0,1,21,108)+~current_harmonic_MIDINN-21+1] == 1, //The second semitone in the array is a black key
						{-10},{0});}, {0})},
				{0});

~case_semitone = if(~max_val == 2, //Array size of 2
				{if(~white_count != 2, //Ensure it's not an E-F or B-C case
					{-10},{0})},{0});

~case_starts_black = if(~array_note_color[~fslider.value.linlin(0,1,21,108)+~current_harmonic_MIDINN-21] == 1, //Starts on black
				{if(~max_val != 2, //Only if not a semitone case (see previous rule)
					{-10},{0})},
				{0});

~deviant_scale = ~basic_sum + ~special_sum + ~case_whole_tone_starts_white + ~case_semitone + ~case_starts_black;
		);
//Here ends that calculation for distance