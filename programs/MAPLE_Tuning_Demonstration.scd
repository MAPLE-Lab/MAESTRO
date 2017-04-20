// "Tuning Demonstration"

// f.freqMode_(0) //sets to linear, but the scaling requires the window to be repositioned

(var basePath = thisProcess.nowExecutingPath.asString.dirname;
s.waitForBoot({ //Ensures it only opens once the server is working completely, and automatically opens server
	s.prepareForRecord;
	w = Window.new("MAPLE Lab Overtone 'Popout' Demonstration (Beta)", Rect.new(
	Window.screenBounds.width/2-250,
	Window.screenBounds.height/2-50,
		500,570),false //shortened the
	).background_(Color.white).userCanClose_(false).front; //Creates the new window with title


//Record button - sends to Supercollider file
	~record = Button.new(w, Rect(35, 100, 85, 20))
	.states_([
	["Start Recording", Color.white,Color(0.4824, 0.4863, 0.4863,1)],
	["Stop Recording", Color.white, Color.grey(0.251)]
])
	.font_(Font("nil", 10))
	.action_({
	arg obj;
	if(obj.value == 1,
		{
					s.record;
				},
		{
					s.stopRecording;

				}
	);
}
		);

~composite = CompositeView(w, Rect(-100,355,600,300)); //needs to use Spectra bounds to not crop FreqScope


//Spectra viewer
~spectra_width = 600;
~spectra_height = 300;
~spectra_db = 60;
f = FreqScopeView(~composite, Rect.new(0,0,~spectra_width,~spectra_height)); //Prepares frequency scope (a.k.a. spectra) from (-120,355,800,300) to (-100,355,600,300)) - for harmonic marker transformation maths
f.active_(true).freqMode_(1).dbRange_(~spectra_db);


	//Label for spectra (PENDING)
/*~fLabel = StaticText(w,Rect(15,620,80,30))
.string_("Frequency")
.font_(Font("nil", 12))
.align_(\topLeft)
.background_(Color(0,0,0,0))
.stringColor_(Color.white);*/

//Label for paragraph
~para = StaticText(w,Rect(10,10,480,80))
	.string_("Welcome to the MAPLE Lab Overtone 'Popout' Demonstration (Beta)! Using the parameters below, you can examine the fusion effect. Select the number of harmonics and which harmonic to move out-of-tune using the dropdown menus. Use the Play/Stop button to start and stop the sound. To explore how fusion/unfusion occurs, use the slider to change the deviation of the selected harmonic.")
.font_(Font("nil", 12))
.align_(\topLeft)
.background_(Color(0,0,0,0))
.stringColor_(Color.black);

i = Image.new(basePath +/+ "images/mapleICON-small.png");
~keyboard_image = Image.new(basePath +/+ "images/keyboard_small.png");

//Aesthetic lines
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

	//Axes

	//Harmonic positions marker

	StaticText(w,Rect(0,622,500,48))
	.background_(Color(0,0,0,1)); //dark bottom cover

	/*~fsliderharm3 = Slider(w, Rect(0,620,500,20)) /////Commented until numbers set properly
	.background_(Color(0,0,0,0))
	.value_(0.56931407052427)
	.thumbSize_(0)
	.knobColor_(Color(1,1,1,0))
	.orientation_(\horizontal)
	.focusColor_(Color.black)
	.action_({
	arg obj;
	var cf;
		// cf = obj.value.linlin(0,1,0,1).postln;
	});

		~fsliderharm2 = Slider(w, Rect(0,620,500,20))
	.background_(Color(0,0,0,0))
	.value_(0.47531407052427)
	.thumbSize_(0)
	.knobColor_(Color(1,1,1,0)) //QGUI does not handle transparent sliders yet http://new-supercollider-mailing-lists-forums-use-these.2681727.n2.nabble.com/QSlider-background-alpha-0-0-not-transparent-td7590743.html
	.orientation_(\horizontal)
	.action_({
	arg obj;
	var cf;
		// cf = obj.value.linlin(0,1,0,1).postln;
	});

	~fsliderharm1 = Slider(w, Rect(0,620,500,20))
	.background_(Color(0,0,0,0))
	.value_(0.31531407052427)
	.thumbSize_(0)
	.knobColor_(Color(1,1,1,0))
	.orientation_(\horizontal)
	.action_({
	arg obj;
	var cf;
		// cf = obj.value.linlin(0,1,0,1).postln;
	});
*/

StaticText(w,Rect(0,620,500,2))
	.background_(Color.white);

	StaticText(w,Rect(10,637,500,33))
	.string_("Freq.
")
	.stringColor_(Color.white)
	.align_(\topLeft)
	.background_(Color(0,0,0,0));


	/*StaticText(w,Rect(54,640,2,15))
	.background_(Color.white);
	StaticText(w,Rect(42,645,500,33))
	.string_("100")
	.stringColor_(Color.white)
	.background_(Color(0,0,0,0));
*/

	//Play sounds button (DERELICT)
	// ~button = Button(w, Rect(250-(200/2),95,200,30))
	// .states_([
	// 	["Click to Play Sounds", Color.white,Color(0.7569,0.1373,0.1725,1)],
	// 	["Click to Mute Sounds", Color.white, Color.grey(0.251)]
	// ])
	// .font_(Font("nil", 18))
	// .action_({
	// 	arg obj;
	// 	if(obj.value == 1,
	// 		{
	// 			x = Synth.new(
	// 				\sound,
	// 				[
	// 					\outoftune, ~freqslider.value.linlin(0,1,2,4),
	// 					\intensity, ~mulslider.value.linlin(0,1,0.0,2),
	// 					\other, ~otherslider.value.linlin(0,1,0.0,2),
	// 					\freq, ~fslider.value.linexp(0,1,100,1000),
	// 				]
	// 			).register;
	// 		},
	// 		{x.free}
	// 	);
	// });

	//VOLUME
//Properties of the slider
~volslider = Slider(w, Rect(160,140,330,15))
	.background_(Color(0.0118,0.0118,0.0118,1))
	.value_(0.3)
	.action_({
	arg obj;
	var cf;
		cf = obj.value.linlin(0,1,0,4).postln; //Boosts the audio volume (hidden from user)
		if(
		x.isPlaying,
		{x.set(\vol,cf)});
	~numberVBox.value_(obj.value.linlin(0,1,0,1)); //Acts as an invisible change so even though it seems 1:1 it's really 1:4

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
	cf = obj.value.linlin(0,1,21,108).postln;
		~fundamental_note = obj.value.linlin(0,1,21,108);
		~fundamental_note.postln;
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

/*A0*/(if(obj.value.linlin(0,1,21,108) == 21,{~note_name.string_("A0");}););
/*B0*/(if(obj.value.linlin(0,1,21,108) == 23,{~note_name.string_("B0");}););
/*C1*/(if(obj.value.linlin(0,1,21,108) == 24,{~note_name.string_("C1");}););
/*D1*/(if(obj.value.linlin(0,1,21,108) == 26,{~note_name.string_("D1");}););
/*E1*/(if(obj.value.linlin(0,1,21,108) == 28,{~note_name.string_("E1");}););
/*F1*/(if(obj.value.linlin(0,1,21,108) == 29,{~note_name.string_("F1");}););
/*G1*/(if(obj.value.linlin(0,1,21,108) == 31,{~note_name.string_("G1");}););
/*A1*/(if(obj.value.linlin(0,1,21,108) == 33,{~note_name.string_("A1");}););
/*B1*/(if(obj.value.linlin(0,1,21,108) == 35,{~note_name.string_("B1");}););
/*C2*/(if(obj.value.linlin(0,1,21,108) == 36,{~note_name.string_("C2");}););
/*D2*/(if(obj.value.linlin(0,1,21,108) == 38,{~note_name.string_("D2");}););
/*E2*/(if(obj.value.linlin(0,1,21,108) == 40,{~note_name.string_("E2");}););
/*F2*/(if(obj.value.linlin(0,1,21,108) == 41,{~note_name.string_("F2");}););
/*G2*/(if(obj.value.linlin(0,1,21,108) == 43,{~note_name.string_("G2");}););
/*A2*/(if(obj.value.linlin(0,1,21,108) == 45,{~note_name.string_("A2");}););
/*B2*/(if(obj.value.linlin(0,1,21,108) == 47,{~note_name.string_("B2");}););
/*C3*/(if(obj.value.linlin(0,1,21,108) == 48,{~note_name.string_("C3");}););
/*D3*/(if(obj.value.linlin(0,1,21,108) == 50,{~note_name.string_("D3");}););
/*E3*/(if(obj.value.linlin(0,1,21,108) == 52,{~note_name.string_("E3");}););
/*F3*/(if(obj.value.linlin(0,1,21,108) == 53,{~note_name.string_("F3");}););
/*G3*/(if(obj.value.linlin(0,1,21,108) == 55,{~note_name.string_("G3");}););
/*A3*/(if(obj.value.linlin(0,1,21,108) == 57,{~note_name.string_("A3");}););
/*B3*/(if(obj.value.linlin(0,1,21,108) == 59,{~note_name.string_("B3");}););
/*C4*/(if(obj.value.linlin(0,1,21,108) == 60,{~note_name.string_("C4");}););
/*D4*/(if(obj.value.linlin(0,1,21,108) == 62,{~note_name.string_("D4");}););
/*E4*/(if(obj.value.linlin(0,1,21,108) == 64,{~note_name.string_("E4");}););
/*F4*/(if(obj.value.linlin(0,1,21,108) == 65,{~note_name.string_("F4");}););
/*G4*/(if(obj.value.linlin(0,1,21,108) == 67,{~note_name.string_("G4");}););
/*A4*/(if(obj.value.linlin(0,1,21,108) == 69,{~note_name.string_("A4");}););
/*B4*/(if(obj.value.linlin(0,1,21,108) == 71,{~note_name.string_("B4");}););
/*C5*/(if(obj.value.linlin(0,1,21,108) == 72,{~note_name.string_("C5");}););
/*D5*/(if(obj.value.linlin(0,1,21,108) == 74,{~note_name.string_("D5");}););
/*E5*/(if(obj.value.linlin(0,1,21,108) == 76,{~note_name.string_("E5");}););
/*F5*/(if(obj.value.linlin(0,1,21,108) == 77,{~note_name.string_("F5");}););
/*G5*/(if(obj.value.linlin(0,1,21,108) == 79,{~note_name.string_("G5");}););
/*A5*/(if(obj.value.linlin(0,1,21,108) == 81,{~note_name.string_("A5");}););
/*B5*/(if(obj.value.linlin(0,1,21,108) == 83,{~note_name.string_("B5");}););
/*C6*/(if(obj.value.linlin(0,1,21,108) == 84,{~note_name.string_("C6");}););
/*D6*/(if(obj.value.linlin(0,1,21,108) == 86,{~note_name.string_("D6");}););
/*E6*/(if(obj.value.linlin(0,1,21,108) == 88,{~note_name.string_("E6");}););
/*F6*/(if(obj.value.linlin(0,1,21,108) == 89,{~note_name.string_("F6");}););
/*G6*/(if(obj.value.linlin(0,1,21,108) == 91,{~note_name.string_("G6");}););
/*A6*/(if(obj.value.linlin(0,1,21,108) == 93,{~note_name.string_("A6");}););
/*B6*/(if(obj.value.linlin(0,1,21,108) == 95,{~note_name.string_("B6");}););
/*C5*/(if(obj.value.linlin(0,1,21,108) == 96,{~note_name.string_("C5");}););
/*D7*/(if(obj.value.linlin(0,1,21,108) == 98,{~note_name.string_("D7");}););
/*E7*/(if(obj.value.linlin(0,1,21,108) == 100,{~note_name.string_("E7");}););
/*F7*/(if(obj.value.linlin(0,1,21,108) == 101,{~note_name.string_("F7");}););
/*G7*/(if(obj.value.linlin(0,1,21,108) == 103,{~note_name.string_("G7");}););
/*A7*/(if(obj.value.linlin(0,1,21,108) == 105,{~note_name.string_("A7");}););
/*B7*/(if(obj.value.linlin(0,1,21,108) == 107,{~note_name.string_("B7");}););
/*C8*/(if(obj.value.linlin(0,1,21,108) == 108,{~note_name.string_("C8");}););


/*ASHARP0*/(if(obj.value.linlin(0,1,21,108) ==22,{~note_name.string_("A#0");}););
/*CSHARP1*/(if(obj.value.linlin(0,1,21,108) ==25,{~note_name.string_("C#1");}););
/*DSHARP1*/(if(obj.value.linlin(0,1,21,108) ==27,{~note_name.string_("D#1");}););
/*FSHARP1*/(if(obj.value.linlin(0,1,21,108) ==30,{~note_name.string_("F#1");}););
/*GSHARP1*/(if(obj.value.linlin(0,1,21,108) ==32,{~note_name.string_("G#1");}););
/*ASHARP1*/(if(obj.value.linlin(0,1,21,108) ==34,{~note_name.string_("A#1");}););
/*CSHARP2*/(if(obj.value.linlin(0,1,21,108) ==37,{~note_name.string_("C#2");}););
/*DSHARP2*/(if(obj.value.linlin(0,1,21,108) ==39,{~note_name.string_("D#2");}););
/*FSHARP2*/(if(obj.value.linlin(0,1,21,108) ==42,{~note_name.string_("F#2");}););
/*GSHARP2*/(if(obj.value.linlin(0,1,21,108) ==44,{~note_name.string_("G#2");}););
/*ASHARP2*/(if(obj.value.linlin(0,1,21,108) ==46,{~note_name.string_("A#2");}););
/*CSHARP3*/(if(obj.value.linlin(0,1,21,108) ==49,{~note_name.string_("C#3");}););
/*DSHARP3*/(if(obj.value.linlin(0,1,21,108) ==51,{~note_name.string_("D#3");}););
/*FSHARP3*/(if(obj.value.linlin(0,1,21,108) ==54,{~note_name.string_("F#3");}););
/*GSHARP3*/(if(obj.value.linlin(0,1,21,108) ==56,{~note_name.string_("G#3");}););
/*ASHARP3*/(if(obj.value.linlin(0,1,21,108) ==58,{~note_name.string_("A#3");}););
/*CSHARP4*/(if(obj.value.linlin(0,1,21,108) ==61,{~note_name.string_("C#4");}););
/*DSHARP4*/(if(obj.value.linlin(0,1,21,108) ==63,{~note_name.string_("D#4");}););
/*FSHARP4*/(if(obj.value.linlin(0,1,21,108) ==66,{~note_name.string_("F#4");}););
/*GSHARP4*/(if(obj.value.linlin(0,1,21,108) ==68,{~note_name.string_("G#4");}););
/*ASHARP4*/(if(obj.value.linlin(0,1,21,108) ==70,{~note_name.string_("A#4");}););
/*CSHARP5*/(if(obj.value.linlin(0,1,21,108) ==73,{~note_name.string_("C#5");}););
/*DSHARP5*/(if(obj.value.linlin(0,1,21,108) ==75,{~note_name.string_("D#5");}););
/*FSHARP5*/(if(obj.value.linlin(0,1,21,108) ==78,{~note_name.string_("F#5");}););
/*GSHARP5*/(if(obj.value.linlin(0,1,21,108) ==80,{~note_name.string_("G#5");}););
/*ASHARP5*/(if(obj.value.linlin(0,1,21,108) ==82,{~note_name.string_("A#5");}););
/*CSHARP6*/(if(obj.value.linlin(0,1,21,108) ==85,{~note_name.string_("C#6");}););
/*DSHARP6*/(if(obj.value.linlin(0,1,21,108) ==87,{~note_name.string_("D#6");}););
/*FSHARP6*/(if(obj.value.linlin(0,1,21,108) ==90,{~note_name.string_("F#6");}););
/*GSHARP6*/(if(obj.value.linlin(0,1,21,108) ==92,{~note_name.string_("G#6");}););
/*ASHARP6*/(if(obj.value.linlin(0,1,21,108) ==94,{~note_name.string_("A#6");}););
/*CSHARP7*/(if(obj.value.linlin(0,1,21,108) ==97,{~note_name.string_("C#7");}););
/*DSHARP7*/(if(obj.value.linlin(0,1,21,108) ==99,{~note_name.string_("D#7");}););
/*FSHARP7*/(if(obj.value.linlin(0,1,21,108) ==102,{~note_name.string_("F#7");}););
/*GSHARP7*/(if(obj.value.linlin(0,1,21,108) ==104,{~note_name.string_("G#7");}););
/*ASHARP7*/(if(obj.value.linlin(0,1,21,108) ==106,{~note_name.string_("A#7");}););


(if(~key_vis.value == 1, {



			/*
			/*A0*/(if(obj.value.linlin(0,1,21,108) <= 21, {~a0.background_(Color(1,(~color_array[21-1]+~color_arrayMAN[21-1]),~color_array[21-1]));}, {~a0.background_(Color.white)}););
/*B0*/(if(obj.value.linlin(0,1,21,108) <= 23, {~b0.background_(Color(1,(~color_array[23-1]+~color_arrayMAN[23-1]),~color_array[23-1]));}, {~b0.background_(Color.white)}););
/*C1*/(if(obj.value.linlin(0,1,21,108) <= 24, {~c1.background_(Color(1,(~color_array[24-1]+~color_arrayMAN[24-1]),~color_array[24-1]));}, {~c1.background_(Color.white)}););
/*D1*/(if(obj.value.linlin(0,1,21,108) <= 26, {~d1.background_(Color(1,(~color_array[26-1]+~color_arrayMAN[26-1]),~color_array[26-1]));}, {~d1.background_(Color.white)}););
/*E1*/(if(obj.value.linlin(0,1,21,108) <= 28, {~e1.background_(Color(1,(~color_array[28-1]+~color_arrayMAN[28-1]),~color_array[28-1]));}, {~e1.background_(Color.white)}););
/*F1*/(if(obj.value.linlin(0,1,21,108) <= 29, {~f1.background_(Color(1,(~color_array[29-1]+~color_arrayMAN[29-1]),~color_array[29-1]));}, {~f1.background_(Color.white)}););
/*G1*/(if(obj.value.linlin(0,1,21,108) <= 31, {~g1.background_(Color(1,(~color_array[31-1]+~color_arrayMAN[31-1]),~color_array[31-1]));}, {~g1.background_(Color.white)}););
/*A1*/(if(obj.value.linlin(0,1,21,108) <= 33, {~a1.background_(Color(1,(~color_array[33-1]+~color_arrayMAN[33-1]),~color_array[33-1]));}, {~a1.background_(Color.white)}););
/*B1*/(if(obj.value.linlin(0,1,21,108) <= 35, {~b1.background_(Color(1,(~color_array[35-1]+~color_arrayMAN[35-1]),~color_array[35-1]));}, {~b1.background_(Color.white)}););
/*C2*/(if(obj.value.linlin(0,1,21,108) <= 36, {~c2.background_(Color(1,(~color_array[36-1]+~color_arrayMAN[36-1]),~color_array[36-1]));}, {~c2.background_(Color.white)}););
/*D2*/(if(obj.value.linlin(0,1,21,108) <= 38, {~d2.background_(Color(1,(~color_array[38-1]+~color_arrayMAN[38-1]),~color_array[38-1]));}, {~d2.background_(Color.white)}););
/*E2*/(if(obj.value.linlin(0,1,21,108) <= 40, {~e2.background_(Color(1,(~color_array[40-1]+~color_arrayMAN[40-1]),~color_array[40-1]));}, {~e2.background_(Color.white)}););
/*F2*/(if(obj.value.linlin(0,1,21,108) <= 41, {~f2.background_(Color(1,(~color_array[41-1]+~color_arrayMAN[41-1]),~color_array[41-1]));}, {~f2.background_(Color.white)}););
/*G2*/(if(obj.value.linlin(0,1,21,108) <= 43, {~g2.background_(Color(1,(~color_array[43-1]+~color_arrayMAN[43-1]),~color_array[43-1]));}, {~g2.background_(Color.white)}););
/*A2*/(if(obj.value.linlin(0,1,21,108) <= 45, {~a2.background_(Color(1,(~color_array[45-1]+~color_arrayMAN[45-1]),~color_array[45-1]));}, {~a2.background_(Color.white)}););
/*B2*/(if(obj.value.linlin(0,1,21,108) <= 47, {~b2.background_(Color(1,(~color_array[47-1]+~color_arrayMAN[47-1]),~color_array[47-1]));}, {~b2.background_(Color.white)}););
/*C3*/(if(obj.value.linlin(0,1,21,108) <= 48, {~c3.background_(Color(1,(~color_array[48-1]+~color_arrayMAN[48-1]),~color_array[48-1]));}, {~c3.background_(Color.white)}););
/*D3*/(if(obj.value.linlin(0,1,21,108) <= 50, {~d3.background_(Color(1,(~color_array[50-1]+~color_arrayMAN[50-1]),~color_array[50-1]));}, {~d3.background_(Color.white)}););
/*E3*/(if(obj.value.linlin(0,1,21,108) <= 52, {~e3.background_(Color(1,(~color_array[52-1]+~color_arrayMAN[52-1]),~color_array[52-1]));}, {~e3.background_(Color.white)}););
/*F3*/(if(obj.value.linlin(0,1,21,108) <= 53, {~f3.background_(Color(1,(~color_array[53-1]+~color_arrayMAN[53-1]),~color_array[53-1]));}, {~f3.background_(Color.white)}););
/*G3*/(if(obj.value.linlin(0,1,21,108) <= 55, {~g3.background_(Color(1,(~color_array[55-1]+~color_arrayMAN[55-1]),~color_array[55-1]));}, {~g3.background_(Color.white)}););
/*A3*/(if(obj.value.linlin(0,1,21,108) <= 57, {~a3.background_(Color(1,(~color_array[57-1]+~color_arrayMAN[57-1]),~color_array[57-1]));}, {~a3.background_(Color.white)}););
/*B3*/(if(obj.value.linlin(0,1,21,108) <= 59, {~b3.background_(Color(1,(~color_array[59-1]+~color_arrayMAN[59-1]),~color_array[59-1]));}, {~b3.background_(Color.white)}););
/*C4*/(if(obj.value.linlin(0,1,21,108) <= 60, {~c4.background_(Color(1,(~color_array[60-1]+~color_arrayMAN[60-1]),~color_array[60-1]));}, {~c4.background_(Color.white)}););
/*D4*/(if(obj.value.linlin(0,1,21,108) <= 62, {~d4.background_(Color(1,(~color_array[62-1]+~color_arrayMAN[62-1]),~color_array[62-1]));}, {~d4.background_(Color.white)}););
/*E4*/(if(obj.value.linlin(0,1,21,108) <= 64, {~e4.background_(Color(1,(~color_array[64-1]+~color_arrayMAN[64-1]),~color_array[64-1]));}, {~e4.background_(Color.white)}););
/*F4*/(if(obj.value.linlin(0,1,21,108) <= 65, {~f4.background_(Color(1,(~color_array[65-1]+~color_arrayMAN[65-1]),~color_array[65-1]));}, {~f4.background_(Color.white)}););
/*G4*/(if(obj.value.linlin(0,1,21,108) <= 67, {~g4.background_(Color(1,(~color_array[67-1]+~color_arrayMAN[67-1]),~color_array[67-1]));}, {~g4.background_(Color.white)}););
/*A4*/(if(obj.value.linlin(0,1,21,108) <= 69, {~a4.background_(Color(1,(~color_array[69-1]+~color_arrayMAN[69-1]),~color_array[69-1]));}, {~a4.background_(Color.white)}););
/*B4*/(if(obj.value.linlin(0,1,21,108) <= 71, {~b4.background_(Color(1,(~color_array[71-1]+~color_arrayMAN[71-1]),~color_array[71-1]));}, {~b4.background_(Color.white)}););
/*C5*/(if(obj.value.linlin(0,1,21,108) <= 72, {~c5.background_(Color(1,(~color_array[72-1]+~color_arrayMAN[72-1]),~color_array[72-1]));}, {~c5.background_(Color.white)}););
/*D5*/(if(obj.value.linlin(0,1,21,108) <= 74, {~d5.background_(Color(1,(~color_array[74-1]+~color_arrayMAN[74-1]),~color_array[74-1]));}, {~d5.background_(Color.white)}););
/*E5*/(if(obj.value.linlin(0,1,21,108) <= 76, {~e5.background_(Color(1,(~color_array[76-1]+~color_arrayMAN[76-1]),~color_array[76-1]));}, {~e5.background_(Color.white)}););
/*F5*/(if(obj.value.linlin(0,1,21,108) <= 77, {~f5.background_(Color(1,(~color_array[77-1]+~color_arrayMAN[77-1]),~color_array[77-1]));}, {~f5.background_(Color.white)}););
/*G5*/(if(obj.value.linlin(0,1,21,108) <= 79, {~g5.background_(Color(1,(~color_array[79-1]+~color_arrayMAN[79-1]),~color_array[79-1]));}, {~g5.background_(Color.white)}););
/*A5*/(if(obj.value.linlin(0,1,21,108) <= 81, {~a5.background_(Color(1,(~color_array[81-1]+~color_arrayMAN[81-1]),~color_array[81-1]));}, {~a5.background_(Color.white)}););
/*B5*/(if(obj.value.linlin(0,1,21,108) <= 83, {~b5.background_(Color(1,(~color_array[83-1]+~color_arrayMAN[83-1]),~color_array[83-1]));}, {~b5.background_(Color.white)}););
/*C6*/(if(obj.value.linlin(0,1,21,108) <= 84, {~c6.background_(Color(1,(~color_array[84-1]+~color_arrayMAN[84-1]),~color_array[84-1]));}, {~c6.background_(Color.white)}););
/*D6*/(if(obj.value.linlin(0,1,21,108) <= 86, {~d6.background_(Color(1,(~color_array[86-1]+~color_arrayMAN[86-1]),~color_array[86-1]));}, {~d6.background_(Color.white)}););
/*E6*/(if(obj.value.linlin(0,1,21,108) <= 88, {~e6.background_(Color(1,(~color_array[88-1]+~color_arrayMAN[88-1]),~color_array[88-1]));}, {~e6.background_(Color.white)}););
/*F6*/(if(obj.value.linlin(0,1,21,108) <= 89, {~f6.background_(Color(1,(~color_array[89-1]+~color_arrayMAN[89-1]),~color_array[89-1]));}, {~f6.background_(Color.white)}););
/*G6*/(if(obj.value.linlin(0,1,21,108) <= 91, {~g6.background_(Color(1,(~color_array[91-1]+~color_arrayMAN[91-1]),~color_array[91-1]));}, {~g6.background_(Color.white)}););
/*A6*/(if(obj.value.linlin(0,1,21,108) <= 93, {~a6.background_(Color(1,(~color_array[93-1]+~color_arrayMAN[93-1]),~color_array[93-1]));}, {~a6.background_(Color.white)}););
/*B6*/(if(obj.value.linlin(0,1,21,108) <= 95, {~b6.background_(Color(1,(~color_array[95-1]+~color_arrayMAN[95-1]),~color_array[95-1]));}, {~b6.background_(Color.white)}););
/*C7*/(if(obj.value.linlin(0,1,21,108) <= 96, {~c7.background_(Color(1,(~color_array[96-1]+~color_arrayMAN[96-1]),~color_array[96-1]));}, {~c7.background_(Color.white)}););
/*D7*/(if(obj.value.linlin(0,1,21,108) <= 98, {~d7.background_(Color(1,(~color_array[98-1]+~color_arrayMAN[98-1]),~color_array[98-1]));}, {~d7.background_(Color.white)}););
/*E7*/(if(obj.value.linlin(0,1,21,108) <= 100, {~e7.background_(Color(1,(~color_array[100-1]+~color_arrayMAN[100-1]),~color_array[100-1]));}, {~e7.background_(Color.white)}););
/*F7*/(if(obj.value.linlin(0,1,21,108) <= 101, {~f7.background_(Color(1,(~color_array[101-1]+~color_arrayMAN[101-1]),~color_array[101-1]));}, {~f7.background_(Color.white)}););
/*G7*/(if(obj.value.linlin(0,1,21,108) <= 103, {~g7.background_(Color(1,(~color_array[103-1]+~color_arrayMAN[103-1]),~color_array[103-1]));}, {~g7.background_(Color.white)}););
/*A7*/(if(obj.value.linlin(0,1,21,108) <= 105, {~a7.background_(Color(1,(~color_array[105-1]+~color_arrayMAN[105-1]),~color_array[105-1]));}, {~a7.background_(Color.white)}););
/*B7*/(if(obj.value.linlin(0,1,21,108) <= 107, {~b7.background_(Color(1,(~color_array[107-1]+~color_arrayMAN[107-1]),~color_array[107-1]));}, {~b7.background_(Color.white)}););
/*C8*/(if(obj.value.linlin(0,1,21,108) <= 108, {~c8.background_(Color(1,(~color_array[108-1]+~color_arrayMAN[108-1]),~color_array[108-1]));}, {~c8.background_(Color.white)}););
*/


/*A0*/(if(obj.value.linlin(0,1,21,108) <= 21, {~a0.background_(Color(1,~color_array[21-1],~color_array[21-1]));~dot_a0.background_(Color(0,0,0,~color_arrayMAN[21-1]))}, {~a0.background_(Color.white);~dot_a0.background_(Color(0,0,0,0))}););
/*B0*/(if(obj.value.linlin(0,1,21,108) <= 23, {~b0.background_(Color(1,~color_array[23-1],~color_array[23-1]));~dot_b0.background_(Color(0,0,0,~color_arrayMAN[23-1]))}, {~b0.background_(Color.white);~dot_b0.background_(Color(0,0,0,0))}););
/*C1*/(if(obj.value.linlin(0,1,21,108) <= 24, {~c1.background_(Color(1,~color_array[24-1],~color_array[24-1]));~dot_c1.background_(Color(0,0,0,~color_arrayMAN[24-1]))}, {~c1.background_(Color.white);~dot_c1.background_(Color(0,0,0,0))}););
/*D1*/(if(obj.value.linlin(0,1,21,108) <= 26, {~d1.background_(Color(1,~color_array[26-1],~color_array[26-1]));~dot_d1.background_(Color(0,0,0,~color_arrayMAN[26-1]))}, {~d1.background_(Color.white);~dot_d1.background_(Color(0,0,0,0))}););
/*E1*/(if(obj.value.linlin(0,1,21,108) <= 28, {~e1.background_(Color(1,~color_array[28-1],~color_array[28-1]));~dot_e1.background_(Color(0,0,0,~color_arrayMAN[28-1]))}, {~e1.background_(Color.white);~dot_e1.background_(Color(0,0,0,0))}););
/*F1*/(if(obj.value.linlin(0,1,21,108) <= 29, {~f1.background_(Color(1,~color_array[29-1],~color_array[29-1]));~dot_f1.background_(Color(0,0,0,~color_arrayMAN[29-1]))}, {~f1.background_(Color.white);~dot_f1.background_(Color(0,0,0,0))}););
/*G1*/(if(obj.value.linlin(0,1,21,108) <= 31, {~g1.background_(Color(1,~color_array[31-1],~color_array[31-1]));~dot_g1.background_(Color(0,0,0,~color_arrayMAN[31-1]))}, {~g1.background_(Color.white);~dot_g1.background_(Color(0,0,0,0))}););
/*A1*/(if(obj.value.linlin(0,1,21,108) <= 33, {~a1.background_(Color(1,~color_array[33-1],~color_array[33-1]));~dot_a1.background_(Color(0,0,0,~color_arrayMAN[33-1]))}, {~a1.background_(Color.white);~dot_a1.background_(Color(0,0,0,0))}););
/*B1*/(if(obj.value.linlin(0,1,21,108) <= 35, {~b1.background_(Color(1,~color_array[35-1],~color_array[35-1]));~dot_b1.background_(Color(0,0,0,~color_arrayMAN[35-1]))}, {~b1.background_(Color.white);~dot_b1.background_(Color(0,0,0,0))}););
/*C2*/(if(obj.value.linlin(0,1,21,108) <= 36, {~c2.background_(Color(1,~color_array[36-1],~color_array[36-1]));~dot_c2.background_(Color(0,0,0,~color_arrayMAN[36-1]))}, {~c2.background_(Color.white);~dot_c2.background_(Color(0,0,0,0))}););
/*D2*/(if(obj.value.linlin(0,1,21,108) <= 38, {~d2.background_(Color(1,~color_array[38-1],~color_array[38-1]));~dot_d2.background_(Color(0,0,0,~color_arrayMAN[38-1]))}, {~d2.background_(Color.white);~dot_d2.background_(Color(0,0,0,0))}););
/*E2*/(if(obj.value.linlin(0,1,21,108) <= 40, {~e2.background_(Color(1,~color_array[40-1],~color_array[40-1]));~dot_e2.background_(Color(0,0,0,~color_arrayMAN[40-1]))}, {~e2.background_(Color.white);~dot_e2.background_(Color(0,0,0,0))}););
/*F2*/(if(obj.value.linlin(0,1,21,108) <= 41, {~f2.background_(Color(1,~color_array[41-1],~color_array[41-1]));~dot_f2.background_(Color(0,0,0,~color_arrayMAN[41-1]))}, {~f2.background_(Color.white);~dot_f2.background_(Color(0,0,0,0))}););
/*G2*/(if(obj.value.linlin(0,1,21,108) <= 43, {~g2.background_(Color(1,~color_array[43-1],~color_array[43-1]));~dot_g2.background_(Color(0,0,0,~color_arrayMAN[43-1]))}, {~g2.background_(Color.white);~dot_g2.background_(Color(0,0,0,0))}););
/*A2*/(if(obj.value.linlin(0,1,21,108) <= 45, {~a2.background_(Color(1,~color_array[45-1],~color_array[45-1]));~dot_a2.background_(Color(0,0,0,~color_arrayMAN[45-1]))}, {~a2.background_(Color.white);~dot_a2.background_(Color(0,0,0,0))}););
/*B2*/(if(obj.value.linlin(0,1,21,108) <= 47, {~b2.background_(Color(1,~color_array[47-1],~color_array[47-1]));~dot_b2.background_(Color(0,0,0,~color_arrayMAN[47-1]))}, {~b2.background_(Color.white);~dot_b2.background_(Color(0,0,0,0))}););
/*C3*/(if(obj.value.linlin(0,1,21,108) <= 48, {~c3.background_(Color(1,~color_array[48-1],~color_array[48-1]));~dot_c3.background_(Color(0,0,0,~color_arrayMAN[48-1]))}, {~c3.background_(Color.white);~dot_c3.background_(Color(0,0,0,0))}););
/*D3*/(if(obj.value.linlin(0,1,21,108) <= 50, {~d3.background_(Color(1,~color_array[50-1],~color_array[50-1]));~dot_d3.background_(Color(0,0,0,~color_arrayMAN[50-1]))}, {~d3.background_(Color.white);~dot_d3.background_(Color(0,0,0,0))}););
/*E3*/(if(obj.value.linlin(0,1,21,108) <= 52, {~e3.background_(Color(1,~color_array[52-1],~color_array[52-1]));~dot_e3.background_(Color(0,0,0,~color_arrayMAN[52-1]))}, {~e3.background_(Color.white);~dot_e3.background_(Color(0,0,0,0))}););
/*F3*/(if(obj.value.linlin(0,1,21,108) <= 53, {~f3.background_(Color(1,~color_array[53-1],~color_array[53-1]));~dot_f3.background_(Color(0,0,0,~color_arrayMAN[53-1]))}, {~f3.background_(Color.white);~dot_f3.background_(Color(0,0,0,0))}););
/*G3*/(if(obj.value.linlin(0,1,21,108) <= 55, {~g3.background_(Color(1,~color_array[55-1],~color_array[55-1]));~dot_g3.background_(Color(0,0,0,~color_arrayMAN[55-1]))}, {~g3.background_(Color.white);~dot_g3.background_(Color(0,0,0,0))}););
/*A3*/(if(obj.value.linlin(0,1,21,108) <= 57, {~a3.background_(Color(1,~color_array[57-1],~color_array[57-1]));~dot_a3.background_(Color(0,0,0,~color_arrayMAN[57-1]))}, {~a3.background_(Color.white);~dot_a3.background_(Color(0,0,0,0))}););
/*B3*/(if(obj.value.linlin(0,1,21,108) <= 59, {~b3.background_(Color(1,~color_array[59-1],~color_array[59-1]));~dot_b3.background_(Color(0,0,0,~color_arrayMAN[59-1]))}, {~b3.background_(Color.white);~dot_b3.background_(Color(0,0,0,0))}););
/*C4*/(if(obj.value.linlin(0,1,21,108) <= 60, {~c4.background_(Color(1,~color_array[60-1],~color_array[60-1]));~dot_c4.background_(Color(0,0,0,~color_arrayMAN[60-1]))}, {~c4.background_(Color.white);~dot_c4.background_(Color(0,0,0,0))}););
/*D4*/(if(obj.value.linlin(0,1,21,108) <= 62, {~d4.background_(Color(1,~color_array[62-1],~color_array[62-1]));~dot_d4.background_(Color(0,0,0,~color_arrayMAN[62-1]))}, {~d4.background_(Color.white);~dot_d4.background_(Color(0,0,0,0))}););
/*E4*/(if(obj.value.linlin(0,1,21,108) <= 64, {~e4.background_(Color(1,~color_array[64-1],~color_array[64-1]));~dot_e4.background_(Color(0,0,0,~color_arrayMAN[64-1]))}, {~e4.background_(Color.white);~dot_e4.background_(Color(0,0,0,0))}););
/*F4*/(if(obj.value.linlin(0,1,21,108) <= 65, {~f4.background_(Color(1,~color_array[65-1],~color_array[65-1]));~dot_f4.background_(Color(0,0,0,~color_arrayMAN[65-1]))}, {~f4.background_(Color.white);~dot_f4.background_(Color(0,0,0,0))}););
/*G4*/(if(obj.value.linlin(0,1,21,108) <= 67, {~g4.background_(Color(1,~color_array[67-1],~color_array[67-1]));~dot_g4.background_(Color(0,0,0,~color_arrayMAN[67-1]))}, {~g4.background_(Color.white);~dot_g4.background_(Color(0,0,0,0))}););
/*A4*/(if(obj.value.linlin(0,1,21,108) <= 69, {~a4.background_(Color(1,~color_array[69-1],~color_array[69-1]));~dot_a4.background_(Color(0,0,0,~color_arrayMAN[69-1]))}, {~a4.background_(Color.white);~dot_a4.background_(Color(0,0,0,0))}););
/*B4*/(if(obj.value.linlin(0,1,21,108) <= 71, {~b4.background_(Color(1,~color_array[71-1],~color_array[71-1]));~dot_b4.background_(Color(0,0,0,~color_arrayMAN[71-1]))}, {~b4.background_(Color.white);~dot_b4.background_(Color(0,0,0,0))}););
/*C5*/(if(obj.value.linlin(0,1,21,108) <= 72, {~c5.background_(Color(1,~color_array[72-1],~color_array[72-1]));~dot_c5.background_(Color(0,0,0,~color_arrayMAN[72-1]))}, {~c5.background_(Color.white);~dot_c5.background_(Color(0,0,0,0))}););
/*D5*/(if(obj.value.linlin(0,1,21,108) <= 74, {~d5.background_(Color(1,~color_array[74-1],~color_array[74-1]));~dot_d5.background_(Color(0,0,0,~color_arrayMAN[74-1]))}, {~d5.background_(Color.white);~dot_d5.background_(Color(0,0,0,0))}););
/*E5*/(if(obj.value.linlin(0,1,21,108) <= 76, {~e5.background_(Color(1,~color_array[76-1],~color_array[76-1]));~dot_e5.background_(Color(0,0,0,~color_arrayMAN[76-1]))}, {~e5.background_(Color.white);~dot_e5.background_(Color(0,0,0,0))}););
/*F5*/(if(obj.value.linlin(0,1,21,108) <= 77, {~f5.background_(Color(1,~color_array[77-1],~color_array[77-1]));~dot_f5.background_(Color(0,0,0,~color_arrayMAN[77-1]))}, {~f5.background_(Color.white);~dot_f5.background_(Color(0,0,0,0))}););
/*G5*/(if(obj.value.linlin(0,1,21,108) <= 79, {~g5.background_(Color(1,~color_array[79-1],~color_array[79-1]));~dot_g5.background_(Color(0,0,0,~color_arrayMAN[79-1]))}, {~g5.background_(Color.white);~dot_g5.background_(Color(0,0,0,0))}););
/*A5*/(if(obj.value.linlin(0,1,21,108) <= 81, {~a5.background_(Color(1,~color_array[81-1],~color_array[81-1]));~dot_a5.background_(Color(0,0,0,~color_arrayMAN[81-1]))}, {~a5.background_(Color.white);~dot_a5.background_(Color(0,0,0,0))}););
/*B5*/(if(obj.value.linlin(0,1,21,108) <= 83, {~b5.background_(Color(1,~color_array[83-1],~color_array[83-1]));~dot_b5.background_(Color(0,0,0,~color_arrayMAN[83-1]))}, {~b5.background_(Color.white);~dot_b5.background_(Color(0,0,0,0))}););
/*C6*/(if(obj.value.linlin(0,1,21,108) <= 84, {~c6.background_(Color(1,~color_array[84-1],~color_array[84-1]));~dot_c6.background_(Color(0,0,0,~color_arrayMAN[84-1]))}, {~c6.background_(Color.white);~dot_c6.background_(Color(0,0,0,0))}););
/*D6*/(if(obj.value.linlin(0,1,21,108) <= 86, {~d6.background_(Color(1,~color_array[86-1],~color_array[86-1]));~dot_d6.background_(Color(0,0,0,~color_arrayMAN[86-1]))}, {~d6.background_(Color.white);~dot_d6.background_(Color(0,0,0,0))}););
/*E6*/(if(obj.value.linlin(0,1,21,108) <= 88, {~e6.background_(Color(1,~color_array[88-1],~color_array[88-1]));~dot_e6.background_(Color(0,0,0,~color_arrayMAN[88-1]))}, {~e6.background_(Color.white);~dot_e6.background_(Color(0,0,0,0))}););
/*F6*/(if(obj.value.linlin(0,1,21,108) <= 89, {~f6.background_(Color(1,~color_array[89-1],~color_array[89-1]));~dot_f6.background_(Color(0,0,0,~color_arrayMAN[89-1]))}, {~f6.background_(Color.white);~dot_f6.background_(Color(0,0,0,0))}););
/*G6*/(if(obj.value.linlin(0,1,21,108) <= 91, {~g6.background_(Color(1,~color_array[91-1],~color_array[91-1]));~dot_g6.background_(Color(0,0,0,~color_arrayMAN[91-1]))}, {~g6.background_(Color.white);~dot_g6.background_(Color(0,0,0,0))}););
/*A6*/(if(obj.value.linlin(0,1,21,108) <= 93, {~a6.background_(Color(1,~color_array[93-1],~color_array[93-1]));~dot_a6.background_(Color(0,0,0,~color_arrayMAN[93-1]))}, {~a6.background_(Color.white);~dot_a6.background_(Color(0,0,0,0))}););
/*B6*/(if(obj.value.linlin(0,1,21,108) <= 95, {~b6.background_(Color(1,~color_array[95-1],~color_array[95-1]));~dot_b6.background_(Color(0,0,0,~color_arrayMAN[95-1]))}, {~b6.background_(Color.white);~dot_b6.background_(Color(0,0,0,0))}););
/*C7*/(if(obj.value.linlin(0,1,21,108) <= 96, {~c7.background_(Color(1,~color_array[96-1],~color_array[96-1]));~dot_c7.background_(Color(0,0,0,~color_arrayMAN[96-1]))}, {~c7.background_(Color.white);~dot_c7.background_(Color(0,0,0,0))}););
/*D7*/(if(obj.value.linlin(0,1,21,108) <= 98, {~d7.background_(Color(1,~color_array[98-1],~color_array[98-1]));~dot_d7.background_(Color(0,0,0,~color_arrayMAN[98-1]))}, {~d7.background_(Color.white);~dot_d7.background_(Color(0,0,0,0))}););
/*E7*/(if(obj.value.linlin(0,1,21,108) <= 100, {~e7.background_(Color(1,~color_array[100-1],~color_array[100-1]));~dot_e7.background_(Color(0,0,0,~color_arrayMAN[100-1]))}, {~e7.background_(Color.white);~dot_e7.background_(Color(0,0,0,0))}););
/*F7*/(if(obj.value.linlin(0,1,21,108) <= 101, {~f7.background_(Color(1,~color_array[101-1],~color_array[101-1]));~dot_f7.background_(Color(0,0,0,~color_arrayMAN[101-1]))}, {~f7.background_(Color.white);~dot_f7.background_(Color(0,0,0,0))}););
/*G7*/(if(obj.value.linlin(0,1,21,108) <= 103, {~g7.background_(Color(1,~color_array[103-1],~color_array[103-1]));~dot_g7.background_(Color(0,0,0,~color_arrayMAN[103-1]))}, {~g7.background_(Color.white);~dot_g7.background_(Color(0,0,0,0))}););
/*A7*/(if(obj.value.linlin(0,1,21,108) <= 105, {~a7.background_(Color(1,~color_array[105-1],~color_array[105-1]));~dot_a7.background_(Color(0,0,0,~color_arrayMAN[105-1]))}, {~a7.background_(Color.white);~dot_a7.background_(Color(0,0,0,0))}););
/*B7*/(if(obj.value.linlin(0,1,21,108) <= 107, {~b7.background_(Color(1,~color_array[107-1],~color_array[107-1]));~dot_b7.background_(Color(0,0,0,~color_arrayMAN[107-1]))}, {~b7.background_(Color.white);~dot_b7.background_(Color(0,0,0,0))}););
/*C8*/(if(obj.value.linlin(0,1,21,108) <= 108, {~c8.background_(Color(1,~color_array[108-1],~color_array[108-1]));~dot_c8.background_(Color(0,0,0,~color_arrayMAN[108-1]))}, {~c8.background_(Color.white);~dot_c8.background_(Color(0,0,0,0))}););




/*
/*ASHARP0*/(if(obj.value.linlin(0,1,21,108) <= 22, {~aSHARP0.background_(Color((1-~color_array[22-1])**(0.25),0,0));}, {~aSHARP0.background_(Color.black)}););
/*CSHARP1*/(if(obj.value.linlin(0,1,21,108) <= 25, {~cSHARP1.background_(Color((1-~color_array[25-1])**(0.25),0,0));}, {~cSHARP1.background_(Color.black)}););
/*DSHARP1*/(if(obj.value.linlin(0,1,21,108) <= 27, {~dSHARP1.background_(Color((1-~color_array[27-1])**(0.25),0,0));}, {~dSHARP1.background_(Color.black)}););
/*FSHARP1*/(if(obj.value.linlin(0,1,21,108) <= 30, {~fSHARP1.background_(Color((1-~color_array[30-1])**(0.25),0,0));}, {~fSHARP1.background_(Color.black)}););
/*GSHARP1*/(if(obj.value.linlin(0,1,21,108) <= 32, {~gSHARP1.background_(Color((1-~color_array[32-1])**(0.25),0,0));}, {~gSHARP1.background_(Color.black)}););
/*ASHARP1*/(if(obj.value.linlin(0,1,21,108) <= 34, {~aSHARP1.background_(Color((1-~color_array[34-1])**(0.25),0,0));}, {~aSHARP1.background_(Color.black)}););
/*CSHARP2*/(if(obj.value.linlin(0,1,21,108) <= 37, {~cSHARP2.background_(Color((1-~color_array[37-1])**(0.25),0,0));}, {~cSHARP2.background_(Color.black)}););
/*DSHARP2*/(if(obj.value.linlin(0,1,21,108) <= 39, {~dSHARP2.background_(Color((1-~color_array[39-1])**(0.25),0,0));}, {~dSHARP2.background_(Color.black)}););
/*FSHARP2*/(if(obj.value.linlin(0,1,21,108) <= 42, {~fSHARP2.background_(Color((1-~color_array[42-1])**(0.25),0,0));}, {~fSHARP2.background_(Color.black)}););
/*GSHARP2*/(if(obj.value.linlin(0,1,21,108) <= 44, {~gSHARP2.background_(Color((1-~color_array[44-1])**(0.25),0,0));}, {~gSHARP2.background_(Color.black)}););
/*ASHARP2*/(if(obj.value.linlin(0,1,21,108) <= 46, {~aSHARP2.background_(Color((1-~color_array[46-1])**(0.25),0,0));}, {~aSHARP2.background_(Color.black)}););
/*CSHARP3*/(if(obj.value.linlin(0,1,21,108) <= 49, {~cSHARP3.background_(Color((1-~color_array[49-1])**(0.25),0,0));}, {~cSHARP3.background_(Color.black)}););
/*DSHARP3*/(if(obj.value.linlin(0,1,21,108) <= 51, {~dSHARP3.background_(Color((1-~color_array[51-1])**(0.25),0,0));}, {~dSHARP3.background_(Color.black)}););
/*FSHARP3*/(if(obj.value.linlin(0,1,21,108) <= 54, {~fSHARP3.background_(Color((1-~color_array[54-1])**(0.25),0,0));}, {~fSHARP3.background_(Color.black)}););
/*GSHARP3*/(if(obj.value.linlin(0,1,21,108) <= 56, {~gSHARP3.background_(Color((1-~color_array[56-1])**(0.25),0,0));}, {~gSHARP3.background_(Color.black)}););
/*ASHARP3*/(if(obj.value.linlin(0,1,21,108) <= 58, {~aSHARP3.background_(Color((1-~color_array[58-1])**(0.25),0,0));}, {~aSHARP3.background_(Color.black)}););
/*CSHARP4*/(if(obj.value.linlin(0,1,21,108) <= 61, {~cSHARP4.background_(Color((1-~color_array[61-1])**(0.25),0,0));}, {~cSHARP4.background_(Color.black)}););
/*DSHARP4*/(if(obj.value.linlin(0,1,21,108) <= 63, {~dSHARP4.background_(Color((1-~color_array[63-1])**(0.25),0,0));}, {~dSHARP4.background_(Color.black)}););
/*FSHARP4*/(if(obj.value.linlin(0,1,21,108) <= 66, {~fSHARP4.background_(Color((1-~color_array[66-1])**(0.25),0,0));}, {~fSHARP4.background_(Color.black)}););
/*GSHARP4*/(if(obj.value.linlin(0,1,21,108) <= 68, {~gSHARP4.background_(Color((1-~color_array[68-1])**(0.25),0,0));}, {~gSHARP4.background_(Color.black)}););
/*ASHARP4*/(if(obj.value.linlin(0,1,21,108) <= 70, {~aSHARP4.background_(Color((1-~color_array[70-1])**(0.25),0,0));}, {~aSHARP4.background_(Color.black)}););
/*CSHARP5*/(if(obj.value.linlin(0,1,21,108) <= 73, {~cSHARP5.background_(Color((1-~color_array[73-1])**(0.25),0,0));}, {~cSHARP5.background_(Color.black)}););
/*DSHARP5*/(if(obj.value.linlin(0,1,21,108) <= 75, {~dSHARP5.background_(Color((1-~color_array[75-1])**(0.25),0,0));}, {~dSHARP5.background_(Color.black)}););
/*FSHARP5*/(if(obj.value.linlin(0,1,21,108) <= 78, {~fSHARP5.background_(Color((1-~color_array[78-1])**(0.25),0,0));}, {~fSHARP5.background_(Color.black)}););
/*GSHARP5*/(if(obj.value.linlin(0,1,21,108) <= 80, {~gSHARP5.background_(Color((1-~color_array[80-1])**(0.25),0,0));}, {~gSHARP5.background_(Color.black)}););
/*ASHARP5*/(if(obj.value.linlin(0,1,21,108) <= 82, {~aSHARP5.background_(Color((1-~color_array[82-1])**(0.25),0,0));}, {~aSHARP5.background_(Color.black)}););
/*CSHARP6*/(if(obj.value.linlin(0,1,21,108) <= 85, {~cSHARP6.background_(Color((1-~color_array[85-1])**(0.25),0,0));}, {~cSHARP6.background_(Color.black)}););
/*DSHARP6*/(if(obj.value.linlin(0,1,21,108) <= 87, {~dSHARP6.background_(Color((1-~color_array[87-1])**(0.25),0,0));}, {~dSHARP6.background_(Color.black)}););
/*FSHARP6*/(if(obj.value.linlin(0,1,21,108) <= 90, {~fSHARP6.background_(Color((1-~color_array[90-1])**(0.25),0,0));}, {~fSHARP6.background_(Color.black)}););
/*GSHARP6*/(if(obj.value.linlin(0,1,21,108) <= 92, {~gSHARP6.background_(Color((1-~color_array[92-1])**(0.25),0,0));}, {~gSHARP6.background_(Color.black)}););
/*ASHARP6*/(if(obj.value.linlin(0,1,21,108) <= 94, {~aSHARP6.background_(Color((1-~color_array[94-1])**(0.25),0,0));}, {~aSHARP6.background_(Color.black)}););
/*CSHARP7*/(if(obj.value.linlin(0,1,21,108) <= 97, {~cSHARP7.background_(Color((1-~color_array[97-1])**(0.25),0,0));}, {~cSHARP7.background_(Color.black)}););
/*DSHARP7*/(if(obj.value.linlin(0,1,21,108) <= 99, {~dSHARP7.background_(Color((1-~color_array[99-1])**(0.25),0,0));}, {~dSHARP7.background_(Color.black)}););
/*FSHARP7*/(if(obj.value.linlin(0,1,21,108) <= 102, {~fSHARP7.background_(Color((1-~color_array[102-1])**(0.25),0,0));}, {~fSHARP7.background_(Color.black)}););
/*GSHARP7*/(if(obj.value.linlin(0,1,21,108) <= 104, {~gSHARP7.background_(Color((1-~color_array[104-1])**(0.25),0,0));}, {~gSHARP7.background_(Color.black)}););
/*ASHARP7*/(if(obj.value.linlin(0,1,21,108) <= 106, {~aSHARP7.background_(Color((1-~color_array[106-1])**(0.25),0,0));}, {~aSHARP7.background_(Color.black)}););
*/
/*
/*ASHARP0*/(if(obj.value.linlin(0,1,21,108) <=22,{if(~color_array[22-1]<1,{~aSHARP0.background_(Color(1,(~color_array[22-1]+~color_arrayMAN[22-1]),~color_array[22-1]));},{~aSHARP0.background_(Color.black)})},{~aSHARP0.background_(Color.black)}););
/*CSHARP1*/(if(obj.value.linlin(0,1,21,108) <=25,{if(~color_array[25-1]<1,{~cSHARP1.background_(Color(1,(~color_array[25-1]+~color_arrayMAN[25-1]),~color_array[25-1]));},{~cSHARP1.background_(Color.black)})},{~cSHARP1.background_(Color.black)}););
/*DSHARP1*/(if(obj.value.linlin(0,1,21,108) <=27,{if(~color_array[27-1]<1,{~dSHARP1.background_(Color(1,(~color_array[27-1]+~color_arrayMAN[27-1]),~color_array[27-1]));},{~dSHARP1.background_(Color.black)})},{~dSHARP1.background_(Color.black)}););
/*FSHARP1*/(if(obj.value.linlin(0,1,21,108) <=30,{if(~color_array[30-1]<1,{~fSHARP1.background_(Color(1,(~color_array[30-1]+~color_arrayMAN[30-1]),~color_array[30-1]));},{~fSHARP1.background_(Color.black)})},{~fSHARP1.background_(Color.black)}););
/*GSHARP1*/(if(obj.value.linlin(0,1,21,108) <=32,{if(~color_array[32-1]<1,{~gSHARP1.background_(Color(1,(~color_array[32-1]+~color_arrayMAN[32-1]),~color_array[32-1]));},{~gSHARP1.background_(Color.black)})},{~gSHARP1.background_(Color.black)}););
/*ASHARP1*/(if(obj.value.linlin(0,1,21,108) <=34,{if(~color_array[34-1]<1,{~aSHARP1.background_(Color(1,(~color_array[34-1]+~color_arrayMAN[34-1]),~color_array[34-1]));},{~aSHARP1.background_(Color.black)})},{~aSHARP1.background_(Color.black)}););
/*CSHARP2*/(if(obj.value.linlin(0,1,21,108) <=37,{if(~color_array[37-1]<1,{~cSHARP2.background_(Color(1,(~color_array[37-1]+~color_arrayMAN[37-1]),~color_array[37-1]));},{~cSHARP2.background_(Color.black)})},{~cSHARP2.background_(Color.black)}););
/*DSHARP2*/(if(obj.value.linlin(0,1,21,108) <=39,{if(~color_array[39-1]<1,{~dSHARP2.background_(Color(1,(~color_array[39-1]+~color_arrayMAN[39-1]),~color_array[39-1]));},{~dSHARP2.background_(Color.black)})},{~dSHARP2.background_(Color.black)}););
/*FSHARP2*/(if(obj.value.linlin(0,1,21,108) <=42,{if(~color_array[42-1]<1,{~fSHARP2.background_(Color(1,(~color_array[42-1]+~color_arrayMAN[42-1]),~color_array[42-1]));},{~fSHARP2.background_(Color.black)})},{~fSHARP2.background_(Color.black)}););
/*GSHARP2*/(if(obj.value.linlin(0,1,21,108) <=44,{if(~color_array[44-1]<1,{~gSHARP2.background_(Color(1,(~color_array[44-1]+~color_arrayMAN[44-1]),~color_array[44-1]));},{~gSHARP2.background_(Color.black)})},{~gSHARP2.background_(Color.black)}););
/*ASHARP2*/(if(obj.value.linlin(0,1,21,108) <=46,{if(~color_array[46-1]<1,{~aSHARP2.background_(Color(1,(~color_array[46-1]+~color_arrayMAN[46-1]),~color_array[46-1]));},{~aSHARP2.background_(Color.black)})},{~aSHARP2.background_(Color.black)}););
/*CSHARP3*/(if(obj.value.linlin(0,1,21,108) <=49,{if(~color_array[49-1]<1,{~cSHARP3.background_(Color(1,(~color_array[49-1]+~color_arrayMAN[49-1]),~color_array[49-1]));},{~cSHARP3.background_(Color.black)})},{~cSHARP3.background_(Color.black)}););
/*DSHARP3*/(if(obj.value.linlin(0,1,21,108) <=51,{if(~color_array[51-1]<1,{~dSHARP3.background_(Color(1,(~color_array[51-1]+~color_arrayMAN[51-1]),~color_array[51-1]));},{~dSHARP3.background_(Color.black)})},{~dSHARP3.background_(Color.black)}););
/*FSHARP3*/(if(obj.value.linlin(0,1,21,108) <=54,{if(~color_array[54-1]<1,{~fSHARP3.background_(Color(1,(~color_array[54-1]+~color_arrayMAN[54-1]),~color_array[54-1]));},{~fSHARP3.background_(Color.black)})},{~fSHARP3.background_(Color.black)}););
/*GSHARP3*/(if(obj.value.linlin(0,1,21,108) <=56,{if(~color_array[56-1]<1,{~gSHARP3.background_(Color(1,(~color_array[56-1]+~color_arrayMAN[56-1]),~color_array[56-1]));},{~gSHARP3.background_(Color.black)})},{~gSHARP3.background_(Color.black)}););
/*ASHARP3*/(if(obj.value.linlin(0,1,21,108) <=58,{if(~color_array[58-1]<1,{~aSHARP3.background_(Color(1,(~color_array[58-1]+~color_arrayMAN[58-1]),~color_array[58-1]));},{~aSHARP3.background_(Color.black)})},{~aSHARP3.background_(Color.black)}););
/*CSHARP4*/(if(obj.value.linlin(0,1,21,108) <=61,{if(~color_array[61-1]<1,{~cSHARP4.background_(Color(1,(~color_array[61-1]+~color_arrayMAN[61-1]),~color_array[61-1]));},{~cSHARP4.background_(Color.black)})},{~cSHARP4.background_(Color.black)}););
/*DSHARP4*/(if(obj.value.linlin(0,1,21,108) <=63,{if(~color_array[63-1]<1,{~dSHARP4.background_(Color(1,(~color_array[63-1]+~color_arrayMAN[63-1]),~color_array[63-1]));},{~dSHARP4.background_(Color.black)})},{~dSHARP4.background_(Color.black)}););
/*FSHARP4*/(if(obj.value.linlin(0,1,21,108) <=66,{if(~color_array[66-1]<1,{~fSHARP4.background_(Color(1,(~color_array[66-1]+~color_arrayMAN[66-1]),~color_array[66-1]));},{~fSHARP4.background_(Color.black)})},{~fSHARP4.background_(Color.black)}););
/*GSHARP4*/(if(obj.value.linlin(0,1,21,108) <=68,{if(~color_array[68-1]<1,{~gSHARP4.background_(Color(1,(~color_array[68-1]+~color_arrayMAN[68-1]),~color_array[68-1]));},{~gSHARP4.background_(Color.black)})},{~gSHARP4.background_(Color.black)}););
/*ASHARP4*/(if(obj.value.linlin(0,1,21,108) <=70,{if(~color_array[70-1]<1,{~aSHARP4.background_(Color(1,(~color_array[70-1]+~color_arrayMAN[70-1]),~color_array[70-1]));},{~aSHARP4.background_(Color.black)})},{~aSHARP4.background_(Color.black)}););
/*CSHARP5*/(if(obj.value.linlin(0,1,21,108) <=73,{if(~color_array[73-1]<1,{~cSHARP5.background_(Color(1,(~color_array[73-1]+~color_arrayMAN[73-1]),~color_array[73-1]));},{~cSHARP5.background_(Color.black)})},{~cSHARP5.background_(Color.black)}););
/*DSHARP5*/(if(obj.value.linlin(0,1,21,108) <=75,{if(~color_array[75-1]<1,{~dSHARP5.background_(Color(1,(~color_array[75-1]+~color_arrayMAN[75-1]),~color_array[75-1]));},{~dSHARP5.background_(Color.black)})},{~dSHARP5.background_(Color.black)}););
/*FSHARP5*/(if(obj.value.linlin(0,1,21,108) <=78,{if(~color_array[78-1]<1,{~fSHARP5.background_(Color(1,(~color_array[78-1]+~color_arrayMAN[78-1]),~color_array[78-1]));},{~fSHARP5.background_(Color.black)})},{~fSHARP5.background_(Color.black)}););
/*GSHARP5*/(if(obj.value.linlin(0,1,21,108) <=80,{if(~color_array[80-1]<1,{~gSHARP5.background_(Color(1,(~color_array[80-1]+~color_arrayMAN[80-1]),~color_array[80-1]));},{~gSHARP5.background_(Color.black)})},{~gSHARP5.background_(Color.black)}););
/*ASHARP5*/(if(obj.value.linlin(0,1,21,108) <=82,{if(~color_array[82-1]<1,{~aSHARP5.background_(Color(1,(~color_array[82-1]+~color_arrayMAN[82-1]),~color_array[82-1]));},{~aSHARP5.background_(Color.black)})},{~aSHARP5.background_(Color.black)}););
/*CSHARP6*/(if(obj.value.linlin(0,1,21,108) <=85,{if(~color_array[85-1]<1,{~cSHARP6.background_(Color(1,(~color_array[85-1]+~color_arrayMAN[85-1]),~color_array[85-1]));},{~cSHARP6.background_(Color.black)})},{~cSHARP6.background_(Color.black)}););
/*DSHARP6*/(if(obj.value.linlin(0,1,21,108) <=87,{if(~color_array[87-1]<1,{~dSHARP6.background_(Color(1,(~color_array[87-1]+~color_arrayMAN[87-1]),~color_array[87-1]));},{~dSHARP6.background_(Color.black)})},{~dSHARP6.background_(Color.black)}););
/*FSHARP6*/(if(obj.value.linlin(0,1,21,108) <=90,{if(~color_array[90-1]<1,{~fSHARP6.background_(Color(1,(~color_array[90-1]+~color_arrayMAN[90-1]),~color_array[90-1]));},{~fSHARP6.background_(Color.black)})},{~fSHARP6.background_(Color.black)}););
/*GSHARP6*/(if(obj.value.linlin(0,1,21,108) <=92,{if(~color_array[92-1]<1,{~gSHARP6.background_(Color(1,(~color_array[92-1]+~color_arrayMAN[92-1]),~color_array[92-1]));},{~gSHARP6.background_(Color.black)})},{~gSHARP6.background_(Color.black)}););
/*ASHARP6*/(if(obj.value.linlin(0,1,21,108) <=94,{if(~color_array[94-1]<1,{~aSHARP6.background_(Color(1,(~color_array[94-1]+~color_arrayMAN[94-1]),~color_array[94-1]));},{~aSHARP6.background_(Color.black)})},{~aSHARP6.background_(Color.black)}););
/*CSHARP7*/(if(obj.value.linlin(0,1,21,108) <=97,{if(~color_array[97-1]<1,{~cSHARP7.background_(Color(1,(~color_array[97-1]+~color_arrayMAN[97-1]),~color_array[97-1]));},{~cSHARP7.background_(Color.black)})},{~cSHARP7.background_(Color.black)}););
/*DSHARP7*/(if(obj.value.linlin(0,1,21,108) <=99,{if(~color_array[99-1]<1,{~dSHARP7.background_(Color(1,(~color_array[99-1]+~color_arrayMAN[99-1]),~color_array[99-1]));},{~dSHARP7.background_(Color.black)})},{~dSHARP7.background_(Color.black)}););
/*FSHARP7*/(if(obj.value.linlin(0,1,21,108) <=102,{if(~color_array[102-1]<1,{~fSHARP7.background_(Color(1,(~color_array[102-1]+~color_arrayMAN[102-1]),~color_array[102-1]));},{~fSHARP7.background_(Color.black)})},{~fSHARP7.background_(Color.black)}););
/*GSHARP7*/(if(obj.value.linlin(0,1,21,108) <=104,{if(~color_array[104-1]<1,{~gSHARP7.background_(Color(1,(~color_array[104-1]+~color_arrayMAN[104-1]),~color_array[104-1]));},{~gSHARP7.background_(Color.black)})},{~gSHARP7.background_(Color.black)}););
/*ASHARP7*/(if(obj.value.linlin(0,1,21,108) <=106,{if(~color_array[106-1]<1,{~aSHARP7.background_(Color(1,(~color_array[106-1]+~color_arrayMAN[106-1]),~color_array[106-1]));},{~aSHARP7.background_(Color.black)})},{~aSHARP7.background_(Color.black)}););*/



/*ASHARP0*/(if(obj.value.linlin(0,1,21,108) <=22,{if(~color_array[22-1]<1,{~aSHARP0.background_(Color(1,~color_array[22-1],~color_array[22-1]));~dot_aSHARP0.background_(Color(1,1,1,~color_arrayMAN[22-1]));},{~aSHARP0.background_(Color.black); ~dot_aSHARP0.background_(Color(1,1,1,0))})},{~aSHARP0.background_(Color.black);~dot_aSHARP0.background_(Color(1,1,1,0))}););
/*CSHARP1*/(if(obj.value.linlin(0,1,21,108) <=25,{if(~color_array[25-1]<1,{~cSHARP1.background_(Color(1,~color_array[25-1],~color_array[25-1]));~dot_cSHARP1.background_(Color(1,1,1,~color_arrayMAN[25-1]));},{~cSHARP1.background_(Color.black); ~dot_cSHARP1.background_(Color(1,1,1,0))})},{~cSHARP1.background_(Color.black);~dot_cSHARP1.background_(Color(1,1,1,0))}););
/*DSHARP1*/(if(obj.value.linlin(0,1,21,108) <=27,{if(~color_array[27-1]<1,{~dSHARP1.background_(Color(1,~color_array[27-1],~color_array[27-1]));~dot_dSHARP1.background_(Color(1,1,1,~color_arrayMAN[27-1]));},{~dSHARP1.background_(Color.black); ~dot_dSHARP1.background_(Color(1,1,1,0))})},{~dSHARP1.background_(Color.black);~dot_dSHARP1.background_(Color(1,1,1,0))}););
/*FSHARP1*/(if(obj.value.linlin(0,1,21,108) <=30,{if(~color_array[30-1]<1,{~fSHARP1.background_(Color(1,~color_array[30-1],~color_array[30-1]));~dot_fSHARP1.background_(Color(1,1,1,~color_arrayMAN[30-1]));},{~fSHARP1.background_(Color.black); ~dot_fSHARP1.background_(Color(1,1,1,0))})},{~fSHARP1.background_(Color.black);~dot_fSHARP1.background_(Color(1,1,1,0))}););
/*GSHARP1*/(if(obj.value.linlin(0,1,21,108) <=32,{if(~color_array[32-1]<1,{~gSHARP1.background_(Color(1,~color_array[32-1],~color_array[32-1]));~dot_gSHARP1.background_(Color(1,1,1,~color_arrayMAN[32-1]));},{~gSHARP1.background_(Color.black); ~dot_gSHARP1.background_(Color(1,1,1,0))})},{~gSHARP1.background_(Color.black);~dot_gSHARP1.background_(Color(1,1,1,0))}););
/*ASHARP1*/(if(obj.value.linlin(0,1,21,108) <=34,{if(~color_array[34-1]<1,{~aSHARP1.background_(Color(1,~color_array[34-1],~color_array[34-1]));~dot_aSHARP1.background_(Color(1,1,1,~color_arrayMAN[34-1]));},{~aSHARP1.background_(Color.black); ~dot_aSHARP1.background_(Color(1,1,1,0))})},{~aSHARP1.background_(Color.black);~dot_aSHARP1.background_(Color(1,1,1,0))}););
/*CSHARP2*/(if(obj.value.linlin(0,1,21,108) <=37,{if(~color_array[37-1]<1,{~cSHARP2.background_(Color(1,~color_array[37-1],~color_array[37-1]));~dot_cSHARP2.background_(Color(1,1,1,~color_arrayMAN[37-1]));},{~cSHARP2.background_(Color.black); ~dot_cSHARP2.background_(Color(1,1,1,0))})},{~cSHARP2.background_(Color.black);~dot_cSHARP2.background_(Color(1,1,1,0))}););
/*DSHARP2*/(if(obj.value.linlin(0,1,21,108) <=39,{if(~color_array[39-1]<1,{~dSHARP2.background_(Color(1,~color_array[39-1],~color_array[39-1]));~dot_dSHARP2.background_(Color(1,1,1,~color_arrayMAN[39-1]));},{~dSHARP2.background_(Color.black); ~dot_dSHARP2.background_(Color(1,1,1,0))})},{~dSHARP2.background_(Color.black);~dot_dSHARP2.background_(Color(1,1,1,0))}););
/*FSHARP2*/(if(obj.value.linlin(0,1,21,108) <=42,{if(~color_array[42-1]<1,{~fSHARP2.background_(Color(1,~color_array[42-1],~color_array[42-1]));~dot_fSHARP2.background_(Color(1,1,1,~color_arrayMAN[42-1]));},{~fSHARP2.background_(Color.black); ~dot_fSHARP2.background_(Color(1,1,1,0))})},{~fSHARP2.background_(Color.black);~dot_fSHARP2.background_(Color(1,1,1,0))}););
/*GSHARP2*/(if(obj.value.linlin(0,1,21,108) <=44,{if(~color_array[44-1]<1,{~gSHARP2.background_(Color(1,~color_array[44-1],~color_array[44-1]));~dot_gSHARP2.background_(Color(1,1,1,~color_arrayMAN[44-1]));},{~gSHARP2.background_(Color.black); ~dot_gSHARP2.background_(Color(1,1,1,0))})},{~gSHARP2.background_(Color.black);~dot_gSHARP2.background_(Color(1,1,1,0))}););
/*ASHARP2*/(if(obj.value.linlin(0,1,21,108) <=46,{if(~color_array[46-1]<1,{~aSHARP2.background_(Color(1,~color_array[46-1],~color_array[46-1]));~dot_aSHARP2.background_(Color(1,1,1,~color_arrayMAN[46-1]));},{~aSHARP2.background_(Color.black); ~dot_aSHARP2.background_(Color(1,1,1,0))})},{~aSHARP2.background_(Color.black);~dot_aSHARP2.background_(Color(1,1,1,0))}););
/*CSHARP3*/(if(obj.value.linlin(0,1,21,108) <=49,{if(~color_array[49-1]<1,{~cSHARP3.background_(Color(1,~color_array[49-1],~color_array[49-1]));~dot_cSHARP3.background_(Color(1,1,1,~color_arrayMAN[49-1]));},{~cSHARP3.background_(Color.black); ~dot_cSHARP3.background_(Color(1,1,1,0))})},{~cSHARP3.background_(Color.black);~dot_cSHARP3.background_(Color(1,1,1,0))}););
/*DSHARP3*/(if(obj.value.linlin(0,1,21,108) <=51,{if(~color_array[51-1]<1,{~dSHARP3.background_(Color(1,~color_array[51-1],~color_array[51-1]));~dot_dSHARP3.background_(Color(1,1,1,~color_arrayMAN[51-1]));},{~dSHARP3.background_(Color.black); ~dot_dSHARP3.background_(Color(1,1,1,0))})},{~dSHARP3.background_(Color.black);~dot_dSHARP3.background_(Color(1,1,1,0))}););
/*FSHARP3*/(if(obj.value.linlin(0,1,21,108) <=54,{if(~color_array[54-1]<1,{~fSHARP3.background_(Color(1,~color_array[54-1],~color_array[54-1]));~dot_fSHARP3.background_(Color(1,1,1,~color_arrayMAN[54-1]));},{~fSHARP3.background_(Color.black); ~dot_fSHARP3.background_(Color(1,1,1,0))})},{~fSHARP3.background_(Color.black);~dot_fSHARP3.background_(Color(1,1,1,0))}););
/*GSHARP3*/(if(obj.value.linlin(0,1,21,108) <=56,{if(~color_array[56-1]<1,{~gSHARP3.background_(Color(1,~color_array[56-1],~color_array[56-1]));~dot_gSHARP3.background_(Color(1,1,1,~color_arrayMAN[56-1]));},{~gSHARP3.background_(Color.black); ~dot_gSHARP3.background_(Color(1,1,1,0))})},{~gSHARP3.background_(Color.black);~dot_gSHARP3.background_(Color(1,1,1,0))}););
/*ASHARP3*/(if(obj.value.linlin(0,1,21,108) <=58,{if(~color_array[58-1]<1,{~aSHARP3.background_(Color(1,~color_array[58-1],~color_array[58-1]));~dot_aSHARP3.background_(Color(1,1,1,~color_arrayMAN[58-1]));},{~aSHARP3.background_(Color.black); ~dot_aSHARP3.background_(Color(1,1,1,0))})},{~aSHARP3.background_(Color.black);~dot_aSHARP3.background_(Color(1,1,1,0))}););
/*CSHARP4*/(if(obj.value.linlin(0,1,21,108) <=61,{if(~color_array[61-1]<1,{~cSHARP4.background_(Color(1,~color_array[61-1],~color_array[61-1]));~dot_cSHARP4.background_(Color(1,1,1,~color_arrayMAN[61-1]));},{~cSHARP4.background_(Color.black); ~dot_cSHARP4.background_(Color(1,1,1,0))})},{~cSHARP4.background_(Color.black);~dot_cSHARP4.background_(Color(1,1,1,0))}););
/*DSHARP4*/(if(obj.value.linlin(0,1,21,108) <=63,{if(~color_array[63-1]<1,{~dSHARP4.background_(Color(1,~color_array[63-1],~color_array[63-1]));~dot_dSHARP4.background_(Color(1,1,1,~color_arrayMAN[63-1]));},{~dSHARP4.background_(Color.black); ~dot_dSHARP4.background_(Color(1,1,1,0))})},{~dSHARP4.background_(Color.black);~dot_dSHARP4.background_(Color(1,1,1,0))}););
/*FSHARP4*/(if(obj.value.linlin(0,1,21,108) <=66,{if(~color_array[66-1]<1,{~fSHARP4.background_(Color(1,~color_array[66-1],~color_array[66-1]));~dot_fSHARP4.background_(Color(1,1,1,~color_arrayMAN[66-1]));},{~fSHARP4.background_(Color.black); ~dot_fSHARP4.background_(Color(1,1,1,0))})},{~fSHARP4.background_(Color.black);~dot_fSHARP4.background_(Color(1,1,1,0))}););
/*GSHARP4*/(if(obj.value.linlin(0,1,21,108) <=68,{if(~color_array[68-1]<1,{~gSHARP4.background_(Color(1,~color_array[68-1],~color_array[68-1]));~dot_gSHARP4.background_(Color(1,1,1,~color_arrayMAN[68-1]));},{~gSHARP4.background_(Color.black); ~dot_gSHARP4.background_(Color(1,1,1,0))})},{~gSHARP4.background_(Color.black);~dot_gSHARP4.background_(Color(1,1,1,0))}););
/*ASHARP4*/(if(obj.value.linlin(0,1,21,108) <=70,{if(~color_array[70-1]<1,{~aSHARP4.background_(Color(1,~color_array[70-1],~color_array[70-1]));~dot_aSHARP4.background_(Color(1,1,1,~color_arrayMAN[70-1]));},{~aSHARP4.background_(Color.black); ~dot_aSHARP4.background_(Color(1,1,1,0))})},{~aSHARP4.background_(Color.black);~dot_aSHARP4.background_(Color(1,1,1,0))}););
/*CSHARP5*/(if(obj.value.linlin(0,1,21,108) <=73,{if(~color_array[73-1]<1,{~cSHARP5.background_(Color(1,~color_array[73-1],~color_array[73-1]));~dot_cSHARP5.background_(Color(1,1,1,~color_arrayMAN[73-1]));},{~cSHARP5.background_(Color.black); ~dot_cSHARP5.background_(Color(1,1,1,0))})},{~cSHARP5.background_(Color.black);~dot_cSHARP5.background_(Color(1,1,1,0))}););
/*DSHARP5*/(if(obj.value.linlin(0,1,21,108) <=75,{if(~color_array[75-1]<1,{~dSHARP5.background_(Color(1,~color_array[75-1],~color_array[75-1]));~dot_dSHARP5.background_(Color(1,1,1,~color_arrayMAN[75-1]));},{~dSHARP5.background_(Color.black); ~dot_dSHARP5.background_(Color(1,1,1,0))})},{~dSHARP5.background_(Color.black);~dot_dSHARP5.background_(Color(1,1,1,0))}););
/*FSHARP5*/(if(obj.value.linlin(0,1,21,108) <=78,{if(~color_array[78-1]<1,{~fSHARP5.background_(Color(1,~color_array[78-1],~color_array[78-1]));~dot_fSHARP5.background_(Color(1,1,1,~color_arrayMAN[78-1]));},{~fSHARP5.background_(Color.black); ~dot_fSHARP5.background_(Color(1,1,1,0))})},{~fSHARP5.background_(Color.black);~dot_fSHARP5.background_(Color(1,1,1,0))}););
/*GSHARP5*/(if(obj.value.linlin(0,1,21,108) <=80,{if(~color_array[80-1]<1,{~gSHARP5.background_(Color(1,~color_array[80-1],~color_array[80-1]));~dot_gSHARP5.background_(Color(1,1,1,~color_arrayMAN[80-1]));},{~gSHARP5.background_(Color.black); ~dot_gSHARP5.background_(Color(1,1,1,0))})},{~gSHARP5.background_(Color.black);~dot_gSHARP5.background_(Color(1,1,1,0))}););
/*ASHARP5*/(if(obj.value.linlin(0,1,21,108) <=82,{if(~color_array[82-1]<1,{~aSHARP5.background_(Color(1,~color_array[82-1],~color_array[82-1]));~dot_aSHARP5.background_(Color(1,1,1,~color_arrayMAN[82-1]));},{~aSHARP5.background_(Color.black); ~dot_aSHARP5.background_(Color(1,1,1,0))})},{~aSHARP5.background_(Color.black);~dot_aSHARP5.background_(Color(1,1,1,0))}););
/*CSHARP6*/(if(obj.value.linlin(0,1,21,108) <=85,{if(~color_array[85-1]<1,{~cSHARP6.background_(Color(1,~color_array[85-1],~color_array[85-1]));~dot_cSHARP6.background_(Color(1,1,1,~color_arrayMAN[85-1]));},{~cSHARP6.background_(Color.black); ~dot_cSHARP6.background_(Color(1,1,1,0))})},{~cSHARP6.background_(Color.black);~dot_cSHARP6.background_(Color(1,1,1,0))}););
/*DSHARP6*/(if(obj.value.linlin(0,1,21,108) <=87,{if(~color_array[87-1]<1,{~dSHARP6.background_(Color(1,~color_array[87-1],~color_array[87-1]));~dot_dSHARP6.background_(Color(1,1,1,~color_arrayMAN[87-1]));},{~dSHARP6.background_(Color.black); ~dot_dSHARP6.background_(Color(1,1,1,0))})},{~dSHARP6.background_(Color.black);~dot_dSHARP6.background_(Color(1,1,1,0))}););
/*FSHARP6*/(if(obj.value.linlin(0,1,21,108) <=90,{if(~color_array[90-1]<1,{~fSHARP6.background_(Color(1,~color_array[90-1],~color_array[90-1]));~dot_fSHARP6.background_(Color(1,1,1,~color_arrayMAN[90-1]));},{~fSHARP6.background_(Color.black); ~dot_fSHARP6.background_(Color(1,1,1,0))})},{~fSHARP6.background_(Color.black);~dot_fSHARP6.background_(Color(1,1,1,0))}););
/*GSHARP6*/(if(obj.value.linlin(0,1,21,108) <=92,{if(~color_array[92-1]<1,{~gSHARP6.background_(Color(1,~color_array[92-1],~color_array[92-1]));~dot_gSHARP6.background_(Color(1,1,1,~color_arrayMAN[92-1]));},{~gSHARP6.background_(Color.black); ~dot_gSHARP6.background_(Color(1,1,1,0))})},{~gSHARP6.background_(Color.black);~dot_gSHARP6.background_(Color(1,1,1,0))}););
/*ASHARP6*/(if(obj.value.linlin(0,1,21,108) <=94,{if(~color_array[94-1]<1,{~aSHARP6.background_(Color(1,~color_array[94-1],~color_array[94-1]));~dot_aSHARP6.background_(Color(1,1,1,~color_arrayMAN[94-1]));},{~aSHARP6.background_(Color.black); ~dot_aSHARP6.background_(Color(1,1,1,0))})},{~aSHARP6.background_(Color.black);~dot_aSHARP6.background_(Color(1,1,1,0))}););
/*CSHARP7*/(if(obj.value.linlin(0,1,21,108) <=97,{if(~color_array[97-1]<1,{~cSHARP7.background_(Color(1,~color_array[97-1],~color_array[97-1]));~dot_cSHARP7.background_(Color(1,1,1,~color_arrayMAN[97-1]));},{~cSHARP7.background_(Color.black); ~dot_cSHARP7.background_(Color(1,1,1,0))})},{~cSHARP7.background_(Color.black);~dot_cSHARP7.background_(Color(1,1,1,0))}););
/*DSHARP7*/(if(obj.value.linlin(0,1,21,108) <=99,{if(~color_array[99-1]<1,{~dSHARP7.background_(Color(1,~color_array[99-1],~color_array[99-1]));~dot_dSHARP7.background_(Color(1,1,1,~color_arrayMAN[99-1]));},{~dSHARP7.background_(Color.black); ~dot_dSHARP7.background_(Color(1,1,1,0))})},{~dSHARP7.background_(Color.black);~dot_dSHARP7.background_(Color(1,1,1,0))}););
/*FSHARP7*/(if(obj.value.linlin(0,1,21,108) <=102,{if(~color_array[102-1]<1,{~fSHARP7.background_(Color(1,~color_array[102-1],~color_array[102-1]));~dot_fSHARP7.background_(Color(1,1,1,~color_arrayMAN[102-1]));},{~fSHARP7.background_(Color.black); ~dot_fSHARP7.background_(Color(1,1,1,0))})},{~fSHARP7.background_(Color.black);~dot_fSHARP7.background_(Color(1,1,1,0))}););
/*GSHARP7*/(if(obj.value.linlin(0,1,21,108) <=104,{if(~color_array[104-1]<1,{~gSHARP7.background_(Color(1,~color_array[104-1],~color_array[104-1]));~dot_gSHARP7.background_(Color(1,1,1,~color_arrayMAN[104-1]));},{~gSHARP7.background_(Color.black); ~dot_gSHARP7.background_(Color(1,1,1,0))})},{~gSHARP7.background_(Color.black);~dot_gSHARP7.background_(Color(1,1,1,0))}););
/*ASHARP7*/(if(obj.value.linlin(0,1,21,108) <=106,{if(~color_array[106-1]<1,{~aSHARP7.background_(Color(1,~color_array[106-1],~color_array[106-1]));~dot_aSHARP7.background_(Color(1,1,1,~color_arrayMAN[106-1]));},{~aSHARP7.background_(Color.black); ~dot_aSHARP7.background_(Color(1,1,1,0))})},{~aSHARP7.background_(Color.black);~dot_aSHARP7.background_(Color(1,1,1,0))}););

/*
			//Deviant definer

/*ASHARP0*/(if(obj.value.linlin(0,1,21,108) <= 22, {~aSHARP0dev.background_(Color((1-~color_array[22-1])**(0.25),0,0));}, {~aSHARP0dev.background_(Color.black)}););
/*CSHARP1*/(if(obj.value.linlin(0,1,21,108) <= 25, {~cSHARP1dev.background_(Color((1-~color_array[25-1])**(0.25),0,0));}, {~cSHARP1dev.background_(Color.black)}););
/*DSHARP1*/(if(obj.value.linlin(0,1,21,108) <= 27, {~dSHARP1dev.background_(Color((1-~color_array[27-1])**(0.25),0,0));}, {~dSHARP1dev.background_(Color.black)}););
/*FSHARP1*/(if(obj.value.linlin(0,1,21,108) <= 30, {~fSHARP1dev.background_(Color((1-~color_array[30-1])**(0.25),0,0));}, {~fSHARP1dev.background_(Color.black)}););
/*GSHARP1*/(if(obj.value.linlin(0,1,21,108) <= 32, {~gSHARP1dev.background_(Color((1-~color_array[32-1])**(0.25),0,0));}, {~gSHARP1dev.background_(Color.black)}););
/*ASHARP1*/(if(obj.value.linlin(0,1,21,108) <= 34, {~aSHARP1dev.background_(Color((1-~color_array[34-1])**(0.25),0,0));}, {~aSHARP1dev.background_(Color.black)}););
/*CSHARP2*/(if(obj.value.linlin(0,1,21,108) <= 37, {~cSHARP2dev.background_(Color((1-~color_array[37-1])**(0.25),0,0));}, {~cSHARP2dev.background_(Color.black)}););
/*DSHARP2*/(if(obj.value.linlin(0,1,21,108) <= 39, {~dSHARP2dev.background_(Color((1-~color_array[39-1])**(0.25),0,0));}, {~dSHARP2dev.background_(Color.black)}););
/*FSHARP2*/(if(obj.value.linlin(0,1,21,108) <= 42, {~fSHARP2dev.background_(Color((1-~color_array[42-1])**(0.25),0,0));}, {~fSHARP2dev.background_(Color.black)}););
/*GSHARP2*/(if(obj.value.linlin(0,1,21,108) <= 44, {~gSHARP2dev.background_(Color((1-~color_array[44-1])**(0.25),0,0));}, {~gSHARP2dev.background_(Color.black)}););
/*ASHARP2*/(if(obj.value.linlin(0,1,21,108) <= 46, {~aSHARP2dev.background_(Color((1-~color_array[46-1])**(0.25),0,0));}, {~aSHARP2dev.background_(Color.black)}););
/*CSHARP3*/(if(obj.value.linlin(0,1,21,108) <= 49, {~cSHARP3dev.background_(Color((1-~color_array[49-1])**(0.25),0,0));}, {~cSHARP3dev.background_(Color.black)}););
/*DSHARP3*/(if(obj.value.linlin(0,1,21,108) <= 51, {~dSHARP3dev.background_(Color((1-~color_array[51-1])**(0.25),0,0));}, {~dSHARP3dev.background_(Color.black)}););
/*FSHARP3*/(if(obj.value.linlin(0,1,21,108) <= 54, {~fSHARP3dev.background_(Color((1-~color_array[54-1])**(0.25),0,0));}, {~fSHARP3dev.background_(Color.black)}););
/*GSHARP3*/(if(obj.value.linlin(0,1,21,108) <= 56, {~gSHARP3dev.background_(Color((1-~color_array[56-1])**(0.25),0,0));}, {~gSHARP3dev.background_(Color.black)}););
/*ASHARP3*/(if(obj.value.linlin(0,1,21,108) <= 58, {~aSHARP3dev.background_(Color((1-~color_array[58-1])**(0.25),0,0));}, {~aSHARP3dev.background_(Color.black)}););
/*CSHARP4*/(if(obj.value.linlin(0,1,21,108) <= 61, {~cSHARP4dev.background_(Color((1-~color_array[61-1])**(0.25),0,0));}, {~cSHARP4dev.background_(Color.black)}););
/*DSHARP4*/(if(obj.value.linlin(0,1,21,108) <= 63, {~dSHARP4dev.background_(Color((1-~color_array[63-1])**(0.25),0,0));}, {~dSHARP4dev.background_(Color.black)}););
/*FSHARP4*/(if(obj.value.linlin(0,1,21,108) <= 66, {~fSHARP4dev.background_(Color((1-~color_array[66-1])**(0.25),0,0));}, {~fSHARP4dev.background_(Color.black)}););
/*GSHARP4*/(if(obj.value.linlin(0,1,21,108) <= 68, {~gSHARP4dev.background_(Color((1-~color_array[68-1])**(0.25),0,0));}, {~gSHARP4dev.background_(Color.black)}););
/*ASHARP4*/(if(obj.value.linlin(0,1,21,108) <= 70, {~aSHARP4dev.background_(Color((1-~color_array[70-1])**(0.25),0,0));}, {~aSHARP4dev.background_(Color.black)}););
/*CSHARP5*/(if(obj.value.linlin(0,1,21,108) <= 73, {~cSHARP5dev.background_(Color((1-~color_array[73-1])**(0.25),0,0));}, {~cSHARP5dev.background_(Color.black)}););
/*DSHARP5*/(if(obj.value.linlin(0,1,21,108) <= 75, {~dSHARP5dev.background_(Color((1-~color_array[75-1])**(0.25),0,0));}, {~dSHARP5dev.background_(Color.black)}););
/*FSHARP5*/(if(obj.value.linlin(0,1,21,108) <= 78, {~fSHARP5dev.background_(Color((1-~color_array[78-1])**(0.25),0,0));}, {~fSHARP5dev.background_(Color.black)}););
/*GSHARP5*/(if(obj.value.linlin(0,1,21,108) <= 80, {~gSHARP5dev.background_(Color((1-~color_array[80-1])**(0.25),0,0));}, {~gSHARP5dev.background_(Color.black)}););
/*ASHARP5*/(if(obj.value.linlin(0,1,21,108) <= 82, {~aSHARP5dev.background_(Color((1-~color_array[82-1])**(0.25),0,0));}, {~aSHARP5dev.background_(Color.black)}););
/*CSHARP6*/(if(obj.value.linlin(0,1,21,108) <= 85, {~cSHARP6dev.background_(Color((1-~color_array[85-1])**(0.25),0,0));}, {~cSHARP6dev.background_(Color.black)}););
/*DSHARP6*/(if(obj.value.linlin(0,1,21,108) <= 87, {~dSHARP6dev.background_(Color((1-~color_array[87-1])**(0.25),0,0));}, {~dSHARP6dev.background_(Color.black)}););
/*FSHARP6*/(if(obj.value.linlin(0,1,21,108) <= 90, {~fSHARP6dev.background_(Color((1-~color_array[90-1])**(0.25),0,0));}, {~fSHARP6dev.background_(Color.black)}););
/*GSHARP6*/(if(obj.value.linlin(0,1,21,108) <= 92, {~gSHARP6dev.background_(Color((1-~color_array[92-1])**(0.25),0,0));}, {~gSHARP6dev.background_(Color.black)}););
/*ASHARP6*/(if(obj.value.linlin(0,1,21,108) <= 94, {~aSHARP6dev.background_(Color((1-~color_array[94-1])**(0.25),0,0));}, {~aSHARP6dev.background_(Color.black)}););
/*CSHARP7*/(if(obj.value.linlin(0,1,21,108) <= 97, {~cSHARP7dev.background_(Color((1-~color_array[97-1])**(0.25),0,0));}, {~cSHARP7dev.background_(Color.black)}););
/*DSHARP7*/(if(obj.value.linlin(0,1,21,108) <= 99, {~dSHARP7dev.background_(Color((1-~color_array[99-1])**(0.25),0,0));}, {~dSHARP7dev.background_(Color.black)}););
/*FSHARP7*/(if(obj.value.linlin(0,1,21,108) <= 102, {~fSHARP7dev.background_(Color((1-~color_array[102-1])**(0.25),0,0));}, {~fSHARP7dev.background_(Color.black)}););
/*GSHARP7*/(if(obj.value.linlin(0,1,21,108) <= 104, {~gSHARP7dev.background_(Color((1-~color_array[104-1])**(0.25),0,0));}, {~gSHARP7dev.background_(Color.black)}););
/*ASHARP7*/(if(obj.value.linlin(0,1,21,108) <= 106, {~aSHARP7dev.background_(Color((1-~color_array[106-1])**(0.25),0,0));}, {~aSHARP7dev.background_(Color.black)}););
*/


		}));
		//
(
~color_array = Array.fill(200,1);
~color_array[~fslider.value.linlin(0,1,21,108)-1+0]=(~harmonics_array[0]+(~otherslider.value.linlin(0,1,1,0)*(1-~harmonics_array[0])))-(~manipulated_harmonic[0]*~mulslider.value.linlin(0,1,0,1););
~color_array[~fslider.value.linlin(0,1,21,108)-1+12]=(~harmonics_array[1]+(~otherslider.value.linlin(0,1,1,0)*(1-~harmonics_array[1])))-(~manipulated_harmonic[1]*~mulslider.value.linlin(0,1,0,1););
~color_array[~fslider.value.linlin(0,1,21,108)-1+19]=(~harmonics_array[2]+(~otherslider.value.linlin(0,1,1,0)*(1-~harmonics_array[2])))-(~manipulated_harmonic[2]*~mulslider.value.linlin(0,1,0,1););
~color_array[~fslider.value.linlin(0,1,21,108)-1+24]=(~harmonics_array[3]+(~otherslider.value.linlin(0,1,1,0)*(1-~harmonics_array[3])))-(~manipulated_harmonic[3]*~mulslider.value.linlin(0,1,0,1););
~color_array[~fslider.value.linlin(0,1,21,108)-1+28]=(~harmonics_array[4]+(~otherslider.value.linlin(0,1,1,0)*(1-~harmonics_array[4])))-(~manipulated_harmonic[4]*~mulslider.value.linlin(0,1,0,1););
~color_array[~fslider.value.linlin(0,1,21,108)-1+31]=(~harmonics_array[5]+(~otherslider.value.linlin(0,1,1,0)*(1-~harmonics_array[5])))-(~manipulated_harmonic[5]*~mulslider.value.linlin(0,1,0,1););
~color_array[~fslider.value.linlin(0,1,21,108)-1+34]=(~harmonics_array[6]+(~otherslider.value.linlin(0,1,1,0)*(1-~harmonics_array[6])))-(~manipulated_harmonic[6]*~mulslider.value.linlin(0,1,0,1););
~color_array[~fslider.value.linlin(0,1,21,108)-1+36]=(~harmonics_array[7]+(~otherslider.value.linlin(0,1,1,0)*(1-~harmonics_array[7])))-(~manipulated_harmonic[7]*~mulslider.value.linlin(0,1,0,1););
~color_array[~fslider.value.linlin(0,1,21,108)-1+38]=(~harmonics_array[8]+(~otherslider.value.linlin(0,1,1,0)*(1-~harmonics_array[8])))-(~manipulated_harmonic[8]*~mulslider.value.linlin(0,1,0,1););
~color_array[~fslider.value.linlin(0,1,21,108)-1+40]=(~harmonics_array[9]+(~otherslider.value.linlin(0,1,1,0)*(1-~harmonics_array[9])))-(~manipulated_harmonic[9]*~mulslider.value.linlin(0,1,0,1););
~color_array[~fslider.value.linlin(0,1,21,108)-1+41]=(~harmonics_array[10]+(~otherslider.value.linlin(0,1,1,0)*(1-~harmonics_array[10])))-(~manipulated_harmonic[10]*~mulslider.value.linlin(0,1,0,1););
~color_array[~fslider.value.linlin(0,1,21,108)-1+43]=(~harmonics_array[11]+(~otherslider.value.linlin(0,1,1,0)*(1-~harmonics_array[11])))-(~manipulated_harmonic[11]*~mulslider.value.linlin(0,1,0,1););
~color_array[~fslider.value.linlin(0,1,21,108)-1+44]=(~harmonics_array[12]+(~otherslider.value.linlin(0,1,1,0)*(1-~harmonics_array[12])))-(~manipulated_harmonic[12]*~mulslider.value.linlin(0,1,0,1););
~color_array[~fslider.value.linlin(0,1,21,108)-1+46]=(~harmonics_array[13]+(~otherslider.value.linlin(0,1,1,0)*(1-~harmonics_array[13])))-(~manipulated_harmonic[13]*~mulslider.value.linlin(0,1,0,1););
~color_array[~fslider.value.linlin(0,1,21,108)-1+47]=(~harmonics_array[14]+(~otherslider.value.linlin(0,1,1,0)*(1-~harmonics_array[14])))-(~manipulated_harmonic[14]*~mulslider.value.linlin(0,1,0,1););
~color_array[~fslider.value.linlin(0,1,21,108)-1+48]=(~harmonics_array[15]+(~otherslider.value.linlin(0,1,1,0)*(1-~harmonics_array[15])))-(~manipulated_harmonic[15]*~mulslider.value.linlin(0,1,0,1););



			~color_arrayMAN = Array.fill(200,0);
~color_arrayMAN[~fslider.value.linlin(0,1,21,108)-1+0]=~manipulated_harmonic[0];
~color_arrayMAN[~fslider.value.linlin(0,1,21,108)-1+12]=~manipulated_harmonic[1];
~color_arrayMAN[~fslider.value.linlin(0,1,21,108)-1+19]=~manipulated_harmonic[2];
~color_arrayMAN[~fslider.value.linlin(0,1,21,108)-1+24]=~manipulated_harmonic[3];
~color_arrayMAN[~fslider.value.linlin(0,1,21,108)-1+28]=~manipulated_harmonic[4];
~color_arrayMAN[~fslider.value.linlin(0,1,21,108)-1+31]=~manipulated_harmonic[5];
~color_arrayMAN[~fslider.value.linlin(0,1,21,108)-1+34]=~manipulated_harmonic[6];
~color_arrayMAN[~fslider.value.linlin(0,1,21,108)-1+36]=~manipulated_harmonic[7];
~color_arrayMAN[~fslider.value.linlin(0,1,21,108)-1+38]=~manipulated_harmonic[8];
~color_arrayMAN[~fslider.value.linlin(0,1,21,108)-1+40]=~manipulated_harmonic[9];
~color_arrayMAN[~fslider.value.linlin(0,1,21,108)-1+41]=~manipulated_harmonic[10];
~color_arrayMAN[~fslider.value.linlin(0,1,21,108)-1+43]=~manipulated_harmonic[11];
~color_arrayMAN[~fslider.value.linlin(0,1,21,108)-1+44]=~manipulated_harmonic[12];
~color_arrayMAN[~fslider.value.linlin(0,1,21,108)-1+46]=~manipulated_harmonic[13];
~color_arrayMAN[~fslider.value.linlin(0,1,21,108)-1+47]=~manipulated_harmonic[14];
~color_arrayMAN[~fslider.value.linlin(0,1,21,108)-1+48]=~manipulated_harmonic[15];

/*
~color_arrayMAN[~fslider.value.linlin(0,1,21,108)-1+0]=~manipulated_harmonic[0]*0.5*~mulslider.value.linlin(0,1,0,1);
~color_arrayMAN[~fslider.value.linlin(0,1,21,108)-1+12]=~manipulated_harmonic[1]*0.5*~mulslider.value.linlin(0,1,0,1);
~color_arrayMAN[~fslider.value.linlin(0,1,21,108)-1+19]=~manipulated_harmonic[2]*0.5*~mulslider.value.linlin(0,1,0,1);
~color_arrayMAN[~fslider.value.linlin(0,1,21,108)-1+24]=~manipulated_harmonic[3]*0.5*~mulslider.value.linlin(0,1,0,1);
~color_arrayMAN[~fslider.value.linlin(0,1,21,108)-1+28]=~manipulated_harmonic[4]*0.5*~mulslider.value.linlin(0,1,0,1);
~color_arrayMAN[~fslider.value.linlin(0,1,21,108)-1+31]=~manipulated_harmonic[5]*0.5*~mulslider.value.linlin(0,1,0,1);
~color_arrayMAN[~fslider.value.linlin(0,1,21,108)-1+34]=~manipulated_harmonic[6]*0.5*~mulslider.value.linlin(0,1,0,1);
~color_arrayMAN[~fslider.value.linlin(0,1,21,108)-1+36]=~manipulated_harmonic[7]*0.5*~mulslider.value.linlin(0,1,0,1);
~color_arrayMAN[~fslider.value.linlin(0,1,21,108)-1+38]=~manipulated_harmonic[8]*0.5*~mulslider.value.linlin(0,1,0,1);
~color_arrayMAN[~fslider.value.linlin(0,1,21,108)-1+40]=~manipulated_harmonic[9]*0.5*~mulslider.value.linlin(0,1,0,1);
~color_arrayMAN[~fslider.value.linlin(0,1,21,108)-1+41]=~manipulated_harmonic[10]*0.5*~mulslider.value.linlin(0,1,0,1);
~color_arrayMAN[~fslider.value.linlin(0,1,21,108)-1+43]=~manipulated_harmonic[11]*0.5*~mulslider.value.linlin(0,1,0,1);
~color_arrayMAN[~fslider.value.linlin(0,1,21,108)-1+44]=~manipulated_harmonic[12]*0.5*~mulslider.value.linlin(0,1,0,1);
~color_arrayMAN[~fslider.value.linlin(0,1,21,108)-1+46]=~manipulated_harmonic[13]*0.5*~mulslider.value.linlin(0,1,0,1);
~color_arrayMAN[~fslider.value.linlin(0,1,21,108)-1+47]=~manipulated_harmonic[14]*0.5*~mulslider.value.linlin(0,1,0,1);
~color_arrayMAN[~fslider.value.linlin(0,1,21,108)-1+48]=~manipulated_harmonic[15]*0.5*~mulslider.value.linlin(0,1,0,1);
*/
		);


//Ensure it updates
s.makeBundle(10.0, //sound delay
			{~dirtyBit = 3; ~dirtyBit.postln;

				(if(~key_vis.value == 1, {

/*A0*/(if(obj.value.linlin(0,1,21,108) <= 21, {~a0.background_(Color(1,~color_array[21-1],~color_array[21-1]));~dot_a0.background_(Color(0,0,0,~color_arrayMAN[21-1]))}, {~a0.background_(Color.white);~dot_a0.background_(Color(0,0,0,0))}););
/*B0*/(if(obj.value.linlin(0,1,21,108) <= 23, {~b0.background_(Color(1,~color_array[23-1],~color_array[23-1]));~dot_b0.background_(Color(0,0,0,~color_arrayMAN[23-1]))}, {~b0.background_(Color.white);~dot_b0.background_(Color(0,0,0,0))}););
/*C1*/(if(obj.value.linlin(0,1,21,108) <= 24, {~c1.background_(Color(1,~color_array[24-1],~color_array[24-1]));~dot_c1.background_(Color(0,0,0,~color_arrayMAN[24-1]))}, {~c1.background_(Color.white);~dot_c1.background_(Color(0,0,0,0))}););
/*D1*/(if(obj.value.linlin(0,1,21,108) <= 26, {~d1.background_(Color(1,~color_array[26-1],~color_array[26-1]));~dot_d1.background_(Color(0,0,0,~color_arrayMAN[26-1]))}, {~d1.background_(Color.white);~dot_d1.background_(Color(0,0,0,0))}););
/*E1*/(if(obj.value.linlin(0,1,21,108) <= 28, {~e1.background_(Color(1,~color_array[28-1],~color_array[28-1]));~dot_e1.background_(Color(0,0,0,~color_arrayMAN[28-1]))}, {~e1.background_(Color.white);~dot_e1.background_(Color(0,0,0,0))}););
/*F1*/(if(obj.value.linlin(0,1,21,108) <= 29, {~f1.background_(Color(1,~color_array[29-1],~color_array[29-1]));~dot_f1.background_(Color(0,0,0,~color_arrayMAN[29-1]))}, {~f1.background_(Color.white);~dot_f1.background_(Color(0,0,0,0))}););
/*G1*/(if(obj.value.linlin(0,1,21,108) <= 31, {~g1.background_(Color(1,~color_array[31-1],~color_array[31-1]));~dot_g1.background_(Color(0,0,0,~color_arrayMAN[31-1]))}, {~g1.background_(Color.white);~dot_g1.background_(Color(0,0,0,0))}););
/*A1*/(if(obj.value.linlin(0,1,21,108) <= 33, {~a1.background_(Color(1,~color_array[33-1],~color_array[33-1]));~dot_a1.background_(Color(0,0,0,~color_arrayMAN[33-1]))}, {~a1.background_(Color.white);~dot_a1.background_(Color(0,0,0,0))}););
/*B1*/(if(obj.value.linlin(0,1,21,108) <= 35, {~b1.background_(Color(1,~color_array[35-1],~color_array[35-1]));~dot_b1.background_(Color(0,0,0,~color_arrayMAN[35-1]))}, {~b1.background_(Color.white);~dot_b1.background_(Color(0,0,0,0))}););
/*C2*/(if(obj.value.linlin(0,1,21,108) <= 36, {~c2.background_(Color(1,~color_array[36-1],~color_array[36-1]));~dot_c2.background_(Color(0,0,0,~color_arrayMAN[36-1]))}, {~c2.background_(Color.white);~dot_c2.background_(Color(0,0,0,0))}););
/*D2*/(if(obj.value.linlin(0,1,21,108) <= 38, {~d2.background_(Color(1,~color_array[38-1],~color_array[38-1]));~dot_d2.background_(Color(0,0,0,~color_arrayMAN[38-1]))}, {~d2.background_(Color.white);~dot_d2.background_(Color(0,0,0,0))}););
/*E2*/(if(obj.value.linlin(0,1,21,108) <= 40, {~e2.background_(Color(1,~color_array[40-1],~color_array[40-1]));~dot_e2.background_(Color(0,0,0,~color_arrayMAN[40-1]))}, {~e2.background_(Color.white);~dot_e2.background_(Color(0,0,0,0))}););
/*F2*/(if(obj.value.linlin(0,1,21,108) <= 41, {~f2.background_(Color(1,~color_array[41-1],~color_array[41-1]));~dot_f2.background_(Color(0,0,0,~color_arrayMAN[41-1]))}, {~f2.background_(Color.white);~dot_f2.background_(Color(0,0,0,0))}););
/*G2*/(if(obj.value.linlin(0,1,21,108) <= 43, {~g2.background_(Color(1,~color_array[43-1],~color_array[43-1]));~dot_g2.background_(Color(0,0,0,~color_arrayMAN[43-1]))}, {~g2.background_(Color.white);~dot_g2.background_(Color(0,0,0,0))}););
/*A2*/(if(obj.value.linlin(0,1,21,108) <= 45, {~a2.background_(Color(1,~color_array[45-1],~color_array[45-1]));~dot_a2.background_(Color(0,0,0,~color_arrayMAN[45-1]))}, {~a2.background_(Color.white);~dot_a2.background_(Color(0,0,0,0))}););
/*B2*/(if(obj.value.linlin(0,1,21,108) <= 47, {~b2.background_(Color(1,~color_array[47-1],~color_array[47-1]));~dot_b2.background_(Color(0,0,0,~color_arrayMAN[47-1]))}, {~b2.background_(Color.white);~dot_b2.background_(Color(0,0,0,0))}););
/*C3*/(if(obj.value.linlin(0,1,21,108) <= 48, {~c3.background_(Color(1,~color_array[48-1],~color_array[48-1]));~dot_c3.background_(Color(0,0,0,~color_arrayMAN[48-1]))}, {~c3.background_(Color.white);~dot_c3.background_(Color(0,0,0,0))}););
/*D3*/(if(obj.value.linlin(0,1,21,108) <= 50, {~d3.background_(Color(1,~color_array[50-1],~color_array[50-1]));~dot_d3.background_(Color(0,0,0,~color_arrayMAN[50-1]))}, {~d3.background_(Color.white);~dot_d3.background_(Color(0,0,0,0))}););
/*E3*/(if(obj.value.linlin(0,1,21,108) <= 52, {~e3.background_(Color(1,~color_array[52-1],~color_array[52-1]));~dot_e3.background_(Color(0,0,0,~color_arrayMAN[52-1]))}, {~e3.background_(Color.white);~dot_e3.background_(Color(0,0,0,0))}););
/*F3*/(if(obj.value.linlin(0,1,21,108) <= 53, {~f3.background_(Color(1,~color_array[53-1],~color_array[53-1]));~dot_f3.background_(Color(0,0,0,~color_arrayMAN[53-1]))}, {~f3.background_(Color.white);~dot_f3.background_(Color(0,0,0,0))}););
/*G3*/(if(obj.value.linlin(0,1,21,108) <= 55, {~g3.background_(Color(1,~color_array[55-1],~color_array[55-1]));~dot_g3.background_(Color(0,0,0,~color_arrayMAN[55-1]))}, {~g3.background_(Color.white);~dot_g3.background_(Color(0,0,0,0))}););
/*A3*/(if(obj.value.linlin(0,1,21,108) <= 57, {~a3.background_(Color(1,~color_array[57-1],~color_array[57-1]));~dot_a3.background_(Color(0,0,0,~color_arrayMAN[57-1]))}, {~a3.background_(Color.white);~dot_a3.background_(Color(0,0,0,0))}););
/*B3*/(if(obj.value.linlin(0,1,21,108) <= 59, {~b3.background_(Color(1,~color_array[59-1],~color_array[59-1]));~dot_b3.background_(Color(0,0,0,~color_arrayMAN[59-1]))}, {~b3.background_(Color.white);~dot_b3.background_(Color(0,0,0,0))}););
/*C4*/(if(obj.value.linlin(0,1,21,108) <= 60, {~c4.background_(Color(1,~color_array[60-1],~color_array[60-1]));~dot_c4.background_(Color(0,0,0,~color_arrayMAN[60-1]))}, {~c4.background_(Color.white);~dot_c4.background_(Color(0,0,0,0))}););
/*D4*/(if(obj.value.linlin(0,1,21,108) <= 62, {~d4.background_(Color(1,~color_array[62-1],~color_array[62-1]));~dot_d4.background_(Color(0,0,0,~color_arrayMAN[62-1]))}, {~d4.background_(Color.white);~dot_d4.background_(Color(0,0,0,0))}););
/*E4*/(if(obj.value.linlin(0,1,21,108) <= 64, {~e4.background_(Color(1,~color_array[64-1],~color_array[64-1]));~dot_e4.background_(Color(0,0,0,~color_arrayMAN[64-1]))}, {~e4.background_(Color.white);~dot_e4.background_(Color(0,0,0,0))}););
/*F4*/(if(obj.value.linlin(0,1,21,108) <= 65, {~f4.background_(Color(1,~color_array[65-1],~color_array[65-1]));~dot_f4.background_(Color(0,0,0,~color_arrayMAN[65-1]))}, {~f4.background_(Color.white);~dot_f4.background_(Color(0,0,0,0))}););
/*G4*/(if(obj.value.linlin(0,1,21,108) <= 67, {~g4.background_(Color(1,~color_array[67-1],~color_array[67-1]));~dot_g4.background_(Color(0,0,0,~color_arrayMAN[67-1]))}, {~g4.background_(Color.white);~dot_g4.background_(Color(0,0,0,0))}););
/*A4*/(if(obj.value.linlin(0,1,21,108) <= 69, {~a4.background_(Color(1,~color_array[69-1],~color_array[69-1]));~dot_a4.background_(Color(0,0,0,~color_arrayMAN[69-1]))}, {~a4.background_(Color.white);~dot_a4.background_(Color(0,0,0,0))}););
/*B4*/(if(obj.value.linlin(0,1,21,108) <= 71, {~b4.background_(Color(1,~color_array[71-1],~color_array[71-1]));~dot_b4.background_(Color(0,0,0,~color_arrayMAN[71-1]))}, {~b4.background_(Color.white);~dot_b4.background_(Color(0,0,0,0))}););
/*C5*/(if(obj.value.linlin(0,1,21,108) <= 72, {~c5.background_(Color(1,~color_array[72-1],~color_array[72-1]));~dot_c5.background_(Color(0,0,0,~color_arrayMAN[72-1]))}, {~c5.background_(Color.white);~dot_c5.background_(Color(0,0,0,0))}););
/*D5*/(if(obj.value.linlin(0,1,21,108) <= 74, {~d5.background_(Color(1,~color_array[74-1],~color_array[74-1]));~dot_d5.background_(Color(0,0,0,~color_arrayMAN[74-1]))}, {~d5.background_(Color.white);~dot_d5.background_(Color(0,0,0,0))}););
/*E5*/(if(obj.value.linlin(0,1,21,108) <= 76, {~e5.background_(Color(1,~color_array[76-1],~color_array[76-1]));~dot_e5.background_(Color(0,0,0,~color_arrayMAN[76-1]))}, {~e5.background_(Color.white);~dot_e5.background_(Color(0,0,0,0))}););
/*F5*/(if(obj.value.linlin(0,1,21,108) <= 77, {~f5.background_(Color(1,~color_array[77-1],~color_array[77-1]));~dot_f5.background_(Color(0,0,0,~color_arrayMAN[77-1]))}, {~f5.background_(Color.white);~dot_f5.background_(Color(0,0,0,0))}););
/*G5*/(if(obj.value.linlin(0,1,21,108) <= 79, {~g5.background_(Color(1,~color_array[79-1],~color_array[79-1]));~dot_g5.background_(Color(0,0,0,~color_arrayMAN[79-1]))}, {~g5.background_(Color.white);~dot_g5.background_(Color(0,0,0,0))}););
/*A5*/(if(obj.value.linlin(0,1,21,108) <= 81, {~a5.background_(Color(1,~color_array[81-1],~color_array[81-1]));~dot_a5.background_(Color(0,0,0,~color_arrayMAN[81-1]))}, {~a5.background_(Color.white);~dot_a5.background_(Color(0,0,0,0))}););
/*B5*/(if(obj.value.linlin(0,1,21,108) <= 83, {~b5.background_(Color(1,~color_array[83-1],~color_array[83-1]));~dot_b5.background_(Color(0,0,0,~color_arrayMAN[83-1]))}, {~b5.background_(Color.white);~dot_b5.background_(Color(0,0,0,0))}););
/*C6*/(if(obj.value.linlin(0,1,21,108) <= 84, {~c6.background_(Color(1,~color_array[84-1],~color_array[84-1]));~dot_c6.background_(Color(0,0,0,~color_arrayMAN[84-1]))}, {~c6.background_(Color.white);~dot_c6.background_(Color(0,0,0,0))}););
/*D6*/(if(obj.value.linlin(0,1,21,108) <= 86, {~d6.background_(Color(1,~color_array[86-1],~color_array[86-1]));~dot_d6.background_(Color(0,0,0,~color_arrayMAN[86-1]))}, {~d6.background_(Color.white);~dot_d6.background_(Color(0,0,0,0))}););
/*E6*/(if(obj.value.linlin(0,1,21,108) <= 88, {~e6.background_(Color(1,~color_array[88-1],~color_array[88-1]));~dot_e6.background_(Color(0,0,0,~color_arrayMAN[88-1]))}, {~e6.background_(Color.white);~dot_e6.background_(Color(0,0,0,0))}););
/*F6*/(if(obj.value.linlin(0,1,21,108) <= 89, {~f6.background_(Color(1,~color_array[89-1],~color_array[89-1]));~dot_f6.background_(Color(0,0,0,~color_arrayMAN[89-1]))}, {~f6.background_(Color.white);~dot_f6.background_(Color(0,0,0,0))}););
/*G6*/(if(obj.value.linlin(0,1,21,108) <= 91, {~g6.background_(Color(1,~color_array[91-1],~color_array[91-1]));~dot_g6.background_(Color(0,0,0,~color_arrayMAN[91-1]))}, {~g6.background_(Color.white);~dot_g6.background_(Color(0,0,0,0))}););
/*A6*/(if(obj.value.linlin(0,1,21,108) <= 93, {~a6.background_(Color(1,~color_array[93-1],~color_array[93-1]));~dot_a6.background_(Color(0,0,0,~color_arrayMAN[93-1]))}, {~a6.background_(Color.white);~dot_a6.background_(Color(0,0,0,0))}););
/*B6*/(if(obj.value.linlin(0,1,21,108) <= 95, {~b6.background_(Color(1,~color_array[95-1],~color_array[95-1]));~dot_b6.background_(Color(0,0,0,~color_arrayMAN[95-1]))}, {~b6.background_(Color.white);~dot_b6.background_(Color(0,0,0,0))}););
/*C7*/(if(obj.value.linlin(0,1,21,108) <= 96, {~c7.background_(Color(1,~color_array[96-1],~color_array[96-1]));~dot_c7.background_(Color(0,0,0,~color_arrayMAN[96-1]))}, {~c7.background_(Color.white);~dot_c7.background_(Color(0,0,0,0))}););
/*D7*/(if(obj.value.linlin(0,1,21,108) <= 98, {~d7.background_(Color(1,~color_array[98-1],~color_array[98-1]));~dot_d7.background_(Color(0,0,0,~color_arrayMAN[98-1]))}, {~d7.background_(Color.white);~dot_d7.background_(Color(0,0,0,0))}););
/*E7*/(if(obj.value.linlin(0,1,21,108) <= 100, {~e7.background_(Color(1,~color_array[100-1],~color_array[100-1]));~dot_e7.background_(Color(0,0,0,~color_arrayMAN[100-1]))}, {~e7.background_(Color.white);~dot_e7.background_(Color(0,0,0,0))}););
/*F7*/(if(obj.value.linlin(0,1,21,108) <= 101, {~f7.background_(Color(1,~color_array[101-1],~color_array[101-1]));~dot_f7.background_(Color(0,0,0,~color_arrayMAN[101-1]))}, {~f7.background_(Color.white);~dot_f7.background_(Color(0,0,0,0))}););
/*G7*/(if(obj.value.linlin(0,1,21,108) <= 103, {~g7.background_(Color(1,~color_array[103-1],~color_array[103-1]));~dot_g7.background_(Color(0,0,0,~color_arrayMAN[103-1]))}, {~g7.background_(Color.white);~dot_g7.background_(Color(0,0,0,0))}););
/*A7*/(if(obj.value.linlin(0,1,21,108) <= 105, {~a7.background_(Color(1,~color_array[105-1],~color_array[105-1]));~dot_a7.background_(Color(0,0,0,~color_arrayMAN[105-1]))}, {~a7.background_(Color.white);~dot_a7.background_(Color(0,0,0,0))}););
/*B7*/(if(obj.value.linlin(0,1,21,108) <= 107, {~b7.background_(Color(1,~color_array[107-1],~color_array[107-1]));~dot_b7.background_(Color(0,0,0,~color_arrayMAN[107-1]))}, {~b7.background_(Color.white);~dot_b7.background_(Color(0,0,0,0))}););
/*C8*/(if(obj.value.linlin(0,1,21,108) <= 108, {~c8.background_(Color(1,~color_array[108-1],~color_array[108-1]));~dot_c8.background_(Color(0,0,0,~color_arrayMAN[108-1]))}, {~c8.background_(Color.white);~dot_c8.background_(Color(0,0,0,0))}););


/*ASHARP0*/(if(obj.value.linlin(0,1,21,108) <=22,{if(~color_array[22-1]<1,{~aSHARP0.background_(Color(1,~color_array[22-1],~color_array[22-1]));~dot_aSHARP0.background_(Color(1,1,1,~color_arrayMAN[22-1]));},{~aSHARP0.background_(Color.black); ~dot_aSHARP0.background_(Color(1,1,1,0))})},{~aSHARP0.background_(Color.black);~dot_aSHARP0.background_(Color(1,1,1,0))}););
/*CSHARP1*/(if(obj.value.linlin(0,1,21,108) <=25,{if(~color_array[25-1]<1,{~cSHARP1.background_(Color(1,~color_array[25-1],~color_array[25-1]));~dot_cSHARP1.background_(Color(1,1,1,~color_arrayMAN[25-1]));},{~cSHARP1.background_(Color.black); ~dot_cSHARP1.background_(Color(1,1,1,0))})},{~cSHARP1.background_(Color.black);~dot_cSHARP1.background_(Color(1,1,1,0))}););
/*DSHARP1*/(if(obj.value.linlin(0,1,21,108) <=27,{if(~color_array[27-1]<1,{~dSHARP1.background_(Color(1,~color_array[27-1],~color_array[27-1]));~dot_dSHARP1.background_(Color(1,1,1,~color_arrayMAN[27-1]));},{~dSHARP1.background_(Color.black); ~dot_dSHARP1.background_(Color(1,1,1,0))})},{~dSHARP1.background_(Color.black);~dot_dSHARP1.background_(Color(1,1,1,0))}););
/*FSHARP1*/(if(obj.value.linlin(0,1,21,108) <=30,{if(~color_array[30-1]<1,{~fSHARP1.background_(Color(1,~color_array[30-1],~color_array[30-1]));~dot_fSHARP1.background_(Color(1,1,1,~color_arrayMAN[30-1]));},{~fSHARP1.background_(Color.black); ~dot_fSHARP1.background_(Color(1,1,1,0))})},{~fSHARP1.background_(Color.black);~dot_fSHARP1.background_(Color(1,1,1,0))}););
/*GSHARP1*/(if(obj.value.linlin(0,1,21,108) <=32,{if(~color_array[32-1]<1,{~gSHARP1.background_(Color(1,~color_array[32-1],~color_array[32-1]));~dot_gSHARP1.background_(Color(1,1,1,~color_arrayMAN[32-1]));},{~gSHARP1.background_(Color.black); ~dot_gSHARP1.background_(Color(1,1,1,0))})},{~gSHARP1.background_(Color.black);~dot_gSHARP1.background_(Color(1,1,1,0))}););
/*ASHARP1*/(if(obj.value.linlin(0,1,21,108) <=34,{if(~color_array[34-1]<1,{~aSHARP1.background_(Color(1,~color_array[34-1],~color_array[34-1]));~dot_aSHARP1.background_(Color(1,1,1,~color_arrayMAN[34-1]));},{~aSHARP1.background_(Color.black); ~dot_aSHARP1.background_(Color(1,1,1,0))})},{~aSHARP1.background_(Color.black);~dot_aSHARP1.background_(Color(1,1,1,0))}););
/*CSHARP2*/(if(obj.value.linlin(0,1,21,108) <=37,{if(~color_array[37-1]<1,{~cSHARP2.background_(Color(1,~color_array[37-1],~color_array[37-1]));~dot_cSHARP2.background_(Color(1,1,1,~color_arrayMAN[37-1]));},{~cSHARP2.background_(Color.black); ~dot_cSHARP2.background_(Color(1,1,1,0))})},{~cSHARP2.background_(Color.black);~dot_cSHARP2.background_(Color(1,1,1,0))}););
/*DSHARP2*/(if(obj.value.linlin(0,1,21,108) <=39,{if(~color_array[39-1]<1,{~dSHARP2.background_(Color(1,~color_array[39-1],~color_array[39-1]));~dot_dSHARP2.background_(Color(1,1,1,~color_arrayMAN[39-1]));},{~dSHARP2.background_(Color.black); ~dot_dSHARP2.background_(Color(1,1,1,0))})},{~dSHARP2.background_(Color.black);~dot_dSHARP2.background_(Color(1,1,1,0))}););
/*FSHARP2*/(if(obj.value.linlin(0,1,21,108) <=42,{if(~color_array[42-1]<1,{~fSHARP2.background_(Color(1,~color_array[42-1],~color_array[42-1]));~dot_fSHARP2.background_(Color(1,1,1,~color_arrayMAN[42-1]));},{~fSHARP2.background_(Color.black); ~dot_fSHARP2.background_(Color(1,1,1,0))})},{~fSHARP2.background_(Color.black);~dot_fSHARP2.background_(Color(1,1,1,0))}););
/*GSHARP2*/(if(obj.value.linlin(0,1,21,108) <=44,{if(~color_array[44-1]<1,{~gSHARP2.background_(Color(1,~color_array[44-1],~color_array[44-1]));~dot_gSHARP2.background_(Color(1,1,1,~color_arrayMAN[44-1]));},{~gSHARP2.background_(Color.black); ~dot_gSHARP2.background_(Color(1,1,1,0))})},{~gSHARP2.background_(Color.black);~dot_gSHARP2.background_(Color(1,1,1,0))}););
/*ASHARP2*/(if(obj.value.linlin(0,1,21,108) <=46,{if(~color_array[46-1]<1,{~aSHARP2.background_(Color(1,~color_array[46-1],~color_array[46-1]));~dot_aSHARP2.background_(Color(1,1,1,~color_arrayMAN[46-1]));},{~aSHARP2.background_(Color.black); ~dot_aSHARP2.background_(Color(1,1,1,0))})},{~aSHARP2.background_(Color.black);~dot_aSHARP2.background_(Color(1,1,1,0))}););
/*CSHARP3*/(if(obj.value.linlin(0,1,21,108) <=49,{if(~color_array[49-1]<1,{~cSHARP3.background_(Color(1,~color_array[49-1],~color_array[49-1]));~dot_cSHARP3.background_(Color(1,1,1,~color_arrayMAN[49-1]));},{~cSHARP3.background_(Color.black); ~dot_cSHARP3.background_(Color(1,1,1,0))})},{~cSHARP3.background_(Color.black);~dot_cSHARP3.background_(Color(1,1,1,0))}););
/*DSHARP3*/(if(obj.value.linlin(0,1,21,108) <=51,{if(~color_array[51-1]<1,{~dSHARP3.background_(Color(1,~color_array[51-1],~color_array[51-1]));~dot_dSHARP3.background_(Color(1,1,1,~color_arrayMAN[51-1]));},{~dSHARP3.background_(Color.black); ~dot_dSHARP3.background_(Color(1,1,1,0))})},{~dSHARP3.background_(Color.black);~dot_dSHARP3.background_(Color(1,1,1,0))}););
/*FSHARP3*/(if(obj.value.linlin(0,1,21,108) <=54,{if(~color_array[54-1]<1,{~fSHARP3.background_(Color(1,~color_array[54-1],~color_array[54-1]));~dot_fSHARP3.background_(Color(1,1,1,~color_arrayMAN[54-1]));},{~fSHARP3.background_(Color.black); ~dot_fSHARP3.background_(Color(1,1,1,0))})},{~fSHARP3.background_(Color.black);~dot_fSHARP3.background_(Color(1,1,1,0))}););
/*GSHARP3*/(if(obj.value.linlin(0,1,21,108) <=56,{if(~color_array[56-1]<1,{~gSHARP3.background_(Color(1,~color_array[56-1],~color_array[56-1]));~dot_gSHARP3.background_(Color(1,1,1,~color_arrayMAN[56-1]));},{~gSHARP3.background_(Color.black); ~dot_gSHARP3.background_(Color(1,1,1,0))})},{~gSHARP3.background_(Color.black);~dot_gSHARP3.background_(Color(1,1,1,0))}););
/*ASHARP3*/(if(obj.value.linlin(0,1,21,108) <=58,{if(~color_array[58-1]<1,{~aSHARP3.background_(Color(1,~color_array[58-1],~color_array[58-1]));~dot_aSHARP3.background_(Color(1,1,1,~color_arrayMAN[58-1]));},{~aSHARP3.background_(Color.black); ~dot_aSHARP3.background_(Color(1,1,1,0))})},{~aSHARP3.background_(Color.black);~dot_aSHARP3.background_(Color(1,1,1,0))}););
/*CSHARP4*/(if(obj.value.linlin(0,1,21,108) <=61,{if(~color_array[61-1]<1,{~cSHARP4.background_(Color(1,~color_array[61-1],~color_array[61-1]));~dot_cSHARP4.background_(Color(1,1,1,~color_arrayMAN[61-1]));},{~cSHARP4.background_(Color.black); ~dot_cSHARP4.background_(Color(1,1,1,0))})},{~cSHARP4.background_(Color.black);~dot_cSHARP4.background_(Color(1,1,1,0))}););
/*DSHARP4*/(if(obj.value.linlin(0,1,21,108) <=63,{if(~color_array[63-1]<1,{~dSHARP4.background_(Color(1,~color_array[63-1],~color_array[63-1]));~dot_dSHARP4.background_(Color(1,1,1,~color_arrayMAN[63-1]));},{~dSHARP4.background_(Color.black); ~dot_dSHARP4.background_(Color(1,1,1,0))})},{~dSHARP4.background_(Color.black);~dot_dSHARP4.background_(Color(1,1,1,0))}););
/*FSHARP4*/(if(obj.value.linlin(0,1,21,108) <=66,{if(~color_array[66-1]<1,{~fSHARP4.background_(Color(1,~color_array[66-1],~color_array[66-1]));~dot_fSHARP4.background_(Color(1,1,1,~color_arrayMAN[66-1]));},{~fSHARP4.background_(Color.black); ~dot_fSHARP4.background_(Color(1,1,1,0))})},{~fSHARP4.background_(Color.black);~dot_fSHARP4.background_(Color(1,1,1,0))}););
/*GSHARP4*/(if(obj.value.linlin(0,1,21,108) <=68,{if(~color_array[68-1]<1,{~gSHARP4.background_(Color(1,~color_array[68-1],~color_array[68-1]));~dot_gSHARP4.background_(Color(1,1,1,~color_arrayMAN[68-1]));},{~gSHARP4.background_(Color.black); ~dot_gSHARP4.background_(Color(1,1,1,0))})},{~gSHARP4.background_(Color.black);~dot_gSHARP4.background_(Color(1,1,1,0))}););
/*ASHARP4*/(if(obj.value.linlin(0,1,21,108) <=70,{if(~color_array[70-1]<1,{~aSHARP4.background_(Color(1,~color_array[70-1],~color_array[70-1]));~dot_aSHARP4.background_(Color(1,1,1,~color_arrayMAN[70-1]));},{~aSHARP4.background_(Color.black); ~dot_aSHARP4.background_(Color(1,1,1,0))})},{~aSHARP4.background_(Color.black);~dot_aSHARP4.background_(Color(1,1,1,0))}););
/*CSHARP5*/(if(obj.value.linlin(0,1,21,108) <=73,{if(~color_array[73-1]<1,{~cSHARP5.background_(Color(1,~color_array[73-1],~color_array[73-1]));~dot_cSHARP5.background_(Color(1,1,1,~color_arrayMAN[73-1]));},{~cSHARP5.background_(Color.black); ~dot_cSHARP5.background_(Color(1,1,1,0))})},{~cSHARP5.background_(Color.black);~dot_cSHARP5.background_(Color(1,1,1,0))}););
/*DSHARP5*/(if(obj.value.linlin(0,1,21,108) <=75,{if(~color_array[75-1]<1,{~dSHARP5.background_(Color(1,~color_array[75-1],~color_array[75-1]));~dot_dSHARP5.background_(Color(1,1,1,~color_arrayMAN[75-1]));},{~dSHARP5.background_(Color.black); ~dot_dSHARP5.background_(Color(1,1,1,0))})},{~dSHARP5.background_(Color.black);~dot_dSHARP5.background_(Color(1,1,1,0))}););
/*FSHARP5*/(if(obj.value.linlin(0,1,21,108) <=78,{if(~color_array[78-1]<1,{~fSHARP5.background_(Color(1,~color_array[78-1],~color_array[78-1]));~dot_fSHARP5.background_(Color(1,1,1,~color_arrayMAN[78-1]));},{~fSHARP5.background_(Color.black); ~dot_fSHARP5.background_(Color(1,1,1,0))})},{~fSHARP5.background_(Color.black);~dot_fSHARP5.background_(Color(1,1,1,0))}););
/*GSHARP5*/(if(obj.value.linlin(0,1,21,108) <=80,{if(~color_array[80-1]<1,{~gSHARP5.background_(Color(1,~color_array[80-1],~color_array[80-1]));~dot_gSHARP5.background_(Color(1,1,1,~color_arrayMAN[80-1]));},{~gSHARP5.background_(Color.black); ~dot_gSHARP5.background_(Color(1,1,1,0))})},{~gSHARP5.background_(Color.black);~dot_gSHARP5.background_(Color(1,1,1,0))}););
/*ASHARP5*/(if(obj.value.linlin(0,1,21,108) <=82,{if(~color_array[82-1]<1,{~aSHARP5.background_(Color(1,~color_array[82-1],~color_array[82-1]));~dot_aSHARP5.background_(Color(1,1,1,~color_arrayMAN[82-1]));},{~aSHARP5.background_(Color.black); ~dot_aSHARP5.background_(Color(1,1,1,0))})},{~aSHARP5.background_(Color.black);~dot_aSHARP5.background_(Color(1,1,1,0))}););
/*CSHARP6*/(if(obj.value.linlin(0,1,21,108) <=85,{if(~color_array[85-1]<1,{~cSHARP6.background_(Color(1,~color_array[85-1],~color_array[85-1]));~dot_cSHARP6.background_(Color(1,1,1,~color_arrayMAN[85-1]));},{~cSHARP6.background_(Color.black); ~dot_cSHARP6.background_(Color(1,1,1,0))})},{~cSHARP6.background_(Color.black);~dot_cSHARP6.background_(Color(1,1,1,0))}););
/*DSHARP6*/(if(obj.value.linlin(0,1,21,108) <=87,{if(~color_array[87-1]<1,{~dSHARP6.background_(Color(1,~color_array[87-1],~color_array[87-1]));~dot_dSHARP6.background_(Color(1,1,1,~color_arrayMAN[87-1]));},{~dSHARP6.background_(Color.black); ~dot_dSHARP6.background_(Color(1,1,1,0))})},{~dSHARP6.background_(Color.black);~dot_dSHARP6.background_(Color(1,1,1,0))}););
/*FSHARP6*/(if(obj.value.linlin(0,1,21,108) <=90,{if(~color_array[90-1]<1,{~fSHARP6.background_(Color(1,~color_array[90-1],~color_array[90-1]));~dot_fSHARP6.background_(Color(1,1,1,~color_arrayMAN[90-1]));},{~fSHARP6.background_(Color.black); ~dot_fSHARP6.background_(Color(1,1,1,0))})},{~fSHARP6.background_(Color.black);~dot_fSHARP6.background_(Color(1,1,1,0))}););
/*GSHARP6*/(if(obj.value.linlin(0,1,21,108) <=92,{if(~color_array[92-1]<1,{~gSHARP6.background_(Color(1,~color_array[92-1],~color_array[92-1]));~dot_gSHARP6.background_(Color(1,1,1,~color_arrayMAN[92-1]));},{~gSHARP6.background_(Color.black); ~dot_gSHARP6.background_(Color(1,1,1,0))})},{~gSHARP6.background_(Color.black);~dot_gSHARP6.background_(Color(1,1,1,0))}););
/*ASHARP6*/(if(obj.value.linlin(0,1,21,108) <=94,{if(~color_array[94-1]<1,{~aSHARP6.background_(Color(1,~color_array[94-1],~color_array[94-1]));~dot_aSHARP6.background_(Color(1,1,1,~color_arrayMAN[94-1]));},{~aSHARP6.background_(Color.black); ~dot_aSHARP6.background_(Color(1,1,1,0))})},{~aSHARP6.background_(Color.black);~dot_aSHARP6.background_(Color(1,1,1,0))}););
/*CSHARP7*/(if(obj.value.linlin(0,1,21,108) <=97,{if(~color_array[97-1]<1,{~cSHARP7.background_(Color(1,~color_array[97-1],~color_array[97-1]));~dot_cSHARP7.background_(Color(1,1,1,~color_arrayMAN[97-1]));},{~cSHARP7.background_(Color.black); ~dot_cSHARP7.background_(Color(1,1,1,0))})},{~cSHARP7.background_(Color.black);~dot_cSHARP7.background_(Color(1,1,1,0))}););
/*DSHARP7*/(if(obj.value.linlin(0,1,21,108) <=99,{if(~color_array[99-1]<1,{~dSHARP7.background_(Color(1,~color_array[99-1],~color_array[99-1]));~dot_dSHARP7.background_(Color(1,1,1,~color_arrayMAN[99-1]));},{~dSHARP7.background_(Color.black); ~dot_dSHARP7.background_(Color(1,1,1,0))})},{~dSHARP7.background_(Color.black);~dot_dSHARP7.background_(Color(1,1,1,0))}););
/*FSHARP7*/(if(obj.value.linlin(0,1,21,108) <=102,{if(~color_array[102-1]<1,{~fSHARP7.background_(Color(1,~color_array[102-1],~color_array[102-1]));~dot_fSHARP7.background_(Color(1,1,1,~color_arrayMAN[102-1]));},{~fSHARP7.background_(Color.black); ~dot_fSHARP7.background_(Color(1,1,1,0))})},{~fSHARP7.background_(Color.black);~dot_fSHARP7.background_(Color(1,1,1,0))}););
/*GSHARP7*/(if(obj.value.linlin(0,1,21,108) <=104,{if(~color_array[104-1]<1,{~gSHARP7.background_(Color(1,~color_array[104-1],~color_array[104-1]));~dot_gSHARP7.background_(Color(1,1,1,~color_arrayMAN[104-1]));},{~gSHARP7.background_(Color.black); ~dot_gSHARP7.background_(Color(1,1,1,0))})},{~gSHARP7.background_(Color.black);~dot_gSHARP7.background_(Color(1,1,1,0))}););
/*ASHARP7*/(if(obj.value.linlin(0,1,21,108) <=106,{if(~color_array[106-1]<1,{~aSHARP7.background_(Color(1,~color_array[106-1],~color_array[106-1]));~dot_aSHARP7.background_(Color(1,1,1,~color_arrayMAN[106-1]));},{~aSHARP7.background_(Color.black); ~dot_aSHARP7.background_(Color(1,1,1,0))})},{~aSHARP7.background_(Color.black);~dot_aSHARP7.background_(Color(1,1,1,0))}););


	/* //Previous deviant yellow colour changer
/*A0*/(if(obj.value.linlin(0,1,21,108) <= 21, {~a0.background_(Color(1,(~color_array[21-1]+~color_arrayMAN[21-1]),~color_array[21-1]));}, {~a0.background_(Color.white)}););
/*B0*/(if(obj.value.linlin(0,1,21,108) <= 23, {~b0.background_(Color(1,(~color_array[23-1]+~color_arrayMAN[23-1]),~color_array[23-1]));}, {~b0.background_(Color.white)}););
/*C1*/(if(obj.value.linlin(0,1,21,108) <= 24, {~c1.background_(Color(1,(~color_array[24-1]+~color_arrayMAN[24-1]),~color_array[24-1]));}, {~c1.background_(Color.white)}););
/*D1*/(if(obj.value.linlin(0,1,21,108) <= 26, {~d1.background_(Color(1,(~color_array[26-1]+~color_arrayMAN[26-1]),~color_array[26-1]));}, {~d1.background_(Color.white)}););
/*E1*/(if(obj.value.linlin(0,1,21,108) <= 28, {~e1.background_(Color(1,(~color_array[28-1]+~color_arrayMAN[28-1]),~color_array[28-1]));}, {~e1.background_(Color.white)}););
/*F1*/(if(obj.value.linlin(0,1,21,108) <= 29, {~f1.background_(Color(1,(~color_array[29-1]+~color_arrayMAN[29-1]),~color_array[29-1]));}, {~f1.background_(Color.white)}););
/*G1*/(if(obj.value.linlin(0,1,21,108) <= 31, {~g1.background_(Color(1,(~color_array[31-1]+~color_arrayMAN[31-1]),~color_array[31-1]));}, {~g1.background_(Color.white)}););
/*A1*/(if(obj.value.linlin(0,1,21,108) <= 33, {~a1.background_(Color(1,(~color_array[33-1]+~color_arrayMAN[33-1]),~color_array[33-1]));}, {~a1.background_(Color.white)}););
/*B1*/(if(obj.value.linlin(0,1,21,108) <= 35, {~b1.background_(Color(1,(~color_array[35-1]+~color_arrayMAN[35-1]),~color_array[35-1]));}, {~b1.background_(Color.white)}););
/*C2*/(if(obj.value.linlin(0,1,21,108) <= 36, {~c2.background_(Color(1,(~color_array[36-1]+~color_arrayMAN[36-1]),~color_array[36-1]));}, {~c2.background_(Color.white)}););
/*D2*/(if(obj.value.linlin(0,1,21,108) <= 38, {~d2.background_(Color(1,(~color_array[38-1]+~color_arrayMAN[38-1]),~color_array[38-1]));}, {~d2.background_(Color.white)}););
/*E2*/(if(obj.value.linlin(0,1,21,108) <= 40, {~e2.background_(Color(1,(~color_array[40-1]+~color_arrayMAN[40-1]),~color_array[40-1]));}, {~e2.background_(Color.white)}););
/*F2*/(if(obj.value.linlin(0,1,21,108) <= 41, {~f2.background_(Color(1,(~color_array[41-1]+~color_arrayMAN[41-1]),~color_array[41-1]));}, {~f2.background_(Color.white)}););
/*G2*/(if(obj.value.linlin(0,1,21,108) <= 43, {~g2.background_(Color(1,(~color_array[43-1]+~color_arrayMAN[43-1]),~color_array[43-1]));}, {~g2.background_(Color.white)}););
/*A2*/(if(obj.value.linlin(0,1,21,108) <= 45, {~a2.background_(Color(1,(~color_array[45-1]+~color_arrayMAN[45-1]),~color_array[45-1]));}, {~a2.background_(Color.white)}););
/*B2*/(if(obj.value.linlin(0,1,21,108) <= 47, {~b2.background_(Color(1,(~color_array[47-1]+~color_arrayMAN[47-1]),~color_array[47-1]));}, {~b2.background_(Color.white)}););
/*C3*/(if(obj.value.linlin(0,1,21,108) <= 48, {~c3.background_(Color(1,(~color_array[48-1]+~color_arrayMAN[48-1]),~color_array[48-1]));}, {~c3.background_(Color.white)}););
/*D3*/(if(obj.value.linlin(0,1,21,108) <= 50, {~d3.background_(Color(1,(~color_array[50-1]+~color_arrayMAN[50-1]),~color_array[50-1]));}, {~d3.background_(Color.white)}););
/*E3*/(if(obj.value.linlin(0,1,21,108) <= 52, {~e3.background_(Color(1,(~color_array[52-1]+~color_arrayMAN[52-1]),~color_array[52-1]));}, {~e3.background_(Color.white)}););
/*F3*/(if(obj.value.linlin(0,1,21,108) <= 53, {~f3.background_(Color(1,(~color_array[53-1]+~color_arrayMAN[53-1]),~color_array[53-1]));}, {~f3.background_(Color.white)}););
/*G3*/(if(obj.value.linlin(0,1,21,108) <= 55, {~g3.background_(Color(1,(~color_array[55-1]+~color_arrayMAN[55-1]),~color_array[55-1]));}, {~g3.background_(Color.white)}););
/*A3*/(if(obj.value.linlin(0,1,21,108) <= 57, {~a3.background_(Color(1,(~color_array[57-1]+~color_arrayMAN[57-1]),~color_array[57-1]));}, {~a3.background_(Color.white)}););
/*B3*/(if(obj.value.linlin(0,1,21,108) <= 59, {~b3.background_(Color(1,(~color_array[59-1]+~color_arrayMAN[59-1]),~color_array[59-1]));}, {~b3.background_(Color.white)}););
/*C4*/(if(obj.value.linlin(0,1,21,108) <= 60, {~c4.background_(Color(1,(~color_array[60-1]+~color_arrayMAN[60-1]),~color_array[60-1]));}, {~c4.background_(Color.white)}););
/*D4*/(if(obj.value.linlin(0,1,21,108) <= 62, {~d4.background_(Color(1,(~color_array[62-1]+~color_arrayMAN[62-1]),~color_array[62-1]));}, {~d4.background_(Color.white)}););
/*E4*/(if(obj.value.linlin(0,1,21,108) <= 64, {~e4.background_(Color(1,(~color_array[64-1]+~color_arrayMAN[64-1]),~color_array[64-1]));}, {~e4.background_(Color.white)}););
/*F4*/(if(obj.value.linlin(0,1,21,108) <= 65, {~f4.background_(Color(1,(~color_array[65-1]+~color_arrayMAN[65-1]),~color_array[65-1]));}, {~f4.background_(Color.white)}););
/*G4*/(if(obj.value.linlin(0,1,21,108) <= 67, {~g4.background_(Color(1,(~color_array[67-1]+~color_arrayMAN[67-1]),~color_array[67-1]));}, {~g4.background_(Color.white)}););
/*A4*/(if(obj.value.linlin(0,1,21,108) <= 69, {~a4.background_(Color(1,(~color_array[69-1]+~color_arrayMAN[69-1]),~color_array[69-1]));}, {~a4.background_(Color.white)}););
/*B4*/(if(obj.value.linlin(0,1,21,108) <= 71, {~b4.background_(Color(1,(~color_array[71-1]+~color_arrayMAN[71-1]),~color_array[71-1]));}, {~b4.background_(Color.white)}););
/*C5*/(if(obj.value.linlin(0,1,21,108) <= 72, {~c5.background_(Color(1,(~color_array[72-1]+~color_arrayMAN[72-1]),~color_array[72-1]));}, {~c5.background_(Color.white)}););
/*D5*/(if(obj.value.linlin(0,1,21,108) <= 74, {~d5.background_(Color(1,(~color_array[74-1]+~color_arrayMAN[74-1]),~color_array[74-1]));}, {~d5.background_(Color.white)}););
/*E5*/(if(obj.value.linlin(0,1,21,108) <= 76, {~e5.background_(Color(1,(~color_array[76-1]+~color_arrayMAN[76-1]),~color_array[76-1]));}, {~e5.background_(Color.white)}););
/*F5*/(if(obj.value.linlin(0,1,21,108) <= 77, {~f5.background_(Color(1,(~color_array[77-1]+~color_arrayMAN[77-1]),~color_array[77-1]));}, {~f5.background_(Color.white)}););
/*G5*/(if(obj.value.linlin(0,1,21,108) <= 79, {~g5.background_(Color(1,(~color_array[79-1]+~color_arrayMAN[79-1]),~color_array[79-1]));}, {~g5.background_(Color.white)}););
/*A5*/(if(obj.value.linlin(0,1,21,108) <= 81, {~a5.background_(Color(1,(~color_array[81-1]+~color_arrayMAN[81-1]),~color_array[81-1]));}, {~a5.background_(Color.white)}););
/*B5*/(if(obj.value.linlin(0,1,21,108) <= 83, {~b5.background_(Color(1,(~color_array[83-1]+~color_arrayMAN[83-1]),~color_array[83-1]));}, {~b5.background_(Color.white)}););
/*C6*/(if(obj.value.linlin(0,1,21,108) <= 84, {~c6.background_(Color(1,(~color_array[84-1]+~color_arrayMAN[84-1]),~color_array[84-1]));}, {~c6.background_(Color.white)}););
/*D6*/(if(obj.value.linlin(0,1,21,108) <= 86, {~d6.background_(Color(1,(~color_array[86-1]+~color_arrayMAN[86-1]),~color_array[86-1]));}, {~d6.background_(Color.white)}););
/*E6*/(if(obj.value.linlin(0,1,21,108) <= 88, {~e6.background_(Color(1,(~color_array[88-1]+~color_arrayMAN[88-1]),~color_array[88-1]));}, {~e6.background_(Color.white)}););
/*F6*/(if(obj.value.linlin(0,1,21,108) <= 89, {~f6.background_(Color(1,(~color_array[89-1]+~color_arrayMAN[89-1]),~color_array[89-1]));}, {~f6.background_(Color.white)}););
/*G6*/(if(obj.value.linlin(0,1,21,108) <= 91, {~g6.background_(Color(1,(~color_array[91-1]+~color_arrayMAN[91-1]),~color_array[91-1]));}, {~g6.background_(Color.white)}););
/*A6*/(if(obj.value.linlin(0,1,21,108) <= 93, {~a6.background_(Color(1,(~color_array[93-1]+~color_arrayMAN[93-1]),~color_array[93-1]));}, {~a6.background_(Color.white)}););
/*B6*/(if(obj.value.linlin(0,1,21,108) <= 95, {~b6.background_(Color(1,(~color_array[95-1]+~color_arrayMAN[95-1]),~color_array[95-1]));}, {~b6.background_(Color.white)}););
/*C7*/(if(obj.value.linlin(0,1,21,108) <= 96, {~c7.background_(Color(1,(~color_array[96-1]+~color_arrayMAN[96-1]),~color_array[96-1]));}, {~c7.background_(Color.white)}););
/*D7*/(if(obj.value.linlin(0,1,21,108) <= 98, {~d7.background_(Color(1,(~color_array[98-1]+~color_arrayMAN[98-1]),~color_array[98-1]));}, {~d7.background_(Color.white)}););
/*E7*/(if(obj.value.linlin(0,1,21,108) <= 100, {~e7.background_(Color(1,(~color_array[100-1]+~color_arrayMAN[100-1]),~color_array[100-1]));}, {~e7.background_(Color.white)}););
/*F7*/(if(obj.value.linlin(0,1,21,108) <= 101, {~f7.background_(Color(1,(~color_array[101-1]+~color_arrayMAN[101-1]),~color_array[101-1]));}, {~f7.background_(Color.white)}););
/*G7*/(if(obj.value.linlin(0,1,21,108) <= 103, {~g7.background_(Color(1,(~color_array[103-1]+~color_arrayMAN[103-1]),~color_array[103-1]));}, {~g7.background_(Color.white)}););
/*A7*/(if(obj.value.linlin(0,1,21,108) <= 105, {~a7.background_(Color(1,(~color_array[105-1]+~color_arrayMAN[105-1]),~color_array[105-1]));}, {~a7.background_(Color.white)}););
/*B7*/(if(obj.value.linlin(0,1,21,108) <= 107, {~b7.background_(Color(1,(~color_array[107-1]+~color_arrayMAN[107-1]),~color_array[107-1]));}, {~b7.background_(Color.white)}););
/*C8*/(if(obj.value.linlin(0,1,21,108) <= 108, {~c8.background_(Color(1,(~color_array[108-1]+~color_arrayMAN[108-1]),~color_array[108-1]));}, {~c8.background_(Color.white)}););




/*ASHARP0*/(if(obj.value.linlin(0,1,21,108) <=22,{if(~color_array[22-1]<1,{~aSHARP0.background_(Color(1,(~color_array[22-1]+~color_arrayMAN[22-1]),~color_array[22-1]));},{~aSHARP0.background_(Color.black)})},{~aSHARP0.background_(Color.black)}););
/*CSHARP1*/(if(obj.value.linlin(0,1,21,108) <=25,{if(~color_array[25-1]<1,{~cSHARP1.background_(Color(1,(~color_array[25-1]+~color_arrayMAN[25-1]),~color_array[25-1]));},{~cSHARP1.background_(Color.black)})},{~cSHARP1.background_(Color.black)}););
/*DSHARP1*/(if(obj.value.linlin(0,1,21,108) <=27,{if(~color_array[27-1]<1,{~dSHARP1.background_(Color(1,(~color_array[27-1]+~color_arrayMAN[27-1]),~color_array[27-1]));},{~dSHARP1.background_(Color.black)})},{~dSHARP1.background_(Color.black)}););
/*FSHARP1*/(if(obj.value.linlin(0,1,21,108) <=30,{if(~color_array[30-1]<1,{~fSHARP1.background_(Color(1,(~color_array[30-1]+~color_arrayMAN[30-1]),~color_array[30-1]));},{~fSHARP1.background_(Color.black)})},{~fSHARP1.background_(Color.black)}););
/*GSHARP1*/(if(obj.value.linlin(0,1,21,108) <=32,{if(~color_array[32-1]<1,{~gSHARP1.background_(Color(1,(~color_array[32-1]+~color_arrayMAN[32-1]),~color_array[32-1]));},{~gSHARP1.background_(Color.black)})},{~gSHARP1.background_(Color.black)}););
/*ASHARP1*/(if(obj.value.linlin(0,1,21,108) <=34,{if(~color_array[34-1]<1,{~aSHARP1.background_(Color(1,(~color_array[34-1]+~color_arrayMAN[34-1]),~color_array[34-1]));},{~aSHARP1.background_(Color.black)})},{~aSHARP1.background_(Color.black)}););
/*CSHARP2*/(if(obj.value.linlin(0,1,21,108) <=37,{if(~color_array[37-1]<1,{~cSHARP2.background_(Color(1,(~color_array[37-1]+~color_arrayMAN[37-1]),~color_array[37-1]));},{~cSHARP2.background_(Color.black)})},{~cSHARP2.background_(Color.black)}););
/*DSHARP2*/(if(obj.value.linlin(0,1,21,108) <=39,{if(~color_array[39-1]<1,{~dSHARP2.background_(Color(1,(~color_array[39-1]+~color_arrayMAN[39-1]),~color_array[39-1]));},{~dSHARP2.background_(Color.black)})},{~dSHARP2.background_(Color.black)}););
/*FSHARP2*/(if(obj.value.linlin(0,1,21,108) <=42,{if(~color_array[42-1]<1,{~fSHARP2.background_(Color(1,(~color_array[42-1]+~color_arrayMAN[42-1]),~color_array[42-1]));},{~fSHARP2.background_(Color.black)})},{~fSHARP2.background_(Color.black)}););
/*GSHARP2*/(if(obj.value.linlin(0,1,21,108) <=44,{if(~color_array[44-1]<1,{~gSHARP2.background_(Color(1,(~color_array[44-1]+~color_arrayMAN[44-1]),~color_array[44-1]));},{~gSHARP2.background_(Color.black)})},{~gSHARP2.background_(Color.black)}););
/*ASHARP2*/(if(obj.value.linlin(0,1,21,108) <=46,{if(~color_array[46-1]<1,{~aSHARP2.background_(Color(1,(~color_array[46-1]+~color_arrayMAN[46-1]),~color_array[46-1]));},{~aSHARP2.background_(Color.black)})},{~aSHARP2.background_(Color.black)}););
/*CSHARP3*/(if(obj.value.linlin(0,1,21,108) <=49,{if(~color_array[49-1]<1,{~cSHARP3.background_(Color(1,(~color_array[49-1]+~color_arrayMAN[49-1]),~color_array[49-1]));},{~cSHARP3.background_(Color.black)})},{~cSHARP3.background_(Color.black)}););
/*DSHARP3*/(if(obj.value.linlin(0,1,21,108) <=51,{if(~color_array[51-1]<1,{~dSHARP3.background_(Color(1,(~color_array[51-1]+~color_arrayMAN[51-1]),~color_array[51-1]));},{~dSHARP3.background_(Color.black)})},{~dSHARP3.background_(Color.black)}););
/*FSHARP3*/(if(obj.value.linlin(0,1,21,108) <=54,{if(~color_array[54-1]<1,{~fSHARP3.background_(Color(1,(~color_array[54-1]+~color_arrayMAN[54-1]),~color_array[54-1]));},{~fSHARP3.background_(Color.black)})},{~fSHARP3.background_(Color.black)}););
/*GSHARP3*/(if(obj.value.linlin(0,1,21,108) <=56,{if(~color_array[56-1]<1,{~gSHARP3.background_(Color(1,(~color_array[56-1]+~color_arrayMAN[56-1]),~color_array[56-1]));},{~gSHARP3.background_(Color.black)})},{~gSHARP3.background_(Color.black)}););
/*ASHARP3*/(if(obj.value.linlin(0,1,21,108) <=58,{if(~color_array[58-1]<1,{~aSHARP3.background_(Color(1,(~color_array[58-1]+~color_arrayMAN[58-1]),~color_array[58-1]));},{~aSHARP3.background_(Color.black)})},{~aSHARP3.background_(Color.black)}););
/*CSHARP4*/(if(obj.value.linlin(0,1,21,108) <=61,{if(~color_array[61-1]<1,{~cSHARP4.background_(Color(1,(~color_array[61-1]+~color_arrayMAN[61-1]),~color_array[61-1]));},{~cSHARP4.background_(Color.black)})},{~cSHARP4.background_(Color.black)}););
/*DSHARP4*/(if(obj.value.linlin(0,1,21,108) <=63,{if(~color_array[63-1]<1,{~dSHARP4.background_(Color(1,(~color_array[63-1]+~color_arrayMAN[63-1]),~color_array[63-1]));},{~dSHARP4.background_(Color.black)})},{~dSHARP4.background_(Color.black)}););
/*FSHARP4*/(if(obj.value.linlin(0,1,21,108) <=66,{if(~color_array[66-1]<1,{~fSHARP4.background_(Color(1,(~color_array[66-1]+~color_arrayMAN[66-1]),~color_array[66-1]));},{~fSHARP4.background_(Color.black)})},{~fSHARP4.background_(Color.black)}););
/*GSHARP4*/(if(obj.value.linlin(0,1,21,108) <=68,{if(~color_array[68-1]<1,{~gSHARP4.background_(Color(1,(~color_array[68-1]+~color_arrayMAN[68-1]),~color_array[68-1]));},{~gSHARP4.background_(Color.black)})},{~gSHARP4.background_(Color.black)}););
/*ASHARP4*/(if(obj.value.linlin(0,1,21,108) <=70,{if(~color_array[70-1]<1,{~aSHARP4.background_(Color(1,(~color_array[70-1]+~color_arrayMAN[70-1]),~color_array[70-1]));},{~aSHARP4.background_(Color.black)})},{~aSHARP4.background_(Color.black)}););
/*CSHARP5*/(if(obj.value.linlin(0,1,21,108) <=73,{if(~color_array[73-1]<1,{~cSHARP5.background_(Color(1,(~color_array[73-1]+~color_arrayMAN[73-1]),~color_array[73-1]));},{~cSHARP5.background_(Color.black)})},{~cSHARP5.background_(Color.black)}););
/*DSHARP5*/(if(obj.value.linlin(0,1,21,108) <=75,{if(~color_array[75-1]<1,{~dSHARP5.background_(Color(1,(~color_array[75-1]+~color_arrayMAN[75-1]),~color_array[75-1]));},{~dSHARP5.background_(Color.black)})},{~dSHARP5.background_(Color.black)}););
/*FSHARP5*/(if(obj.value.linlin(0,1,21,108) <=78,{if(~color_array[78-1]<1,{~fSHARP5.background_(Color(1,(~color_array[78-1]+~color_arrayMAN[78-1]),~color_array[78-1]));},{~fSHARP5.background_(Color.black)})},{~fSHARP5.background_(Color.black)}););
/*GSHARP5*/(if(obj.value.linlin(0,1,21,108) <=80,{if(~color_array[80-1]<1,{~gSHARP5.background_(Color(1,(~color_array[80-1]+~color_arrayMAN[80-1]),~color_array[80-1]));},{~gSHARP5.background_(Color.black)})},{~gSHARP5.background_(Color.black)}););
/*ASHARP5*/(if(obj.value.linlin(0,1,21,108) <=82,{if(~color_array[82-1]<1,{~aSHARP5.background_(Color(1,(~color_array[82-1]+~color_arrayMAN[82-1]),~color_array[82-1]));},{~aSHARP5.background_(Color.black)})},{~aSHARP5.background_(Color.black)}););
/*CSHARP6*/(if(obj.value.linlin(0,1,21,108) <=85,{if(~color_array[85-1]<1,{~cSHARP6.background_(Color(1,(~color_array[85-1]+~color_arrayMAN[85-1]),~color_array[85-1]));},{~cSHARP6.background_(Color.black)})},{~cSHARP6.background_(Color.black)}););
/*DSHARP6*/(if(obj.value.linlin(0,1,21,108) <=87,{if(~color_array[87-1]<1,{~dSHARP6.background_(Color(1,(~color_array[87-1]+~color_arrayMAN[87-1]),~color_array[87-1]));},{~dSHARP6.background_(Color.black)})},{~dSHARP6.background_(Color.black)}););
/*FSHARP6*/(if(obj.value.linlin(0,1,21,108) <=90,{if(~color_array[90-1]<1,{~fSHARP6.background_(Color(1,(~color_array[90-1]+~color_arrayMAN[90-1]),~color_array[90-1]));},{~fSHARP6.background_(Color.black)})},{~fSHARP6.background_(Color.black)}););
/*GSHARP6*/(if(obj.value.linlin(0,1,21,108) <=92,{if(~color_array[92-1]<1,{~gSHARP6.background_(Color(1,(~color_array[92-1]+~color_arrayMAN[92-1]),~color_array[92-1]));},{~gSHARP6.background_(Color.black)})},{~gSHARP6.background_(Color.black)}););
/*ASHARP6*/(if(obj.value.linlin(0,1,21,108) <=94,{if(~color_array[94-1]<1,{~aSHARP6.background_(Color(1,(~color_array[94-1]+~color_arrayMAN[94-1]),~color_array[94-1]));},{~aSHARP6.background_(Color.black)})},{~aSHARP6.background_(Color.black)}););
/*CSHARP7*/(if(obj.value.linlin(0,1,21,108) <=97,{if(~color_array[97-1]<1,{~cSHARP7.background_(Color(1,(~color_array[97-1]+~color_arrayMAN[97-1]),~color_array[97-1]));},{~cSHARP7.background_(Color.black)})},{~cSHARP7.background_(Color.black)}););
/*DSHARP7*/(if(obj.value.linlin(0,1,21,108) <=99,{if(~color_array[99-1]<1,{~dSHARP7.background_(Color(1,(~color_array[99-1]+~color_arrayMAN[99-1]),~color_array[99-1]));},{~dSHARP7.background_(Color.black)})},{~dSHARP7.background_(Color.black)}););
/*FSHARP7*/(if(obj.value.linlin(0,1,21,108) <=102,{if(~color_array[102-1]<1,{~fSHARP7.background_(Color(1,(~color_array[102-1]+~color_arrayMAN[102-1]),~color_array[102-1]));},{~fSHARP7.background_(Color.black)})},{~fSHARP7.background_(Color.black)}););
/*GSHARP7*/(if(obj.value.linlin(0,1,21,108) <=104,{if(~color_array[104-1]<1,{~gSHARP7.background_(Color(1,(~color_array[104-1]+~color_arrayMAN[104-1]),~color_array[104-1]));},{~gSHARP7.background_(Color.black)})},{~gSHARP7.background_(Color.black)}););
/*ASHARP7*/(if(obj.value.linlin(0,1,21,108) <=106,{if(~color_array[106-1]<1,{~aSHARP7.background_(Color(1,(~color_array[106-1]+~color_arrayMAN[106-1]),~color_array[106-1]));},{~aSHARP7.background_(Color.black)})},{~aSHARP7.background_(Color.black)}););
*/



/*
			//Deviant definer

/*ASHARP0*/(if(obj.value.linlin(0,1,21,108) <= 22, {~aSHARP0dev.background_(Color((1-~color_array[22-1])**(0.25),0,0));}, {~aSHARP0dev.background_(Color.black)}););
/*CSHARP1*/(if(obj.value.linlin(0,1,21,108) <= 25, {~cSHARP1dev.background_(Color((1-~color_array[25-1])**(0.25),0,0));}, {~cSHARP1dev.background_(Color.black)}););
/*DSHARP1*/(if(obj.value.linlin(0,1,21,108) <= 27, {~dSHARP1dev.background_(Color((1-~color_array[27-1])**(0.25),0,0));}, {~dSHARP1dev.background_(Color.black)}););
/*FSHARP1*/(if(obj.value.linlin(0,1,21,108) <= 30, {~fSHARP1dev.background_(Color((1-~color_array[30-1])**(0.25),0,0));}, {~fSHARP1dev.background_(Color.black)}););
/*GSHARP1*/(if(obj.value.linlin(0,1,21,108) <= 32, {~gSHARP1dev.background_(Color((1-~color_array[32-1])**(0.25),0,0));}, {~gSHARP1dev.background_(Color.black)}););
/*ASHARP1*/(if(obj.value.linlin(0,1,21,108) <= 34, {~aSHARP1dev.background_(Color((1-~color_array[34-1])**(0.25),0,0));}, {~aSHARP1dev.background_(Color.black)}););
/*CSHARP2*/(if(obj.value.linlin(0,1,21,108) <= 37, {~cSHARP2dev.background_(Color((1-~color_array[37-1])**(0.25),0,0));}, {~cSHARP2dev.background_(Color.black)}););
/*DSHARP2*/(if(obj.value.linlin(0,1,21,108) <= 39, {~dSHARP2dev.background_(Color((1-~color_array[39-1])**(0.25),0,0));}, {~dSHARP2dev.background_(Color.black)}););
/*FSHARP2*/(if(obj.value.linlin(0,1,21,108) <= 42, {~fSHARP2dev.background_(Color((1-~color_array[42-1])**(0.25),0,0));}, {~fSHARP2dev.background_(Color.black)}););
/*GSHARP2*/(if(obj.value.linlin(0,1,21,108) <= 44, {~gSHARP2dev.background_(Color((1-~color_array[44-1])**(0.25),0,0));}, {~gSHARP2dev.background_(Color.black)}););
/*ASHARP2*/(if(obj.value.linlin(0,1,21,108) <= 46, {~aSHARP2dev.background_(Color((1-~color_array[46-1])**(0.25),0,0));}, {~aSHARP2dev.background_(Color.black)}););
/*CSHARP3*/(if(obj.value.linlin(0,1,21,108) <= 49, {~cSHARP3dev.background_(Color((1-~color_array[49-1])**(0.25),0,0));}, {~cSHARP3dev.background_(Color.black)}););
/*DSHARP3*/(if(obj.value.linlin(0,1,21,108) <= 51, {~dSHARP3dev.background_(Color((1-~color_array[51-1])**(0.25),0,0));}, {~dSHARP3dev.background_(Color.black)}););
/*FSHARP3*/(if(obj.value.linlin(0,1,21,108) <= 54, {~fSHARP3dev.background_(Color((1-~color_array[54-1])**(0.25),0,0));}, {~fSHARP3dev.background_(Color.black)}););
/*GSHARP3*/(if(obj.value.linlin(0,1,21,108) <= 56, {~gSHARP3dev.background_(Color((1-~color_array[56-1])**(0.25),0,0));}, {~gSHARP3dev.background_(Color.black)}););
/*ASHARP3*/(if(obj.value.linlin(0,1,21,108) <= 58, {~aSHARP3dev.background_(Color((1-~color_array[58-1])**(0.25),0,0));}, {~aSHARP3dev.background_(Color.black)}););
/*CSHARP4*/(if(obj.value.linlin(0,1,21,108) <= 61, {~cSHARP4dev.background_(Color((1-~color_array[61-1])**(0.25),0,0));}, {~cSHARP4dev.background_(Color.black)}););
/*DSHARP4*/(if(obj.value.linlin(0,1,21,108) <= 63, {~dSHARP4dev.background_(Color((1-~color_array[63-1])**(0.25),0,0));}, {~dSHARP4dev.background_(Color.black)}););
/*FSHARP4*/(if(obj.value.linlin(0,1,21,108) <= 66, {~fSHARP4dev.background_(Color((1-~color_array[66-1])**(0.25),0,0));}, {~fSHARP4dev.background_(Color.black)}););
/*GSHARP4*/(if(obj.value.linlin(0,1,21,108) <= 68, {~gSHARP4dev.background_(Color((1-~color_array[68-1])**(0.25),0,0));}, {~gSHARP4dev.background_(Color.black)}););
/*ASHARP4*/(if(obj.value.linlin(0,1,21,108) <= 70, {~aSHARP4dev.background_(Color((1-~color_array[70-1])**(0.25),0,0));}, {~aSHARP4dev.background_(Color.black)}););
/*CSHARP5*/(if(obj.value.linlin(0,1,21,108) <= 73, {~cSHARP5dev.background_(Color((1-~color_array[73-1])**(0.25),0,0));}, {~cSHARP5dev.background_(Color.black)}););
/*DSHARP5*/(if(obj.value.linlin(0,1,21,108) <= 75, {~dSHARP5dev.background_(Color((1-~color_array[75-1])**(0.25),0,0));}, {~dSHARP5dev.background_(Color.black)}););
/*FSHARP5*/(if(obj.value.linlin(0,1,21,108) <= 78, {~fSHARP5dev.background_(Color((1-~color_array[78-1])**(0.25),0,0));}, {~fSHARP5dev.background_(Color.black)}););
/*GSHARP5*/(if(obj.value.linlin(0,1,21,108) <= 80, {~gSHARP5dev.background_(Color((1-~color_array[80-1])**(0.25),0,0));}, {~gSHARP5dev.background_(Color.black)}););
/*ASHARP5*/(if(obj.value.linlin(0,1,21,108) <= 82, {~aSHARP5dev.background_(Color((1-~color_array[82-1])**(0.25),0,0));}, {~aSHARP5dev.background_(Color.black)}););
/*CSHARP6*/(if(obj.value.linlin(0,1,21,108) <= 85, {~cSHARP6dev.background_(Color((1-~color_array[85-1])**(0.25),0,0));}, {~cSHARP6dev.background_(Color.black)}););
/*DSHARP6*/(if(obj.value.linlin(0,1,21,108) <= 87, {~dSHARP6dev.background_(Color((1-~color_array[87-1])**(0.25),0,0));}, {~dSHARP6dev.background_(Color.black)}););
/*FSHARP6*/(if(obj.value.linlin(0,1,21,108) <= 90, {~fSHARP6dev.background_(Color((1-~color_array[90-1])**(0.25),0,0));}, {~fSHARP6dev.background_(Color.black)}););
/*GSHARP6*/(if(obj.value.linlin(0,1,21,108) <= 92, {~gSHARP6dev.background_(Color((1-~color_array[92-1])**(0.25),0,0));}, {~gSHARP6dev.background_(Color.black)}););
/*ASHARP6*/(if(obj.value.linlin(0,1,21,108) <= 94, {~aSHARP6dev.background_(Color((1-~color_array[94-1])**(0.25),0,0));}, {~aSHARP6dev.background_(Color.black)}););
/*CSHARP7*/(if(obj.value.linlin(0,1,21,108) <= 97, {~cSHARP7dev.background_(Color((1-~color_array[97-1])**(0.25),0,0));}, {~cSHARP7dev.background_(Color.black)}););
/*DSHARP7*/(if(obj.value.linlin(0,1,21,108) <= 99, {~dSHARP7dev.background_(Color((1-~color_array[99-1])**(0.25),0,0));}, {~dSHARP7dev.background_(Color.black)}););
/*FSHARP7*/(if(obj.value.linlin(0,1,21,108) <= 102, {~fSHARP7dev.background_(Color((1-~color_array[102-1])**(0.25),0,0));}, {~fSHARP7dev.background_(Color.black)}););
/*GSHARP7*/(if(obj.value.linlin(0,1,21,108) <= 104, {~gSHARP7dev.background_(Color((1-~color_array[104-1])**(0.25),0,0));}, {~gSHARP7dev.background_(Color.black)}););
/*ASHARP7*/(if(obj.value.linlin(0,1,21,108) <= 106, {~aSHARP7dev.background_(Color((1-~color_array[106-1])**(0.25),0,0));}, {~aSHARP7dev.background_(Color.black)}););
*/


		}));

		});



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
	~harmonics_array[0] =0;
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
	arg freqX = 21, outoftune = 0, intensity = 1, other = 1, vol = 1.2, harmToggle1=1, harmToggle2=1, harmToggle3=1, harmToggle4=1, harmToggle5=1, harmToggle6=1, harmToggle7=1, harmToggle8=1, harmToggle9=1, harmToggle10=1, harmToggle11=1, harmToggle12=1, harmToggle13=1, harmToggle14=1, harmToggle15=1, harmToggle16=1,
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


//FREQUENCY of deviant
//Properties of the slider
~freqslider = Slider(w, Rect(160,200+65+30,330,30))
.background_(Color(0.8,0.8,0.8,0.75))
.value_(0.5)
.action_({
	arg obj;
	var cf;
	cf = obj.value.linlin(0,1,-1,1).postln;
		if(
		x.isPlaying,
		{x.set(\outoftune,cf)});
	~numberBox.value_(obj.value.linlin(0,1,-1,1));
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
	cf = obj.value.linlin(0,1,0.0,2).postln;
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
			{~dirtyBit = 5; ~dirtyBit.postln;~fslider.valueAction_(~fslider.value);});

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
	cf = obj.value.linlin(0,1,0.0,2).postln;
		if(
		x.isPlaying,
		{x.set(\other,cf)});
	~number3Box.value_(obj.value.linlin(0,1,0.0,2));

/*
~color_array[~fslider.value.linlin(0,1,21,108)-1+0]=(~harmonics_array[0]+(~otherslider.value.linlin(0,1,1,0)*(1-~harmonics_array[0])))-(~manipulated_harmonic[0]*~mulslider.value.linlin(0,1,0,1););
~color_array[~fslider.value.linlin(0,1,21,108)-1+12]=(~harmonics_array[1]+(~otherslider.value.linlin(0,1,1,0)*(1-~harmonics_array[1])))-(~manipulated_harmonic[1]*~mulslider.value.linlin(0,1,0,1););
~color_array[~fslider.value.linlin(0,1,21,108)-1+19]=(~harmonics_array[2]+(~otherslider.value.linlin(0,1,1,0)*(1-~harmonics_array[2])))-(~manipulated_harmonic[2]*~mulslider.value.linlin(0,1,0,1););
~color_array[~fslider.value.linlin(0,1,21,108)-1+24]=(~harmonics_array[3]+(~otherslider.value.linlin(0,1,1,0)*(1-~harmonics_array[3])))-(~manipulated_harmonic[3]*~mulslider.value.linlin(0,1,0,1););
~color_array[~fslider.value.linlin(0,1,21,108)-1+28]=(~harmonics_array[4]+(~otherslider.value.linlin(0,1,1,0)*(1-~harmonics_array[4])))-(~manipulated_harmonic[4]*~mulslider.value.linlin(0,1,0,1););
~color_array[~fslider.value.linlin(0,1,21,108)-1+31]=(~harmonics_array[5]+(~otherslider.value.linlin(0,1,1,0)*(1-~harmonics_array[5])))-(~manipulated_harmonic[5]*~mulslider.value.linlin(0,1,0,1););
~color_array[~fslider.value.linlin(0,1,21,108)-1+34]=(~harmonics_array[6]+(~otherslider.value.linlin(0,1,1,0)*(1-~harmonics_array[6])))-(~manipulated_harmonic[6]*~mulslider.value.linlin(0,1,0,1););
~color_array[~fslider.value.linlin(0,1,21,108)-1+36]=(~harmonics_array[7]+(~otherslider.value.linlin(0,1,1,0)*(1-~harmonics_array[7])))-(~manipulated_harmonic[7]*~mulslider.value.linlin(0,1,0,1););
~color_array[~fslider.value.linlin(0,1,21,108)-1+38]=(~harmonics_array[8]+(~otherslider.value.linlin(0,1,1,0)*(1-~harmonics_array[8])))-(~manipulated_harmonic[8]*~mulslider.value.linlin(0,1,0,1););
~color_array[~fslider.value.linlin(0,1,21,108)-1+40]=(~harmonics_array[9]+(~otherslider.value.linlin(0,1,1,0)*(1-~harmonics_array[9])))-(~manipulated_harmonic[9]*~mulslider.value.linlin(0,1,0,1););
~color_array[~fslider.value.linlin(0,1,21,108)-1+41]=(~harmonics_array[10]+(~otherslider.value.linlin(0,1,1,0)*(1-~harmonics_array[10])))-(~manipulated_harmonic[10]*~mulslider.value.linlin(0,1,0,1););
~color_array[~fslider.value.linlin(0,1,21,108)-1+43]=(~harmonics_array[11]+(~otherslider.value.linlin(0,1,1,0)*(1-~harmonics_array[11])))-(~manipulated_harmonic[11]*~mulslider.value.linlin(0,1,0,1););
~color_array[~fslider.value.linlin(0,1,21,108)-1+44]=(~harmonics_array[12]+(~otherslider.value.linlin(0,1,1,0)*(1-~harmonics_array[12])))-(~manipulated_harmonic[12]*~mulslider.value.linlin(0,1,0,1););
~color_array[~fslider.value.linlin(0,1,21,108)-1+46]=(~harmonics_array[13]+(~otherslider.value.linlin(0,1,1,0)*(1-~harmonics_array[13])))-(~manipulated_harmonic[13]*~mulslider.value.linlin(0,1,0,1););
~color_array[~fslider.value.linlin(0,1,21,108)-1+47]=(~harmonics_array[14]+(~otherslider.value.linlin(0,1,1,0)*(1-~harmonics_array[14])))-(~manipulated_harmonic[14]*~mulslider.value.linlin(0,1,0,1););
~color_array[~fslider.value.linlin(0,1,21,108)-1+48]=(~harmonics_array[15]+(~otherslider.value.linlin(0,1,1,0)*(1-~harmonics_array[15])))-(~manipulated_harmonic[15]*~mulslider.value.linlin(0,1,0,1););
*/

~fslider.valueAction_(~fslider.value); //This allows it to refresh real-time
		s.makeBundle(1.0, //sound delay
			{~dirtyBit = 5; ~dirtyBit.postln;~fslider.valueAction_(~fslider.value);});


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

/*
////VERSION:
~versioncode = StaticText(w,Rect(0,559,500,30))
	.string_("Beta Version 0.1.0")
.font_(Font("Helvetica", 10, false))
.align_(\top)
	.background_(Color.clear)
	.stringColor_(Color.white);

	~versioncodeBox = StaticText(w,Rect(0,555,500,30))
	.string_("")
.font_(Font("Helvetica", 10, false))
.align_(\top)
	.background_(Color(1,1,1,0.2))
	.stringColor_(Color.white);

*/

	// ~keyboard_open = 0;
/*
//Keyboard MIDI notation image button
		~midi_table = Button.new(w, Rect(10, 100, 20, 20))
	.states_([["#", Color.white, Color.gray]])
	.font_(Font("nil", 10))
	.mouseDownAction_({

				(basePath +/+  "modules/keyboard_image.scd").loadPaths; //This line allows all contact buttons to be updated automatically
	});
	*/


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
				["            Click to Play # of Harmonics", Color.white, Color(0.7569,0.1373,0.1725,1)], ["            Click to Stop Sound", Color.white, Color.grey(0.251)]])


  .mouseDownAction_(

				{

					arg obj;
	if(obj.value == 0,
						{

							snd = funcs2.at(menu.value).play /*+ funcs2.at(menu2.value).postln*/;

	~fslider.valueAction_(~fslider.value); //This allows it to refresh real-time
				s.makeBundle(3.0, //sound delay
			{~dirtyBit = 4; ~dirtyBit.postln;~fslider.valueAction_(~fslider.value);});




						},{x.free; /*~fslider.valueAction_(0.value.linlin(21,108,0,1));*/}
			)})
  .action_({ arg mod;
/*~menu2.allowsReselection;
				~menu2.value_(0);
				~menu2.valueAction_(0);*/
    snd.release;
				~fslider.valueAction_(~fslider.value); //This allows it to refresh real-time
		s.makeBundle(1.0, //sound delay
			{~dirtyBit = 5; ~dirtyBit.postln;~fslider.valueAction_(~fslider.value);});

			~volslider.valueAction_(0.3);

			});

menu = PopUpMenu(w, Rect(250-(250/2)+5,95+5,50,20));
			menu.items_(["1", "2", "3", "5", "8", "16"]);
			menu.font_(Font(\size, 12));
			menu.allowsReselection_(true);
			menu.action = { arg menu, menu2;

				// [menu.value, menu.item, menu.action].postln; //These lines allow below allow the menu clicker to auto-set the choice selected (not requiring to click on-off the button to set the dropdown selection)
~vinbutton.valueAction_(0);
				x.free;
				~vinbutton.valueAction_(1);
	~fslider.valueAction_(~fslider.value); //This allows it to refresh real-time
				s.makeBundle(1.0, //sound delay
			{~dirtyBit = 5; ~dirtyBit.postln;~fslider.valueAction_(~fslider.value);});

snd = funcs2.at(menu.value).play;
			};


 funcs2 = [

				{~harmonic_count = 1; ~harmonics_array[0] =0; ~harmonics_array[1..15] =1;
						~fslider.valueAction_(~fslider.value); //This allows it to refresh real-time
				s.makeBundle(1.0, //sound delay
			{~dirtyBit = 5; ~dirtyBit.postln;~fslider.valueAction_(~fslider.value);});

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
			{~dirtyBit = 5; ~dirtyBit.postln;~fslider.valueAction_(~fslider.value);});

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
			{~dirtyBit = 5; ~dirtyBit.postln;~fslider.valueAction_(~fslider.value);});

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
			{~dirtyBit = 5; ~dirtyBit.postln;~fslider.valueAction_(~fslider.value);});
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
			{~dirtyBit = 5; ~dirtyBit.postln;~fslider.valueAction_(~fslider.value);});

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
			{~dirtyBit = 5; ~dirtyBit.postln;~fslider.valueAction_(~fslider.value);});

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

 p = CmdPeriod.add({ b.value_(0) }); // set button to 0 on hitting Cmd-period
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




 funcs2 = [

				{//None
					~harmonics_array[0..(~harmonic_count-1)]=0;~manipulated_harmonic[0..15]=0; //resets
					~fslider.valueAction_(~fslider.value); //This allows it to refresh real-time
				s.makeBundle(1.0, //sound delay
			{~dirtyBit = 5; ~dirtyBit.postln;~fslider.valueAction_(~fslider.value);});

			x.set(
						\choose1,0,
						\choose2,0,
						\choose3,0,
						\choose4,0,
						\choose5,0,
						\choose6,0,
						\choose7,0,
						\choose8,0,
						\choose9,0,
						\choose10,0,
						\choose11,0,
						\choose12,0,
						\choose13,0,
						\choose14,0,
						\choose15,0,
						\choose16,0,

				);
				(~coverComposite.visible = true)},

				{//1
					~harmonics_array[0..(~harmonic_count-1)]=0;~harmonics_array[0]=1;~manipulated_harmonic[0..15]=0;~manipulated_harmonic[0]=1;

					~fslider.valueAction_(~fslider.value); //This allows it to refresh real-time
				s.makeBundle(1.0, //sound delay
			{~dirtyBit = 5; ~dirtyBit.postln;~fslider.valueAction_(~fslider.value);});

			x.set(
						\choose1,1,
						\choose2,0,
						\choose3,0,
						\choose4,0,
						\choose5,0,
						\choose6,0,
						\choose7,0,
						\choose8,0,
						\choose9,0,
						\choose10,0,
						\choose11,0,
						\choose12,0,
						\choose13,0,
						\choose14,0,
						\choose15,0,
						\choose16,0,

				)},

				{//2
				~harmonics_array[0..(~harmonic_count-1)]=0;~harmonics_array[1]=1;~manipulated_harmonic[0..15]=0;~manipulated_harmonic[1]=1;
					~fslider.valueAction_(~fslider.value); //This allows it to refresh real-time
				s.makeBundle(1.0, //sound delay
			{~dirtyBit = 5; ~dirtyBit.postln;~fslider.valueAction_(~fslider.value);});
			x.set(
						\choose1,0,
						\choose2,1,
						\choose3,0,
						\choose4,0,
						\choose5,0,
						\choose6,0,
						\choose7,0,
						\choose8,0,
						\choose9,0,
						\choose10,0,
						\choose11,0,
						\choose12,0,
						\choose13,0,
						\choose14,0,
						\choose15,0,
						\choose16,0,

				)},

				{//3
					~harmonics_array[0..(~harmonic_count-1)]=0;~harmonics_array[2]=1;~manipulated_harmonic[0..15]=0;~manipulated_harmonic[2]=1;
					~fslider.valueAction_(~fslider.value); //This allows it to refresh real-time
				s.makeBundle(1.0, //sound delay
			{~dirtyBit = 5; ~dirtyBit.postln;~fslider.valueAction_(~fslider.value);});
			x.set(
						\choose1,0,
						\choose2,0,
						\choose3,1,
						\choose4,0,
						\choose5,0,
						\choose6,0,
						\choose7,0,
						\choose8,0,
						\choose9,0,
						\choose10,0,
						\choose11,0,
						\choose12,0,
						\choose13,0,
						\choose14,0,
						\choose15,0,
						\choose16,0,

				)},

				{//4
					~harmonics_array[0..(~harmonic_count-1)]=0;~harmonics_array[3]=1;~manipulated_harmonic[0..15]=0;~manipulated_harmonic[3]=1;
					~fslider.valueAction_(~fslider.value); //This allows it to refresh real-time
				s.makeBundle(1.0, //sound delay
			{~dirtyBit = 5; ~dirtyBit.postln;~fslider.valueAction_(~fslider.value);});
			x.set(
						\choose1,0,
						\choose2,0,
						\choose3,0,
						\choose4,1,
						\choose5,0,
						\choose6,0,
						\choose7,0,
						\choose8,0,
						\choose9,0,
						\choose10,0,
						\choose11,0,
						\choose12,0,
						\choose13,0,
						\choose14,0,
						\choose15,0,
						\choose16,0,

				)},

				{//5
					~harmonics_array[0..(~harmonic_count-1)]=0;~harmonics_array[4]=1;~manipulated_harmonic[0..15]=0;~manipulated_harmonic[4]=1;
					~fslider.valueAction_(~fslider.value); //This allows it to refresh real-time
				s.makeBundle(1.0, //sound delay
			{~dirtyBit = 5; ~dirtyBit.postln;~fslider.valueAction_(~fslider.value);});
			x.set(
						\choose1,0,
						\choose2,0,
						\choose3,0,
						\choose4,0,
						\choose5,1,
						\choose6,0,
						\choose7,0,
						\choose8,0,
						\choose9,0,
						\choose10,0,
						\choose11,0,
						\choose12,0,
						\choose13,0,
						\choose14,0,
						\choose15,0,
						\choose16,0,

				)},

				{//6
					~harmonics_array[0..(~harmonic_count-1)]=0;~harmonics_array[5]=1;~manipulated_harmonic[0..15]=0;~manipulated_harmonic[5]=1;
					~fslider.valueAction_(~fslider.value); //This allows it to refresh real-time
				s.makeBundle(1.0, //sound delay
			{~dirtyBit = 5; ~dirtyBit.postln;~fslider.valueAction_(~fslider.value);});
			x.set(
						\choose1,0,
						\choose2,0,
						\choose3,0,
						\choose4,0,
						\choose5,0,
						\choose6,1,
						\choose7,0,
						\choose8,0,
						\choose9,0,
						\choose10,0,
						\choose11,0,
						\choose12,0,
						\choose13,0,
						\choose14,0,
						\choose15,0,
						\choose16,0,

				)},

				{//7
					~harmonics_array[0..(~harmonic_count-1)]=0;~harmonics_array[6]=1;~manipulated_harmonic[0..15]=0;~manipulated_harmonic[6]=1;
					~fslider.valueAction_(~fslider.value); //This allows it to refresh real-time
				s.makeBundle(1.0, //sound delay
			{~dirtyBit = 5; ~dirtyBit.postln;~fslider.valueAction_(~fslider.value);});
			x.set(
						\choose1,0,
						\choose2,0,
						\choose3,0,
						\choose4,0,
						\choose5,0,
						\choose6,0,
						\choose7,1,
						\choose8,0,
						\choose9,0,
						\choose10,0,
						\choose11,0,
						\choose12,0,
						\choose13,0,
						\choose14,0,
						\choose15,0,
						\choose16,0,

				)},

				{//8
					~harmonics_array[0..(~harmonic_count-1)]=0;~harmonics_array[7]=1;~manipulated_harmonic[0..15]=0;~manipulated_harmonic[7]=1;
					~fslider.valueAction_(~fslider.value); //This allows it to refresh real-time
				s.makeBundle(1.0, //sound delay
			{~dirtyBit = 5; ~dirtyBit.postln;~fslider.valueAction_(~fslider.value);});
			x.set(
						\choose1,0,
						\choose2,0,
						\choose3,0,
						\choose4,0,
						\choose5,0,
						\choose6,0,
						\choose7,0,
						\choose8,1,
						\choose9,0,
						\choose10,0,
						\choose11,0,
						\choose12,0,
						\choose13,0,
						\choose14,0,
						\choose15,0,
						\choose16,0,

				)},

				{//9
					~harmonics_array[0..(~harmonic_count-1)]=0;~harmonics_array[8]=1;~manipulated_harmonic[0..15]=0;~manipulated_harmonic[8]=1;
					~fslider.valueAction_(~fslider.value); //This allows it to refresh real-time
				s.makeBundle(1.0, //sound delay
			{~dirtyBit = 5; ~dirtyBit.postln;~fslider.valueAction_(~fslider.value);});
			x.set(
						\choose1,0,
						\choose2,0,
						\choose3,0,
						\choose4,0,
						\choose5,0,
						\choose6,0,
						\choose7,0,
						\choose8,0,
						\choose9,1,
						\choose10,0,
						\choose11,0,
						\choose12,0,
						\choose13,0,
						\choose14,0,
						\choose15,0,
						\choose16,0,

				)},

				{//10
					~harmonics_array[0..(~harmonic_count-1)]=0;~harmonics_array[9]=1;~manipulated_harmonic[0..15]=0;~manipulated_harmonic[9]=1;
					~fslider.valueAction_(~fslider.value); //This allows it to refresh real-time
				s.makeBundle(1.0, //sound delay
			{~dirtyBit = 5; ~dirtyBit.postln;~fslider.valueAction_(~fslider.value);});
			x.set(
						\choose1,0,
						\choose2,0,
						\choose3,0,
						\choose4,0,
						\choose5,0,
						\choose6,0,
						\choose7,0,
						\choose8,0,
						\choose9,0,
						\choose10,1,
						\choose11,0,
						\choose12,0,
						\choose13,0,
						\choose14,0,
						\choose15,0,
						\choose16,0,

				)},

				{//11
					~harmonics_array[0..(~harmonic_count-1)]=0;~harmonics_array[10]=1;~manipulated_harmonic[0..15]=0;~manipulated_harmonic[10]=1;
					~fslider.valueAction_(~fslider.value); //This allows it to refresh real-time
				s.makeBundle(1.0, //sound delay
			{~dirtyBit = 5; ~dirtyBit.postln;~fslider.valueAction_(~fslider.value);});
			x.set(
						\choose1,0,
						\choose2,0,
						\choose3,0,
						\choose4,0,
						\choose5,0,
						\choose6,0,
						\choose7,0,
						\choose8,0,
						\choose9,0,
						\choose10,0,
						\choose11,1,
						\choose12,0,
						\choose13,0,
						\choose14,0,
						\choose15,0,
						\choose16,0,

				)},

				{//12
					~harmonics_array[0..(~harmonic_count-1)]=0;~harmonics_array[11]=1;~manipulated_harmonic[0..15]=0;~manipulated_harmonic[11]=1;
					~fslider.valueAction_(~fslider.value); //This allows it to refresh real-time
				s.makeBundle(1.0, //sound delay
			{~dirtyBit = 5; ~dirtyBit.postln;~fslider.valueAction_(~fslider.value);});
			x.set(
						\choose1,0,
						\choose2,0,
						\choose3,0,
						\choose4,0,
						\choose5,0,
						\choose6,0,
						\choose7,0,
						\choose8,0,
						\choose9,0,
						\choose10,0,
						\choose11,0,
						\choose12,1,
						\choose13,0,
						\choose14,0,
						\choose15,0,
						\choose16,0,

				)},

				{//13
					~harmonics_array[0..(~harmonic_count-1)]=0;~harmonics_array[12]=1;~manipulated_harmonic[0..15]=0;~manipulated_harmonic[12]=1;
					~fslider.valueAction_(~fslider.value); //This allows it to refresh real-time
				s.makeBundle(1.0, //sound delay
			{~dirtyBit = 5; ~dirtyBit.postln;~fslider.valueAction_(~fslider.value);});
			x.set(
						\choose1,0,
						\choose2,0,
						\choose3,0,
						\choose4,0,
						\choose5,0,
						\choose6,0,
						\choose7,0,
						\choose8,0,
						\choose9,0,
						\choose10,0,
						\choose11,0,
						\choose12,0,
						\choose13,1,
						\choose14,0,
						\choose15,0,
						\choose16,0,

				)},

				{//14
					~harmonics_array[0..(~harmonic_count-1)]=0;~harmonics_array[13]=1;~manipulated_harmonic[0..15]=0;~manipulated_harmonic[13]=1;
					~fslider.valueAction_(~fslider.value); //This allows it to refresh real-time
				s.makeBundle(1.0, //sound delay
			{~dirtyBit = 5; ~dirtyBit.postln;~fslider.valueAction_(~fslider.value);});
			x.set(
						\choose1,0,
						\choose2,0,
						\choose3,0,
						\choose4,0,
						\choose5,0,
						\choose6,0,
						\choose7,0,
						\choose8,0,
						\choose9,0,
						\choose10,0,
						\choose11,0,
						\choose12,0,
						\choose13,0,
						\choose14,1,
						\choose15,0,
						\choose16,0,

				)},

				{//15
					~harmonics_array[0..(~harmonic_count-1)]=0;~harmonics_array[14]=1;~manipulated_harmonic[0..15]=0;~manipulated_harmonic[14]=1;
					~fslider.valueAction_(~fslider.value); //This allows it to refresh real-time
				s.makeBundle(1.0, //sound delay
			{~dirtyBit = 5; ~dirtyBit.postln;~fslider.valueAction_(~fslider.value);});
			x.set(
						\choose1,0,
						\choose2,0,
						\choose3,0,
						\choose4,0,
						\choose5,0,
						\choose6,0,
						\choose7,0,
						\choose8,0,
						\choose9,0,
						\choose10,0,
						\choose11,0,
						\choose12,0,
						\choose13,0,
						\choose14,0,
						\choose15,1,
						\choose16,0,

				)},

				{//16
					~harmonics_array[0..(~harmonic_count-1)]=0;~harmonics_array[15]=1;~manipulated_harmonic[0..15]=0;~manipulated_harmonic[15]=1;
					~fslider.valueAction_(~fslider.value); //This allows it to refresh real-time
				s.makeBundle(1.0, //sound delay
			{~dirtyBit = 5; ~dirtyBit.postln;~fslider.valueAction_(~fslider.value);});
			x.set(
						\choose1,0,
						\choose2,0,
						\choose3,0,
						\choose4,0,
						\choose5,0,
						\choose6,0,
						\choose7,0,
						\choose8,0,
						\choose9,0,
						\choose10,0,
						\choose11,0,
						\choose12,0,
						\choose13,0,
						\choose14,0,
						\choose15,0,
						\choose16,1,

				)},

			];


 w.front;

 p = CmdPeriod.add({ b.value_(0) }); // set button to 0 on hitting Cmd-period
 w.onClose_{ snd.release; CmdPeriod.removeAll }; // clean up when window is closed

})



	);

	~coverComposite = CompositeView(w, Rect(160-80,235+60-30,330+80,30+30));
	~coverBox = StaticText(~coverComposite, Rect(0,0,330+80,30+30)).background_(Color.white).stringColor_(Color.black).align_(\center);
	~coverBox.string = "Select a harmonic to deviate from the
Harmonic (mistuned) dropdown menu";




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

)