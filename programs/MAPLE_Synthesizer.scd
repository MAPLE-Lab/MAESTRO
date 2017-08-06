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
		~masterTitle = StaticText(w, Rect(0,0,500,40)).string_("Synthesizer").align_(\center).font_(Font(nil, 14, true));
	);

	(~trace +/+  "data/synthesizer_specific_data/synthesizerPlotFunction.scd").load; // Load the Plotting function



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


	8.do({
	arg i, j;
	j = i+1;

	j.postln;

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

// Play Button
	~playButton = Button.new(w, Rect(200,30,100,30))
.states_([
	["Sound OFF", Color.white, Color.red(0.7)],
	["Sound ON", Color.white, Color.green(0.5)]
])
.action_({
	arg obj;
	if(obj.value == 1, {

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

			8.do({
	arg i, j;
	j = i+1;

	j.postln;

				("~sound" ++ j ++ "Synth = Synth(" ++ ("sound" ++ j).asCompileString
	++ ", [
\\freq, ~freq" ++ j ++ ".value.interpret,
				\\attackTime, (~attack" ++ j ++ ".value.interpret)/1000,
				\\sustainTime, (~sustain" ++ j ++ ".value.interpret)/1000,
				\\releaseTime, (~release" ++ j ++ ".value.interpret)/1000,
				\\startTime, (~startTime" ++ j ++ ".value.interpret)/1000,
				\\onCurve, ~onCurve" ++ j ++ ".value.interpret,
				\\offCurve, ~offCurve" ++ j ++ ".value.interpret,
				\\intensityValue, ~intensity" ++ j ++ ".value.interpret
]);").interpret;
});

			~maximumTimeArray = Array.fill(8, {
				arg i;
				j = i+1;

				if(("~intensity" ++ j).interpret.value.interpret == 0, {
					0;
				},{

				(("~attack" ++ j).interpret.value.interpret + ("~sustain" ++ j).interpret.value.interpret + ("~release" ++ j).interpret.value.interpret)*0.001 + ("~startTime" ++ j).interpret.value.interpret;
				});

			});

			AppClock.sched(~maximumTimeArray.maxItem, {~playButton.valueAction_(0);});

		},{
			8.do({
				arg i, j;
				j = i+1;
				j.postln;
				("~sound" ++ j ++ "Synth.free;").interpret;
			});

		});
});


// Columns

	StaticText(w, Rect(10,70,50,237)).background_(Color.grey(0.9)).string_("Freq. (Hz)").align_(\top);
	StaticText(w, Rect(60,70,70,237)).background_(Color.grey(0.95)).string_("Attack (ms)").align_(\top);
	StaticText(w, Rect(130,70,70,237)).background_(Color.grey(0.9)).string_("Sustain (ms)").align_(\top);
	StaticText(w, Rect(200,70,70,237)).background_(Color.grey(0.95)).string_("Release (ms)").align_(\top);
	StaticText(w, Rect(270,70,80,237)).background_(Color.grey(0.9)).string_("Start Time (ms)").align_(\top);
	StaticText(w, Rect(350,70,50,237)).background_(Color.grey(0.95)).string_("On
Curve").align_(\top);
	StaticText(w, Rect(400,70,50,237)).background_(Color.grey(0.9)).string_("Off
Curve").align_(\top);
	StaticText(w, Rect(450,70,40,237)).background_(Color.grey(0.95)).string_("Int.
(+)").align_(\top);

	StaticText(w, Rect(10,105,480,2)).background_(Color.grey); // Line (drawHook is underneath)

// TextFields

	8.do({
		arg i, j, intensityArray;
		j = i+1;
		j.postln;
		intensityArray = [1,0,0,0,0,0,0,0];
		(
			"~freq" ++ j ++ "= TextField(w, Rect(10+2,110+" ++ (i*25) ++ ",46,20)).value_(440).align_(\\center);
~attack" ++ j ++ "= TextField(w, Rect(60+2,110+" ++ (i*25) ++ ",66,20)).value_(5).align_(\\center);
~sustain" ++ j ++ "= TextField(w, Rect(130+2,110+" ++ (i*25) ++ ",66,20)).value_(490).align_(\\center);
~release" ++ j ++ "= TextField(w, Rect(200+2,110+" ++ (i*25) ++ ",66,20)).value_(5).align_(\\center);
~startTime" ++ j ++ "= TextField(w, Rect(270+2,110+" ++ (i*25) ++ ",76,20)).value_(0).align_(\\center);
~onCurve" ++ j ++ "= TextField(w, Rect(350+2,110+" ++ (i*25) ++ ",46,20)).value_(0).align_(\\center);
~offCurve" ++ j ++ "= TextField(w, Rect(400+2,110+" ++ (i*25) ++ ",46,20)).value_(0).align_(\\center);
~intensity" ++ j ++ "= TextField(w, Rect(450+2,110+" ++ (i*25) ++ ",36,20)).value_(" ++ intensityArray[i] ++ ").align_(\\center);"
		).interpret;
	});


	// Plot Envelope
	~plotterNumber = TextField(w, Rect(40,315,30,20)).value_(1).align_(\center);
	Button(w, Rect(10,315,30,20)).string_("Plot").action_({
		~synthesizerPlotFunction.value(j:~plotterNumber.value);
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

		if(obj.value == 1, {
				~w2 = Window.new("Oscilloscope", Rect.new(
	Window.screenBounds.width/2+420,
	500,
		250,250),false).background_(Color.white).userCanClose_(true).front;

		~d = Stethoscope.new(s, 1,view:~w2, zoom:0.1) //.scope//nil causes it to open in its own window
				// .xZoom_(5) //is only setting slider, isn't changing view properly
				// .cycle_(50) //same problem as xZoom: workaround, use a button for 440Hz
				.yZoom_(4);

				/*( //still not auto-setting
s.sendBundle(2, //sound delay
				["/s_new", "d", ~nam = s.nextNodeID, 1, 1, s.cycle_(501)]; //nam to ensure it doesn't override any other variables
				););*/



				// ~d.cycle_(3000);
				// ~d.scope(zoom:4);
		//~d.bufsize;

		// AUTO:
			//AppClock.sched(0.01, {~d.cycle_(5*44100/~fundamental_freq);});


		/*	}*//*,
		{
				// ~w2.close;
				// ~d.quit //had to comment these two to make it not error as can't interpret - maybe these should open as default?
			}*/
	/*);*/
		},{
			~w2.close;
		});
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