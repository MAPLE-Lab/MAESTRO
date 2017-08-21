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
		~master_window_bounds_array = [Window.screenBounds.width/2-270, Window.screenBounds.height/2-50, 540, 570+50];
w = Window.new("MAPLE Lab Synthesizer (Beta)", Rect.new(
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
		// ~masterTitle = StaticText(w, Rect(0,0,540,40)).string_("Synthesizer                   ").align_(\center).font_(Font(nil, 14, true));
	);

	(~trace +/+  "data/synthesizer_specific_data/synthesizerPlotFunction.scd").load; // Load the Plotting function
	(~trace +/+  "data/oscilloscopeButtonFunctions.scd").load; // Load the oscilloscope button functions


//Record button - sends to Supercollider file in the Recordings section
~record_button_bounds_array = [10, 40+5, 85, 20];
(basePath +/+  "modules/record_button.scd").load;

// SynthDefs define the sound to be played
/*(
SynthDef.new("sound1", {
	arg freq, attackTime, sustainTime, releaseTime, startTime, onCurve, offCurve, intensityValue;

	var mul, mul2, signal, env, intensityPeak;

			//mul = XLine.kr(0.01,1,0.2,0.1); //Ramps sound onset so not so harsh

			intensityPeak = intensityValue*0.2;

			env = Env.new(levels:[0,0,intensityPeak,intensityPeak,0], times:[startTime, attackTime, sustainTime, releaseTime], curve:[0,onCurve,0,offCurve]);

			mul = EnvGen.ar(env);

			//freq = ((2**((-69+midi)/12))*440);

	signal = SinOsc.ar(freq,0, mul);

	Out.ar([0,1], signal); //sends to busses 1 & 2 (stereo), and plays the var "signal"
}).add;
);*/


	12.do({
	arg i, j;
	j = i+1;


	("
(
SynthDef.new("++ ("sound" ++ j).asCompileString ++ ", {
	arg freq, attackTime, sustainTime, releaseTime, startTime, onCurve, offCurve, intensityValue;

	var mul, mul2, signal, env, intensityPeak;

			//mul = XLine.kr(0.01,1,0.2,0.1); //Ramps sound onset so not so harsh

			intensityPeak = intensityValue*0.2;

			env = Env.new(levels:[0,0,intensityPeak,intensityPeak,0], times:[startTime, attackTime, sustainTime, releaseTime], curve:[0,onCurve,0,offCurve]);

			mul = EnvGen.ar(env);

			//freq = ((2**((-69+midi)/12))*440);

	signal = SinOsc.ar(freq,0, mul);

	Out.ar([0,1], signal);
}).add;
);
").interpret.postln;
});

	//Button CompositeViews for hiding and showing
(
~play_image_left = Image.new(basePath +/+ "images/big_button_media/red_left.png");
~play_image_right = Image.new(basePath +/+ "images/big_button_media/red_right.png");
~play_image_indent = Image.new(basePath +/+ "images/big_button_media/red_indent_col.png");

~stop_image_left = Image.new(basePath +/+ "images/big_button_media/black_left.png");
~stop_image_right = Image.new(basePath +/+ "images/big_button_media/black_right.png");
~stop_image_indent = Image.new(basePath +/+ "images/big_button_media/black_indent_col.png");

~play_UserView = UserView(w, Rect(~master_window_bounds_array[2]/2-50,10,100,30));
	~play_UserView.drawFunc_({
		~play_image_left.drawInRect(Rect(0,0,100,30), Rect(0,0,200,60), 2, 1.0);
		~play_image_right.drawInRect(Rect(0,0,100,30), Rect(0,0,200,60), 2, 1.0);
		~play_image_indent.drawInRect(Rect(2,0,100,30), Rect(0,0,200,60), 2, 1.0); // The offset by +2.left looks better for centering
	});

~stop_UserView = UserView(w, Rect(~master_window_bounds_array[2]/2-50,10,100,30));
	~stop_UserView.drawFunc_({
		~stop_image_left.drawInRect(Rect(0,0,100,30), Rect(0,0,200,60), 2, 1.0);
		~stop_image_right.drawInRect(Rect(0,0,100,30), Rect(0,0,200,60), 2, 1.0);
		~stop_image_indent.drawInRect(Rect(0,0,100,30), Rect(0,0,200,60), 2, 1.0);
	});

	//~play_UserView.bounds_(Rect(400-(100/2),65,1,1)); //Hide the play button
	~stop_UserView.bounds_(Rect(~master_window_bounds_array[2]/2-50,10,1,1)); //Hide the stop button
);


// Play Button
	~playButton = Button.new(w, Rect(~master_window_bounds_array[2]/2-50,10,100,30))
.states_([
	["OFF", Color.clear, Color.clear],
	["ON", Color.clear, Color.clear]
])
.action_({
	arg obj;
	if(obj.value == 1, {

			~stop_UserView.bounds_(Rect(~master_window_bounds_array[2]/2-50,10,100,30));

			/*/*1.do({
				arg i;
				"*/
~sound1Synth = Synth("sound1", [
				\freq, ~freq1.value.interpret,
				\attackTime, (~attack1.value.interpret)/1000,
				\sustainTime, (~sustain1.value.interpret)/1000,
				\releaseTime, (~release1.value.interpret)/1000,
				\startTime, (~startTime1.value.interpret)/1000,
				\onCurve, ~onCurve1.value.interpret,
				\offCurve, ~offCurve1.value.interpret,
				\intensityValue, ~intensity1.value.interpret
			]);
			// "}).interpret.postln;*/

			12.do({
	arg i, j;
	j = i+1;

				("~sound" ++ j ++ "Synth = Synth(" ++ ("sound" ++ j).asCompileString
	++ ", [
				\\freq, ~freq" ++ j ++ ".value,
				\\attackTime, (~attack" ++ j ++ ".value)/1000,
				\\sustainTime, (~sustain" ++ j ++ ".value)/1000,
				\\releaseTime, (~release" ++ j ++ ".value)/1000,
				\\startTime, (~startTime" ++ j ++ ".value)/1000,
				\\onCurve, ~onCurve" ++ j ++ ".value,
				\\offCurve, ~offCurve" ++ j ++ ".value,
				\\intensityValue, ~intensity" ++ j ++ ".value
]);").interpret;
});

			~maximumTimeArray = Array.fill(12, {
				arg i;
				j = i+1;

				if(("~intensity" ++ j).interpret.value == 0, {
					0;
				},{

				(("~attack" ++ j).interpret.value + ("~sustain" ++ j).interpret.value + ("~release" ++ j).interpret.value)*1 + ("~startTime" ++ j).interpret.value;
				});

			});

			AppClock.sched(~maximumTimeArray.maxItem*0.001, {~playButton.valueAction_(0);});

		},{

			~stop_UserView.bounds_(Rect(~master_window_bounds_array[2]/2-50,10,1,1)); // Hide


			12.do({
				arg i, j;
				j = i+1;
				("if(~sound" ++ j ++ "Synth.isPlaying == true, {
~sound" ++ j ++ "Synth.free;})"

				).interpret;
			});

		});
});


// Columns

	StaticText(w, Rect(10,70,50,237+73)).background_(Color.grey(0.9)).string_("Freq.
(Hz)").align_(\top).font_(Font(size:11));
	StaticText(w, Rect(60,70,70,237+73)).background_(Color.grey(0.95)).string_("Attack
(ms)").align_(\top).font_(Font(size:11));
	StaticText(w, Rect(130,70,70,237+73)).background_(Color.grey(0.9)).string_("Sustain
(ms)").align_(\top).font_(Font(size:11));
	StaticText(w, Rect(200,70,70,237+73)).background_(Color.grey(0.95)).string_("Release
(ms)").align_(\top).font_(Font(size:11));
	StaticText(w, Rect(270,70,80,237+73)).background_(Color.grey(0.9)).string_("Start Time (ms)").align_(\top).font_(Font(size:11));
	StaticText(w, Rect(350,70,50,237+73)).background_(Color.grey(0.95)).string_("On
Curve").align_(\top).font_(Font(size:11));
	StaticText(w, Rect(400,70,50,237+73)).background_(Color.grey(0.9)).string_("Off
Curve").align_(\top).font_(Font(size:11));
	StaticText(w, Rect(450,70,40,237+73)).background_(Color.grey(0.95)).string_("Int.
(+)").align_(\top).font_(Font(size:11));
	StaticText(w, Rect(490,70,40,237+73)).background_(Color.grey(0.9)).string_("MIDI
(#)").align_(\top).font_(Font(size:11));

	StaticText(w, Rect(10,98,520,2)).background_(Color.grey); // Line (drawHook is underneath)

		StaticText(w, Rect(10,342,520,2)).background_(Color.grey); // Line2 (drawHook is underneath)


	StaticText(w, Rect(10,342,520,38)).background_(Color.grey(0.5,0.35)).string_("Buttons used to fill all fields with the values").align_(\bottom).font_(Font(size:8));

// NumberBoxes

	12.do({
		arg i, j, intensityArray, boxheight, boxspaceheight, fontsize;
		j = i+1;
		intensityArray = [1,0,0,0,0,0,0,0,0,0,0,0];
		boxheight = 18;
		boxspaceheight = 20;
		fontsize = 10;
		("~freq" ++ j ++ "= NumberBox(w, Rect(10+2,102+" ++ (i*boxspaceheight) ++ ",46," ++ boxheight ++ ")).value_(440).align_(\\center).font_(Font(size:"++fontsize++")).maxDecimals_(6).action_({
arg obj;
~midi" ++ j ++ ".value = (log2(obj.value/440)*12)+69;
});
~attack" ++ j ++ "= NumberBox(w, Rect(60+2,102+" ++ (i*boxspaceheight) ++ ",66," ++ boxheight ++ ")).value_(5).align_(\\center).font_(Font(size:"++fontsize++"));
~sustain" ++ j ++ "= NumberBox(w, Rect(130+2,102+" ++ (i*boxspaceheight) ++ ",66," ++ boxheight ++ ")).value_(490).align_(\\center).font_(Font(size:"++fontsize++"));
~release" ++ j ++ "= NumberBox(w, Rect(200+2,102+" ++ (i*boxspaceheight) ++ ",66," ++ boxheight ++ ")).value_(5).align_(\\center).font_(Font(size:"++fontsize++"));
~startTime" ++ j ++ "= NumberBox(w, Rect(270+2,102+" ++ (i*boxspaceheight) ++ ",76," ++ boxheight ++ ")).value_(0).align_(\\center).font_(Font(size:"++fontsize++"));
~onCurve" ++ j ++ "= NumberBox(w, Rect(350+2,102+" ++ (i*boxspaceheight) ++ ",46," ++ boxheight ++ ")).value_(0).align_(\\center).font_(Font(size:"++fontsize++"));
~offCurve" ++ j ++ "= NumberBox(w, Rect(400+2,102+" ++ (i*boxspaceheight) ++ ",46," ++ boxheight ++ ")).value_(0).align_(\\center).font_(Font(size:"++fontsize++"));
~intensity" ++ j ++ "= NumberBox(w, Rect(450+2,102+" ++ (i*boxspaceheight) ++ ",36," ++ boxheight ++ ")).value_(" ++ intensityArray[i] ++ ").align_(\\center).font_(Font(size:"++fontsize++"));
~midi" ++ j ++ "= NumberBox(w, Rect(490+2,102+" ++ (i*boxspaceheight) ++ ",36," ++ boxheight ++ ")).value_((log2(~freq" ++ j ++ ".value/440)*12)+69).align_(\\center).font_(Font(size:"++fontsize++")).maxDecimals_(6).action_({
arg obj;
~freq" ++ j ++ ".value = (2**((-69+obj.value)/12))*440;
});"
		).interpret;
	});

	12.do({
		arg i, j, boxheight, boxspaceheight, fontsize;
		j = i+1;
		boxheight = 18;
		boxspaceheight = 20;
		fontsize = 8;
		("~number" ++ j ++ "= StaticText(w, Rect(0,102+" ++ (i*boxspaceheight) ++ ",10," ++ boxheight ++ ")).string_(" ++ (j).asCompileString ++ ").align_(\\center).font_(Font(size:"++fontsize++"));").interpret;
	});



	// Fill-all sections
	1.do({
		arg i, j, boxheight, boxspaceheight, fontsize, boxcolor, stringcolor;
		j = i+13;
		boxheight = 14;
		boxspaceheight = 0;
		fontsize = 7;
		boxcolor = Color.grey(0.3);
		stringcolor = Color.white;
		(
			"~freq" ++ j ++ "= NumberBox(w, Rect(10+2,346+" ++ (i*boxspaceheight) ++ ",46," ++ boxheight ++ ")).value_(440).align_(\\center).font_(Font(size:"++fontsize++")).maxDecimals_(6).background_(" ++ boxcolor ++ ").normalColor_(" ++ stringcolor ++ ").action_({
arg obj;
~midi" ++ j ++ ".value = (log2(obj.value/440)*12)+69;
});
~attack" ++ j ++ "= NumberBox(w, Rect(60+2,346+" ++ (i*boxspaceheight) ++ ",66," ++ boxheight ++ ")).value_(5).align_(\\center).font_(Font(size:"++fontsize++")).background_(" ++ boxcolor ++ ").normalColor_(" ++ stringcolor ++ ");
~sustain" ++ j ++ "= NumberBox(w, Rect(130+2,346+" ++ (i*boxspaceheight) ++ ",66," ++ boxheight ++ ")).value_(490).align_(\\center).font_(Font(size:"++fontsize++")).background_(" ++ boxcolor ++ ").normalColor_(" ++ stringcolor ++ ");
~release" ++ j ++ "= NumberBox(w, Rect(200+2,346+" ++ (i*boxspaceheight) ++ ",66," ++ boxheight ++ ")).value_(5).align_(\\center).font_(Font(size:"++fontsize++")).background_(" ++ boxcolor ++ ").normalColor_(" ++ stringcolor ++ ");
~startTime" ++ j ++ "= NumberBox(w, Rect(270+2,346+" ++ (i*boxspaceheight) ++ ",76," ++ boxheight ++ ")).value_(0).align_(\\center).font_(Font(size:"++fontsize++")).background_(" ++ boxcolor ++ ").normalColor_(" ++ stringcolor ++ ");
~onCurve" ++ j ++ "= NumberBox(w, Rect(350+2,346+" ++ (i*boxspaceheight) ++ ",46," ++ boxheight ++ ")).value_(0).align_(\\center).font_(Font(size:"++fontsize++")).background_(" ++ boxcolor ++ ").normalColor_(" ++ stringcolor ++ ");
~offCurve" ++ j ++ "= NumberBox(w, Rect(400+2,346+" ++ (i*boxspaceheight) ++ ",46," ++ boxheight ++ ")).value_(0).align_(\\center).font_(Font(size:"++fontsize++")).background_(" ++ boxcolor ++ ").normalColor_(" ++ stringcolor ++ ");
~intensity" ++ j ++ "= NumberBox(w, Rect(450+2,346+" ++ (i*boxspaceheight) ++ ",36," ++ boxheight ++ ")).value_(0).align_(\\center).font_(Font(size:"++fontsize++")).background_(" ++ boxcolor ++ ").normalColor_(" ++ stringcolor ++ ");
~midi" ++ j ++ "= NumberBox(w, Rect(490+2,346+" ++ (i*boxspaceheight) ++ ",36," ++ boxheight ++ ")).value_((log2(~freq" ++ j ++ ".value/440)*12)+69).align_(\\center).font_(Font(size:"++fontsize++")).maxDecimals_(6).background_(" ++ boxcolor ++ ").normalColor_(" ++ stringcolor ++ ").action_({
arg obj;
~freq" ++ j ++ ".value = (2**((-69+obj.value)/12))*440;
});"
		).interpret;
	});

// Fill-all buttons
	Button(w, Rect(12,360,46,12)).action_({
		12.do({
			arg i,j;
			j=i+1;
			("~freq" ++ j ++ ".valueAction_(~freq13.value)").interpret
		})
	});

	Button(w, Rect(62,360,66,12)).action_({
		12.do({
			arg i,j;
			j=i+1;
			("~attack" ++ j ++ ".valueAction_(~attack13.value)").interpret
		})
	});

	Button(w, Rect(132,360,66,12)).action_({
		12.do({
			arg i,j;
			j=i+1;
			("~sustain" ++ j ++ ".valueAction_(~sustain13.value)").interpret
		})
	});

	Button(w, Rect(202,360,66,12)).action_({
		12.do({
			arg i,j;
			j=i+1;
			("~release" ++ j ++ ".valueAction_(~release13.value)").interpret
		})
	});

	Button(w, Rect(272,360,76,12)).action_({
		12.do({
			arg i,j;
			j=i+1;
			("~startTime" ++ j ++ ".valueAction_(~startTime13.value)").interpret
		})
	});

	Button(w, Rect(352,360,46,12)).action_({
		12.do({
			arg i,j;
			j=i+1;
			("~onCurve" ++ j ++ ".valueAction_(~onCurve13.value)").interpret
		})
	});

	Button(w, Rect(402,360,46,12)).action_({
		12.do({
			arg i,j;
			j=i+1;
			("~offCurve" ++ j ++ ".valueAction_(~offCurve13.value)").interpret
		})
	});

	Button(w, Rect(452,360,36,12)).action_({
		12.do({
			arg i,j;
			j=i+1;
			("~intensity" ++ j ++ ".valueAction_(~intensity13.value)").interpret
		})
	});

	Button(w, Rect(492,360,36,12)).action_({
		12.do({
			arg i,j;
			j=i+1;
			("~midi" ++ j ++ ".valueAction_(~midi13.value)").interpret
		})
	});

	// Plot Envelope
	~plotterNumber = NumberBox(w, Rect(40,315+50+20,30,20)).value_(1).align_(\center);
	Button(w, Rect(10,315+50+20,30,20)).string_("Plot").action_({
		~synthesizerPlotFunction.value(j:~plotterNumber.value);
	});

	// Semitone modifier
	~semitoneShifterNumber = NumberBox(w, Rect(510,315+50+20,20,20)).value_(0).font_(Font(size:8));
	~semitoneShifterButton = Button(w, Rect(380,315+50+20,130,20)).string_("Press to change all MIDI values
by the given semitone value:").font_(Font(size:8)).action_({
12.do({
		arg i, j;
		j = i+1;
		j.postln;
			("~midi" ++ j ++ ".valueAction = ~midi" ++ j ++ ".value + ~semitoneShifterNumber.value"
		).interpret;
		});
	});

//~freq" ++ j ++ ".valueAction_((2**((-69+1+~midi" ++ j ++ ".value)/12))*440);

	//Create spectra
~spectraScreenComposite_bounds_array = [-100+100,355+50,540,215];
~spectraButton_bounds_array = [250-(200/2)-65-10,200+135-20+50+20,110+10+40,20];
~spectraAutoscale_bounds_array = [500+250-(200/2)-65+110+10,200+135+50,110,20];
(basePath +/+  "modules/spectra_screen.scd").load;
	~spectraTitle.bounds_(Rect(10,335+50+25,480,80)).stringColor_(Color.white);

	// Hide Autoscale
	//~autoscaleCover = StaticText(w, Rect(250-(200/2)-65+110+10,200+135,110,20)).background_(Color.white);


	//Load graphics elements
~house_icon = Image.new(basePath +/+ "images/house-small.png");
			~maple_icon = Image.new(basePath +/+ "images/mapleICON-small.png");

//All graphics (aesthetic lines and image positions)
w.drawFunc = {
		//Images underneath buttons
		~house_icon.drawInRect(Rect(500,10,30,30), Rect(0,0,30,30), 2, 1.0);
			~maple_icon.drawInRect(Rect(10,10,30,30), Rect(0,0,30,30), 2, 1.0);

		Pen.line(10@(310+71),530@(310+71)); // Line above Spectra

		Pen.strokeColor = Color(0,0,0,0.5); //Top line, written differently in code
                Pen.width = 2;
                Pen.stroke;
        };

	// Save parameters to file
	~exportParametersButton = Button(w, Rect(100, 40+5, 115, 20)).states_([
		["Save Parameters to File", Color.white, Color(0.4824, 0.4863, 0.4863,1)]
	])
	.font_(Font("nil", 10))
	.action_({

		File.new(~trace +/+ "synthesizer_files/" ++ ~exportParametersText.value ++ ".txt", "w").write(
"Freq. (Hz)\tAttack (ms)\tSustain (ms)\tRelease (ms)\tStart Time (ms)\tOn Curve\tOff Curve\tInt. (+)\tMIDI (#)
"
).close;


12.do({
	arg i, j;
	j = i+1;
			File.new(~trace +/+ "synthesizer_files/" ++ ~exportParametersText.value ++ ".txt", "a").write("" ++ ("~freq" ++ j ++ ".value").interpret ++ "\t"++ ("~attack" ++ j ++ ".value").interpret ++ "\t"++ ("~sustain" ++ j ++ ".value").interpret ++ "\t"++ ("~release" ++ j ++ ".value").interpret ++ "\t"++ ("~startTime" ++ j ++ ".value").interpret ++ "\t"++ ("~onCurve" ++ j ++ ".value").interpret ++ "\t"++ ("~offCurve" ++ j ++ ".value").interpret ++ "\t"++ ("~intensity" ++ j ++ ".value").interpret ++ "\t"++ ("~midi" ++ j ++ ".value").interpret ++ "
"
).close
});

		("Parameters for the 12 sounds saved to filepath:" + ~trace +/+ "synthesizer_files/" ++ ~exportParametersText.value ++ ".txt").postln;

	});
	~exportParametersText = TextField(w, Rect(215, 40+5, 100, 20))
	.font_(Font(size:10))
	.value_("synthesizer1");

// Import button and functionality
	~importParametersButton = Button(w, Rect(320, 40+5, 115, 20)).states_([
		["Import Parameter File", Color.white, Color(0.4824, 0.4863, 0.4863,1)]
	])
	.font_(Font("nil", 10))
	.action_({
	arg obj;
		~importParametersTable = TabFileReader.read(~trace +/+  "synthesizer_files/" ++ ~importParametersText.value ++ ".txt");

// Fix empties
		~importParametersTableFormatted = Array.fill(13, {
			arg a,b;
			b = a+1;
			if(a == 0, {~importParametersTable[0]}, {

				Array.fill(9, {
					arg i,j;
					j = i+2;

					switch(i,
						0, {if(~importParametersTable[a][0] != "", {
							// Use frequency data
							~importParametersTable[a][0]},{
							// If no frequency data, use MIDI data
							if(~importParametersTable[a][8] != "", {
								(2**((-69+~importParametersTable[a][8].interpret)/12))*440 // .interpret required to change from String to Float
							}, {
								// If no MIDI data either
								0})
						}
						)},
						1, {if(and(~importParametersTable[a][i] != "",~importParametersTable[a][i] != nil), {~importParametersTable[a][i]},{0})},
						2, {if(and(~importParametersTable[a][i] != "",~importParametersTable[a][i] != nil), {~importParametersTable[a][i]},{0})},
						3, {if(and(~importParametersTable[a][i] != "",~importParametersTable[a][i] != nil), {~importParametersTable[a][i]},{0})},
						4, {if(and(~importParametersTable[a][i] != "",~importParametersTable[a][i] != nil), {~importParametersTable[a][i]},{0})},
						5, {if(and(~importParametersTable[a][i] != "",~importParametersTable[a][i] != nil), {~importParametersTable[a][i]},{0})},
						6, {if(and(~importParametersTable[a][i] != "",~importParametersTable[a][i] != nil), {~importParametersTable[a][i]},{0})},
						7, {if(and(~importParametersTable[a][i] != "",~importParametersTable[a][i] != nil), {~importParametersTable[a][i]},{0})},
						8, {if(and(~importParametersTable[a][8] != "", ~importParametersTable[a][8] != nil), {
							// Use MIDI data
							~importParametersTable[a][8]},{
							// If no MIDI data, use freq data
							if(~importParametersTable[a][0] != "", {
								(log2(~importParametersTable[a][0].interpret/440)*12)+69 // .interpret required to change from String to Float
							}, {
								// If no MIDI data either
								0})
						}
						)}
					);
				});
			});
		});



		12.do({
		arg i, j;
		j = i+1;
		(
		"~freq" ++ j ++ ".value_(" ++ ~importParametersTableFormatted[j][0] ++ ");" +
		"~attack" ++ j ++ ".value_(" ++ ~importParametersTableFormatted[j][1] ++ ");" +
		"~sustain" ++ j ++ ".value_(" ++ ~importParametersTableFormatted[j][2] ++ ");" +
		"~release" ++ j ++ ".value_(" ++ ~importParametersTableFormatted[j][3] ++ ");" +
		"~startTime" ++ j ++ ".value_(" ++ ~importParametersTableFormatted[j][4] ++ ");" +
		"~onCurve" ++ j ++ ".value_(" ++ ~importParametersTableFormatted[j][5] ++ ");" +
		"~offCurve" ++ j ++ ".value_(" ++ ~importParametersTableFormatted[j][6] ++ ");" +
		"~intensity" ++ j ++ ".value_(" ++ ~importParametersTableFormatted[j][7] ++ ");" +
		"~midi" ++ j ++ ".value_(" ++ ~importParametersTableFormatted[j][8] ++ ");"
		).interpret;
	});

	});

	~importParametersText = TextField(w, Rect(435, 40+5, 100, 20))
	.font_(Font(size:10))
	.value_("synthesizer_table_template");





	//Q. Quit function
(
~quit = Button.new(w, Rect(500,10,30,30))
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


		//Open Stethoscope / Oscilloscope
~scopebutton = Button(w, Rect(250, 335-20+50+20, 120, 20))
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


	/*~scope2button1 = Button(w, Rect(250+120, 335-20, 120, 20))
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
	);*/







	// Freeall
	w.onClose_({
		s.freeAll;
	})

})
)
)