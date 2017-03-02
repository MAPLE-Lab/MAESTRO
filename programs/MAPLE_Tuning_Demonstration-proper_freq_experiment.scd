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
f = FreqScopeView(~composite, Rect.new(0,0,600,300)); //Prepares frequency scope (a.k.a. spectra) from (-120,355,800,300) to (-100,355,600,300)) - for harmonic marker transformation maths
f.active_(true).freqMode_(1).dbRange_(70);


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
	cf = obj.value.linlin(0,1,0,1).postln;
		if(
		x.isPlaying,
		{x.set(\vol,cf)});
	~numberVBox.value_(obj.value.linlin(0,1,0,1));

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
	~volslider.valueAction_(obj.value.linlin(0,1,0,1))
});

	//TONIC FREQUENCY

//Label for Freq.
~fLabel = StaticText(w,Rect(10,158,80,25))
.string_("Fundamental")
.font_(Font("nil", 8))
.align_(\topLeft)
.background_(Color(0,0,0,0))
.stringColor_(Color.black);

//Properties of the slider
~fslider = Slider(w, Rect(160,155,330,15))
	.background_(Color(0.8,0.8,0.8,0.75)).value_(0)
	.step_(1/35) //Math of linexp: y=100e^(kx)
	//y1(1)=1000=y3(1) and y2(0)=100=y3(0) and y3=100e^(kx) what is k?
	//hence: ln(y3/100)/x = k -->ln(1000/100)/1 = k = 2.3025 (using y2 makes no sense but should...)
	//--> k = ln(10) EXACTLY
	//new is k=ln(8)
	.action_({
	arg obj;
	var cf;
	cf = obj.value.linlin(0,1,40,75).postln;
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

/*	C4	*/	(if(obj.value.linlin(0,1,40,75) == 	40	, {~	c4	.background_(Color.red);	~note_name.string_("C4");	}, {~	c4	.background_(Color.white)}););
/*	D4	*/	(if(obj.value.linlin(0,1,40,75) == 	42	, {~	d4	.background_(Color.red);	~note_name.string_("D4");	}, {~	d4	.background_(Color.white)}););
/*	E4	*/	(if(obj.value.linlin(0,1,40,75) == 	44	, {~	e4	.background_(Color.red);	~note_name.string_("E4");	}, {~	e4	.background_(Color.white)}););
/*	F4	*/	(if(obj.value.linlin(0,1,40,75) == 	45	, {~	f4	.background_(Color.red);	~note_name.string_("F4");	}, {~	f4	.background_(Color.white)}););
/*	G4	*/	(if(obj.value.linlin(0,1,40,75) == 	47	, {~	g4	.background_(Color.red);	~note_name.string_("G4");	}, {~	g4	.background_(Color.white)}););
/*	A4	*/	(if(obj.value.linlin(0,1,40,75) == 	49	, {~	a4	.background_(Color.red);	~note_name.string_("A4");	}, {~	a4	.background_(Color.white)}););
/*	B4	*/	(if(obj.value.linlin(0,1,40,75) == 	51	, {~	b4	.background_(Color.red);	~note_name.string_("B4");	}, {~	b4	.background_(Color.white)}););
/*	C5	*/	(if(obj.value.linlin(0,1,40,75) == 	52	, {~	c5	.background_(Color.red);	~note_name.string_("C5");	}, {~	c5	.background_(Color.white)}););
/*	D5	*/	(if(obj.value.linlin(0,1,40,75) == 	54	, {~	d5	.background_(Color.red);	~note_name.string_("D5");	}, {~	d5	.background_(Color.white)}););
/*	E5	*/	(if(obj.value.linlin(0,1,40,75) == 	56	, {~	e5	.background_(Color.red);	~note_name.string_("E5");	}, {~	e5	.background_(Color.white)}););
/*	F5	*/	(if(obj.value.linlin(0,1,40,75) == 	57	, {~	f5	.background_(Color.red);	~note_name.string_("F5");	}, {~	f5	.background_(Color.white)}););
/*	G5	*/	(if(obj.value.linlin(0,1,40,75) == 	59	, {~	g5	.background_(Color.red);	~note_name.string_("G5");	}, {~	g5	.background_(Color.white)}););
/*	A5	*/	(if(obj.value.linlin(0,1,40,75) == 	61	, {~	a5	.background_(Color.red);	~note_name.string_("A5");	}, {~	a5	.background_(Color.white)}););
/*	B5	*/	(if(obj.value.linlin(0,1,40,75) == 	63	, {~	b5	.background_(Color.red);	~note_name.string_("B5");	}, {~	b5	.background_(Color.white)}););
/*	C6	*/	(if(obj.value.linlin(0,1,40,75) == 	64	, {~	c6	.background_(Color.red);	~note_name.string_("C6");	}, {~	c6	.background_(Color.white)}););
/*	D6	*/	(if(obj.value.linlin(0,1,40,75) == 	66	, {~	d6	.background_(Color.red);	~note_name.string_("D6");	}, {~	d6	.background_(Color.white)}););
/*	E6	*/	(if(obj.value.linlin(0,1,40,75) == 	68	, {~	e6	.background_(Color.red);	~note_name.string_("E6");	}, {~	e6	.background_(Color.white)}););
/*	F6	*/	(if(obj.value.linlin(0,1,40,75) == 	69	, {~	f6	.background_(Color.red);	~note_name.string_("F6");	}, {~	f6	.background_(Color.white)}););
/*	G6	*/	(if(obj.value.linlin(0,1,40,75) == 	71	, {~	g6	.background_(Color.red);	~note_name.string_("G6");	}, {~	g6	.background_(Color.white)}););
/*	A6	*/	(if(obj.value.linlin(0,1,40,75) == 	73	, {~	a6	.background_(Color.red);	~note_name.string_("A6");	}, {~	a6	.background_(Color.white)}););
/*	B6	*/	(if(obj.value.linlin(0,1,40,75) == 	75	, {~	b6	.background_(Color.red);	~note_name.string_("B6");	}, {~	b6	.background_(Color.white)}););

/*	CSHARP4	*/	(if(obj.value.linlin(0,1,40,75) == 	41	, {	~cSHARP4.background_(Color.red);		~note_name.string_("C#4");	}, {~	cSHARP4	.background_(Color.black)}););
/*	DSHARP4	*/	(if(obj.value.linlin(0,1,40,75) == 	43	, {	~dSHARP4.background_(Color.red);		~note_name.string_("D#4");	}, {~	dSHARP4	.background_(Color.black)}););
/*	FSHARP4	*/	(if(obj.value.linlin(0,1,40,75) == 	46	, {	~fSHARP4.background_(Color.red);		~note_name.string_("F#4");	}, {~	fSHARP4	.background_(Color.black)}););
/*	GSHARP4	*/	(if(obj.value.linlin(0,1,40,75) == 	48	, {	~gSHARP4.background_(Color.red);		~note_name.string_("G#4");	}, {~	gSHARP4	.background_(Color.black)}););
/*	ASHARP4	*/	(if(obj.value.linlin(0,1,40,75) == 	50	, {	~aSHARP4.background_(Color.red);		~note_name.string_("A#4");	}, {~	aSHARP4	.background_(Color.black)}););
/*	CSHARP5	*/	(if(obj.value.linlin(0,1,40,75) == 	53	, {	~cSHARP5.background_(Color.red);		~note_name.string_("C#5");	}, {~	cSHARP5	.background_(Color.black)}););
/*	DSHARP5	*/	(if(obj.value.linlin(0,1,40,75) == 	55	, {	~dSHARP5.background_(Color.red);		~note_name.string_("D#5");	}, {~	dSHARP5	.background_(Color.black)}););
/*	FSHARP5	*/	(if(obj.value.linlin(0,1,40,75) == 	58	, {	~fSHARP5.background_(Color.red);		~note_name.string_("F#5");	}, {~	fSHARP5	.background_(Color.black)}););
/*	GSHARP5	*/	(if(obj.value.linlin(0,1,40,75) == 	60	, {	~gSHARP5.background_(Color.red);		~note_name.string_("G#5");	}, {~	gSHARP5	.background_(Color.black)}););
/*	ASHARP5	*/	(if(obj.value.linlin(0,1,40,75) == 	62	, {	~aSHARP5.background_(Color.red);		~note_name.string_("A#5");	}, {~	aSHARP5	.background_(Color.black)}););
/*	CSHARP6	*/	(if(obj.value.linlin(0,1,40,75) == 	65	, {	~cSHARP6.background_(Color.red);		~note_name.string_("C#6");	}, {~	cSHARP6	.background_(Color.black)}););
/*	DSHARP6	*/	(if(obj.value.linlin(0,1,40,75) == 	67	, {	~dSHARP6.background_(Color.red);		~note_name.string_("D#6");	}, {~	dSHARP6	.background_(Color.black)}););
/*	FSHARP6	*/	(if(obj.value.linlin(0,1,40,75) == 	70	, {	~fSHARP6.background_(Color.red);		~note_name.string_("F#6");	}, {~	fSHARP6	.background_(Color.black)}););
/*	GSHARP6	*/	(if(obj.value.linlin(0,1,40,75) == 	72	, {	~gSHARP6.background_(Color.red);		~note_name.string_("G#6");	}, {~	gSHARP6	.background_(Color.black)}););
/*	ASHARP6	*/	(if(obj.value.linlin(0,1,40,75) == 	74	, {	~aSHARP6.background_(Color.red);		~note_name.string_("A#6");	}, {~	aSHARP6	.background_(Color.black)}););


		if(
		x.isPlaying,
		{x.set(\freqX,cf)});
	~numberfBox.value_(obj.value.linlin(0,1,40,75));
	/*	~fsliderharm1.valueAction_(obj.value.linlin(0,1,(55/500),(325/500)));//must be linlin because a slider to slider is using the same exact values (no transformation required)
		~fsliderharm2.valueAction_(obj.value.linlin(0,1,(55/500+0.16),(325/500+0.16)));
				~fsliderharm3.valueAction_(obj.value.linlin(0,1,(55/500+0.254),(325/500+0.254)));
		*/
})
	.orientation_(\horizontal);

//Number box that can edit slider position
~numberfBox = NumberBox(w,Rect(85,155,72,15))
.value_(40)
.clipLo_(40)
.clipHi_(75)
.font_(Font("nil",12))
.decimals_(0)
.align_(\center)
.action_({
	arg obj;
	~fslider.valueAction_(obj.value.linlin(40,75,0,1))
});

//True note value
	~note_name = StaticText(w,Rect(85-23,155,72,15))
	.string_("C4")
	.font_(Font("nil", 12));




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
	arg freqX = 40, outoftune = 0, intensity = 1, other = 1, vol = 0.3, harmToggle1=1, harmToggle2=1, harmToggle3=1, harmToggle4=1, harmToggle5=1, harmToggle6=1, harmToggle7=1, harmToggle8=1, harmToggle9=1, harmToggle10=1, harmToggle11=1, harmToggle12=1, harmToggle13=1, harmToggle14=1, harmToggle15=1, harmToggle16=1,
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
			freq = ((2**((-49+freqX)/12))*440);

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

//Keyboard MIDI notation image button
		~midi_table = Button.new(w, Rect(10, 100, 20, 20))
	.states_([["#", Color.white, Color.gray]])
	.font_(Font("nil", 10))
	.mouseDownAction_({

				(basePath +/+  "modules/keyboard_image.scd").loadPaths; //This line allows all contact buttons to be updated automatically
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
		},{

~keyboard.close;
					// ~keyboard_open = 1;
		};);

		});


	///SPECTRA BUTTON
	//Add swapables for the pen lines to switch the frequency views

	~spectraButton = Button(w, Rect(250-(200/2)-65,200+135,110,20))
.states_([
		["Log View
(Click to Switch to Linear)", Color.white,Color(0.4824, 0.4863, 0.4863,1)]
		,["Linear View
(Click to Switch to Log)", Color.white,Color(0.4824, 0.4863, 0.4863,1)]]

)
.font_(Font("nil", 8))
.action_(


				{

					arg obj;
	if(obj.value == 1,
						{


					f.freqMode_(0);
					~composite.bounds_(Rect(0,355,600,300));
					p.visible = false;

					// f.set(\bounds, Rect.new(100,100,600,300));
					// f.bounds_(Rect(100, 0, 300, 300);

						},{f.freqMode_(1); ~composite.bounds_(Rect(-100,355,600,300));}
			)});






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


						},{x.free; ~fslider.valueAction_(0.value.linlin(40,75,0,1));}
			)})
  .action_({ arg mod;
/*~menu2.allowsReselection;
				~menu2.value_(0);
				~menu2.valueAction_(0);*/
    snd.release;
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

snd = funcs2.at(menu.value).play;
			};

 funcs2 = [

				{
			x = Synth(
				\sound,
				[
						\outoftune, ~freqslider.value.linlin(0,1,-1,1),
						\intensity, ~mulslider.value.linlin(0,1,0.0,2),
						\other, ~otherslider.value.linlin(0,1,0.0,2),
						\freq, ~fslider.value.linexp(0,1,100,1000),
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
					~menu2.valueAction_([menu.value]);},
{
			x = Synth(
				\sound,
				[
						\outoftune, ~freqslider.value.linlin(0,1,-1,1),
						\intensity, ~mulslider.value.linlin(0,1,0.0,2),
						\other, ~otherslider.value.linlin(0,1,0.0,2),
						\freq, ~fslider.value.linexp(0,1,100,1000),
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
					~menu2.valueAction_([menu.value]);},
				{
			x = Synth(
				\sound,
				[
						\outoftune, ~freqslider.value.linlin(0,1,-1,1),
						\intensity, ~mulslider.value.linlin(0,1,0.0,2),
						\other, ~otherslider.value.linlin(0,1,0.0,2),
						\freq, ~fslider.value.linexp(0,1,100,1000),
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
{
					x.free;

			x = Synth(
				\sound,
				[
						\outoftune, ~freqslider.value.linlin(0,1,-1,1),
						\intensity, ~mulslider.value.linlin(0,1,0.0,2),
						\other, ~otherslider.value.linlin(0,1,0.0,2),
						\freq, ~fslider.value.linexp(0,1,100,1000),
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
				{
					x.free;

			x = Synth(
				\sound,
				[
						\outoftune, ~freqslider.value.linlin(0,1,-1,1),
						\intensity, ~mulslider.value.linlin(0,1,0.0,2),
						\other, ~otherslider.value.linlin(0,1,0.0,2),
						\freq, ~fslider.value.linexp(0,1,100,1000),
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
				{
					x.free;

			x = Synth(
				\sound,
				[
						\outoftune, ~freqslider.value.linlin(0,1,-1,1),
						\intensity, ~mulslider.value.linlin(0,1,0.0,2),
						\other, ~otherslider.value.linlin(0,1,0.0,2),
						\freq, ~fslider.value.linexp(0,1,100,1000),
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
snd = funcs2.at(menu2.value).play;

				// x.set(menu.action);

			};

 funcs2 = [

				{//None
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

				)},

				{//1
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


~quit = Button.new(w, Rect(465,95,30,30))
	.states_([["", Color.white, Color.clear]])
	.font_(Font("nil", 12))
	.mouseDownAction_({w.close; f.kill; x.free; //shuts down window and scope
		(basePath +/+ "splashscreen.scd").loadPaths;
		});


	/*~quit = Button.new(w, Rect((400), 100, 60, 20))
	.states_([["Home", Color.white, Color(0.2510,0.2510,0.2510,1)]])
	.font_(Font("nil", 12))
	.mouseDownAction_({w.close; f.kill; x.free; //shuts down window and scope
		(basePath +/+ "splashscreen.scd").loadPaths;
		});*/


w.onClose_({s.quit; x.free}); //ends server when quit
});

)