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
~trace = basePath.asString;

//Avoids delay when the Recording button is pressed
//s.prepareForRecord;

//A. Create window and aesthetics
(
//Create the module's master window
		~master_window_bounds_array = [Window.screenBounds.width/2-250, Window.screenBounds.height/2-50, 500, 570];
w = Window.new("MAPLE Lab Difference Tones Demonstration (Beta)", Rect.new(
	~master_window_bounds_array[0],
	~master_window_bounds_array[1],
	~master_window_bounds_array[2],
	~master_window_bounds_array[3]
),
false) //Cannot be resized by user.
.background_(Color.white)
.userCanClose_(true)
.front
.acceptsMouseOver_(true);

	// Title and labels
		~masterTitle = StaticText(w, Rect(0,0,500,40)).string_("Difference Tones").align_(\center).font_(Font(nil, 14, true));



	);


		(basePath +/+  "data/tones_pitch_name.scd").load; // Load the function for updating the information panel below the harmonics panel
	(~trace +/+  "data/oscilloscopeButtonFunctions.scd").load; // Load the oscilloscope button functions


	//Record button - sends to Supercollider file in the Recordings section
~record_button_bounds_array = [10, 40, 85, 20];
(basePath +/+  "modules/record_button.scd").load;


// SynthDefs define the sound to be played
(
SynthDef.new("sound1", {
	arg /*midi = 60*/ freq = 440;

	var mul, mul2, signal/*, freq*/;

			mul = XLine.kr(0.01,1,0.2,0.1); //Ramps sound onset so not so harsh

			//freq = ((2**((-69+midi)/12))*440);

	signal = SinOsc.ar(freq,0, mul);

	Out.ar([0,1], signal); //sends to busses 1 & 2 (stereo), and plays the var "signal"
}).add;
);


	(
SynthDef.new("sound2", {
	arg /*midi = 60*/ freq = 440;

	var mul, mul2, signal/*, freq*/;

			mul = XLine.kr(0.01,1,0.2,0.1); //Ramps sound onset so not so harsh

			//freq = ((2**((-69+midi)/12))*440);

	signal = SinOsc.ar(freq,0, mul);

	Out.ar([0,1], signal); //sends to busses 1 & 2 (stereo), and plays the var "signal"
}).add;
);


	(
SynthDef.new("sound3", {
	arg /*midi = 60*/ freq = 440, differenceIntensity;

	var mul, mul2, signal/*, freq*/;

		//	mul = XLine.kr(0.01,1,0.2,0.1)*differenceIntensity; //Ramps sound onset so not so harsh

			//freq = ((2**((-69+midi)/12))*440);

			mul = differenceIntensity*0.1;

	signal = SinOsc.ar(freq,0, mul);

	Out.ar([0,1], signal); //sends to busses 1 & 2 (stereo), and plays the var "signal"
}).add;
);

// Sound Sliders

	~frequencyLabel = StaticText(w, Rect(10,70-20,500-100,20)).string_("Hz");
	~midiLabel = StaticText(w, Rect(450-40,70-20,40,20)).string_("MIDI").align_(\right);
		~nameLabel = StaticText(w, Rect(450,70-20,40,20)).string_("Pitch").align_(\center);



	~fundamentalTitle = StaticText(w, Rect(50,70-20,500-100,20)).string_("Frequency 1");
	~fundamentalSlider = Slider(w, Rect(50,70,500-100-40,20)).value_(440.linlin(0,5000,0,1)).action_({
		arg obj;
		~fundamentalBox.value_(obj.value.linlin(0,1,0,5000));

		if(~playButton.value == 1,{
			~sound1Synth.set(\freq, obj.value.linlin(0,1,0,5000););
		});


		~fundamentalMIDI.value = (log2(~fundamentalBox.value/440)*12)+69;
		~differenceTonePitchName.value(fundamentalNote:~fundamentalMIDI.value, outputToStaticText:~fundamentalName);
		~differenceSlider.valueAction_((~compareMIDI.value-~fundamentalMIDI.value).linlin(-12,12,0,1));
	});
	~fundamentalBox = NumberBox(w, Rect(10,70,40,20)).value_(440).action_({
		arg obj;
		~fundamentalSlider.valueAction_(obj.value.linlin(0,5000,0,1))
	});
	~fundamentalMIDI = NumberBox(w, Rect(450-40,70,40,20)).value_(69).action_({
		arg obj;
		var val;
		// ~midi2 = (log2(~compareBox.value/440)*12)+69;
		val = ((2**((-69+obj.value)/12))*440);
		~fundamentalBox.valueAction_(val);
	});
		~fundamentalName = StaticText(w, Rect(450,70,40,20)).string_("A4").align_(\center);


	~compareTitle = StaticText(w, Rect(50,70-20+50,500-100,20)).string_("Frequency 2");
	~compareSlider = Slider(w, Rect(50,70+50,500-100-40,20)).value_(880.linlin(0,5000,0,1)).action_({
		arg obj;
		~compareBox.value_(obj.value.linlin(0,1,0,5000));

		if(~playButton.value == 1,{
			~sound2Synth.set(\freq, obj.value.linlin(0,1,0,5000););
		});

		~compareMIDI.value = (log2(~compareBox.value/440)*12)+69;
		~differenceTonePitchName.value(fundamentalNote:~compareMIDI.value, outputToStaticText:~compareName);
		~differenceSlider.valueAction_((~compareMIDI.value-~fundamentalMIDI.value).linlin(-12,12,0,1));

	});
	~compareBox = NumberBox(w, Rect(10,70+50,40,20)).value_(880).action_({
		arg obj;
		~compareSlider.valueAction_(obj.value.linlin(0,5000,0,1))
	});
	~compareMIDI = NumberBox(w, Rect(450-40,70+50,40,20)).value_(81).action_({
		arg obj;
		var val;
		// ~midi2 = (log2(~compareBox.value/440)*12)+69;
		val = ((2**((-69+obj.value)/12))*440);
		~compareBox.valueAction_(val);
	});
	~compareName = StaticText(w, Rect(450,70+50,40,20)).string_("A5").align_(\center);



	// Play button
	// Button to play the Basic SynthDef
~playButton = Button.new(w, Rect(200,30,100,30))
.states_([
	["Sound OFF", Color.white, Color.red(0.5)],
	["Sound ON", Color.white, Color.green(0.5)]
])
.action_({
	arg obj;
	if(obj.value == 1, {
		~sound1Synth = Synth("sound1", [\freq, ~fundamentalBox.value]);
			~sound2Synth = Synth("sound2", [\freq, ~compareBox.value]);
	},{
		~sound1Synth.free;
			~sound2Synth.free;
	});
});


	// Difference Data


		// Immediately play the difference tone, but silent
	AppClock.sched(0.01, {~sound3Synth = Synth("sound3", [\freq, 440, \differenceIntensity:0.0]);});


	~fundamentalTitle = StaticText(w, Rect(50,70-20+120,500-100,20)).string_("Difference Tone");
	~differenceBox = NumberBox(w, Rect(10,70+120,40,20)).background_(Color.grey(0.2)).value_(440).normalColor_(Color.white);
	~differenceMIDI = NumberBox(w, Rect(450,70+120,40,20)).background_(Color.grey(0.2)).value_(12).normalColor_(Color.white);

	~differenceSlider = Slider(w, Rect(50,70+120,500-100,20)).knobColor_(Color.grey(0.2)).background_(Color.grey(0.2)).value_(1).action_({

		~differenceBox.value_((~compareBox.value-~fundamentalBox.value).abs);
		~differenceMIDI.value_((~compareMIDI.value-~fundamentalMIDI.value).abs);
		~sound3Synth.set(\freq, ~differenceBox.value;);
	});

	~differenceLabelsArray = ["P1", "m2", "M2", "m3", "M3", "P4", "TT", "P5", "m6", "M6", "m7", "M7", "P8"];

	~differenceLabelsArrayDouble = [~differenceLabelsArray.reverse.drop(-1), ~differenceLabelsArray].flatten;

	~differenceSliderCover = StaticText(w, Rect(50,70+120,500-100,20));

	~differenceLabelsDistance = 31.4/2;
	(13*2-1).do({
		arg i;

		("StaticText(w, Rect(51+(" ++ i ++ "*~differenceLabelsDistance), 191+13, 20, 20)).font_(Font(nil, 8)).string_(~differenceLabelsArrayDouble[" ++ i ++ "]).stringColor_(Color.black).align_(" ++ "\\" ++ "center);").interpret;
	});

	/*~differenceLabels = StaticText(w, Rect(50+5,70+120+1,500-100+50,20)).font_(Font("Courier New", 8)).string_(
		// "P1     m2     M2     m3     M3     P4     P5     m6     M6     m7     M7     P8"
	).align_(\left).stringColor_(Color.white);*/

	//~midi1 = (log2(~fundamentalBox.value/440)*12)+69;
	//~differenceMIDI = ~midi2-~midi1;
	//~differenceSlider.value_((~compareMIDI.value-~fundamentalMIDI.value).linlin(0,12,0,1));


	~differenceIntensitySlider = Slider(w, Rect(10,70+120+20, 40, 95)).value_(0).action_({
		arg obj;
		~sound3Synth.set(\differenceIntensity, obj.value;);
	});

	//Create spectra
~spectraScreenComposite_bounds_array = [-100+100,355,500,215];
~spectraButton_bounds_array = [250-(200/2)-65-10,200+135-20,110+10+40,20+20];
~spectraAutoscale_bounds_array = [500+250-(200/2)-65+110+10,200+135,110,20];
(basePath +/+  "modules/spectra_screen.scd").load;

	// Hide Autoscale
	//~autoscaleCover = StaticText(w, Rect(250-(200/2)-65+110+10,200+135,110,20)).background_(Color.white);


	//Load graphics elements
~house_icon = Image.new(basePath +/+ "images/house-small.png");
			~maple_icon = Image.new(basePath +/+ "images/mapleICON-small.png");

//All graphics (aesthetic lines and image positions)
w.drawFunc = {
		//Images underneath buttons
		~house_icon.drawInRect(Rect(460,10,30,30), Rect(0,0,30,30), 2, 1.0);
			~maple_icon.drawInRect(Rect(10,10,30,30), Rect(0,0,30,30), 2, 1.0);

		Pen.line(10@310,490@310); // Line above Spectra

		Pen.strokeColor = Color(0,0,0,0.5); //Top line, written differently in code
                Pen.width = 2;
                Pen.stroke;
        };







	//Q. Quit function
(
~quit = Button.new(w, Rect(460,10,30,30))
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
			(if(~scopebutton.value == 1, {
				~oscilloscopeCloseFunction.value;
			}));
			(basePath +/+ "splashscreen.scd").loadPaths;
		});
);


		//Open Stethoscope
~scopebutton = Button(w, Rect(250, 335-20, 120, 20+20))
.states_([
	["Open Oscilloscope", Color.white,Color(0.4824, 0.4863, 0.4863,1)],
	["Close Oscilloscope", Color.white, Color.grey(0.251)]
])
.font_(Font("nil", 12))
	.action_({ // This still seems to cause an Error message of "cycle_" - July 17 2017
	/*arg obj;
	if(obj.value == 1,
		{*/
		arg obj;
		~oscilloscopeButtonFunction.value(obj:obj);
});


	~scope2button1 = Button(w, Rect(250+120, 335-20, 120, 20))
.states_([
	["Set Osc. to ~Freq.1", Color.white,Color(0.4824, 0.4863, 0.4863,1)]
])
.font_(Font("nil", 12))
	.action_({
		/*~d
		//.xZoom_((438.9105/1024)*1)
		.cycle_((501));*/
	/*	{x}.plot*/

	if(~d != nil, {
		~d.cycle_(7*44100/~fundamentalBox.value);
		});

	}
	);

	~scope2button2 = Button(w, Rect(250+120, 335, 120, 20))
.states_([
	["Set Osc. to ~Freq.2", Color.white,Color(0.4824, 0.4863, 0.4863,1)]
])
.font_(Font("nil", 12))
	.action_({
		/*~d
		//.xZoom_((438.9105/1024)*1)
		.cycle_((501));*/
	/*	{x}.plot*/

	if(~d != nil, {
		~d.cycle_(7*44100/~compareBox.value);
		});

	}
	);







	// Freeall
	w.onClose_({
		s.freeAll;
	})

})
)
)