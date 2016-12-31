// "2MC3 Tuning Demonstration"
//splashscreen = COMPLETED
//tonic frequency = COMPLETED

//Spectra - can the frequency axis be on the vertical axis (option to go back and forth)? = possibility using Pen, but requires different data collection: http://sccode.org/1-1HR
//Add axis if not possible =
//Dropdown menu for Focus tone (third/fourth/fifth/etc.)
///Number of harmonics active -> control the loops of harmonics
//Add an IF statement so that the harmonic desired to manipulate cannot be manipulated/added by the LOOP
//Variable: fade in rate

///2D slider for rate and delay (window of tolerance? thresholds?)
///Tone that moves come through a different - for science
///Move Slides OUT of Dropbox once all received = COMPLETE

(
s.waitForBoot({ //Ensures it only opens once the server is working completely, and automatically opens server

w = Window.new("MAPLE Lab Tuning Demonstration", Rect.new(
	Window.screenBounds.width/2-250,
	Window.screenBounds.height/2-50,
		500,670),false
	).background_(Color.white).userCanClose_(true).front; //Creates the new window with title

//Spectra viewer
f = FreqScopeView(w, Rect.new(-120,355,800,300)); //Prepares frequency scope (a.k.a. spectra)
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
.string_("Welcome to the MAPLE Lab Tuning Demonstration! Using the parameters below, you can examine the fusion effect. Select the sounds you want to play using the buttons below. Use the Play/Mute button to start and stop the sound. To explore how fusion/unfusion occurs, use the slider or numbers-box to change the frequency of the 3rd harmonic.")
.font_(Font("nil", 12))
.align_(\topLeft)
.background_(Color(0,0,0,0))
.stringColor_(Color.black);

i = Image.new("/Users/max/Documents/GitHub-Auditory-Exploration-Suite/mapleICON-small.png");

//Aesthetic lines
	w.drawFunc = {
		i.drawInRect(Rect(465,95,30,30), Rect(0,0,30,30), 2, 1.0); // only a section

		Pen.use{
		Pen.line(10@325,490@325); //Third line
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

	~fsliderharm3 = Slider(w, Rect(0,620,500,20))
	.background_(Color(0,0,0,0))
	.value_(0.56931407052427)
	.thumbSize_(0)
	.knobColor_(Color(1,1,1,0))
	.orientation_(\horizontal)
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


	StaticText(w,Rect(54,640,2,20))
	.background_(Color.white);

StaticText(w,Rect(0,620,500,2))
	.background_(Color.white);


	StaticText(w,Rect(10,622,500,33))
	.string_("Frequency")
	.stringColor_(Color.white)
	.background_(Color(0,0,0,0));





//Play sounds button
~button = Button(w, Rect(250-(200/2),95,200,30))
.states_([
	["Click to Play Sounds", Color.white,Color(0.7569,0.1373,0.1725,1)],
	["Click to Mute Sounds", Color.white, Color.grey(0.251)]
])
.font_(Font("nil", 18))
.action_({
	arg obj;
	if(obj.value == 1,
		{
			x = Synth.new(
				\sound,
				[
						\outoftune, ~freqslider.value.linlin(0,1,2,4),
						\intensity, ~mulslider.value.linlin(0,1,0.0,2),
						\other, ~otherslider.value.linlin(0,1,0.0,2),
						\freq, ~fslider.value.linexp(0,1,100,1000),
				]
			).register;
		},
		{x.free}
	);
});

	//TONIC FREQUENCY

//Label for Freq.
~fLabel = StaticText(w,Rect(15,140,65,30))
.string_("Tonic Frequency")
.font_(Font("nil", 12))
.align_(\topRight)
.background_(Color(0,0,0,0))
.stringColor_(Color.black);

//Properties of the slider
~fslider = Slider(w, Rect(160,140,330,30))
	.background_(Color(0.8,0.8,0.8,0.75)).value_(0.3802)
	.action_({
	arg obj;
	var cf;
	cf = obj.value.linexp(0,1,100,1000).postln;
		if(
		x.isPlaying,
		{x.set(\freq,cf)});
	~numberfBox.value_(obj.value.linexp(0,1,100,1000));
		~fsliderharm1.valueAction_(obj.value.linlin(0,1,(55/500),(325/500)));//must be linlin because a slider to slider is using the same exact values (no transformation required)
		~fsliderharm2.valueAction_(obj.value.linlin(0,1,(55/500+0.16),(325/500+0.16)));
				~fsliderharm3.valueAction_(obj.value.linlin(0,1,(55/500+0.254),(325/500+0.254)));
})
	.orientation_(\horizontal);


//Number box that can edit slider position
~numberfBox = NumberBox(w,Rect(85,140,72,30))
.value_(240)
.clipLo_(100)
.clipHi_(2000)
.font_(Font("nil",16))
.decimals_(1)
.align_(\center)
.action_({
	arg obj;
	~fslider.valueAction_(obj.value.explin(100,1000,0,1))
});



//Label for Focus tone
~para = StaticText(w,Rect(10,177,480,80))
	.string_("Focus tone (third harmonic)")
.font_(Font("nil", 18))
.align_(\topLeft)
.background_(Color(0,0,0,0))
.stringColor_(Color.black);

//Label for Other tones
~para = StaticText(w,Rect(10,270,480,80))
	.string_("Other tones")
.font_(Font("nil", 18))
.align_(\topLeft)
.background_(Color(0,0,0,0))
.stringColor_(Color.black);

//Label for Spectra
~para = StaticText(w,Rect(10,332,480,80))
	.string_("Spectra")
.font_(Font("nil", 18))
.align_(\topLeft)
.background_(Color(0,0,0,0))
.stringColor_(Color.black);

//Define the sound to be played
(
SynthDef.new("sound", {
	arg freq = 240, outoftune = 3, intensity = 1, other = 1, vol = 1;
	var mul, mul2, signal;

	mul = XLine.kr(0.01,1,0.2,0.1); //Ramps sound onset so not so harsh
			mul2 = XLine.kr(0.01,1,0.2,0.1); //Ramps sound onset so not so harsh


	signal =
	SinOsc.ar(freq, 0, mul*other) +
	SinOsc.ar(freq*2, 0, mul*other) +
	SinOsc.ar(freq*outoftune, 0, mul2*intensity) + //the third harmonic can be varied 720-778, using Dr. Steven Brown's 2MP3 2015-2016 class; while estimation that critical bandwidth at this frequency is approximately 150, so 150/4 = 37.5, and 720+37.5 =757.5 and derivation of the two-tone dissonance formula from Plomp 1965 gives g_max = 1.01931f + 17.4672 = 751.3704, this does not necessarily mean it gives the most 'unfused' effect for students
	SinOsc.ar(freq*4, 0, mul*other*vol) +
	SinOsc.ar(freq*5, 0, mul*other*vol) +
	SinOsc.ar(freq*6, 0, mul*other*vol) +
	SinOsc.ar(freq*7, 0, mul*other*vol) +
	SinOsc.ar(freq*8, 0, mul*other*vol) +
	SinOsc.ar(freq*9, 0, mul*other*vol) +
	SinOsc.ar(freq*10, 0, mul*other*vol) +
	SinOsc.ar(freq*11, 0, mul*other*vol) +
	SinOsc.ar(freq*12, 0, mul*other*vol) +
	SinOsc.ar(freq*13, 0, mul*other*vol) +
	SinOsc.ar(freq*14, 0, mul*other*vol) +
	SinOsc.ar(freq*15, 0, mul*other*vol) +
	SinOsc.ar(freq*16, 0, mul*other*vol)
	;

	Out.ar([0,1], signal); //sends to busses 1 & 2 (stereo), and plays the var "signal"
}).add;
);


//FREQUENCY of 3rd harmonic
//Properties of the slider
~freqslider = Slider(w, Rect(160,200,330,30))
.background_(Color(0.8,0.8,0.8,0.75))
.value_(0.5)
.action_({
	arg obj;
	var cf;
	cf = obj.value.linlin(0,1,2,4).postln;
		if(
		x.isPlaying,
		{x.set(\outoftune,cf)});
	~numberBox.value_(obj.value.linlin(0,1,2,4));
});

//Label for Freq.
~freqLabel = StaticText(w,Rect(15,200,65,40))
.string_("Tonic Multiple")
.font_(Font("nil", 12))
.align_(\topRight)
.background_(Color(0,0,0,0))
.stringColor_(Color.black);

//Number box that can edit slider position
~numberBox = NumberBox(w,Rect(85,200,72,30))
.value_(3)
.clipLo_(2)
.clipHi_(4)
.font_(Font("nil",16))
.decimals_(2)
.align_(\center)
.action_({
	arg obj;
	~freqslider.valueAction_(obj.value.linlin(2,4,0,1))
});

//INTENSITY of 3rd harmonic
//Properties of the slider
~mulslider = Slider(w, Rect(160,235,330,30))
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
});

//Label for Freq.
~mulLabel = StaticText(w,Rect(15,240,65,40))
.string_("Intensity")
.font_(Font("nil", 12))
.align_(\topRight)
.background_(Color(0,0,0,0))
.stringColor_(Color.black);

//Number box that can edit slider position
~number2Box = NumberBox(w,Rect(85,235,72,30))
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
~otherslider = Slider(w, Rect(160,290,330,30))
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
~otherLabel = StaticText(w,Rect(15,300,65,40))
.string_("Intensity")
.font_(Font("nil", 12))
.align_(\topRight)
.background_(Color(0,0,0,0))
.stringColor_(Color.black);

//Number box that can edit slider position
~number3Box = NumberBox(w,Rect(85,290,72,30))
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



	~quit = Button.new(w, Rect((400), 100, 60, 20))
	.states_([["Go Back", Color.white, Color(0.2510,0.2510,0.2510,1)]])
	.font_(Font("nil", 12))
	.mouseDownAction_({w.close; f.kill; //shuts down window and scope
		"/Users/max/Documents/GitHub-Auditory-Exploration-Suite/splashscreen.scd".loadPaths;
		});



w.onClose_({s.quit}); //ends server when quit
});
)