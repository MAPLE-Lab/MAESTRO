//NOTE THIS IS FOR THE BOUNDS OF THE STARTING POSITION, there is another file for the harmonic's deviation
//Here begins the note-specific calculation for distance
(
//How many semitones does that harmonic move it? 2 switch systems, the one used depends on the sign; Gives the maximum number of semitones to move away from the deviating note.
~deviant_maximum_harm =
			if(~deviant_move.sign > -2,
				{(//IF POSITIVE DIRECTION:
					switch (~menu2.value-1,

			-1,0,
			0,0,
1,12,
2,19,
3,24,
4,28,
5,31,
6,34,
7,36,
8,38,
9,40,
10,41,
11,43,
12,44,
13,46,
14,47,
15,48
			/*
						0,0,
						1,12,
						2,7,
						3,5,
						4,4,
						5,3,
						6,3,
						7,2,
						8,2,
						9,2,
						10,1,
						11,2,
						12,1,
						13,2,
						14,1,
						15,1,
						16,0
			*/

					);
				);},

				{(//IF NEGATIVE DIRECTION:
					switch (~menu2.value-1,
						0,0,
						1,0,
						2,12,
						3,7,
						4,5,
						5,4,
						6,3,
						7,3,
						8,2,
						9,2,
						10,2,
						11,1,
						12,2,
						13,1,
						14,2,
						15,1,
						16,1
					);
			);});


//Database for how many semitones higher from fundamental is the selected harmonic for deviation:
~current_harmonic_MIDINN_harm = switch (~menu2.value-1,
	0,0,
	1,0,
				2,12,
				3,19,
				4,24,
				5,28,
				6,31,
				7,34,
				8,36,
				9,38,
				10,40,
				11,41,
				12,43,
				13,44,
				14,46,
				15,47,
				16,48
				);



//Is the harmonic-end a different color than the one being deviated (currently just measures against the fundamental, need to find the variable that says the MIDINN of the harmonic being deviated)? If so, -10 pixels (because usually 10 pixels); else don't do any subtraction

~black_end_harm = if(~array_note_color[~fslider.value.linlin(0,1,21,108)+~deviant_maximum_harm-21] != ~array_note_color[~fslider.value.linlin(0,1,21,108)+~current_harmonic_MIDINN_harm-21],
				{-10},
				{-10}
			);
// Count the number of black and white keys
(
~max_val_harm = ~deviant_maximum_harm+1; //How many semitones to consider
~fund; //Fundamental
~fundamental_note;
~array_fund = ~fundamental_note-21;

				/*~array_note_color[(~array_fund+~current_harmonic_MIDINN_harm).asInteger..(~array_fund+~max_val_harm-1).asInteger]; //The -1 is necessary because computer counts from 0, not 1*/

//Counts the number of black keys
~black_count_harm = ~array_note_color[(~array_fund
					+~current_harmonic_MIDINN_harm
				).asInteger..(~array_fund
					+~current_harmonic_MIDINN_harm
					+~max_val_harm-1).asInteger].sum;

//Counts the number of white keys
~white_count_harm = ~max_val_harm-~black_count_harm;

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


			//Checks if there are any double-whites (i.e. B-C and E-F), ALL THE WAY FROM THE FUNDAMENTAL
(
~adder_harm = 0;
~bonus_harm = ~array_note_color[(~array_fund
						/*+~current_harmonic_MIDINN_harm*/).asInteger..(~array_fund
	//+~current_harmonic_MIDINN_harm //SOMETHING's ADDING TOO MANY
						+~max_val_harm
	-1).asInteger].do({
	arg i, seq;
	~prev_harm = seq-1;
	~curr_harm = seq;
	/*[i,seq, ~prev, ~curr].postln;*/

	if(~array_note_color[(~array_fund
		//+~current_harmonic_MIDINN_harm
		+~curr_harm).asInteger] == 0,
		{
			if(~array_note_color[(~array_fund
			//+~current_harmonic_MIDINN
			+~prev_harm).asInteger] == 0,
				{~adder_harm = ~adder_harm + 1;
					/*~adder.postln;
					"added".postln;*/
				},
				{"do nothingB"/*.postln*/});
		},
		{"do nothingA"/*.postln*/});

}).postln; //Posts the truncated array

);


//What is the maximum distance the red dot can move? It is the number of white keys * 20px - number of black keys * 10px
//~deviant_scale = (~white_count*20)-(~black_count*10)+(~adder*20)+~black_end;

//New model
~basic_sum_harm = ((~white_count_harm+~black_count_harm)*10);

~special_sum_harm = switch (~adder_harm,
	0,0, //HARM1
	1,0, //HARM1
	2,10, //HARM2
	3,if(~menu2.value == 2, {10}, {20}), //HARM2-3
	4,if(~menu2.value == 3, {//Harm3
		if(or(~class_fund == 10, ~class_fund == 11), {30},{20})},
	{if(~menu2.value == 4, {30},//Harm4
		{30},
	)
	}),
	5, if(~menu2.value == 5,
	{if(or(~class_fund == 0, or(~class_fund == 5, ~class_fund == 6)), {30}, {40})},
	{if(~class_fund == 6, {40}, {40})}), //H4-6
	6, if(or(~class_fund == 0, ~class_fund == 5), {40}, {50}),
	7,if(or(~class_fund == 0, ~class_fund == 5), {50}, {60}),
	8, if(~menu2.value == 12,
	{if(~class_fund == 10, {70}, {60})},
	{if(~menu2.value == 13,
			{if(or(~class_fund >= 9, ~class_fund == 4), {70}, {60})},
			{if(~menu2.value == 14,
				{if(~class_fund == 0, {60}, {70})},
				{if(or(~class_fund == 0, ~class_fund == 5), {60}, {70})}
			)}
			)}
	)
	,
	9,70,





	/*///THIS ALL MUST CHANGE
	0,0, //HARM1
	1,0, //HARM1
	2,10, //HARM2
	3,0, //HARM2
	5,20+10, //HARM3
	6,if(or(~class_fund == 10, ~class_fund == 11), {30},{20}),//HARM3
	7,0,
	8,0,
	10,30, //HARM4
	11,30, //HARM4
	12,30, //HARM4
	17,if(or(~class_fund == 5, ~class_fund == 6), {30}, {40}), //HARM5
	18,if(or(~class_fund == 7, ~class_fund == 0), {30}, {40}), //HARM5
	25,if(or(~class_fund == 10, ~class_fund == 11), {50}, {40}), //HARM6
	27,if(or(or(~class_fund == 3, ~class_fund == 4), ~class_fund >= 8), {50}, {40}), //HARM7
	28,if(or(~class_fund > 5, ~class_fund == 2), {50}, {40}), //HARM7
*/








	/*
				0, 0,
				1, 0,
				2, 10,
	3,{if(~menu2.value == 3, {20},{20-10})}, //Added -10 and also made if, Used for HARM 3
	4,{if(or(~class_fund == 4, ~class_fund == 5),{20},{30})},//Used for HARM 3
	5,0,
	6,30, //Used for HARM4 and HARM8
	7, 30, //Used for HARM4 and HARM8
	8, 0,
	9, {if(or(~class_fund == 4, ~class_fund == 3), {40}, {30})}, //Used for HARM5
	10, {if(~class_fund == 0, {30}, {40})}, //Used for HARM5
	11, 0,
	12, 0,
	13, {if(~class_fund == 11, {50}, {40})}, //Used for HARM6
	14, {if(and(~class_fund == 10, ~menu2.value == 6), {50},
		{
			if(and(~menu2.value == 7, or(~class_fund == 3, or(~class_fund == 8, ~class_fund == 11))), {50}, {40})})}, //Used for HARM6 and HARM7
	15, {if(or(~class_fund == 2, or(~class_fund == 4, or(~class_fund == 7, or(~class_fund == 9, ~class_fund == 10)))), {50}, {40})}, //Used for HARM7
	16, 0,
	17, 0,
	18, 0,


	*/
);

~case_whole_tone_starts_white_harm = if(~array_note_color[~fslider.value.linlin(0,1,21,108)+~current_harmonic_MIDINN_harm-21] == 0, //Starts on white
				{if(~white_count_harm == 2, //Two white keys
					{if(~array_note_color[~fslider.value.linlin(0,1,21,108)+~current_harmonic_MIDINN_harm-21+1] == 1, //The second semitone in the array is a black key
						{-10},{0});}, {0})},
				{0});

~case_semitone_harm = if(~max_val_harm == 2, //Array size of 2
				{if(~white_count_harm != 2, //Ensure it's not an E-F or B-C case
					{-10},{0})},{0});

~case_starts_black_harm = if(~array_note_color[~fslider.value.linlin(0,1,21,108)+~current_harmonic_MIDINN_harm-21] == 1, //Starts on black
				{if(~max_val_harm != 2, //Only if not a semitone case (see previous rule)
					{-10+10}//Needs to be 0, not sure why
		,{0})},
				{0});

~deviant_scale_harm = ~basic_sum_harm + ~special_sum_harm + ~case_whole_tone_starts_white_harm + ~case_semitone_harm + ~case_starts_black_harm;
		);
//Here ends that calculation for distance

///WHY IS ~adder_harm EVER above 7? That's ridiculously high and does not match up with the array. There seems to be an issue here - the switch also is likely going to either need a proper algorithm or for every special case the ~menu2.value needs to be added as an IF or AND.

[~adder_harm, ~class_fund, ~deviant_scale_harm, ~basic_sum_harm, ~special_sum_harm, ~case_whole_tone_starts_white_harm,  ~case_semitone_harm,~case_starts_black_harm].postln;

//Helpful format if needed:
/*if(~menu2.value==3,
		{if(or(~class_fund == 10, ~class_fund == 11), {30},
			{if(or(~class_fund == 4, ~class_fund == 5), {20},
				{20})
			}
		)
		}
	)*/