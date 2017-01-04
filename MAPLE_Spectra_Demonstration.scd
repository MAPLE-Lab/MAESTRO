// "2MC3 Spectra Demonstration"

//Under harmonics, give frequencies of each harmonic underneath the intensity value box = COMPLETE
//Go up to harmonic 16 = COMPLETE
//Import and analyze sound? See how that spectrogram did it...
///Dr. Ballora recommends PVOC (may need extension/quark)
//Still need a way to analyze the harmonics for their time-varying values
//Fix memory spectra allocation = COMPLETE(?)
////From error messages it is clear it is a Node tree allocation problem - just later add proper allocations at the start of the program
//Remove artifact --> have it free at end.. doneAction? or cheap box // BOXED TRIM = COMPLETE
////But still issue present in Oscilloscope - so needs a true solution (because additively negative) = COMPLETE, the audio must go to 0 at end or else artifact
//Add OSC Delay for x.free for preset activations = if necessary?
//Add oscilloscope button = COMPLETE

//For GraphClick, set 0db = 100u, -96=0u
//Add ticks at the bottom / overtone lines that work with the tonic frequency =
///See Amadeus (in the lab licenses)
///See DropBox files with videos - use GraphClick to take from those
//Tuning fork, Trumpet, Flute, Horn

(
Window.closeAll;
a.free; //clear buffers to help resolve memory leak
		b.free;
		e.free;
s.waitForBoot({ //Ensures it only opens once the server is working completely, and automatically opens server
	w = Window.new("MAPLE Lab Spectra Demonstration", Rect.new(
	Window.screenBounds.width/2-400,
	Window.screenBounds.height/2-50,
		800,530),false).background_(Color.white).userCanClose_(true).front;//Creates the new window with title
	// w.view.background = Color(0.9,0.9,0.9,1);

//Spectra viewer
h = FreqScopeView.new(w, Rect.new(320,105,500,300)); //Prepares frequency scope (a.k.a. spectra)
h.active_(true).freqMode_(1).dbRange_(70);



//Label for paragraph
~para = StaticText(w,Rect(10,10,790,80))
.string_("Welcome to the MAPLE Lab Spectra Demonstration! Using the parameters below, you can examine timbre of sounds. Select the tonic frequency and the intensity of each harmonic. Use the Play/Mute button to start and stop the sound. To explore how forced choice spectra are not representative of real instruments, try playing a moving spectra sound.")
.font_(Font("nil", 12))
.align_(\topLeft)
.background_(Color(0,0,0,0))
.stringColor_(Color.black);


//Left cheap box
StaticText(w,Rect(0,105,410,300))
.background_(Color.white);

//Right cheap box
StaticText(w,Rect(790,105,410,300))
.background_(Color.white);

	//Harmonics cheap box
StaticText(w,Rect(10,105,380,25))
.background_(Color(0,0,0,0.0));



//Axes

	//Harmonic positions marker

	~fsliderharm3 = Slider(w, Rect(410,360,380,20))
	.background_(Color(0,0,0,0))
	.value_(0.43121693121693)
	.thumbSize_(0)
	.knobColor_(Color(1,1,1,0))
	.orientation_(\horizontal)
	.action_({
	arg obj;
	var cf;
		// cf = obj.value.linlin(0,1,0,1).postln;
	});

		~fsliderharm2 = Slider(w, Rect(410,360,380,20))
	.background_(Color(0,0,0,0))
	.value_(0.35185185185185)
	.thumbSize_(0)
	.knobColor_(Color(1,1,1,0)) //QGUI does not handle transparent sliders yet http://new-supercollider-mailing-lists-forums-use-these.2681727.n2.nabble.com/QSlider-background-alpha-0-0-not-transparent-td7590743.html
	.orientation_(\horizontal)
	.action_({
	arg obj;
	var cf;
		// cf = obj.value.linlin(0,1,0,1).postln;
	});

	~fsliderharm1 = Slider(w, Rect(410,360,380,20))
	.background_(Color(0,0,0,0))
	.value_(0.22222222222222)
	.thumbSize_(0)
	.knobColor_(Color(1,1,1,0))
	.orientation_(\horizontal)
	.action_({
	arg obj;
	var cf;
		// cf = obj.value.linlin(0,1,0,1).postln;
	});


	StaticText(w,Rect(430,380,2,20))
	.background_(Color.white);

StaticText(w,Rect(410,360,500,2))
	.background_(Color.white);

	// StaticText(w,Rect(0,622,500,33))
	// .background_(Color(0,0,0,0.8)); //old dark bottom cover

	StaticText(w,Rect(420,380,500,33))
	.string_("Frequency")
	.align_(\topLeft)
	.stringColor_(Color.white)
	.background_(Color(0,0,0,0));


//Play Forced sounds button
~button = Button(w, Rect(400-(330/2),65,330,30))
.states_([
	["Click to Play Forced Choice Sounds", Color.white,Color(0.7569,0.1373,0.1725,1)],
	["Click to Mute Forced Choice Sounds", Color.white, Color.grey(0.251)]
])
.font_(Font("nil", 18))
.action_({
	arg obj;
	if(obj.value == 1,
		{
			x = Synth.new(
				\sound,
				[
						\freq, ~freqslider.value.linexp(0,1,100,1000),
						\vol, ~volslider.value.linlin(0,1,0,1),
						\f1, ~f1slider.value.linlin(0,1,0.0,2),
						\f2, ~f2slider.value.linlin(0,1,0.0,2),
						\f3, ~f3slider.value.linlin(0,1,0.0,2),
						\f4, ~f4slider.value.linlin(0,1,0.0,2),
						\f5, ~f5slider.value.linlin(0,1,0.0,2),
						\f6, ~f6slider.value.linlin(0,1,0.0,2),
						\f7, ~f7slider.value.linlin(0,1,0.0,2),
						\f8, ~f8slider.value.linlin(0,1,0.0,2),
						\f9, ~f9slider.value.linlin(0,1,0.0,2),
						\f10, ~f10slider.value.linlin(0,1,0.0,2),
						\f11, ~f11slider.value.linlin(0,1,0.0,2),
						\f12, ~f12slider.value.linlin(0,1,0.0,2),
						\f13, ~f13slider.value.linlin(0,1,0.0,2),
						\f14, ~f14slider.value.linlin(0,1,0.0,2),
						\f15, ~f15slider.value.linlin(0,1,0.0,2),
						\f16, ~f16slider.value.linlin(0,1,0.0,2),

				]
			).register;
				y.free;
				z.free;
				v.free;
		},
		{x.free}
	);
});


	//Label for Forced Choice
~para = StaticText(w,Rect(10,420,380,20))
	.string_("Power Spectra")
.font_(Font("nil", 18))
.align_(\topLeft)
.background_(Color(0,0,0,0))
.stringColor_(Color.black);

//Dropdown menus
//Preset
	(
s.waitForBoot({

 var menu, snd, funcs2, b;


 ~vinbutton = Button(w, Rect(630, 417.5, 160, 25))
  .states_([["            Click to Play", Color.white, Color.gray]])
  .mouseDownAction_({
    snd = funcs2.at(menu.value).play;
   })
  .action_({ arg mod;
    snd.release;
   });

menu = PopUpMenu(w, Rect(632.5, 420, 50, 20));
  menu.items_(["Sine", "Saw"]);
			menu.font_(Font(\size, 10));


 funcs2 = [
				{
		var variable;
		variable = SinOsc.kr(2); //unfortunately the QtGUI cannot use variables in this slider (error message)
		~freqslider.valueAction_(440.value.explin(100,1000,0,1)); //only need to affect slider to affect the number box and true sound value
		~volslider.valueAction_(1.value.linlin(0,1,0,1));
		~f1slider.valueAction_(2.value.linlin(0.0,2,0,1));
		~f2slider.valueAction_(0.value.linlin(0.0,2,0,1));
		~f3slider.valueAction_(0.value.linlin(0.0,2,0,1));
		~f4slider.valueAction_(0.value.linlin(0.0,2,0,1));
		~f5slider.valueAction_(0.value.linlin(0.0,2,0,1));
		~f6slider.valueAction_(0.value.linlin(0.0,2,0,1));
		~f7slider.valueAction_(0.value.linlin(0.0,2,0,1));
		~f8slider.valueAction_(0.value.linlin(0.0,2,0,1));
		~f9slider.valueAction_(0.value.linlin(0.0,2,0,1));
		~f10slider.valueAction_(0.value.linlin(0.0,2,0,1));
		~f11slider.valueAction_(0.value.linlin(0.0,2,0,1));
		~f12slider.valueAction_(0.value.linlin(0.0,2,0,1));
		~f13slider.valueAction_(0.value.linlin(0.0,2,0,1));
		~f14slider.valueAction_(0.value.linlin(0.0,2,0,1));
		~f15slider.valueAction_(0.value.linlin(0.0,2,0,1));
		~f16slider.valueAction_(0.value.linlin(0.0,2,0,1));
		x.free; ///NEED TO ADD OSC DELAY
		~button.valueAction_(1);
	},
{
		var variable;
		variable = SinOsc.kr(2); //unfortunately the QtGUI cannot use variables in this slider (error message)
		~freqslider.valueAction_(440.value.explin(100,1000,0,1)); //only need to affect slider to affect the number box and true sound value
		~volslider.valueAction_(0.8.value.linlin(0,1,0,1));
		~f1slider.valueAction_(2.value.linlin(0.0,2,0,1));
		~f2slider.valueAction_(1.value.linlin(0.0,2,0,1));
		~f3slider.valueAction_(0.5.value.linlin(0.0,2,0,1));
		~f4slider.valueAction_(0.25.value.linlin(0.0,2,0,1));
		~f5slider.valueAction_(0.125.value.linlin(0.0,2,0,1));
		~f6slider.valueAction_(0.07.value.linlin(0.0,2,0,1));
		~f7slider.valueAction_(0.05.value.linlin(0.0,2,0,1));
		~f8slider.valueAction_(0.03.value.linlin(0.0,2,0,1));
		~f9slider.valueAction_(0.02.value.linlin(0.0,2,0,1));
		~f10slider.valueAction_(0.01.value.linlin(0.0,2,0,1));
		~f11slider.valueAction_(0.value.linlin(0.0,2,0,1));
		~f12slider.valueAction_(0.value.linlin(0.0,2,0,1));
		~f13slider.valueAction_(0.value.linlin(0.0,2,0,1));
		~f14slider.valueAction_(0.value.linlin(0.0,2,0,1));
		~f15slider.valueAction_(0.value.linlin(0.0,2,0,1));
		~f16slider.valueAction_(0.value.linlin(0.0,2,0,1));
		x.free; ///NEED TO ADD OSC DELAY
		~button.valueAction_(1);
	}

 ];


 w.front;

 p = CmdPeriod.add({ b.value_(0) }); // set button to 0 on hitting Cmd-period
 w.onClose_{ snd.release; CmdPeriod.removeAll }; // clean up when window is closed

})
	);


	//Play synthesized true
	(
s.waitForBoot({

 var menu, snd, funcs, b;


 ~playbutton = Button(w, Rect(630, 497.5, 160, 25))
  .states_([["            Hold to Play", Color.white, Color.gray]])
  .mouseDownAction_({
    snd = funcs.at(menu.value).play;

	~button.valueAction_(0);
			})
  .action_({ arg mod;
    snd.release;
   });

menu = PopUpMenu(w, Rect(632.5, 500, 50, 20));
  menu.items_(["Sine", "Saw"]);
			menu.font_(Font(\size, 10));


 funcs = [
				{ Pan2.ar(SinOsc.ar(440, 0, 0.3),0);
				},
				{ Pan2.ar(Saw.ar(440, 0.3),0);}
 ];


 w.front;

 p = CmdPeriod.add({ b.value_(0) }); // set button to 0 on hitting Cmd-period
 w.onClose_{ snd.release; CmdPeriod.removeAll }; // clean up when window is closed

})
	);


//FORCED tuning fork preset
j = Button(w, Rect(240, 417.5, 90, 26))
	.states_([["Tuning Fork", Color.white, Color(0,0,0,0.5)]])
	.font_(Font("nil", 14))
	.mouseDownAction_({
		var variable;
		variable = SinOsc.kr(2); //unfortunately the QtGUI cannot use variables in this slider (error message)
		~freqslider.valueAction_(440.value.explin(100,1000,0,1)); //only need to affect slider to affect the number box and true sound value
		~volslider.valueAction_(1.value.linlin(0,1,0,1));
		~f1slider.valueAction_(1.value.linlin(0.0,2,0,1));
		~f2slider.valueAction_(0.02.value.linlin(0.0,2,0,1));
		~f3slider.valueAction_(0.02.value.linlin(0.0,2,0,1));
		~f4slider.valueAction_(0.00.value.linlin(0.0,2,0,1));
		~f5slider.valueAction_(0.value.linlin(0.0,2,0,1));
		~f6slider.valueAction_(0.value.linlin(0.0,2,0,1));
		~f7slider.valueAction_(0.value.linlin(0.0,2,0,1));
		~f8slider.valueAction_(0.value.linlin(0.0,2,0,1));
		~f9slider.valueAction_(0.value.linlin(0.0,2,0,1));
		~f10slider.valueAction_(0.value.linlin(0.0,2,0,1));
		~f11slider.valueAction_(0.value.linlin(0.0,2,0,1));
		~f12slider.valueAction_(0.value.linlin(0.0,2,0,1));
		~f13slider.valueAction_(0.value.linlin(0.0,2,0,1));
		~f14slider.valueAction_(0.value.linlin(0.0,2,0,1));
		~f15slider.valueAction_(0.value.linlin(0.0,2,0,1));
		~f16slider.valueAction_(0.value.linlin(0.0,2,0,1));
		x.free; ///requires OSC delay?
		~button.valueAction_(1);
	});

	//FORCED flute preset
l = Button(w, Rect(335, 417.5, 90, 26))
	.states_([["Trumpet", Color.white, Color(0,0,0,0.5)]])
	.font_(Font("nil", 14))
	.mouseDownAction_({
		var variable;
		variable = SinOsc.kr(2); //unfortunately the QtGUI cannot use variables in this slider (error message)
		~freqslider.valueAction_(440.value.explin(100,1000,0,1)); //only need to affect slider to affect the number box and true sound value
				~volslider.valueAction_(1.value.linlin(0,1,0,1));
		~f1slider.valueAction_(1.value.linlin(0.0,2,0,1));
		~f2slider.valueAction_(0.01.value.linlin(0.0,2,0,1));
		~f3slider.valueAction_(0.221.value.linlin(0.0,2,0,1));
		~f4slider.valueAction_(0.125.value.linlin(0.0,2,0,1));
		~f5slider.valueAction_(0.202.value.linlin(0.0,2,0,1));
		~f6slider.valueAction_(0.048.value.linlin(0.0,2,0,1));
		~f7slider.valueAction_(0.077.value.linlin(0.0,2,0,1));
		~f8slider.valueAction_(0.231.value.linlin(0.0,2,0,1));
		~f9slider.valueAction_(0.077.value.linlin(0.0,2,0,1));
		~f10slider.valueAction_(0.154.value.linlin(0.0,2,0,1));
		~f11slider.valueAction_(0.value.linlin(0.0,2,0,1));
		~f12slider.valueAction_(0.value.linlin(0.0,2,0,1));
		~f13slider.valueAction_(0.value.linlin(0.0,2,0,1));
		~f14slider.valueAction_(0.value.linlin(0.0,2,0,1));
		~f15slider.valueAction_(0.value.linlin(0.0,2,0,1));
		~f16slider.valueAction_(0.value.linlin(0.0,2,0,1));
		x.free;
		~button.valueAction_(1);
	});


//FORCED trumpet preset
k = Button(w, Rect(430, 417.5, 90, 26))
	.states_([["Flute", Color.white, Color(0,0,0,0.5)]])
	.font_(Font("nil", 14))
	.mouseDownAction_({
		var variable;
		variable = SinOsc.kr(2); //unfortunately the QtGUI cannot use variables in this slider (error message)
		~freqslider.valueAction_(440.value.explin(100,1000,0,1)); //only need to affect slider to affect the number box and true sound value
				~volslider.valueAction_(1.value.linlin(0,1,0,1));
		~f1slider.valueAction_(1.value.linlin(0.0,2,0,1));
		~f2slider.valueAction_(1.24.value.linlin(0.0,2,0,1));
		~f3slider.valueAction_(0.74.value.linlin(0.0,2,0,1));
		~f4slider.valueAction_(0.163.value.linlin(0.0,2,0,1));
		~f5slider.valueAction_(0.231.value.linlin(0.0,2,0,1));
		~f6slider.valueAction_(0.106.value.linlin(0.0,2,0,1));
		~f7slider.valueAction_(0.058.value.linlin(0.0,2,0,1));
		~f8slider.valueAction_(0.077.value.linlin(0.0,2,0,1));
		~f9slider.valueAction_(0.096.value.linlin(0.0,2,0,1));
		~f10slider.valueAction_(0.019.value.linlin(0.0,2,0,1));
		~f11slider.valueAction_(0.019.value.linlin(0.0,2,0,1));
		~f12slider.valueAction_(0.019.value.linlin(0.0,2,0,1));
		~f13slider.valueAction_(0.019.value.linlin(0.0,2,0,1));
		~f14slider.valueAction_(0.019.value.linlin(0.0,2,0,1));
		~f15slider.valueAction_(0.019.value.linlin(0.0,2,0,1));
		~f16slider.valueAction_(0.019.value.linlin(0.0,2,0,1));
		x.free;
	~button.valueAction_(1);
	});

	//FORCED trumpet preset
r = Button(w, Rect(525, 417.5, 90, 26))
	.states_([["Horn", Color.white, Color(0,0,0,0.5)]])
	.font_(Font("nil", 14))
	.mouseDownAction_({
		var variable;
		variable = SinOsc.kr(2); //unfortunately the QtGUI cannot use variables in this slider (error message)
		~freqslider.valueAction_(440.value.explin(100,1000,0,1)); //only need to affect slider to affect the number box and true sound value
				~volslider.valueAction_(1.value.linlin(0,1,0,1));
		~f1slider.valueAction_(1.value.linlin(0.0,2,0,1));
		~f2slider.valueAction_(1.24.value.linlin(0.0,2,0,1));
		~f3slider.valueAction_(0.74.value.linlin(0.0,2,0,1));
		~f4slider.valueAction_(0.163.value.linlin(0.0,2,0,1));
		~f5slider.valueAction_(0.231.value.linlin(0.0,2,0,1));
		~f6slider.valueAction_(0.106.value.linlin(0.0,2,0,1));
		~f7slider.valueAction_(0.058.value.linlin(0.0,2,0,1));
		~f8slider.valueAction_(0.077.value.linlin(0.0,2,0,1));
		~f9slider.valueAction_(0.096.value.linlin(0.0,2,0,1));
		~f10slider.valueAction_(0.019.value.linlin(0.0,2,0,1));
		~f11slider.valueAction_(0.019.value.linlin(0.0,2,0,1));
		~f12slider.valueAction_(0.019.value.linlin(0.0,2,0,1));
		~f13slider.valueAction_(0.019.value.linlin(0.0,2,0,1));
		~f14slider.valueAction_(0.019.value.linlin(0.0,2,0,1));
		~f15slider.valueAction_(0.019.value.linlin(0.0,2,0,1));
		~f16slider.valueAction_(0.019.value.linlin(0.0,2,0,1));
		x.free;
	~button.valueAction_(1);
	});


	//Label for Moving
~para = StaticText(w,Rect(10,460,380,30))
	.string_("Synthesized Sounds")
.font_(Font("nil", 18))
.align_(\topLeft)
.background_(Color(0,0,0,0))
.stringColor_(Color.black);

//Label for Realistic
~para = StaticText(w,Rect(10,500,380,30))
	.string_("Instrument Recordings")
.font_(Font("nil", 18))
.align_(\topLeft)
.background_(Color(0,0,0,0))
.stringColor_(Color.black);

//Label for Harmonics
~para = StaticText(w,Rect(15,110,380,20))
	.string_("Harmonics|")
.font_(Font("nil", 18))
.align_(\topLeft)
.background_(Color(0,0,0,0))
.stringColor_(Color.black);

//Label for Spectra
~para = StaticText(w,Rect(410,110,380,80))
	.string_("Spectra")
.font_(Font("nil", 18))
.align_(\top)
.background_(Color(0,0,0,0))
.stringColor_(Color.white);


		//TONIC FREQUENCY
//Properties of the slider
~freqslider = Slider(w, Rect(250,110,140,20))
	.background_(Color(0.8,0.8,0.8,0.75)).value_(0.3802)
	.action_({
	arg obj;
	var cf;
		cf = obj.value.linexp(0,1,100,1000)
		// .postln
		;
		if(
		x.isPlaying,
		{x.set(\freq,cf)});
	~numberBox.value_(obj.value.linexp(0,1,100,1000));
		~f1Box.value_(obj.value.linexp(0,1,100,1000));
		~f2Box.value_(obj.value.linexp(0,1,200,2000));
		~f3Box.value_(obj.value.linexp(0,1,300,3000));
		~f4Box.value_(obj.value.linexp(0,1,400,4000));
		~f5Box.value_(obj.value.linexp(0,1,500,5000));
		~f6Box.value_(obj.value.linexp(0,1,600,6000));
		~f7Box.value_(obj.value.linexp(0,1,700,7000));
		~f8Box.value_(obj.value.linexp(0,1,800,8000));
		~f9Box.value_(obj.value.linexp(0,1,900,9000));
		~f10Box.value_(obj.value.linexp(0,1,1000,10000));
		~f11Box.value_(obj.value.linexp(0,1,1100,11000));
		~f12Box.value_(obj.value.linexp(0,1,1200,12000));
		~f13Box.value_(obj.value.linexp(0,1,1300,13000));
		~f14Box.value_(obj.value.linexp(0,1,1400,14000));
		~f15Box.value_(obj.value.linexp(0,1,1500,15000));
		~f16Box.value_(obj.value.linexp(0,1,1600,16000));
		 ~fsliderharm1.valueAction_(obj.value.linlin(0,1,0.065,0.495));//must be linlin because a slider to slider is using the same exact values (no transformation required)
		 ~fsliderharm2.valueAction_(obj.value.linlin(0,1,0.19047619047619,0.63));
				~fsliderharm3.valueAction_(obj.value.linlin(0,1,0.26190476190476
,0.705));
})
	.orientation_(\horizontal);

//Label for Freq.
~freqLabel = StaticText(w,Rect(115,115,80,20))
.string_("Tonic Frequency")
.font_(Font("nil", 10))
.align_(\topLeft)
.background_(Color(0,0,0,0))
.stringColor_(Color.black);

//Number box that can edit slider position
~numberBox = NumberBox(w,Rect(200,110,50,20))
.value_(240)
.clipLo_(100)
.clipHi_(2000)
.font_(Font("nil",16))
.decimals_(1)
.align_(\center)
.action_({
	arg obj;
	~freqslider.valueAction_(obj.value.explin(100,1000,0,1))
});

//VOLUME //sometimes this ruins the computer speakers too...
//Properties of the slider
~volslider = Slider(w, Rect(50,145,20,230))
	.background_(Color(0.0118,0.0118,0.0118,1))
	.value_(0.2)
	.action_({
	arg obj;
	var cf;
	cf = obj.value.linlin(0,1,0,1).postln;
		if(
		x.isPlaying,
		{x.set(\vol,cf)});
	~numberVBox.value_(obj.value.linlin(0,1,0,1));

})
	.orientation_(\vertical);

//Label for Freq.
~volLabel = StaticText(w,Rect(50,130,20,15))
.string_("Vol.")
.font_(Font("nil", 10, italic:true))
.align_(\center)
.background_(Color(0,0,0,0.1))
.stringColor_(Color.black);

//Number box that can edit slider position
~numberVBox = NumberBox(w,Rect(50,375,20,15))
	.normalColor_(Color.white)
	.background_(Color(0.0118,0.0118,0.0118,1))
	.value_(0.2)
.clipLo_(0)
.clipHi_(1)
.font_(Font("nil",7))
.decimals_(1)
.align_(\center)
.action_({
	arg obj;
	~volslider.valueAction_(obj.value.linlin(0,1,0,1))
});

	//Labels
~intensity = StaticText(w,Rect(12,377.5,40,15))
.string_("Intensity")
.font_(Font("nil", 8,true))
.align_(\topLeft)
.background_(Color(0,0,0,0))
.stringColor_(Color.black);

	~frequencyname = StaticText(w,Rect(12,392.5,50,15))
.string_("Frequency")
.font_(Font("nil", 8,true))
.align_(\topLeft)
.background_(Color(0,0,0,0))
.stringColor_(Color.black);



///add sound to a buffer as an import - tuning fork
(
a = Buffer.read(s, "/Users/max/Dropbox/Ng, Maxwell/SuperCollider-realistic-audio/tuning_fork_A4 (fadeout).wav");

SynthDef("import1",{ arg out=0,bufnum=0, trigger=1, startPos=0, loop=1;
	var rate;
			rate = 0.98; //using rate because it was slightly out of tune (too high pitched)
	Out.ar(out,
		Pan2.ar(PlayBuf.ar(1,bufnum, BufRateScale.kr(bufnum)*rate, trigger, BufFrames.ir(bufnum)*startPos, loop=0),0.0)
	);
}).add;
);


//Play a sound... tuning fork preset
q = Button(w, Rect(240, 497.5, 120, 26))
	.states_([["Tuning Fork", Color.white, Color(0,0,0,0.5)]])
	.font_(Font("nil", 18))
	.action_({
			y = Synth.new(\import1, [\out, 0, \bufnum, a.bufnum]);
		x.free;
		z.free;
		v.free;
		~button.valueAction_(0);
		});

///add sound to a buffer as an import - flute
(
b = Buffer.read(s, "/Users/max/Dropbox/Ng, Maxwell/SuperCollider-realistic-audio/flute_A4 (fadeout).wav");

SynthDef("import2",{ arg out=0,bufnum=0, trigger=1, startPos=0, loop=1;
	var rate;
			rate = 1.0; //using rate because it was slightly out of tune (too high pitched)
	Out.ar(out,
		Pan2.ar(PlayBuf.ar(1,bufnum, BufRateScale.kr(bufnum)*rate, trigger, BufFrames.ir(bufnum)*startPos, loop=0),0.0)
	);
}).add;
);


//Play a sound... flute preset
r = Button(w, Rect(500, 497.5, 120, 26))
	.states_([["Flute", Color.white, Color(0,0,0,0.5)]])
	.font_(Font("nil", 18))
	.action_({
			z = Synth.new(\import2, [\out, 0, \bufnum, b.bufnum]);
		x.free;
		y.free;
		v.free;
		~button.valueAction_(0);
		});

///add sound to a buffer as an import - violin
(
c = Buffer.read(s, "/Users/max/Dropbox/Ng, Maxwell/SuperCollider-realistic-audio/violin_A4 (fadeout).wav");

SynthDef("import3",{ arg out=0,bufnum=0, trigger=1, startPos=0, loop=1;
	var rate;
			rate = 0.98; //using rate because it was slightly out of tune (too high pitched)
	Out.ar(out,
		Pan2.ar(PlayBuf.ar(1,bufnum, BufRateScale.kr(bufnum)*rate, trigger, BufFrames.ir(bufnum)*startPos, loop=0),0.0)
	);
}).add;
);


//Play a sound... violin preset
e = Button(w, Rect(370, 497.5, 120, 26))
	.states_([["Violin", Color.white, Color(0,0,0,0.5)]])
	.font_(Font("nil", 18))
	.action_({
			v = Synth.new(\import3, [\out, 0, \bufnum, c.bufnum]);
		x.free;
		y.free;
		z.free;
		~button.valueAction_(0);
		});


//Define the slider sounds to be played
(
SynthDef.new("sound", {
			arg vol = 0.2, freq = 240, outoftune = 720, f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16;
	var mul, signal;

			mul = XLine.kr(0.01,1,0.01,0.1); //Ramps sound onset so not so harsh

	signal =
	SinOsc.ar(freq, 0, vol*mul*f1) +
	SinOsc.ar(freq*2, 0, vol*mul*f2) +
	SinOsc.ar(freq*3, 0, vol*mul*f3) +
	SinOsc.ar(freq*4, 0, vol*mul*f4) +
	SinOsc.ar(freq*5, 0, vol*mul*f5) +
	SinOsc.ar(freq*6, 0, vol*mul*f6)+
	SinOsc.ar(freq*7, 0, vol*mul*f7)+
	SinOsc.ar(freq*8, 0, vol*mul*f8)+
	SinOsc.ar(freq*9, 0, vol*mul*f9)+
	SinOsc.ar(freq*10, 0, vol*mul*f10)+
	SinOsc.ar(freq*11, 0, vol*mul*f11)+
	SinOsc.ar(freq*12, 0, vol*mul*f12)+
	SinOsc.ar(freq*13, 0, vol*mul*f13)+
	SinOsc.ar(freq*14, 0, vol*mul*f14)+
	SinOsc.ar(freq*15, 0, vol*mul*f15)+
	SinOsc.ar(freq*16, 0, vol*mul*f16)
	;

	Out.ar([0,1], signal); //sends to busses 1 & 2 (stereo), and plays the var "signal"
}).add;
);





	/////////////////SLIDERS
///F1
//Properties of the slider
~f1slider = Slider(w, Rect(70,145,20,230))
.background_(Color(0.8,0.8,0.8,0.75))
	.value_(0.5) //is converted to 1
	.orientation_(\vertical)
	.action_({
	arg obj;
	var cf;
	cf = obj.value.linlin(0,1,0.0,2).postln;
		if(
		x.isPlaying,
		{x.set(\f1,cf)});
	~number1Box.value_(obj.value.linlin(0,1,0.0,2));
});
//Label
~f1Label = StaticText(w,Rect(70,130,20,15))
.string_("1")
.font_(Font("nil", 12))
.align_(\top)
.background_(Color(0,0,0,0.1))
.stringColor_(Color.black);
//Number box that can edit slider position
~number1Box = NumberBox(w,Rect(70,375,20,15))
.value_(1)
.clipLo_(0.0)
.clipHi_(2)
.font_(Font("nil",7))
.decimals_(2)
.align_(\center)
.action_({
	arg obj;
	~f1slider.valueAction_(obj.value.linlin(0.0,2,0,1))
});
//Number box showing harmonic frequency
~f1Box = NumberBox(w,Rect(70,390,20,15))
.value_(240)
.clipLo_(100)
.clipHi_(20000)
.font_(Font("nil",5))
.decimals_(1)
.align_(\center);
	// .action_({
		// arg obj;
		// ~freqslider.valueAction_(obj.value.explin(100,1000,0,1))
// });

	///F2
//Properties of the slider
~f2slider = Slider(w, Rect(90,145,20,230))
.background_(Color(0.8,0.8,0.8,0.75))
	.value_(0.5) //is converted to 1
	.orientation_(\vertical)
	.action_({
	arg obj;
	var cf;
	cf = obj.value.linlin(0,1,0.0,2).postln;
		if(
		x.isPlaying,
		{x.set(\f2,cf)});
	~number2Box.value_(obj.value.linlin(0,1,0.0,2));
});
//Label
~f2Label = StaticText(w,Rect(90,130,20,15))
.string_("2")
.font_(Font("nil", 12))
.align_(\top)
.background_(Color(0,0,0,0.1))
.stringColor_(Color.black);
//Number box that can edit slider position
~number2Box = NumberBox(w,Rect(90,375,20,15))
.value_(1)
.clipLo_(0.0)
.clipHi_(2)
.font_(Font("nil",7))
.decimals_(2)
.align_(\center)
.action_({
	arg obj;
	~f2slider.valueAction_(obj.value.linlin(0.0,2,0,1))
});
//Number box showing harmonic frequency
~f2Box = NumberBox(w,Rect(90,390,20,15))
.value_(240*1)
.clipLo_(100)
.clipHi_(20000)
.font_(Font("nil",5))
.decimals_(1)
.align_(\center);
	// .action_({
		// arg obj;
		// ~freqslider.valueAction_(obj.value.explin(100,1000,0,1))
// });

	///F3
//Properties of the slider
~f3slider = Slider(w, Rect(110,145,20,230))
.background_(Color(0.8,0.8,0.8,0.75))
	.value_(0.5) //is converted to 1
	.orientation_(\vertical)
	.action_({
	arg obj;
	var cf;
	cf = obj.value.linlin(0,1,0.0,2).postln;
		if(
		x.isPlaying,
		{x.set(\f3,cf)});
	~number3Box.value_(obj.value.linlin(0,1,0.0,2));
});
//Label
~f3Label = StaticText(w,Rect(110,130,20,15))
.string_("3")
.font_(Font("nil", 12))
.align_(\top)
.background_(Color(0,0,0,0.1))
.stringColor_(Color.black);
//Number box that can edit slider position
~number3Box = NumberBox(w,Rect(110,375,20,15))
.value_(3)
.clipLo_(0.0)
.clipHi_(2)
.font_(Font("nil",7))
.decimals_(2)
.align_(\center)
.action_({
	arg obj;
	~f3slider.valueAction_(obj.value.linlin(0.0,2,0,1))
});
//Number box showing harmonic frequency
~f3Box = NumberBox(w,Rect(110,390,20,15))
.value_(240*3)
.clipLo_(100)
.clipHi_(20000)
.font_(Font("nil",5))
.decimals_(1)
.align_(\center);
	// .action_({
		// arg obj;
		// ~freqslider.valueAction_(obj.value.explin(100,1000,0,1))
// });

	///F4
//Properties of the slider
~f4slider = Slider(w, Rect(130,145,20,230))
.background_(Color(0.8,0.8,0.8,0.75))
	.value_(0.5) //is converted to 1
	.orientation_(\vertical)
	.action_({
	arg obj;
	var cf;
	cf = obj.value.linlin(0,1,0.0,2).postln;
		if(
		x.isPlaying,
		{x.set(\f4,cf)});
	~number4Box.value_(obj.value.linlin(0,1,0.0,2));
});
//Label
~f4Label = StaticText(w,Rect(130,130,20,15))
.string_("4")
.font_(Font("nil", 12))
.align_(\top)
.background_(Color(0,0,0,0.1))
.stringColor_(Color.black);
//Number box that can edit slider position
~number4Box = NumberBox(w,Rect(130,375,20,15))
.value_(1)
.clipLo_(0.0)
.clipHi_(2)
.font_(Font("nil",7))
.decimals_(2)
.align_(\center)
.action_({
	arg obj;
	~f4slider.valueAction_(obj.value.linlin(0.0,2,0,1))
});
//Number box showing harmonic frequency
~f4Box = NumberBox(w,Rect(130,390,20,15))
.value_(240*4)
.clipLo_(100)
.clipHi_(20000)
.font_(Font("nil",5))
.decimals_(1)
.align_(\center);
	// .action_({
		// arg obj;
		// ~freqslider.valueAction_(obj.value.explin(100,1000,0,1))
// });

	///F5
//Properties of the slider
~f5slider = Slider(w, Rect(150,145,20,230))
.background_(Color(0.8,0.8,0.8,0.75))
	.value_(0.5) //is converted to 1
	.orientation_(\vertical)
	.action_({
	arg obj;
	var cf;
	cf = obj.value.linlin(0,1,0.0,2).postln;
		if(
		x.isPlaying,
		{x.set(\f5,cf)});
	~number5Box.value_(obj.value.linlin(0,1,0.0,2));
});
//Label
~f5Label = StaticText(w,Rect(150,130,20,15))
.string_("5")
.font_(Font("nil", 12))
.align_(\top)
.background_(Color(0,0,0,0.1))
.stringColor_(Color.black);
//Number box that can edit slider position
~number5Box = NumberBox(w,Rect(150,375,20,15))
.value_(1)
.clipLo_(0.0)
.clipHi_(2)
.font_(Font("nil",7))
.decimals_(2)
.align_(\center)
.action_({
	arg obj;
	~f5slider.valueAction_(obj.value.linlin(0.0,2,0,1))
});
//Number box showing harmonic frequency
~f5Box = NumberBox(w,Rect(150,390,20,15))
.value_(240*5)
.clipLo_(100)
.clipHi_(20000)
.font_(Font("nil",5))
.decimals_(1)
.align_(\center);
	// .action_({
		// arg obj;
		// ~freqslider.valueAction_(obj.value.explin(100,1000,0,1))
// });

	///F6
//Properties of the slider
~f6slider = Slider(w, Rect(170,145,20,230))
.background_(Color(0.8,0.8,0.8,0.75))
	.value_(0.5) //is converted to 1
	.orientation_(\vertical)
	.action_({
	arg obj;
	var cf;
	cf = obj.value.linlin(0,1,0.0,2).postln;
		if(
		x.isPlaying,
		{x.set(\f6,cf)});
	~number6Box.value_(obj.value.linlin(0,1,0.0,2));
});
//Label
~f6Label = StaticText(w,Rect(170,130,20,15))
.string_("6")
.font_(Font("nil", 12))
.align_(\top)
.background_(Color(0,0,0,0.1))
.stringColor_(Color.black);
//Number box that can edit slider position
~number6Box = NumberBox(w,Rect(170,375,20,15))
.value_(1)
.clipLo_(0.0)
.clipHi_(2)
.font_(Font("nil",7))
.decimals_(2)
.align_(\center)
.action_({
	arg obj;
	~f6slider.valueAction_(obj.value.linlin(0.0,2,0,1))
});
//Number box showing harmonic frequency
~f6Box = NumberBox(w,Rect(170,390,20,15))
.value_(240)
.clipLo_(100)
.clipHi_(20000)
.font_(Font("nil",5))
.decimals_(1)
.align_(\center);
	// .action_({
		// arg obj;
		// ~freqslider.valueAction_(obj.value.explin(100,1000,0,1))
// });

	///F7
//Properties of the slider
~f7slider = Slider(w, Rect(190,145,20,230))
.background_(Color(0.8,0.8,0.8,0.75))
	.value_(0.5) //is converted to 1
	.orientation_(\vertical)
	.action_({
	arg obj;
	var cf;
	cf = obj.value.linlin(0,1,0.0,2).postln;
		if(
		x.isPlaying,
		{x.set(\f7,cf)});
	~number7Box.value_(obj.value.linlin(0,1,0.0,2));
});
//Label
~f7Label = StaticText(w,Rect(190,130,20,15))
.string_("7")
.font_(Font("nil", 12))
.align_(\top)
.background_(Color(0,0,0,0.1))
.stringColor_(Color.black);
//Number box that can edit slider position
~number7Box = NumberBox(w,Rect(190,375,20,15))
.value_(1)
.clipLo_(0.0)
.clipHi_(2)
.font_(Font("nil",7))
.decimals_(2)
.align_(\center)
.action_({
	arg obj;
	~f7slider.valueAction_(obj.value.linlin(0.0,2,0,1))
});
//Number box showing harmonic frequency
~f7Box = NumberBox(w,Rect(190,390,20,15))
.value_(240*7)
.clipLo_(100)
.clipHi_(20000)
.font_(Font("nil",5))
.decimals_(1)
.align_(\center);
	// .action_({
		// arg obj;
		// ~freqslider.valueAction_(obj.value.explin(100,1000,0,1))
// });

	///F8
//Properties of the slider
~f8slider = Slider(w, Rect(210,145,20,230))
.background_(Color(0.8,0.8,0.8,0.75))
	.value_(0.5) //is converted to 1
	.orientation_(\vertical)
	.action_({
	arg obj;
	var cf;
	cf = obj.value.linlin(0,1,0.0,2).postln;
		if(
		x.isPlaying,
		{x.set(\f8,cf)});
	~number8Box.value_(obj.value.linlin(0,1,0.0,2));
});
//Label
~f8Label = StaticText(w,Rect(210,130,20,15))
.string_("8")
.font_(Font("nil", 12))
.align_(\top)
.background_(Color(0,0,0,0.1))
.stringColor_(Color.black);
//Number box that can edit slider position
~number8Box = NumberBox(w,Rect(210,375,20,15))
.value_(1)
.clipLo_(0.0)
.clipHi_(2)
.font_(Font("nil",7))
.decimals_(2)
.align_(\center)
.action_({
	arg obj;
	~f8slider.valueAction_(obj.value.linlin(0.0,2,0,1))
});
//Number box showing harmonic frequency
~f8Box = NumberBox(w,Rect(210,390,20,15))
.value_(240*8)
.clipLo_(100)
.clipHi_(20000)
.font_(Font("nil",5))
.decimals_(1)
.align_(\center);
	// .action_({
		// arg obj;
		// ~freqslider.valueAction_(obj.value.explin(100,1000,0,1))
// });

	///F9
//Properties of the slider
~f9slider = Slider(w, Rect(230,145,20,230))
.background_(Color(0.8,0.8,0.8,0.75))
	.value_(0.5) //is converted to 1
	.orientation_(\vertical)
	.action_({
	arg obj;
	var cf;
	cf = obj.value.linlin(0,1,0.0,2).postln;
		if(
		x.isPlaying,
		{x.set(\f9,cf)});
	~number9Box.value_(obj.value.linlin(0,1,0.0,2));
});
//Label
~f9Label = StaticText(w,Rect(230,130,20,15))
.string_("9")
.font_(Font("nil", 12))
.align_(\top)
.background_(Color(0,0,0,0.1))
.stringColor_(Color.black);
//Number box that can edit slider position
~number9Box = NumberBox(w,Rect(230,375,20,15))
.value_(1)
.clipLo_(0.0)
.clipHi_(2)
.font_(Font("nil",7))
.decimals_(2)
.align_(\center)
.action_({
	arg obj;
	~f9slider.valueAction_(obj.value.linlin(0.0,2,0,1))
});
//Number box showing harmonic frequency
~f9Box = NumberBox(w,Rect(230,390,20,15))
.value_(240*9)
.clipLo_(100)
.clipHi_(20000)
.font_(Font("nil",5))
.decimals_(1)
.align_(\center);
	// .action_({
		// arg obj;
		// ~freqslider.valueAction_(obj.value.explin(100,1000,0,1))
// });

	///F10
//Properties of the slider
~f10slider = Slider(w, Rect(250,145,20,230))
.background_(Color(0.8,0.8,0.8,0.75))
	.value_(0.5) //is converted to 1
	.orientation_(\vertical)
	.action_({
	arg obj;
	var cf;
	cf = obj.value.linlin(0,1,0.0,2).postln;
		if(
		x.isPlaying,
		{x.set(\f10,cf)});
	~number10Box.value_(obj.value.linlin(0,1,0.0,2));
});
//Label
~f10Label = StaticText(w,Rect(250,130,20,15))
.string_("10")
.font_(Font("nil", 12))
.align_(\top)
.background_(Color(0,0,0,0.1))
.stringColor_(Color.black);
//Number box that can edit slider position
~number10Box = NumberBox(w,Rect(250,375,20,15))
.value_(1)
.clipLo_(0.0)
.clipHi_(2)
.font_(Font("nil",7))
.decimals_(2)
.align_(\center)
.action_({
	arg obj;
	~f10slider.valueAction_(obj.value.linlin(0.0,2,0,1))
});
//Number box showing harmonic frequency
~f10Box = NumberBox(w,Rect(250,390,20,15))
.value_(240*10)
.clipLo_(100)
.clipHi_(20000)
.font_(Font("nil",5))
.decimals_(1)
.align_(\center);
	// .action_({
		// arg obj;
		// ~freqslider.valueAction_(obj.value.explin(100,1000,0,1))
// });

	///F11
//Properties of the slider
~f11slider = Slider(w, Rect(270,145,20,230))
.background_(Color(0.8,0.8,0.8,0.75))
	.value_(0.5) //is converted to 1
	.orientation_(\vertical)
	.action_({
	arg obj;
	var cf;
	cf = obj.value.linlin(0,1,0.0,2).postln;
		if(
		x.isPlaying,
		{x.set(\f11,cf)});
	~number11Box.value_(obj.value.linlin(0,1,0.0,2));
});
//Label
~f11Label = StaticText(w,Rect(270,130,20,15))
.string_("11")
.font_(Font("nil", 12))
.align_(\top)
.background_(Color(0,0,0,0.1))
.stringColor_(Color.black);
//Number box that can edit slider position
~number11Box = NumberBox(w,Rect(270,375,20,15))
.value_(1)
.clipLo_(0.0)
.clipHi_(2)
.font_(Font("nil",7))
.decimals_(2)
.align_(\center)
.action_({
	arg obj;
	~f11slider.valueAction_(obj.value.linlin(0.0,2,0,1))
});
//Number box showing harmonic frequency
~f11Box = NumberBox(w,Rect(270,390,20,15))
.value_(240*11)
.clipLo_(100)
.clipHi_(20000)
.font_(Font("nil",5))
.decimals_(1)
.align_(\center);
	// .action_({
		// arg obj;
		// ~freqslider.valueAction_(obj.value.explin(100,1000,0,1))
// });

	///F12
//Properties of the slider
~f12slider = Slider(w, Rect(290,145,20,230))
.background_(Color(0.8,0.8,0.8,0.75))
	.value_(0.5) //is converted to 1
	.orientation_(\vertical)
	.action_({
	arg obj;
	var cf;
	cf = obj.value.linlin(0,1,0.0,2).postln;
		if(
		x.isPlaying,
		{x.set(\f12,cf)});
	~number12Box.value_(obj.value.linlin(0,1,0.0,2));
});
//Label
~f12Label = StaticText(w,Rect(290,130,20,15))
.string_("12")
.font_(Font("nil", 12))
.align_(\top)
.background_(Color(0,0,0,0.1))
.stringColor_(Color.black);
//Number box that can edit slider position
~number12Box = NumberBox(w,Rect(290,375,20,15))
.value_(1)
.clipLo_(0.0)
.clipHi_(2)
.font_(Font("nil",7))
.decimals_(2)
.align_(\center)
.action_({
	arg obj;
	~f12slider.valueAction_(obj.value.linlin(0.0,2,0,1))
});
//Number box showing harmonic frequency
~f12Box = NumberBox(w,Rect(290,390,20,15))
.value_(240*12)
.clipLo_(100)
.clipHi_(20000)
.font_(Font("nil",5))
.decimals_(1)
.align_(\center);
	// .action_({
		// arg obj;
		// ~freqslider.valueAction_(obj.value.explin(100,1000,0,1))
// });

	///F13
//Properties of the slider
~f13slider = Slider(w, Rect(310,145,20,230))
.background_(Color(0.8,0.8,0.8,0.75))
	.value_(0.5) //is converted to 1
	.orientation_(\vertical)
	.action_({
	arg obj;
	var cf;
	cf = obj.value.linlin(0,1,0.0,2).postln;
		if(
		x.isPlaying,
		{x.set(\f13,cf)});
	~number13Box.value_(obj.value.linlin(0,1,0.0,2));
});
//Label
~f13Label = StaticText(w,Rect(310,130,20,15))
.string_("13")
.font_(Font("nil", 12))
.align_(\top)
.background_(Color(0,0,0,0.1))
.stringColor_(Color.black);
//Number box that can edit slider position
~number13Box = NumberBox(w,Rect(310,375,20,15))
.value_(1)
.clipLo_(0.0)
.clipHi_(2)
.font_(Font("nil",7))
.decimals_(2)
.align_(\center)
.action_({
	arg obj;
	~f13slider.valueAction_(obj.value.linlin(0.0,2,0,1))
});
//Number box showing harmonic frequency
~f13Box = NumberBox(w,Rect(310,390,20,15))
.value_(240*13)
.clipLo_(100)
.clipHi_(20000)
.font_(Font("nil",5))
.decimals_(1)
.align_(\center);
	// .action_({
		// arg obj;
		// ~freqslider.valueAction_(obj.value.explin(100,1000,0,1))
// });

	///F14
//Properties of the slider
~f14slider = Slider(w, Rect(330,145,20,230))
.background_(Color(0.8,0.8,0.8,0.75))
	.value_(0.5) //is converted to 1
	.orientation_(\vertical)
	.action_({
	arg obj;
	var cf;
	cf = obj.value.linlin(0,1,0.0,2).postln;
		if(
		x.isPlaying,
		{x.set(\f14,cf)});
	~number14Box.value_(obj.value.linlin(0,1,0.0,2));
});
//Label
~f14Label = StaticText(w,Rect(330,130,20,15))
.string_("1")
.font_(Font("nil", 12))
.align_(\top)
.background_(Color(0,0,0,0.1))
.stringColor_(Color.black);
//Number box that can edit slider position
~number14Box = NumberBox(w,Rect(330,375,20,15))
.value_(1)
.clipLo_(0.0)
.clipHi_(2)
.font_(Font("nil",7))
.decimals_(2)
.align_(\center)
.action_({
	arg obj;
	~f14slider.valueAction_(obj.value.linlin(0.0,2,0,1))
});
//Number box showing harmonic frequency
~f14Box = NumberBox(w,Rect(330,390,20,15))
.value_(240*14)
.clipLo_(100)
.clipHi_(20000)
.font_(Font("nil",5))
.decimals_(1)
.align_(\center);
	// .action_({
		// arg obj;
		// ~freqslider.valueAction_(obj.value.explin(100,1000,0,1))
// });

	///F15
//Properties of the slider
~f15slider = Slider(w, Rect(350,145,20,230))
.background_(Color(0.8,0.8,0.8,0.75))
	.value_(0.5) //is converted to 1
	.orientation_(\vertical)
	.action_({
	arg obj;
	var cf;
	cf = obj.value.linlin(0,1,0.0,2).postln;
		if(
		x.isPlaying,
		{x.set(\f15,cf)});
	~number15Box.value_(obj.value.linlin(0,1,0.0,2));
});
//Label
~f15Label = StaticText(w,Rect(350,130,20,15))
.string_("15")
.font_(Font("nil", 12))
.align_(\top)
.background_(Color(0,0,0,0.1))
.stringColor_(Color.black);
//Number box that can edit slider position
~number15Box = NumberBox(w,Rect(350,375,20,15))
.value_(1)
.clipLo_(0.0)
.clipHi_(2)
.font_(Font("nil",7))
.decimals_(2)
.align_(\center)
.action_({
	arg obj;
	~f15slider.valueAction_(obj.value.linlin(0.0,2,0,1))
});
//Number box showing harmonic frequency
~f15Box = NumberBox(w,Rect(350,390,20,15))
.value_(240*15)
.clipLo_(100)
.clipHi_(20000)
.font_(Font("nil",5))
.decimals_(1)
.align_(\center);
	// .action_({
		// arg obj;
		// ~freqslider.valueAction_(obj.value.explin(100,1000,0,1))
// });

	///F16
//Properties of the slider
~f16slider = Slider(w, Rect(370,145,20,230))
.background_(Color(0.8,0.8,0.8,0.75))
	.value_(0.5) //is converted to 1
	.orientation_(\vertical)
	.action_({
	arg obj;
	var cf;
	cf = obj.value.linlin(0,1,0.0,2).postln;
		if(
		x.isPlaying,
		{x.set(\f16,cf)});
	~number16Box.value_(obj.value.linlin(0,1,0.0,2));
});
//Label
~f16Label = StaticText(w,Rect(370,130,20,15))
.string_("16")
.font_(Font("nil", 12))
.align_(\top)
.background_(Color(0,0,0,0.1))
.stringColor_(Color.black);
//Number box that can edit slider position
~number16Box = NumberBox(w,Rect(370,375,20,15))
.value_(1)
.clipLo_(0.0)
.clipHi_(2)
.font_(Font("nil",7))
.decimals_(2)
.align_(\center)
.action_({
	arg obj;
	~f16slider.valueAction_(obj.value.linlin(0.0,2,0,1))
});
//Number box showing harmonic frequency
~f16Box = NumberBox(w,Rect(370,390,20,15))
.value_(240*16)
.clipLo_(100)
.clipHi_(20000)
.font_(Font("nil",5))
.decimals_(1)
.align_(\center);
	// .action_({
		// arg obj;
		// ~freqslider.valueAction_(obj.value.explin(100,1000,0,1))
// });


~quit = Button.new(w, Rect((690), 70, 60, 20))
	.states_([["Go Back", Color.white, Color(0.2510,0.2510,0.2510,1)]])
	.font_(Font("nil", 12))
	.mouseDownAction_({
		x.free;
		y.free;
		z.free;
		v.free;
		a.free; //clear buffers to help resolve memory leak
		b.free;
		e.free;
		// ~d.quit; causes issues if ~d doesn't exist before quitting, in any case ~d closes automatically because it is parented to the w window
		~w2.close;
		h.kill;
		w.close;
		"/Users/max/Documents/GitHub-Auditory-Exploration-Suite/splashscreen.scd".loadPaths;
		});

	//Open Stethoscope
~scopebutton = Button(w, Rect((690-27.5), 112.5, 120, 20))
.states_([
	["Open Oscilloscope", Color.white,Color(0.7569,0.1373,0.1725,1)],
	["Close Oscilloscope", Color.white, Color.grey(0.251)]
])
.font_(Font("nil", 12))
.action_({
	arg obj;
	if(obj.value == 1,
		{
				~w2 = Window.new("Oscilloscope", Rect.new(
	Window.screenBounds.width/2+420,
	500,
		250,250),false).background_(Color.white).userCanClose_(false).front;

		~d = Stethoscope.new(s, 2,view:~w2)//nil causes it to open in its own window
				// .xZoom_(5) //is only setting slider, isn't changing view properly
				// .cycle_(50) //same problem as xZoom: workaround, use a button for 440Hz
				.yZoom_(4);
			},
		{~w2.close;
				~d.quit}
	);
});


~scope2button = Button(w, Rect((690-27.5), 132.5, 120, 20))
.states_([
	["Set Osc. to 440Hz", Color.white,Color(0.7569,0.1373,0.1725,1)]
])
.font_(Font("nil", 12))
	.action_({
		~d
		//.xZoom_((438.9105/1024)*1)
		.cycle_((501))
		;
	}
	);


 ~i = Image.new("/Users/max/Documents/GitHub-Auditory-Exploration-Suite/mapleICON-small.png");

//Aesthetic lines
	w.drawFunc = {
		~i.drawInRect(Rect(760,65,30,30), Rect(0,0,30,30), 2, 1.0);
		Pen.line(10@490,790@490); //Fifth line
		Pen.line(10@450,790@450); //Fourth line
		Pen.line(10@410,790@410); //Third line
		Pen.line(10@100,790@100); //Second line
	Pen.strokeColor = Color(0,0,0,0.5); //Top line, written differently in code
                Pen.width = 2;
                Pen.moveTo(10@60);
                Pen.lineTo(790@60);
                Pen.stroke;
        };

w.onClose_({s.quit}); //not working, rerouted to back button
})
 //ends server when quit
)
// ~d.cycle_(501)//can only go to 0 decimals anyways, rounds up at 5th-ish decimal
// 300.99999
// (~d.cycle).postln