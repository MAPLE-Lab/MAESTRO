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
TabFileReader.read(~trace +/+  "admin/access.txt").[4].[2].interpret) //Cannot be resized by user without admin permission.
.background_(Color.white)
.userCanClose_(true)
.front
.acceptsMouseOver_(true);
);

//B. Add starting ID parameters
(
~module_ID = "difference_tones";
~inspectorExists = 0;
);



		(basePath +/+  "data/tones_pitch_name.scd").load; // Load the function for updating the information panel below the harmonics panel
	(~trace +/+  "data/oscilloscopeButtonFunctions.scd").load; // Load the oscilloscope button functions
(~trace +/+  "data/readTextFileFunction.scd").load; // Load the text reader function

	//Record button - sends to Supercollider file in the Recordings section
~record_button_bounds_array = [75, 15, 85, 20];
(basePath +/+  "modules/record_button.scd").load;


	//Opening paragraph for the module, holds data for Inspector window to load
~para = StaticText(w,Rect(5000,10,~master_window_bounds_array[2]-20,80));
~para.string_(~readTextFileFunction.value(path:"difference_tones/difference_tonesIntro.txt"));

	//Inspector button
	~inspector = Button.new(w, Rect(50, 15, 20, 20))
	.states_([["(i)", Color.white, Color.gray], ["(i)", Color.gray, Color.black]])
	.font_(Font("nil", 10))
	.action_({ arg obj;
		if(obj.value == 1, {
			(basePath +/+  "modules/inspector.scd").loadPaths;
		},
		{
			~inspectorWindow.close;
		});
	});





// SynthDefs define the sound to be played
(
SynthDef.new("sound1", {
	arg /*midi = 60*/ freq = 440, fundamentalIntensity=1;

	var mul, mul2, signal/*, freq*/;

			mul = XLine.kr(0.01,1,0.2,0.1)*fundamentalIntensity; //Ramps sound onset so not so harsh

			//freq = ((2**((-69+midi)/12))*440);

	signal = SinOsc.ar(freq,0, mul);

	Out.ar([0,1], signal); //sends to busses 1 & 2 (stereo), and plays the var "signal"
}).add;
);


	(
SynthDef.new("sound2", {
	arg /*midi = 60*/ freq = 440, compareIntensity=1;

	var mul, mul2, signal/*, freq*/;

			mul = XLine.kr(0.01,1,0.2,0.1)*compareIntensity; //Ramps sound onset so not so harsh

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

			mul = XLine.kr(0.01,1,0.2,0.1)*differenceIntensity;

	signal = SinOsc.ar(freq,0, mul);

	Out.ar([0,1], signal); //sends to busses 1 & 2 (stereo), and plays the var "signal"
}).add;
);

// Sound Sliders

	~slidersLeftEdge = 90;
	~slidersTopEdge = 100-15;
	~slidersHeight = 150;
	~spaceBetweenPrimaryFrequencySliders = 70;
	~spaceBetweenFirstAndDifferenceSliders = 250;


	// Sound 1
	~fundamentalTitle = StaticText(w, Rect(~slidersLeftEdge-5,~slidersTopEdge-40,50,20)).string_("Freq. 1").font_(Font(bold:true)).align_(\center);
	~fundamentalSlider = Slider(w, Rect(~slidersLeftEdge,~slidersTopEdge,40,~slidersHeight)).value_(440.linlin(0,5000,0,1)).background_(Color.grey(0.95)).action_({
		arg obj;
		~fundamentalBox.value_(obj.value.linlin(0,1,0,5000));

		if(~playButton.value == 1,{
			~sound1Synth.set(\freq, obj.value.linlin(0,1,0,5000););
		});


		if(~fundamentalBox.value > 0, {
					~fundamentalMIDI.value = (log2(~fundamentalBox.value/440)*12)+69;
			~fundamentalMIDICover.bounds_(~fundamentalMIDI.bounds.moveBy(-500,0).insetBy(2,2));
		}, {
			~fundamentalMIDI.value = 0;
			~fundamentalMIDICover.bounds_(~fundamentalMIDI.bounds.insetBy(2,2));
		});
		~differenceTonePitchName.value(fundamentalNote:~fundamentalMIDI.value, outputToStaticText:~fundamentalName);
		~differenceSlider.valueAction_((~compareMIDI.value-~fundamentalMIDI.value).linlin(-12,12,0,1));

		~keyboardUpdateGUI.value;
	});
	~fundamentalBox = NumberBox(w, Rect(~slidersLeftEdge,~slidersTopEdge-20,40,20)).value_(440).action_({
		arg obj;
		~fundamentalSlider.valueAction_(obj.value.linlin(0,5000,0,1))
	});
	~fundamentalMIDI = NumberBox(w, Rect(~slidersLeftEdge,~slidersTopEdge+~fundamentalSlider.bounds.height+20,40,20)).value_(69).action_({
		arg obj;
		var val;
		// ~midi2 = (log2(~compareBox.value/440)*12)+69;
		val = ((2**((-69+obj.value)/12))*440);
		~fundamentalBox.valueAction_(val);
	})
	.clipLo_(0);
		~fundamentalName = StaticText(w, Rect(~slidersLeftEdge,~slidersTopEdge+~fundamentalSlider.bounds.height,40,20)).string_("A4").align_(\center);

	~fundamentalIntensitySlider = Knob(w, Rect(~slidersLeftEdge+5,~slidersTopEdge+~fundamentalSlider.bounds.height+42,30,30)).value_(1).action_({
		arg obj;
		~sound1Synth.set(\fundamentalIntensity, obj.value;);
	~keyboardUpdateGUI.value;
	});

		~fundamentalMIDICover = StaticText(w, ~fundamentalMIDI.bounds.moveBy(-500,0).insetBy(2,2)).string_("NaN").background_(Color.white).align_(\center);


	// Sound 2
	~compareTitle = StaticText(w, Rect(~slidersLeftEdge-5+~spaceBetweenPrimaryFrequencySliders,~slidersTopEdge-40,50,20)).string_("Freq. 2").font_(Font(bold:true)).align_(\center);
	~compareSlider = Slider(w, Rect(~slidersLeftEdge+~spaceBetweenPrimaryFrequencySliders,~slidersTopEdge,40,~slidersHeight)).value_(880.linlin(0,5000,0,1)).background_(Color.grey(0.90)).action_({
		arg obj;
		~compareBox.value_(obj.value.linlin(0,1,0,5000));

		if(~playButton.value == 1,{
			~sound2Synth.set(\freq, obj.value.linlin(0,1,0,5000););
		});

		if(~compareBox.value > 0, {
		~compareMIDI.value = 	(log2(~compareBox.value/440)*12)+69;
		~compareMIDICover.bounds_(~compareMIDI.bounds.moveBy(-500,0).insetBy(2,2));
		}, {
			~compareMIDI.value = 0;
			~compareMIDICover.bounds_(~compareMIDI.bounds.insetBy(2,2))
		});
		~differenceTonePitchName.value(fundamentalNote:~compareMIDI.value, outputToStaticText:~compareName);
		~differenceSlider.valueAction_((~compareMIDI.value-~fundamentalMIDI.value).linlin(-12,12,0,1));

		~keyboardUpdateGUI.value;
	});
	~compareBox = NumberBox(w, Rect(~slidersLeftEdge+~spaceBetweenPrimaryFrequencySliders,~slidersTopEdge-20,40,20)).value_(880).action_({
		arg obj;
		~compareSlider.valueAction_(obj.value.linlin(0,5000,0,1))
	});
	~compareMIDI = NumberBox(w, Rect(~slidersLeftEdge+~spaceBetweenPrimaryFrequencySliders,~slidersTopEdge+~fundamentalSlider.bounds.height+20,40,20)).value_(81).action_({
		arg obj;
		var val;
		// ~midi2 = (log2(~compareBox.value/440)*12)+69;
		val = ((2**((-69+obj.value)/12))*440);
		~compareBox.valueAction_(val);
	})
	.clipLo_(0);
	~compareName = StaticText(w, Rect(~slidersLeftEdge+~spaceBetweenPrimaryFrequencySliders,~slidersTopEdge+~fundamentalSlider.bounds.height,40,20)).string_("A5").align_(\center);

	~compareIntensitySlider = Knob(w, Rect(~slidersLeftEdge+~spaceBetweenPrimaryFrequencySliders+5,~slidersTopEdge+~fundamentalSlider.bounds.height+42,30,30)).value_(1).action_({
		arg obj;
		~sound2Synth.set(\compareIntensity, obj.value;);
		~keyboardUpdateGUI.value;
	});

	~compareMIDICover = StaticText(w, ~compareMIDI.bounds.moveBy(-500,0).insetBy(2,2)).string_("NaN").background_(Color.white).align_(\center);


	// Difference Data
	// Immediately play the difference tone, but silent
	/*AppClock.sched(0.01, {~sound3Synth = Synth("sound3", [\freq, 440, \differenceIntensity:0.0]);});*/

	~differenceTitle = StaticText(w, Rect(~slidersLeftEdge+~spaceBetweenFirstAndDifferenceSliders-40,~slidersTopEdge-40,120,20)).string_("Difference Tone").font_(Font(bold:true)).align_(\center);
	~differenceBox = NumberBox(w, Rect(~slidersLeftEdge+~spaceBetweenFirstAndDifferenceSliders,~slidersTopEdge-20,40,20)).background_(Color.grey(0.2)).value_(440).normalColor_(Color.white);
	~differenceMIDI = NumberBox(w, Rect(~slidersLeftEdge+~spaceBetweenFirstAndDifferenceSliders,~slidersTopEdge+~fundamentalSlider.bounds.height+20,40,20)).background_(Color.grey(0.2)).value_(12).normalColor_(Color.white);

	~differenceSlider = Slider(w, Rect(~slidersLeftEdge+~spaceBetweenFirstAndDifferenceSliders,~slidersTopEdge,40,~slidersHeight)).knobColor_(Color.grey(0.2)).background_(Color.grey(0.2)).value_(1).action_({


		~differenceBox.value_((~compareBox.value-~fundamentalBox.value).abs);
		~differenceMIDI.value_((~compareMIDI.value-~fundamentalMIDI.value).abs);
		~sound3Synth.set(\freq, ~differenceBox.value;);
			~differenceMIDICoverCheckFunction.value;

	});

	~differenceLabelsArray = ["P1", "m2", "M2", "m3", "M3", "P4", "TT", "P5", "m6", "M6", "m7", "M7", "P8"];

	~differenceLabelsArrayDouble = [~differenceLabelsArray.reverse.drop(-1), ~differenceLabelsArray].flatten;

	~differenceSliderCover = StaticText(w, bounds:Rect(~differenceSlider.bounds.left,~differenceSlider.bounds.top-20,~differenceSlider.bounds.width,~differenceSlider.bounds.height+60));

	~differenceLabelsFontSize = 6;

	~differenceLabelsDistance = 5.35;
	(13*2-1).do({
		arg i,j;

		if(i.even, {j = 0}, {j = 12});

		("StaticText(w, Rect(~differenceSlider.bounds.left+~differenceSlider.bounds.width+" ++ j ++ ", ~differenceSlider.bounds.top+(" ++ i ++ "*~differenceLabelsDistance), 20, 20)).font_(Font(nil, ~differenceLabelsFontSize)).string_(~differenceLabelsArrayDouble[" ++ i ++ "]).stringColor_(Color.black).align_(" ++ "\\" ++ "left);").interpret;
	});

	/*~differenceLabels = StaticText(w, Rect(50+5,70+120+1,500-100+50,20)).font_(Font("Courier New", 8)).string_(
		// "P1     m2     M2     m3     M3     P4     P5     m6     M6     m7     M7     P8"
	).align_(\left).stringColor_(Color.white);*/

	//~midi1 = (log2(~fundamentalBox.value/440)*12)+69;
	//~differenceMIDI = ~midi2-~midi1;
	//~differenceSlider.value_((~compareMIDI.value-~fundamentalMIDI.value).linlin(0,12,0,1));


	~differenceIntensitySlider = Knob(w, Rect(~slidersLeftEdge+~spaceBetweenFirstAndDifferenceSliders+5,~slidersTopEdge+~fundamentalSlider.bounds.height+40+2,30,30)).value_(0).action_({
		arg obj;
		~sound3Synth.set(\differenceIntensity, obj.value;);
		~keyboardUpdateGUI.value;
	});

	~differenceMIDICover = StaticText(w, ~differenceMIDI.bounds.moveBy(-500,0).insetBy(2,2)).string_("NaN").stringColor_(Color.white).background_(Color.grey(0.2)).align_(\center);

	~differenceMIDICoverCheckFunction = {
		if(and(~fundamentalMIDI.value == 0,~compareMIDI.value == 0), {
			~differenceMIDICover.bounds_(~differenceMIDI.bounds.insetBy(2,2));
		},{
			~differenceMIDICover.bounds_(~differenceMIDI.bounds.moveBy(-500,0).insetBy(2,2));
		}
		);
	};

	// Keyboard GUI

	// Basics (artifacts due to adaptation from TUNING code)
		~color_arrayMAN = Array.fill(200, 0);
	~greyIntensity = 1;

	~keyboardUpdateGUI = {
	// The note intensities
	// NOTE: 0 means completely on, 1 means completely off
	// The first is MIDI number 21
if(~playButton.value == 1, {

	~color_array = Array.fill(200, {
		arg i;

		if(i == (~fundamentalMIDI.value-1),{~fundamentalIntensitySlider.value.linlin(0,1,1,0)},{

			if(i == (~compareMIDI.value-1),{~compareIntensitySlider.value.linlin(0,1,1,0)},{

				if(i == (~differenceMIDI.value-1),{~differenceIntensitySlider.value.linlin(0,1,1,0)},{1});

			});

			});


	});

	~keyboardCodeGUI = {
		(if(~key_vis.value == 1, {
			(~trace +/+  "data/difference_tones_keyboard_GUI_colours.scd").load;
		}));
	};



			if(~key_vis.value == 1, { ~keyboardUpdateGUI_action.value;});

		});
	};

	// Reset keyboard
	~keyboardUpdateGUIClear = {

		~color_array = Array.fill(200, {1});
		if(~key_vis.value == 1, {~keyboardUpdateGUI_action.value;});
	};


// Row Labels
	~frequencyLabel = StaticText(w, Rect(~slidersLeftEdge-40,~slidersTopEdge-20,40,20)).string_("Hz ").align_(\right);
	~midiLabel = StaticText(w, Rect(~slidersLeftEdge-40,~slidersTopEdge+~fundamentalSlider.bounds.height+20,40,20)).string_("MIDI ").align_(\right);
		~nameLabel = StaticText(w, Rect(~slidersLeftEdge-80,~slidersTopEdge+~fundamentalSlider.bounds.height,80,20)).string_("Closest Pitch ").align_(\right);
	~intensityLabel = StaticText(w, Rect(~slidersLeftEdge-60,~slidersTopEdge+~fundamentalSlider.bounds.height+47,60,20)).string_("Intensity ").align_(\right);


	//Button CompositeViews for hiding and showing
(
~play_image_left = Image.new(basePath +/+ "images/big_button_media/red_left.png");
~play_image_right = Image.new(basePath +/+ "images/big_button_media/red_right.png");
~play_image_indent = Image.new(basePath +/+ "images/big_button_media/red_indent_col.png");

~stop_image_left = Image.new(basePath +/+ "images/big_button_media/black_left.png");
~stop_image_right = Image.new(basePath +/+ "images/big_button_media/black_right.png");
~stop_image_indent = Image.new(basePath +/+ "images/big_button_media/black_indent_col.png");

~play_UserView = UserView(w, Rect(200,10,100,30));
	~play_UserView.drawFunc_({
		~play_image_left.drawInRect(Rect(0,0,100,30), Rect(0,0,200,60), 2, 1.0);
		~play_image_right.drawInRect(Rect(0,0,100,30), Rect(0,0,200,60), 2, 1.0);
		~play_image_indent.drawInRect(Rect(2,0,100,30), Rect(0,0,200,60), 2, 1.0); // The offset by +2.left looks better for centering
	});

~stop_UserView = UserView(w, Rect(200,10,100,30));
	~stop_UserView.drawFunc_({
		~stop_image_left.drawInRect(Rect(0,0,100,30), Rect(0,0,200,60), 2, 1.0);
		~stop_image_right.drawInRect(Rect(0,0,100,30), Rect(0,0,200,60), 2, 1.0);
		~stop_image_indent.drawInRect(Rect(0,0,100,30), Rect(0,0,200,60), 2, 1.0);
	});

	//~play_UserView.bounds_(Rect(400-(100/2),65,1,1)); //Hide the play button
	~stop_UserView.bounds_(Rect(200,10,1,1)); //Hide the stop button
);

	// Play button
	// Button to play the Basic SynthDef
~playButton = Button.new(w, Rect(200,10,100,30))
.states_([
	["Sound OFF", Color.clear, Color.clear],
	["Sound ON", Color.clear, Color.clear]
])
.action_({
	arg obj;
	if(obj.value == 1, {
			~stop_UserView.bounds_(Rect(200,10,100,30)); //Sow the stop button
		~sound1Synth = Synth("sound1", [\freq, ~fundamentalBox.value, \fundamentalIntensity:~fundamentalIntensitySlider.value]);
			~sound2Synth = Synth("sound2", [\freq, ~compareBox.value, \compareIntensity:~compareIntensitySlider.value]);
			~sound3Synth = Synth("sound3", [\freq, 440, \differenceIntensity:~differenceIntensitySlider.value]);

			~keyboardUpdateGUI.value;
	},{
			~stop_UserView.bounds_(Rect(200,10,1,1)); //Hide the stop button
		~sound1Synth.free;
			~sound2Synth.free;
			~sound3Synth.free;

		~keyboardUpdateGUIClear.value;
		});
});

	// Activate play button with spacebar
w.view.keyDownAction_( { |view, char, mod, uni, key|
		if(key == 49, {
			switch(~playButton.value,
				0, {~playButton.valueAction_(1)},
				1, {~playButton.valueAction_(0)},
			);
		}, { nil });
    } );

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
~keyboard_image = Image.new(basePath +/+ "images/keyboard_small.png");

//All graphics (aesthetic lines and image positions)
w.drawFunc = {
		//Images underneath buttons
		~house_icon.drawInRect(Rect(10,10,30,30), Rect(0,0,30,30), 2, 1.0);
			~maple_icon.drawInRect(Rect(460,10,30,30), Rect(0,0,30,30), 2, 1.0);
		~keyboard_image.drawInRect(Rect(10,312,60,25), Rect(0,0,60,25), 2, 1.0);

		Pen.line(10@310,490@310); // Line above Spectra

		Pen.strokeColor = Color(0,0,0,0.5); //Top line, written differently in code
                Pen.width = 2;
                Pen.stroke;
        };


//Keyboard visualizer button
		~key_vis = Button.new(w, Rect(10,312,60,25))
	.states_([["", Color.black, Color.clear],["CLOSE", Color.white, Color(0,0,0,0.7)]])
	.font_(Font("nil", 10))
	.action_({

arg obj;
		if(obj.value == 1,
				// ~keyboard_open.value == 1,
			{
					// ~keyboard_open = 0;
	(basePath +/+  "modules/keyboard.scd").loadPaths; //This line allows all contact buttons to be updated automatically


				/*~fslider.valueAction_(~fslider.value); //This allows it to refresh real-time

					if(~vinbutton.value == 1, {
						~greyIntensity = 1;
						~deviant_fill.background_(Color.clear); // Now clear instead of black
						});*/
~keyboardUpdateGUI.value;
		},{

~keyboardWindow.close;
					// ~keyboard_open = 1;
		};);



		});





	//Q. Quit function
(
~quit = Button.new(w, Rect(10,10,30,30))
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
	});


	( // Start with windows open
AppClock.sched(0.01,{
			~inspector.valueAction_(1); // Start with the inspector window open

			~key_vis.valueAction_(1); // Start with the keyboard window open
    nil;
});

		AppClock.sched(0.1,{
			// ~inspector.valueAction_(1); // Start with the inspector window open

			~scopebutton.valueAction_(1); // Start with the oscilloscopes open

			// ~key_vis.valueAction_(1); // Start with the keyboard window open


	~keyboardUpdateGUI.value;

			w.front;

			nil;
		});
);

})
)
)