//Database for how many semitones higher from fundamental is the selected harmonic for deviation:
// ~current_harmonic_MIDINN_neg = switch (~menu2.value-1,
// 	0,0, //To avoid errors if none selected
// 	1,0,
// 	2,12,
// 	3,19,
// 	4,24,
// 	5,28,
// 	6,31,
// 	7,34,
// 	8,36,
// 	9,38,
// 	10,40,
// 	11,41,
// 	12,43,
// 	13,44,
// 	14,46,
// 	15,47,
// 	16,48
// );


//Here begins the note-specific calculation for distance
(
//Is the harmonic-end a different color than the one being deviated (currently just measures against the fundamental, need to find the variable that says the MIDINN of the harmonic being deviated)? If so, -10 pixels (because usually 10 pixels); else don't do any subtraction

~black_end = if(~array_note_color[~fslider.value.linlin(0,1,21,108)+~deviant_maximum-21] != ~array_note_color[~fslider.value.linlin(0,1,21,108)+~current_harmonic_MIDINN_neg-21],
				{-10},
				{-10}
			);
// Count the number of black and white keys
(
~max_val = ~deviant_maximum+1; //How many semitones to consider
~fund; //Fundamental
~fundamental_note;
~array_fund = ~fundamental_note-21;

				~array_note_color[(~array_fund+~current_harmonic_MIDINN_neg).asInteger..(~array_fund+~max_val-1).asInteger]; //The -1 is necessary because computer counts from 0, not 1

//Counts the number of black keys
				~black_count = ~array_note_color[(~array_fund
					+~current_harmonic_MIDINN_neg
				).asInteger..(~array_fund
					+~current_harmonic_MIDINN_neg
					+~max_val-1).asInteger].sum;

//Counts the number of white keys
~white_count = ~max_val- ~black_count;

/*
[
	"Array used",
	~array_note_color[(~array_fund
						+~current_harmonic_MIDINN_neg).asInteger..(~array_fund
						+~current_harmonic_MIDINN_neg
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
						+~current_harmonic_MIDINN_neg).asInteger..(~array_fund
						+~current_harmonic_MIDINN_neg
						+~max_val-1).asInteger].do({
	arg i, seq;
	~prev = seq-1;
	~curr = seq;
	/*[i,seq, ~prev, ~curr].postln;*/

	if(~array_note_color[(~array_fund+~current_harmonic_MIDINN_neg+~curr).asInteger] == 0,
		{
			if(~array_note_color[(~array_fund+~current_harmonic_MIDINN_neg+~prev).asInteger] == 0,
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
~basic_sum = ((~white_count+~black_count-1)*10);

~special_sum = switch (~adder,
				-1,0,
	0, 0,
				1, 10,
				2, 20,
	3,30
);

~case_whole_tone_starts_white = if(~array_note_color[~fslider.value.linlin(0,1,21,108)+~current_harmonic_MIDINN_neg-21] == 0, //Starts on white
				{if(~white_count == 2, //Two white keys
		{if(~black_count == 1, //One black key (avoids a 0,1,0,1 mistake)
					{if(~array_note_color[~fslider.value.linlin(0,1,21,108)+~current_harmonic_MIDINN_neg-21+1] == 1, //The second semitone in the array is a black key
						{-10+10},{0});}
			,{0})}
			, {0})},
				{0});

~case_semitone = if(~max_val == 2, //Array size of 2
				{if(~white_count != 2, //Ensure it's not an E-F or B-C case
					{-10+10},{0})},{0});

~case_starts_black = if(~array_note_color[~fslider.value.linlin(0,1,21,108)+~current_harmonic_MIDINN_neg-21] == 1, //Starts on black
				{if(~max_val != 2, //Only if not a semitone case (see previous rule)
					{-10+10},{0})},
				{0});

//Adds 10 if a C or F for some cases
//TO BE REPLACED WITH BETTER MATH
~case_CF = if(or(~class_harm_neg == 0, ~class_harm_neg == 5), {-10+0}, {0});

~deviant_scale = ~basic_sum + ~special_sum + ~case_whole_tone_starts_white + ~case_semitone + ~case_starts_black + ~case_CF;
		);
//Here ends that calculation for distance

[~adder, ~class_harm_neg, ~deviant_scale, ~basic_sum, ~special_sum, ~case_whole_tone_starts_white,  ~case_semitone,~case_starts_black, ~case_CF].postln;