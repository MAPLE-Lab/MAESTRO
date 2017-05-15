//Tuning Demonstration
( var basePath = thisProcess.nowExecutingPath.asString.dirname; //Provides code shorthand to call files in same or sub-folders.
s.waitForBoot({//Ensures the module only opens once the server is working completely, and automatically opens server.
	s.prepareForRecord; //Avoids lag when Record button is pressed.

//Create the window.
w = Window.new("MAPLE Lab Overtone 'Popout' Demonstration (Beta)", Rect.new(
	Window.screenBounds.width/2-250,
	Window.screenBounds.height/2-50,
		500,570),
	false) //Cannot be resized by user.
	.background_(Color.white).userCanClose_(false).front
	.acceptsMouseOver_(true)
	//.mouseOverAction_({"MouseOver".postln})
	;

//Module ID
~module_ID = "tuning";

	//Record button - sends to Supercollider file in the Recordings section.
~record = Button.new(w, Rect(35, 100, 85, 20))
	.states_
	([
		["Start Recording", Color.white,Color(0.4824, 0.4863, 0.4863,1)],
		["Stop Recording", Color.white, Color.grey(0.251)]
	])
	.font_(Font("nil", 10))
	.action_({
	arg obj;
	if(obj.value == 1,
		{s.record;},
		{s.stopRecording;}
		);
	});

//CompositeView to allow scaling of the Spectra.
~composite = CompositeView(w, Rect(-100,355,600,300)); //Needs to use Spectra bounds to not crop FreqScope.


//Spectra viewer
~spectra_width = 600;
~spectra_height = 300;
~spectra_db = 60;
f = FreqScopeView(~composite, Rect.new(0,0,~spectra_width,~spectra_height)); //Prepares frequency scope (a.k.a. spectra) from (-120,355,800,300) to (-100,355,600,300)) - for harmonic marker transformation maths
f.active_(true).freqMode_(1).dbRange_(~spectra_db);

//Descriptive paragraph at top
~para = StaticText(w,Rect(10,10,480,80))
	.string_(
"Welcome to the MAPLE Lab Overtone 'Popout' Demonstration (Beta)! Using the parameters below, you can examine the fusion effect. Select the number of harmonics and which harmonic to move out-of-tune using the dropdown menus. Use the Play/Stop button to start and stop the sound. To explore how fusion/unfusion occurs, use the slider to change the deviation of the selected harmonic."
	)
	.font_(Font("nil", 12))
	.align_(\topLeft)
	.background_(Color(0,0,0,0))
	.stringColor_(Color.black);

i = Image.new(basePath +/+ "images/mapleICON-small.png");
~keyboard_image = Image.new(basePath +/+ "images/keyboard_small.png");

//All graphics (aesthetic lines and image positions)
w.drawFunc = {
		i.drawInRect(Rect(465,95,30,30), Rect(0,0,30,30), 2, 1.0); // only a section
		~keyboard_image.drawInRect(Rect(250,330,60,25), Rect(0,0,60,25), 2, 1.0);

		Pen.use{
		Pen.line(10@240,490@240); //New line
		Pen.line(10@175,490@175); //New line
		Pen.line(10@330,490@330); //Third line
		Pen.line(10@130,490@130); //Bottom line
		Pen.line(10@90,490@90);
		Pen.strokeColor = Color(0,0,0,0.5);
			    Pen.width = 2;
                Pen.stroke};//Top line, written differently in code
        };

//Frequency on Spectra label
StaticText(w,Rect(10,200+135+200,110,20))
	.string_("Frequency")
	.stringColor_(Color.white)
	.align_(\topLeft)
	.background_(Color(0,0,0,0));


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
x.set(\fundamental_note, obj.value.linlin(0,1,21,108););
		// (basePath +/+  "data/control_keyboard.scd").loadPaths;
		//Does not seem to funciton this loadPaths as a function - liekly because cannot pull live like this
		/*//C4
		(
		if( //This IF function provides the capability to control the system
		obj.value.linlin(0,1,40,75) == 40, {a.free; //Needs to be at front because when leaving the slider position calls the first
				// a = Synth(\SimpleSine);
			~c4.background_(Color.red);
	}, {a.free; ~c4.background_(Color.white)});
	);*/


		~freqslider.valueAction_(~freqslider.value.linlin(0,1,0,1)); //Updates the deviation dot


		(basePath +/+  "data/tuning_arrays-1.scd").load; //This line MUST come before the functions affecting the Keyboard as the array values must exist to provide the data

		(basePath +/+  "data/tuning_frequency_slider.scd").load; //This calls the naming function from another code block to help keep this program clean and modular

		(if(~key_vis.value == 1, {
			(basePath +/+  "data/tuning_keyboard_GUI_colours.scd").load;
		}));





		if(
		x.isPlaying,
		{x.set(\freqX,cf)});
	~numberfBox.value_(obj.value.linlin(0,1,21,108));
	/*	~fsliderharm1.valueAction_(obj.value.linlin(0,1,(55/500),(325/500)));//must be linlin because a slider to slider is using the same exact values (no transformation required)
		~fsliderharm2.valueAction_(obj.value.linlin(0,1,(55/500+0.16),(325/500+0.16)));
				~fsliderharm3.valueAction_(obj.value.linlin(0,1,(55/500+0.254),(325/500+0.254)));
		*/
})
	.orientation_(\horizontal);

//Number box that can edit slider position
~numberfBox = NumberBox(w,Rect(85+30,155,72-30,15))
.value_(69)
.clipLo_(21)
.clipHi_(108)
.font_(Font("nil",12))
.decimals_(0)
.align_(\center)
.action_({
	arg obj;
	~fslider.valueAction_(obj.value.linlin(21,108,0,1))
});

//True note value
	~note_name = StaticText(w,Rect(85-23+30-5,155,27,15))
	.string_("A4").align_(\center)
	.font_(Font("nil", 11));

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
~para = StaticText(w,Rect(10,177+65+2,480,80))
	.string_("Harmonic (mistuned)")
.font_(Font("nil", 16))
.align_(\topLeft)
.background_(Color(0,0,0,0))
.stringColor_(Color.black);

//Label for Other tones
~para = StaticText(w,Rect(10,270-90,480,80))
	.string_("Harmonics (tuned)")
.font_(Font("nil", 16))
.align_(\topLeft)
.background_(Color(0,0,0,0))
.stringColor_(Color.black);

//Label for Spectra
~para = StaticText(w,Rect(10,335,480,80))
	.string_("Spectra")
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

(basePath +/+  "data/tuning_deviant_scale.scd").load; //This calculates the ~deviant_scale distance


//Where does the dot start? A0 = 0

//Counts the number of black keys from A0
~black_count_fund = ~array_note_color[0..~array_fund.asInteger].sum;

//Counts the number of white keys from A0
~white_count_fund = ~array_fund-~black_count_fund+1;

//Calculates starting position of fundamental for the red dot
~starting_position_fund = if(~array_note_color[~array_fund.asInteger] == 1,
				{((~white_count_fund)*20)-10},
				{((~white_count_fund-1)*20)});

//Note ID
(basePath +/+  "data/switch_fund_ID.scd").load;

(basePath +/+  "data/tuning_deviant_scale_harm-2.scd").load; //This calculates the ~deviant_scale_harm distance
//~deviant_scale_harm = 0;
~starting_position_harm = if(~menu2.value < 2,
				{0},
				{~deviant_scale_harm}); //BUT NEEDS TO USE THE PREVIOUS HARMONIC'S SCALE







//The actuator for this motion
~keyboard_CompositeView_White.bounds_(Rect(27+(~deviant_move*~deviant_scale)+1+~starting_position_fund+~starting_position_harm,175+1,5-1,5-1))
);



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
		~key_vis = Button.new(w, Rect(250,330,60,25))
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
		},{

~keyboard.close;
					// ~keyboard_open = 1;
		};);

		});


	///SPECTRA BUTTON
	//Add swapables for the pen lines to switch the frequency views

	~spectraButton = Button(w, Rect(250-(200/2)-65,200+135,110,20))
.states_([
		["Log View", Color.white,Color(0.4824, 0.4863, 0.4863,1)]
		,["Linear View", Color.white,Color(0.4824, 0.4863, 0.4863,1)]]

)
.font_(Font("nil", 12))
.action_(


				{

					arg obj;
	if(obj.value == 1,
						{


					f.freqMode_(0);
					~composite.bounds_(Rect(0,355,~spectra_width,~spectra_height));
					p.visible = false;

					// f.set(\bounds, Rect.new(100,100,600,300));
					// f.bounds_(Rect(100, 0, 300, 300);

				},{f.freqMode_(1); ~composite.bounds_(Rect(-100,355,~spectra_width,~spectra_height));}
			)});


	///SPECTRA SLIDER
	//Allows scaling

	~spectra_x = Slider(w, Rect(0,555,500,15)).value_(0).action_({
		~spectra_width = ~spectra_x.value.linlin(0,1,600,6000);
f.bounds_(Rect.new(0,0,~spectra_width,~spectra_height));
	});

	~spectra_y = Slider(w, Rect(485,355,15,200)).value_(0.5).action_({
		~spectra_db = ~spectra_y.value.linlin(0,1,30,90);
f.dbRange_(~spectra_db);
	});







//Dropdown harmonic value number
~harmonic_count = 1;



	//Dropdown menus
//Preset
	(
s.waitForBoot({

 var menu, snd, funcs2, b;


 ~vinbutton = Button(w, Rect(250-(250/2),95,250,30))
  .states_([
				["            Click to Play # of Harmonics", Color.white, Color(0.7569,0.1373,0.1725,1)], ["            Click to Stop Sound", Color.white, Color.grey(0.251)]]);

~vinbutton.mouseDownAction_({ arg obj;
				if(~vinbutton.value == 0, {
					snd.postln;
							snd = funcs2.at(menu.value).play /*+ funcs2.at(menu2.value).postln*/;
					snd.postln;
	~fslider.valueAction_(~fslider.value); //This allows it to refresh real-time
				s.makeBundle(3.0, //sound delay
			{~dirtyBit = 4; ~dirtyBit/*.postln*/;~fslider.valueAction_(~fslider.value);});

						},{x.free; /*~fslider.valueAction_(0.value.linlin(21,108,0,1));*/}
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

menu = PopUpMenu(w, Rect(250-(250/2)+5,95+5,50,20));
			menu.items_(["1", "2", "3", "5", "8", "16"]);
			menu.font_(Font(\size, 12));
			menu.allowsReselection_(true);
			menu.valueAction_(4); //Starts the menu at position 4 (i.e. 8 harmonics)
			menu.action = { arg menu, menu2;


				[menu.value, menu.item, menu.action].postln; //These lines allow below allow the menu clicker to auto-set the choice selected (not requiring to click on-off the button to set the dropdown selection)

				~vinbutton.valueAction_(0);
				x.free;
				// ~vinbutton.valueAction_(1); FOR SOME REASON THIS DOES NOT WORK NOW (UNKNOWN CAUSE FOR BREAK, NEEDS CONTINUED INVESTIGATION), current workaround is to just keep the big button off

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
			~menu2.items_(["--","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16"]);
			~menu2.font_(Font(\size, 12));
			~menu2.valueAction_(5); //Visually display that it's 5
			~menu2.allowsReselection_(true);
			~menu2.action = { arg menu2;

				// [menu.value, menu.item, menu.action].postln; //These lines allow below allow the menu clicker to auto-set the choice selected (not requiring to click on-off the button to set the dropdown selection)
/*~choosebutton.valueAction_(0);*/
/*				x.free;*/
			/*	~choosebutton.valueAction_(1);*/

(
					if((~menu2.value == 0),
					(~coverComposite.visible = true), (~coverComposite.visible = false));

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
	.states_([["(i)", Color.white, Color.gray]])
	.font_(Font("nil", 10))
	.mouseDownAction_
	({
		(basePath +/+  "modules/inspector.scd").loadPaths;
	});


~quit = Button.new(w, Rect(465,95,30,30))
	.states_([["", Color.white, Color.clear]])
	.font_(Font("nil", 12))
	.mouseDownAction_({w.close; f.kill; x.free; //shuts down window and scope
		(if(~key_vis.value == 1, {
			~keyboard.close;
		}));
		(basePath +/+ "splashscreen.scd").loadPaths;
		});


	/*~quit = Button.new(w, Rect((400), 100, 60, 20))
	.states_([["Home", Color.white, Color(0.2510,0.2510,0.2510,1)]])
	.font_(Font("nil", 12))
	.mouseDownAction_({w.close; f.kill; x.free; //shuts down window and scope
		(basePath +/+ "splashscreen.scd").loadPaths;
		});*/



	//To ensure there is a variable value for when the keyboard is opened, if the keyboard is opened before the slider or any other setting is activated - thus bypasses error
	~numberfBox.valueAction_(~fslider.value.linlin(0,1,21,108));



w.onClose_({

		(if(~key_vis.value == 1, {
			~keyboard.close;
		}));

		s.quit; x.free}); //ends server when quit
});



/*s.doWhenBooted_(

s.makeBundle(0.2, {
					//~menu2.valueAction_(5); // Activates it as being 5
~coverComposite.visible = false;

});*/
)