//TUNING Module
(
//Z. Reset to blank slate
(
//Ensure all other windows are closed
Window.closeAll;

//Clear all nodes in the server
s.freeAll;
);

//interim. Activate the module with standards
(
//Opens the module only once the server is working completely
s.waitForBoot({

//Provides code shorthand to call files in same or sub-folders.
var basePath = thisProcess.nowExecutingPath.asString.dirname;

//Avoids delay when the Recording button is pressed
//s.prepareForRecord;

//A. Create window and aesthetics
(
//Positions the note name text
~note_name_bounds_array = [(85-23+30-5),155,27,15];

//Create the module's master window
~master_window_bounds_array = [Window.screenBounds.width/2-250, Window.screenBounds.height/2-50, 500, 570];
(basePath +/+  "modules/master_window.scd").load;

//Descriptive paragraph at top
~para.string_(
"Welcome to the MAPLE Lab Overtone 'Popout' Demonstration (Beta)! Using the parameters below, you can examine the fusion effect. Select the number of harmonics and which harmonic to move out-of-tune using the dropdown menus. Use the Play/Stop button to start and stop the sound. To explore how fusion/unfusion occurs, use the slider to change the deviation of the selected harmonic."
	);

//Load graphics elements
~maple_icon = Image.new(basePath +/+ "images/mapleICON-small.png");
~keyboard_image = Image.new(basePath +/+ "images/keyboard_small.png");

//All graphics (aesthetic lines and image positions)
w.drawFunc = {
		//Images underneath buttons
		~maple_icon.drawInRect(Rect(465,95,30,30), Rect(0,0,30,30), 2, 1.0); // only a section
		~keyboard_image.drawInRect(Rect(250+75,330,60,25), Rect(0,0,60,25), 2, 1.0);

		//Draw lines
		Pen.use{
			Pen.line(10@240,490@240);
			Pen.line(10@175,490@175);
			Pen.line(10@330,490@330);
			Pen.line(10@130,490@130);
			Pen.line(10@90,490@90);

			Pen.strokeColor = Color(0,0,0,0.5);
			Pen.width = 2;
			Pen.stroke;
			};//Top line, written differently in code
        };

//Create spectra
~spectraScreenComposite_bounds_array = [-100+100,355,500,215];
~spectraButton_bounds_array = [250-(200/2)-65,200+135,110,20];
~spectraAutoscale_bounds_array = [250-(200/2)-65+110+10,200+135,110,20];
(basePath +/+  "modules/spectra_screen.scd").load;
);

//Button CompositeViews for hiding and showing
(
~play_image_left = Image.new(basePath +/+ "images/big_button_media/red_left.png");
~play_image_right = Image.new(basePath +/+ "images/big_button_media/red_right.png");
~play_image_indent = Image.new(basePath +/+ "images/big_button_media/red_indent_col.png");

~stop_image_left = Image.new(basePath +/+ "images/big_button_media/black_left.png");
~stop_image_right = Image.new(basePath +/+ "images/big_button_media/black_right.png");
~stop_image_indent = Image.new(basePath +/+ "images/big_button_media/black_indent_col.png");

~play_UserView = UserView(w, Rect(250-(250/2),95,100,30));
	~play_UserView.drawFunc_({
		~play_image_left.drawInRect(Rect(0,0,100,30), Rect(0,0,200,60), 2, 1.0);
		~play_image_right.drawInRect(Rect(0,0,100,30), Rect(0,0,200,60), 2, 1.0);
		~play_image_indent.drawInRect(Rect(25,0,100,30), Rect(0,0,200,60), 2, 1.0);
	});

~stop_UserView = UserView(w, Rect(250-(250/2),95,100,30));
	~stop_UserView.drawFunc_({
		~stop_image_left.drawInRect(Rect(0,0,100,30), Rect(0,0,200,60), 2, 1.0);
		~stop_image_right.drawInRect(Rect(0,0,100,30), Rect(0,0,200,60), 2, 1.0);
		~stop_image_indent.drawInRect(Rect(25,0,100,30), Rect(0,0,200,60), 2, 1.0);
	});

	//~play_UserView.bounds_(Rect(400-(100/2),65,1,1)); //Hide the play button
	~stop_UserView.bounds_(Rect(400-(100/2),65,1,1)); //Hide the stop button
);

//B. Add starting ID parameters
(
~module_ID = "tuning";
~inspectorExists = 0;
);

//E. Interactive elements
(
//Record button - sends to Supercollider file in the Recordings section
~record_button_bounds_array = [35, 100, 85, 20];
(basePath +/+  "modules/record_button.scd").load;


//VOLUME
//Properties of the slider
	~volume_value = 1.2;

~volslider = Slider(w, Rect(160,140,330,15))
	.background_(Color(0.0118,0.0118,0.0118,1))
	.value_(0.3)
	.action_({
	arg obj;
	var cf;
		cf = obj.value.linlin(0,1,0,4)/*.postln*/; //Boosts the audio volume (hidden from user)
		if(
		x.isPlaying,
		{x.set(\vol,cf)});
	~numberVBox.value_(obj.value.linlin(0,1,0,1)); //Acts as an invisible change so even though it seems 1:1 it's really 1:4
		~volume_value = ~volslider.value.linlin(0,1,0,4);

})
	.orientation_(\horizontal);

//Label for Vol.
~volLabel = StaticText(w,Rect(10,143,70,15))
.string_("Volume")
.font_(Font("nil", 8, italic:false))
.align_(\topRight)
.background_(Color(0,0,0,0.0))
.stringColor_(Color.black);

//Number box that can edit slider position
~numberVBox = NumberBox(w,Rect(85,140,72,15))
	.normalColor_(Color.white)
	.background_(Color(0.0118,0.0118,0.0118,1))
	.value_(0.3)
.clipLo_(0)
.clipHi_(1)
.font_(Font("nil",7))
.decimals_(1)
.align_(\center)
.action_({
	arg obj;
		~volslider.valueAction_(obj.value.linlin(0,1,0,1)) //Acts as an invisible change so even though it seems 1:1 it's really 1:4
});



	//TONIC FREQUENCY

//Label for Freq.
~fLabel = StaticText(w,Rect(10-10,158,80,25))
.string_("Fundamental")
.font_(Font("nil", 8))
.align_(\topRight)
.background_(Color(0,0,0,0))
.stringColor_(Color.black);



//Properties of the slider
~fslider = Slider(w, Rect(160,155,330,15))
	.background_(Color(0.8,0.8,0.8,0.75)).value_(48/87)
	.step_(1/(108-21)) //Math: 108-21 = 87; 69-21 = 48; 48/87 =
	.action_({
	arg obj;
	var cf;
	cf = obj.value.linlin(0,1,21,108)/*.postln*/;
		~fundamental_note = obj.value.linlin(0,1,21,108);
		~fundamental_note/*.postln*/;
		~fund = ~fundamental_note-1;

			if(x.isPlaying,{
x.set(\fundamental_note, obj.value.linlin(0,1,21,108););
			});


		~freqslider.valueAction_(~freqslider.value.linlin(0,1,0,1)); //Updates the deviation dot

if(~vinbutton.value == 1, {
		(basePath +/+  "data/tuning_arrays-1.scd").load; //This line MUST come before the functions affecting the Keyboard as the array values must exist to provide the data
			}, {~color_array = Array.fill(200,1);});

		(basePath +/+  "data/tuning_frequency_slider.scd").load; //This calls the naming function from another code block to help keep this program clean and modular

		(if(~key_vis.value == 1, {
			(basePath +/+  "data/tuning_keyboard_GUI_colours.scd").load;
		}));


		if(
		x.isPlaying,
		{x.set(\freqX,cf)});

~fundamental_freq = ((2**((-69+~fundamental_note)/12))*440);
		~numberfBox.value_(~fundamental_freq);

				if(~spectraButton.value == 1,{
			//{~spectraButton.valueAction_(1);}); // Automatically updates the Autoscaling
			~spectra_scopeAutoscaleFunction.value;}) // Bypass the Button system entirely to reduce CPU load


})
	.orientation_(\horizontal);

	//Number box that can edit slider position (NO LONGER BECAUSE NOW NOT SET TO FREQUENCY, NEEDS MATH OTHERWISE)
//Displays the frequency
~numberfBox = NumberBox(w,Rect(85+30,155,72-30,15))
.value_(440)
//.clipLo_(21)
//.clipHi_(108)
.font_(Font("nil",12))
.decimals_(1)
.align_(\center)
.action_({
	arg obj;
	//~fslider.valueAction_(obj.value.linlin(21,108,0,1))
});

		// Cover to avoid editing
~numberBox_Cover = StaticText(w,Rect(85+30,155,72-30,15))
	.background_(Color.clear);



///Starter harmonics array (sets everything to 0) arrays
~harmonics_array = Array.fill(16, {arg i; 1});
~harmonics_array[0..7] =0; //Starting value (first 8 currently)
~harmonic_count = 0;
~intensity_array = Array.fill(1, {arg i; 0});
~harmonic_sums = Array.fill(0, {arg i; 0});
~fundamental_note = ~fslider.value.linlin(0,1,21,108); //Middle C
~fundamental_freq = ((2**((-69+~fundamental_note)/12))*440);
~manipulated_harmonic = Array.fill(16, {arg i; 0});
	~color_array = Array.fill(200,1);


//Label for Focus tone
~label2 = StaticText(w,Rect(10,177+65+2,480,80))
	.string_("Harmonic (mistuned)")
.font_(Font("nil", 16))
.align_(\topLeft)
.background_(Color(0,0,0,0))
.stringColor_(Color.black);

//Label for Other tones
~label1 = StaticText(w,Rect(10,270-90,480,80))
	.string_("Harmonics (tuned)")
.font_(Font("nil", 16))
.align_(\topLeft)
.background_(Color(0,0,0,0))
.stringColor_(Color.black);


//Define the sound to be played
(
SynthDef.new("sound", {
	arg freqX = 21, outoftune = 0, intensity = 1, other = 1, vol = 0+~volume_value, harmToggle1=1, harmToggle2=1, harmToggle3=1, harmToggle4=1, harmToggle5=1, harmToggle6=1, harmToggle7=1, harmToggle8=1, harmToggle9=1, harmToggle10=1, harmToggle11=1, harmToggle12=1, harmToggle13=1, harmToggle14=1, harmToggle15=1, harmToggle16=1,
			choose1=0,
			choose2=0,
			choose3=0,
			choose4=0,
			choose5=0,
			choose6=0,
			choose7=0,
			choose8=0,
			choose9=0,
			choose10=0,
			choose11=0,
			choose12=0,
			choose13=0,
			choose14=0,
			choose15=0,
			choose16=0
			;

	var mul, mul2, signal, freq/*, freq_ex, freq_u*/;

	mul = XLine.kr(0.01,1,0.2,0.1); //Ramps sound onset so not so harsh
			mul2 = XLine.kr(0.01,1,0.2,0.1); //Ramps sound onset so not so harsh

/*			freq_ex = ((-49+freqX)/12); //this section converts the MIDI key note value to the frequency value (where 49 = A4)
			freq_u =2**(freq_ex); */
			freq = ((2**((-69+freqX)/12))*440);

	signal =

	SinOsc.ar(freq*(1+(outoftune*choose1)),
				0, ((mul*(1-choose1))+(mul2*choose1))*((other*(1-choose1))+(intensity*(choose1)))*vol*harmToggle1) +
	SinOsc.ar(freq*(2+(outoftune*choose2)),
				0, ((mul*(1-choose2))+(mul2*choose2))*((other*(1-choose2))+(intensity*(choose2)))*vol*harmToggle2) +
	SinOsc.ar(freq*(3+(outoftune*choose3)),
				0, ((mul*(1-choose3))+(mul2*choose3))*((other*(1-choose3))+(intensity*(choose3)))*vol*harmToggle3) +
	SinOsc.ar(freq*(4+(outoftune*choose4)),
				0, ((mul*(1-choose4))+(mul2*choose4))*((other*(1-choose4))+(intensity*(choose4)))*vol*harmToggle4) +
	SinOsc.ar(freq*(5+(outoftune*choose5)),
				0, ((mul*(1-choose5))+(mul2*choose5))*((other*(1-choose5))+(intensity*(choose5)))*vol*harmToggle5) +
	SinOsc.ar(freq*(6+(outoftune*choose6)),
				0, ((mul*(1-choose6))+(mul2*choose6))*((other*(1-choose6))+(intensity*(choose6)))*vol*harmToggle6) +
	SinOsc.ar(freq*(7+(outoftune*choose7)),
				0, ((mul*(1-choose7))+(mul2*choose7))*((other*(1-choose7))+(intensity*(choose7)))*vol*harmToggle7) +
	SinOsc.ar(freq*(8+(outoftune*choose8)),
				0, ((mul*(1-choose8))+(mul2*choose8))*((other*(1-choose8))+(intensity*(choose8)))*vol*harmToggle8) +
	SinOsc.ar(freq*(9+(outoftune*choose9)),
				0, ((mul*(1-choose9))+(mul2*choose9))*((other*(1-choose9))+(intensity*(choose9)))*vol*harmToggle9) +
	SinOsc.ar(freq*(10+(outoftune*choose10)),
				0, ((mul*(1-choose10))+(mul2*choose10))*((other*(1-choose10))+(intensity*(choose10)))*vol*harmToggle10) +
	SinOsc.ar(freq*(11+(outoftune*choose11)),
				0, ((mul*(1-choose11))+(mul2*choose11))*((other*(1-choose11))+(intensity*(choose11)))*vol*harmToggle11) +
	SinOsc.ar(freq*(12+(outoftune*choose12)),
				0, ((mul*(1-choose12))+(mul2*choose12))*((other*(1-choose12))+(intensity*(choose12)))*vol*harmToggle12) +
	SinOsc.ar(freq*(13+(outoftune*choose13)),
				0, ((mul*(1-choose13))+(mul2*choose13))*((other*(1-choose13))+(intensity*(choose13)))*vol*harmToggle13) +
	SinOsc.ar(freq*(14+(outoftune*choose14)),
				0, ((mul*(1-choose14))+(mul2*choose14))*((other*(1-choose14))+(intensity*(choose14)))*vol*harmToggle14) +
	SinOsc.ar(freq*(15+(outoftune*choose15)),
				0, ((mul*(1-choose15))+(mul2*choose15))*((other*(1-choose15))+(intensity*(choose15)))*vol*harmToggle15) +
	SinOsc.ar(freq*(16+(outoftune*choose16)),
				0, ((mul*(1-choose16))+(mul2*choose16))*((other*(1-choose16))+(intensity*(choose16)))*vol*harmToggle16)
	;
//ORIGINALLY: the third harmonic can be varied 720-778, using Dr. Steven Brown's 2MP3 2015-2016 class; while estimation that critical bandwidth at this frequency is approximately 150, so 150/4 = 37.5, and 720+37.5 =757.5 and derivation of the two-tone dissonance formula from Plomp 1965 gives g_max = 1.01931f + 17.4672 = 751.3704, this does not necessarily mean it gives the most 'unfused' effect for students
	Out.ar([0,1], signal); //sends to busses 1 & 2 (stereo), and plays the var "signal"
}).add;
);


//Spacing arrays
~array_note_numbers = Array.fill((108-21+1), {arg i;  21 + i});
//~array_note_name;

//Note colour array (0 : white, 1 : black) (~array_note_color), starting on the 21st MIDI Note and ending on the 108th (can call using ~array_note_color[i] or ~array_note_color[MIDINN-21])
(~bit = 0; ~queue = 1;

~array_note_color = Array.fill((/*108-21+1*/ 200), { arg i;

	if( i > 2, {

		if( ~bit == 0, {
			(~queue = ~queue+1;
				if((~queue % 6)==0,{~queue = 1; ~bit = 1});
			);
			if(i.odd, {0},{1})}, {
			(~queue = ~queue+1;
				if((~queue % 8)==0,{~queue = 1; ~bit = 0});
			);
			if(i.even, {0},{1})
		});

	},
		{if(i < 1, {0}, {
			if(i < 2, {1}, {0})
		})
		});

	});
);


//Frequency DEVIATION of deviant
//Properties of the slider
~freqslider = Slider(w, Rect(160,200+65+30,330,30))
.background_(Color(0.8,0.8,0.8,0.75))
.value_(0.5)
.action_({
	arg obj;
	var cf;
	cf = obj.value.linlin(0,1,-1,1)/*.postln*/;
		if(
		x.isPlaying,
		{x.set(\outoftune,cf)});
	~numberBox.value_(obj.value.linlin(0,1,-1,1));


//Deviant control for keyboard GUI to shift the inner fill square
if(~key_vis.value == 1,
			{
		(
//What is the fundamental note? Gives MIDI Note Number (MIDINN)
//~fslider.value.linlin(0,1,21,108);

//What is the harmonic being deviated? Gives the harmonic being used, 1-16
//~menu2.value;


//The percentage (in decimal) from which the new frequency has gone from original to the new value, in an linear method (Should get value from the deviant slider). Gives decimal
~deviant_move = ~freqslider.value.linlin(0,1,-1,1);

			//Is it going in the positive or negative deviation? Gives {-1, 0, 1}; NEEDS TO BE AFTER ~deviant_move is created and given a value, otherwise errors
//~deviant_move.sign;

//How many semitones does that harmonic move it? 2 switch systems, the one used depends on the sign; Gives the maximum number of semitones to move away from the deviating note.
~deviant_maximum =
			if(~deviant_move.sign >= 0,
				{(//IF POSITIVE DIRECTION:
					switch (~menu2.value,
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
					);
				);},

				{(//IF NEGATIVE DIRECTION:
					switch (~menu2.value,
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
~current_harmonic_MIDINN = switch (~menu2.value,
				0,0, //To avoid errors if none selected
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

~current_harmonic_MIDINN_neg = switch (~menu2.value-1,
				-1,0, //To avoid errors if none selected
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


~array_fund = ~fundamental_note-21;


//Note ID, must be before the scale calculators!
(basePath +/+  "data/switch_fund_ID.scd").load;

//This calculates the ~deviant_scale distance}
if(~deviant_move.sign >= 0,
				{(basePath +/+  "data/tuning_deviant_scale.scd").load;},
				{(basePath +/+  "data/tuning_deviant_scale-neg.scd").load;});

		//	(basePath +/+  "data/tuning_deviant_scale.scd").load;

/*			(thisProcess.nowExecutingPath.asString.dirname +/+  "data/tuning_deviant_scale.scd").load;*/

//Where does the dot start? A0 = 0

//Counts the number of black keys from A0
~black_count_fund = ~array_note_color[0..~array_fund.asInteger].sum;

//Counts the number of white keys from A0
~white_count_fund = ~array_fund-~black_count_fund+1;

//Calculates starting position of fundamental for the red dot
~starting_position_fund = if(~array_note_color[~array_fund.asInteger] == 1,
				{((~white_count_fund)*20)-10},
				{((~white_count_fund-1)*20)});

//This calculates the ~deviant_scale_harm distance
(basePath +/+  "data/tuning_deviant_scale_harm-2.scd").load;
//~deviant_scale_harm = 0;
~starting_position_harm = if(~menu2.value < 2,
				{0},
				{~deviant_scale_harm}); //BUT NEEDS TO USE THE PREVIOUS HARMONIC'S SCALE


~case_none_selected =
			if(~menu2.value == 0,
				{2000}, //Hides the red dot by moving off-screen to the right
				{0}
			);




//The actuator for this motion
~keyboard_CompositeView_White.bounds_(Rect(27+(~deviant_move*~deviant_scale)+1+~starting_position_fund+~starting_position_harm+~case_none_selected,175+1,5-1,5-1))
);
			},
			{
					//"Key Vis not open".postln
			});



});

//Label for Freq.
~freqLabel = StaticText(w,Rect(15,200+7+65+30,65,40))
.string_(" Deviation")
.font_(Font("nil", 12))
.align_(\topRight)
.background_(Color(0,0,0,0))
.stringColor_(Color.black);

//Number box that can edit slider position
~numberBox = NumberBox(w,Rect(85+35,200+65+30,72-35,30))
.value_(0)
.clipLo_(-1)
.clipHi_(1)
.font_(Font("nil",12))
.decimals_(2)
.align_(\center)
.action_({
	arg obj;
	~freqslider.valueAction_(obj.value.linlin(-1,1,0,1))
});

//Button to reset deviant
~reset = Button(w, Rect(250-(200/2)-65,200+65+30,35,30))
.states_([
	["Reset
to 0", Color.white,Color(0.4824, 0.4863, 0.4863,1)]
])
.font_(Font("nil", 8))
.action_({
		~freqslider.valueAction_(3.value.linlin(2,4,0,1));
});


//INTENSITY of deviant
//Properties of the slider
~mulslider = Slider(w, Rect(160,235+60-30,330,30))
.background_(Color(0.8,0.8,0.8,0.75))
	.value_(0.5) //is converted to 1
.action_({
	arg obj;
	var cf;
	cf = obj.value.linlin(0,1,0.0,2)/*.postln*/;
		if(
		x.isPlaying,
		{x.set(\intensity,cf)});
	~number2Box.value_(obj.value.linlin(0,1,0.0,2));
	/*	if(
			obj.value == 1, {
				a = {SinOsc.ar(440)}.play}, {
				a.free;
		});*/

		~fslider.valueAction_(~fslider.value); //This allows it to refresh real-time
		s.makeBundle(1.0, //sound delay
			{~dirtyBit = 5; ~dirtyBit/*.postln*/;~fslider.valueAction_(~fslider.value);});

	});

//Label for Freq.
~mulLabel = StaticText(w,Rect(15,240+60-30,65,40))
.string_("Intensity")
.font_(Font("nil", 12))
.align_(\topRight)
.background_(Color(0,0,0,0))
.stringColor_(Color.black);

//Number box that can edit slider position
~number2Box = NumberBox(w,Rect(85,235+60-30,72,30))
.value_(1)
.clipLo_(0.0)
.clipHi_(2)
.font_(Font("nil",16))
.decimals_(2)
.align_(\center)
.action_({
	arg obj;
	~mulslider.valueAction_(obj.value.linlin(0.0,2,0,1))
});


//OTHER
//Properties of the slider
~otherslider = Slider(w, Rect(160,290-90,330,30))
.background_(Color(0.8,0.8,0.8,0.75))
	.value_(0.5) //is converted to 1
.action_({
	arg obj;
	var cf;
	cf = obj.value.linlin(0,1,0.0,2)/*.postln*/;
		if(
		x.isPlaying,
		{x.set(\other,cf)});
	~number3Box.value_(obj.value.linlin(0,1,0.0,2));



~fslider.valueAction_(~fslider.value); //This allows it to refresh real-time
		s.makeBundle(1.0, //sound delay
			{~dirtyBit = 5; ~dirtyBit/*.postln*/;~fslider.valueAction_(~fslider.value);});


});

//Label for Freq.
~otherLabel = StaticText(w,Rect(15,300-90,65,40))
.string_("Intensity")
.font_(Font("nil", 12))
.align_(\topRight)
.background_(Color(0,0,0,0))
.stringColor_(Color.black);

//Number box that can edit slider position
~number3Box = NumberBox(w,Rect(85,290-90,72,30))
.value_(1)
.clipLo_(0.0)
.clipHi_(2)
.font_(Font("nil",16))
.decimals_(2)
.align_(\center)
.action_({
	arg obj;
	~otherslider.valueAction_(obj.value.linlin(0.0,2,0,1))
});



	//Keyboard visualizer button
		~key_vis = Button.new(w, Rect(250+75,330,60,25))
	.states_([["", Color.black, Color.clear],["CLOSE", Color.white, Color(0,0,0,0.7)]])
	.font_(Font("nil", 10))
	.action_({

arg obj;
		if(obj.value == 1,
				// ~keyboard_open.value == 1,
			{
					// ~keyboard_open = 0;
	(basePath +/+  "modules/keyboard.scd").loadPaths; //This line allows all contact buttons to be updated automatically
					~fslider.valueAction_(~fslider.value); //This allows it to refresh real-time

					if(~vinbutton.value == 1, {
						~greyIntensity = 0.5;
						~deviant_fill.background_(Color.black);
						});

		},{

~keyboardWindow.close;
					// ~keyboard_open = 1;
		};);

		});




//Dropdown harmonic value number
~harmonic_count = 8; //The dropdown is already set to open at 8, and this just ensures the starting value is also 8, for the Harmonic deviator.



//Dropdown menus
//Preset
	(
s.waitForBoot({

 var menu, snd, funcs2, b;

				menu = ~harmonics_menu; //Without having to recode everything, it allows the dropdown menu to be a global variable

 ~vinbutton = Button(w, Rect(250-(250/2),95,100,30))
  .states_([
				[
						""
						//"            Click to Play # of Harmonics"
						, Color.white,
						Color.clear
						//Color(0.7569,0.1373,0.1725,1)
					], [

						""
						//"            Click to Stop Sound"
						, Color.white,
						Color.clear
						//Color.grey(0.251)
				]]);

~vinbutton.mouseDownAction_({ arg obj;
				if(~vinbutton.value == 0, {

						if(~key_vis.value == 1, {
						~greyIntensity = 0.5;
						~deviant_fill.background_(Color.black);
						});
					//snd.postln;
						~stop_UserView.bounds_(Rect(250-(250/2),95,100,30));

						~harmonics_menu.background_(Color.black);
						~harmonics_menu.stringColor_(Color.white);

						// This line is necessary for sound generation bu SC is not happy with it:
							snd = funcs2.at(~harmonics_menu.value).play /*+ funcs2.at(menu2.value).postln*/;


					//snd.postln;
	//~fslider.valueAction_(~fslider.value); //This allows it to refresh real-time
				/*s.makeBundle(3.0, //sound delay
			{~dirtyBit = 4; ~dirtyBit/*.postln*/;~fslider.valueAction_(~fslider.value);});*/


						},{
												~stop_UserView.bounds_(Rect(250-(250/2),95,1,1));


	~harmonics_menu.background_(Color(0.7569-0.1,0.1373-0.1,0.1725-0.1,1));
						~harmonics_menu.stringColor_(Color.black);

						x.free; /*~fslider.valueAction_(0.value.linlin(21,108,0,1));*/


						//Reset to base colours when not playing
						if(~key_vis.value == 1, {
						~color_array = Array.fill(200,1);
							~greyIntensity = 1.0;
							~deviant_fill.background_(Color.clear);
						(basePath +/+  "data/tuning_keyboard_GUI_colours.scd").load;
						});

					}
			)})
  .action_({ arg mod;
/*~menu2.allowsReselection;
				~menu2.value_(0);
				~menu2.valueAction_(0);*/


    snd.release;
				~fslider.valueAction_(~fslider.value); //This allows it to refresh real-time
		s.makeBundle(1.0, //sound delay
			{~dirtyBit = 5; ~dirtyBit/*.postln*/;~fslider.valueAction_(~fslider.value);});


				(if(
		~vinbutton.value == 1, //Helps ensure this function activates
					{x.set(\vol,~volume_value)})); //Conserves the volume value between sound on/off and ensures it plays

//			~volslider.valueAction_(0.3);

			});

~harmonics_menu = PopUpMenu(w, Rect(250-(250/2)+5,95+5,50,20));
			~harmonics_menu.items_(["1", "2", "3", "5", "8", "16"]);
			~harmonics_menu.background_(Color(0.7569-0.1,0.1373-0.1,0.1725-0.1,1));
			~harmonics_menu.font_(Font(\size, 12));
			~harmonics_menu.allowsReselection_(true);
			~harmonics_menu.valueAction_(4); //Starts the menu at position 4 (i.e. 8 harmonics)
			~harmonics_menu.action = { arg menu, menu2;

					// Make the needed harmonics to be affected available
(
switch (~harmonics_menu.value,
							0,{~menu2_hold_value = ~menu2.value;~menu2.items_(["--","1"]);
								(
AppClock.sched(0.01,{
   // "0.01 seconds after load, the Harmonic is set to 5".postln;
			~menu2.valueAction_(~menu2_hold_value);
    nil;
});
);},
							1,{~menu2_hold_value = ~menu2.value;~menu2.items_(["--","1","2",]);(
AppClock.sched(0.01,{
   // "0.01 seconds after load, the Harmonic is set to 5".postln;
			~menu2.valueAction_(~menu2_hold_value);
    nil;
});
);},
							2,{~menu2_hold_value = ~menu2.value;~menu2.items_(["--","1","2","3"]);(
AppClock.sched(0.01,{
   // "0.01 seconds after load, the Harmonic is set to 5".postln;
			~menu2.valueAction_(~menu2_hold_value);
    nil;
});
);},
							3,{~menu2_hold_value = ~menu2.value;~menu2.items_(["--","1","2","3","4","5"]);(
AppClock.sched(0.01,{
   // "0.01 seconds after load, the Harmonic is set to 5".postln;
			~menu2.valueAction_(~menu2_hold_value);
    nil;
});
);},
							4,{~menu2_hold_value = ~menu2.value;~menu2.items_(["--","1","2","3","4","5","6","7","8"]);(
AppClock.sched(0.01,{
   // "0.01 seconds after load, the Harmonic is set to 5".postln;
			~menu2.valueAction_(~menu2_hold_value);
    nil;
});
);},
							5,{
~menu2_hold_value = ~menu2.value;~menu2.items_(["--","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16"]);
								(
AppClock.sched(0.01,{
   // "0.01 seconds after load, the Harmonic is set to 5".postln;
			~menu2.valueAction_(~menu2_hold_value);
    nil;
});
);
							}
					);
				);
					//~menu2.items_(["--","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16"]);

				[menu.value, menu.item, menu.action].postln; //These lines allow below allow the menu clicker to auto-set the choice selected (not requiring to click on-off the button to set the dropdown selection)

			//	~vinbutton.valueAction_(0);
				x.free;
				//~vinbutton.valueAction_(1); //FOR SOME REASON THIS DOES NOT WORK NOW (UNKNOWN CAUSE FOR BREAK, NEEDS CONTINUED INVESTIGATION), current workaround is to just keep the big button off
				//This gives a delay just enough so that the auto-playing works. Unknown why can't be set to immediately, as above used to work.
				if(~vinbutton.value == 1, {

						/*(
AppClock.sched(0.01,{
    //"0.1 seconds after set, HELLO".postln;

						~vinbutton.valueAction_(0);
							//~stop_UserView.bounds_(Rect(250-(250/2),95,100,30));
    nil;
});

);*/

					(
AppClock.sched(0.05,{
    //"0.1 seconds after set, HELLO".postln;

						~vinbutton.valueAction_(1);
							~stop_UserView.bounds_(Rect(250-(250/2),95,100,30));
    nil;
});

);
					});

	// ~fslider.valueAction_(~fslider.value); //This allows it to refresh real-time
/*				s.makeBundle(1.0, //sound delay
			{~dirtyBit = 5; /*~dirtyBit.postln;*/~fslider.valueAction_(~fslider.value);});*/


snd = funcs2.at(menu.value).play;




			};


 funcs2 = [

				{~harmonic_count = 1; ~harmonics_array[0] =0; ~harmonics_array[1..15] =1;
						~fslider.valueAction_(~fslider.value); //This allows it to refresh real-time
				s.makeBundle(1.0, //sound delay
			{~dirtyBit = 5; /*~dirtyBit.postln;*/~fslider.valueAction_(~fslider.value);});



					x = Synth(
				\sound,
				[
						\outoftune, ~freqslider.value.linlin(0,1,-1,1),
						\intensity, ~mulslider.value.linlin(0,1,0.0,2),
						\other, ~otherslider.value.linlin(0,1,0.0,2),
						\freqX, ~fslider.value.linlin(0,1,21,108),
							\harmToggle1, 1,
							\harmToggle2, 0,
							\harmToggle3, 0,
							\harmToggle4, 0,
							\harmToggle5, 0,
							\harmToggle6, 0,
							\harmToggle7, 0,
							\harmToggle8, 0,
							\harmToggle9, 0,
							\harmToggle10, 0,
							\harmToggle11, 0,
							\harmToggle12, 0,
							\harmToggle13, 0,
							\harmToggle14, 0,
							\harmToggle15, 0,
							\harmToggle16, 0,
				]
					).register; ~menu2.value_([menu.value]); //this allows the key to stay and be called at the current one without changing
					~menu2.valueAction_([menu.value]);

				},
{~harmonic_count = 2;~harmonics_array[0..1] =0; ~harmonics_array[2..15] =1;
					~fslider.valueAction_(~fslider.value); //This allows it to refresh real-time
				s.makeBundle(1.0, //sound delay
			{~dirtyBit = 5; /*~dirtyBit.postln;*/~fslider.valueAction_(~fslider.value);});

			x = Synth(
				\sound,
				[
						\outoftune, ~freqslider.value.linlin(0,1,-1,1),
						\intensity, ~mulslider.value.linlin(0,1,0.0,2),
						\other, ~otherslider.value.linlin(0,1,0.0,2),
						\freqX, ~fslider.value.linlin(0,1,21,108),
							\harmToggle1, 1,
							\harmToggle2, 1,
							\harmToggle3, 0,
							\harmToggle4, 0,
							\harmToggle5, 0,
							\harmToggle6, 0,
							\harmToggle7, 0,
							\harmToggle8, 0,
							\harmToggle9, 0,
							\harmToggle10, 0,
							\harmToggle11, 0,
							\harmToggle12, 0,
							\harmToggle13, 0,
							\harmToggle14, 0,
							\harmToggle15, 0,
							\harmToggle16, 0,
				]
					).register; ~menu2.value_([menu.value]); //this allows the key to stay and be called at the current one without changing
					~menu2.valueAction_([menu.value]);

				},
				{~harmonic_count = 3;~harmonics_array[0..2] =0; ~harmonics_array[3..15] =1;
					~fslider.valueAction_(~fslider.value); //This allows it to refresh real-time
				s.makeBundle(1.0, //sound delay
			{~dirtyBit = 5; /*~dirtyBit.postln;*/~fslider.valueAction_(~fslider.value);});

			x = Synth(
				\sound,
				[
						\outoftune, ~freqslider.value.linlin(0,1,-1,1),
						\intensity, ~mulslider.value.linlin(0,1,0.0,2),
						\other, ~otherslider.value.linlin(0,1,0.0,2),
						\freqX, ~fslider.value.linlin(0,1,21,108),
							\harmToggle1, 1,
							\harmToggle2, 1,
							\harmToggle3, 1,
							\harmToggle4, 0,
							\harmToggle5, 0,
							\harmToggle6, 0,
							\harmToggle7, 0,
							\harmToggle8, 0,
							\harmToggle9, 0,
							\harmToggle10, 0,
							\harmToggle11, 0,
							\harmToggle12, 0,
							\harmToggle13, 0,
							\harmToggle14, 0,
							\harmToggle15, 0,
							\harmToggle16, 0,
				]
					).register; ~menu2.value_([menu.value]); //this allows the key to stay and be called at the current one without changing
					~menu2.valueAction_([menu.value]);},
{~harmonic_count = 5;~harmonics_array[0..4] =0; ~harmonics_array[5..15] =1;

					~fslider.valueAction_(~fslider.value); //This allows it to refresh real-time
				s.makeBundle(1.0, //sound delay
			{~dirtyBit = 5; /*~dirtyBit.postln;*/~fslider.valueAction_(~fslider.value);});
					x.free;

			x = Synth(
				\sound,
				[
						\outoftune, ~freqslider.value.linlin(0,1,-1,1),
						\intensity, ~mulslider.value.linlin(0,1,0.0,2),
						\other, ~otherslider.value.linlin(0,1,0.0,2),
						\freqX, ~fslider.value.linlin(0,1,21,108),
							\harmToggle1, 1,
							\harmToggle2, 1,
							\harmToggle3, 1,
							\harmToggle4, 1,
							\harmToggle5, 1,
							\harmToggle6, 0,
							\harmToggle7, 0,
							\harmToggle8, 0,
							\harmToggle9, 0,
							\harmToggle10, 0,
							\harmToggle11, 0,
							\harmToggle12, 0,
							\harmToggle13, 0,
							\harmToggle14, 0,
							\harmToggle15, 0,
							\harmToggle16, 0,
				]
			).register; ~menu2.value_([menu.value]); //this allows the key to stay and be called at the current one without changing
					~menu2.valueAction_([menu.value]);},
				{~harmonic_count = 8;~harmonics_array[0..7] =0; ~harmonics_array[8..15] =1;
					x.free;

					~fslider.valueAction_(~fslider.value); //This allows it to refresh real-time
				s.makeBundle(1.0, //sound delay
			{~dirtyBit = 5; /*~dirtyBit.postln;*/~fslider.valueAction_(~fslider.value);});

			x = Synth(
				\sound,
				[
						\outoftune, ~freqslider.value.linlin(0,1,-1,1),
						\intensity, ~mulslider.value.linlin(0,1,0.0,2),
						\other, ~otherslider.value.linlin(0,1,0.0,2),
						\freqX, ~fslider.value.linlin(0,1,21,108),
							\harmToggle1, 1,
							\harmToggle2, 1,
							\harmToggle3, 1,
							\harmToggle4, 1,
							\harmToggle5, 1,
							\harmToggle6, 1,
							\harmToggle7, 1,
							\harmToggle8, 1,
							\harmToggle9, 0,
							\harmToggle10, 0,
							\harmToggle11, 0,
							\harmToggle12, 0,
							\harmToggle13, 0,
							\harmToggle14, 0,
							\harmToggle15, 0,
							\harmToggle16, 0,
				]
			).register; ~menu2.value_([menu.value]); //this allows the key to stay and be called at the current one without changing
					~menu2.valueAction_([menu.value]);},
				{~harmonic_count = 16;~harmonics_array[0..15] =0;
					x.free;

					~fslider.valueAction_(~fslider.value); //This allows it to refresh real-time
				s.makeBundle(1.0, //sound delay
			{~dirtyBit = 5; /*~dirtyBit.postln;*/~fslider.valueAction_(~fslider.value);});

			x = Synth(
				\sound,
				[
						\outoftune, ~freqslider.value.linlin(0,1,-1,1),
						\intensity, ~mulslider.value.linlin(0,1,0.0,2),
						\other, ~otherslider.value.linlin(0,1,0.0,2),
						\freqX, ~fslider.value.linlin(0,1,21,108),
							\harmToggle1, 1,
							\harmToggle2, 1,
							\harmToggle3, 1,
							\harmToggle4, 1,
							\harmToggle5, 1,
							\harmToggle6, 1,
							\harmToggle7, 1,
							\harmToggle8, 1,
							\harmToggle9, 1,
							\harmToggle10, 1,
							\harmToggle11, 1,
							\harmToggle12, 1,
							\harmToggle13, 1,
							\harmToggle14, 1,
							\harmToggle15, 1,
							\harmToggle16, 1,
				]
			).register; ~menu2.value_([menu.value]); //this allows the key to stay and be called at the current one without changing
					~menu2.valueAction_([menu.value]);}
			];


 w.front;

// p = CmdPeriod.add({ b.value_(0) }); // set button to 0 on hitting Cmd-period //Is this necessary/functional?
 w.onClose_{ snd.release; CmdPeriod.removeAll }; // clean up when window is closed

})



	);





	/////////DROPDOWN FOR CHOOSING WHICH TO AFFECT

(
s.waitForBoot({

 var menu2, snd, funcs2, b;


 /*~choosebutton = Button(w, Rect(250-(250/2),95+50,250,30))
  .states_([
				["            Click to Play # of Harmonics", Color.white, Color(0.7569,0.1373,0.1725,1)], ["            Click to Stop Sound", Color.white, Color.grey(0.251)]])


  .mouseDownAction_(

				{
					arg obj;
	if(obj.value == 0,
						{
    snd = funcs2.at(menu2.value).play;
						},{x.free}
			)})
  .action_({ arg mod;
    snd.release;
   });
*/
~menu2 = PopUpMenu(w, Rect(250-(250/2)+50,95+3+80+65+2,50,20));


//Switch function for how many to display (up to maximum) - this is above in the other dropdown; here it starts at 8 because the module opens with 8:
			~menu2.items_(["--","1","2","3","4","5","6","7","8"/*,"9","10","11","12","13","14","15","16"*/]);

			~menu2.font_(Font(\size, 12));
			~menu2.allowsReselection_(true);
			~menu2.action = { arg menu2;

				// [menu.value, menu.item, menu.action].postln; //These lines allow below allow the menu clicker to auto-set the choice selected (not requiring to click on-off the button to set the dropdown selection)
/*~choosebutton.valueAction_(0);*/
/*				x.free;*/
			/*	~choosebutton.valueAction_(1);*/

				(
					if((~menu2.value == 0),
						{~coverComposite.visible = true}, {~coverComposite.visible = false});
				);

					//~menu2_hold_value = ~menu2.value;

/*				(
					if(~menu2.value > ~menu2_hold_value/*~harmonic_count*/, {
							if(~inspectorExists == 1, {
								~inspectorError.string_("The harmonic selected was above the number of harmonics being played. Please select a lower harmonic to deviate or increase the number of harmonics being played");
							});
							~menu2.valueAction_(0);
						}, {"The harmonic selected is accepted".postln})
				);*/

					(
						if(~menu2.value == nil, //Because now those higher values do not even exist, so ~menu2 is error-set to nil when its value is higher than possible (when switching from a higher set of harmonics played to this lower one)
							{
							if(~inspectorExists == 1, {
								~inspectorError.string_("The harmonic selected for deviation was above the number of harmonics being played. Please select a lower harmonic to deviate or increase the number of harmonics being played.");

									(
AppClock.sched(10,{
   // 5 seconds after error message appears, the error message goes away
											~inspectorError.string_(" ");
    nil;
});
);

							});
							~menu2.valueAction_(0);
						})
					);

snd = funcs2.at(menu2.value).play;

				// x.set(menu.action);



			};




 funcs2 = (basePath +/+  "data/tuning_harmonic_deviant_funcs2.scd").load;




 w.front;

 p = CmdPeriod.add({ b.value_(0) }); // set button to 0 on hitting Cmd-period
 w.onClose_{ snd.release; CmdPeriod.removeAll }; // clean up when window is closed

})



	);


	~coverComposite = CompositeView(w, Rect(160-80,235+60-30,330+80,30+30));
	~coverBox = StaticText(~coverComposite, Rect(0,0,330+80,30+30)).background_(Color.white).stringColor_(Color.black).align_(\center);
	~coverBox.string = "Select a harmonic to deviate from the
Harmonic (mistuned) dropdown menu";

//Inspector button (remove upon Release)
~inspector = Button.new(w, Rect(10, 100, 20, 20))
	.states_([["(i)", Color.white, Color.gray], ["(i)", Color.gray, Color.black]])
	.font_(Font("nil", 10))
	.action_
	({ arg obj;
		if(obj.value == 1, {
		(basePath +/+  "modules/inspector.scd").loadPaths;
		},
		{
~inspectorWindow.close;
		});
	});

//Q. Quit function
(
~quit = Button.new(w, Rect(465,95,30,30))
	.states_([["", Color.white, Color.clear]])
	.font_(Font("nil", 12))
	.mouseDownAction_({
			w.close;
			~spectra_scope.kill; // Kills the FreqScopeView
			x.free; //shuts down window and scope

			(if(~record.value == 1, {
			s.stopRecording; // Auto-stops recording if started
			}));

			(if(~key_vis.value == 1, {
				~keyboardWindow.close;
			}));
			(if(~inspectorExists == 1, {
				~inspectorWindow.close;
			}));
			(basePath +/+ "splashscreen.scd").loadPaths;
		});
);

(
AppClock.sched(0.01,{
   // "0.01 seconds after load, the Harmonic is set to 5".postln;
			~menu2.valueAction_(5);
    nil;
});
);
);
});
);
)