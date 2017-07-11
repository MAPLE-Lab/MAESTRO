// MAESTRO Sound Synthesizer
// For raw code lines, search: Example Code

(
// Start the server
s.waitForBoot({

// Close any other windows and free any nodes
s.freeAll;
Window.closeAll;

// Create master window (w)
w = Window.new("MAESTRO Synthesizer", Rect.new(
	Window.screenBounds.width/2-400,
	Window.screenBounds.height-700,
	1000,500),true)
.background_(Color.white)
.userCanClose_(true)
.front
.acceptsMouseOver_(true);


// Basic SynthDef
SynthDef.new("basicSynth", {
	arg outBus=0, freq=440;
	var soundSource;
	soundSource = SinOsc.ar(freq,0,0.1);
	Out.ar(outBus, soundSource);
}).add;

// Button to play the Basic SynthDef
~playButtonBasic = Button.new(w, Rect(10,10,100,40))
.states_([
	["Basic OFF", Color.white, Color.red(0.5)],
	["Basic ON", Color.white, Color.green(0.5)]
])
.action_({
	arg obj;
	if(obj.value == 1, {
		~basicSoundSynth = Synth("basicSynth", [\freq, ~soundFrequencyBox.value]);
	},{
		~basicSoundSynth.free
	});
});




	// Button to play the Draw SynthDef
	~playButtonDraw = Button.new(w, Rect(10+200,10,100,40))
	.states_([
		["Draw OFF", Color.white, Color.red(0.5)],
		["Draw LOAD", Color.white, Color.yellow(0.5)],
		["Draw ON", Color.white, Color.green(0.5)]
	])
	.action_({
		arg obj;

		if(obj.value == 2, {
			// ON


			~drawSoundCompileFunction.value;


			AppClock.sched(0.01, { // Delayed to allow SynthDef to save to the server
				~drawSoundSynth = Synth("drawEnvelopeSynth", [\freq, ~soundFrequencyBox.value]);
			});

			// Reset to OFF
			AppClock.sched(~soundDuration+0.5, {
				~playButtonDraw.valueAction_(0);
			});
		},{
			if(obj.value == 1, { // LOAD
				//~drawEnvelopePlot.parent.close; // Close the previous data
				~plotCoverDraw.close;


				//if(~plotCompositeView.visible != true, { // Create new Composite View for the Envelope Plots if necessary

		//		});



			},{
				// OFF
				~drawSoundSynth.free;
				~plotCoverDraw = CompositeView.new(~plotCompositeView, Rect(0,250,300,200)).background_(Color.grey(alpha:0.5));
				//StaticText.new(~plotCompositeView, Rect(0,0,300,320)).background_(Color.grey(alpha:0.5));
			});
	});
});

	~soundDurationBox = NumberBox.new(w, Rect(150,200+20,300-150,20)).value_(1).align_(\center).action_({~soundDuration = ~soundDurationBox.value;});
				~soundDurationBoxLabel = StaticText.new(w, Rect(0,200+20,150,20)).string_("Draw Duration (s)").align_(\center);

	~soundFrequencyBox = NumberBox.new(w, Rect(150,220+20,300-150,20)).value_(440).align_(\center).action_({ ~freq = ~soundFrequencyBox.value; });
				~soundFrequencyBoxLabel = StaticText.new(w, Rect(0,220+20,150,20)).string_("Fundamental (Hz)").align_(\center);


// Causing errors:
/*	// Oscilloscope (Scope)
	s.scope;

	// Spectra (FreqScope)
	s.freqscope;*/

	// Spectra (FreqScopeView)
~freqscope = FreqScopeView.new(w, Rect(10,60,300,150))
.active_(true)
.freqMode_(1); // LOG view




	["Attack", "Decay", "Sustain", "Release"].do({
		arg item, i;
		("~sound" ++ item ++ "IntensityBox = NumberBox.new(w, Rect(150,280+(" ++ i ++ "*20),300-150,20)).value_(1).action_({~envelopeSoundCompileFunction.value});" + "~sound" ++ item ++ "IntensityBoxLabel = StaticText.new(w, Rect(0,280+(" ++ i ++ "*20),150,20)).string_(" ++ (item + "Intensity").asCompileString ++ ");"
).interpret;
});

		["Attack", "Decay", "Sustain", "Release"].do({
		arg item, i;
		("~sound" ++ item ++ "TimeBox = NumberBox.new(w, Rect(150,400+(" ++ i ++ "*20),300-150,20)).value_(1).action_({~envelopeSoundCompileFunction.value});" + "~sound" ++ item ++ "TimeBoxLabel = StaticText.new(w, Rect(0,400+(" ++ i ++ "*20),150,20)).string_(" ++ (item + "Time").asCompileString ++ ");"
).interpret;
});

// Starting values
			~soundAttackIntensityBox.value = 1;
			~soundDecayIntensityBox.value = 0.5;
			~soundSustainIntensityBox.value = 0.5;
			~soundReleaseIntensityBox.value = 0;

			~soundAttackTimeBox.value = 1;
			~soundDecayTimeBox.value = 1;
			~soundSustainTimeBox.value = 1;
			~soundReleaseTimeBox.value = 1;



	// Button to play the Envelope SynthDef
~playButtonEnvelope = Button.new(w, Rect(10+100,10,100,40))
.states_([
	["Envelope OFF", Color.white, Color.red(0.5)],
	["Envelope ON", Color.white, Color.green(0.5)]
])
.action_({
	arg obj;
	if(obj.value == 1, {

			~envelopeSoundCompileFunction.value;


			AppClock.sched(0.01, {
		~envelopeSoundSynth = Synth("envelopeSynth", [\freq, ~soundFrequencyBox.value]);
			});

			// Reset to OFF
			AppClock.sched(~adsrSum+0.5, {
				~playButtonEnvelope.valueAction_(0);})
	},{
		~envelopeSoundSynth.free;

				//~plotCoverEnvelope = CompositeView.new(~plotCompositeView, Rect(0,0,300,200)).background_(Color.grey(alpha:0.5));
	});
});



		~plotCompositeView = CompositeView.new(w, Rect.new(400+10, 10, 300, 500)).background_(Color.white).visible_(true);

// Starting values
	~envelopeLevels = [0,1,0.5,0.5,0];
	~envelopeEnvelopePlot = Plotter.new("Envelope", Rect(0,0,300,200), ~plotCompositeView).value_(~envelopeLevels/*~envelopeEnv*/).editMode_(false);

//	~plotCompositeView = CompositeView.new(w, Rect.new(400, 10, 300, 500)).background_(Color.red).visible_(true);
				~drawEnvelopePlot = Plotter.new("Draw", Rect(0,250,300,200), ~plotCompositeView).value_((0..100)).editMode_(true);

	// If forget to turn off the sounds, automatically turns them off
	w.onClose_({s.freeAll;});


	// Button to repeat the Envelope SynthDef
~repeaterButtonEnvelope = Button.new(w, Rect(310,10,100,40))
.states_([
	["Repeat Envelope
OFF", Color.white, Color.red(0.5)],
	["Repeat Envelope
ON", Color.white, Color.green(0.5)]
])
.action_({
	arg obj, integer;
	if(obj.value == 1, {


			/*integer = 0; // Start on 0

			SystemClock.sched(0.0, {
				arg time;
				integer = integer + 1;
				[time, integer].postln;
				//~basicSoundSynth = Synth("basicSynth", [\freq, ~soundFrequencyBox.value]);
				~ioi; // ioi value defines how long before next one is called
			});*/


			~envelopeSoundCompileFunction.value;

			~freq = ~soundFrequencyBox.value;
			~ioi = ~ioiBox.value;

			~envelopeSoundSynthPlay =
			{Synth("envelopeSynth", [\freq, ~freq])};

			(
				~repeaterTaskEnvelope = Task({
					inf.do({ arg i;
						("Beat number" + i).postln;
						~envelopeSoundSynthPlay.value;
						~ioi.wait;
					});
				});
			);

			AppClock.sched(0.01, {
			"Repeater started.".postln;
			~repeaterTaskEnvelope.start;
			});



	},{
		//~basicSoundSynth.free;

		/*	SystemClock.sched(0.0, {
				~ioi = nil;
			});*/

			"Repeater stopped.".postln;
			~repeaterTaskEnvelope.stop;


	});
});


	// Button to repeat the Draw SynthDef
~repeaterButtonDraw = Button.new(w, Rect(310,10+50,100,40))
.states_([
	["Repeat Draw
OFF", Color.white, Color.red(0.5)],
	["Repeat Draw
ON", Color.white, Color.green(0.5)]
])
.action_({
	arg obj, integer;
	if(obj.value == 1, {


			/*integer = 0; // Start on 0

			SystemClock.sched(0.0, {
				arg time;
				integer = integer + 1;
				[time, integer].postln;
				//~basicSoundSynth = Synth("basicSynth", [\freq, ~soundFrequencyBox.value]);
				~ioi; // ioi value defines how long before next one is called
			});*/


			~drawSoundCompileFunction.value;

			~freq = ~soundFrequencyBox.value;
			~ioi = ~ioiBox.value;

			~drawSoundSynthPlay =
			{Synth("drawEnvelopeSynth", [\freq, ~freq])};

			(
				~repeaterTaskDraw = Task({
					inf.do({ arg i;
						("Beat number" + i).postln;
						~drawSoundSynthPlay.value;
						~ioi.wait;
					});
				});
			);

			AppClock.sched(0.01, {
			"Repeater started.".postln;
			~repeaterTaskDraw.start;
			});



	},{
		//~basicSoundSynth.free;

		/*	SystemClock.sched(0.0, {
				~ioi = nil;
			});*/

			"Repeater stopped.".postln;
			~repeaterTaskDraw.stop;


	});
});


	~plotterButtonEnvelope = Button.new(w, Rect(310,10+50+50,100,40))
.states_([
		["Plot Envelope", Color.white, Color.grey(0.5)]
	])
	.action_({
~envelopeEnv.plot;
	});






	~ioiBoxLabel = StaticText.new(w, Rect(310,200+20,150,20)).string_("IOI (s)").align_(\left);
	~ioiBox = NumberBox.new(w, Rect(350,200+20,40,20)).value_(0.5).align_(\center).action_({ ~ioi = ~ioiBox.value});




	~envelopeSoundCompileFunction = {

			// Envelope generator
~attackLevel = ~soundAttackIntensityBox.value;
			~decayLevel = ~soundDecayIntensityBox.value;
			~sustainLevel = ~soundSustainIntensityBox.value;
			~releaseLevel = ~soundReleaseIntensityBox.value;

			~attackTime = ~soundAttackTimeBox.value;
			~decayTime = ~soundDecayTimeBox.value;
			~sustainTime = ~soundSustainTimeBox.value;
			~releaseTime = ~soundReleaseTimeBox.value;


	~envelopeLevels = [0,~attackLevel,~decayLevel,~sustainLevel,~releaseLevel];
	~envelopeTimes = [~attackTime,~decayTime,~sustainTime,~releaseTime];

				~adsrSum = ~envelopeTimes.sum;

	if(~envelopeTimes.size >= ~envelopeLevels.size, {"Error: The envelope times array is bigger than the evelope levels array.".postln});

	~envelopeEnv = Env.new(levels:~envelopeLevels, times:~envelopeTimes, curve:\lin);

			// Plot it
//if(~plotCompositeView.visible != true, { // Create new Composite View for the Envelope Plots if necessary
	~envelopeEnvelopePlot = Plotter.new("Envelope", Rect(0,0,300,200), ~plotCompositeView).value_(~envelopeLevels/*~envelopeEnv*/).editMode_(false);
				//});
//~envelopeEnv.plot;

	// Envelope SynthDef
	SynthDef.new("envelopeSynth", {
		arg outBus=0, freq=440;
		var soundSource, envgen;

		envgen = EnvGen.ar(~envelopeEnv);

		soundSource = SinOsc.ar(freq,0,0.1) * envgen;

		Out.ar(outBus, soundSource);
	}).add;
			};


	~drawSoundCompileFunction = {

			~drawEnvelopeLevelsArray = (~drawEnvelopePlot.value)/~drawEnvelopePlot.value.maxItem; // the value

			~soundDuration = ~soundDurationBox.value; // In seconds

			~drawEnvelopeTimesArray = Array.fill(~drawEnvelopeLevelsArray.size-1, {~soundDuration/(~drawEnvelopeLevelsArray.size-1)});

			~drawEnvelope = Env(levels:~drawEnvelopeLevelsArray, times:~drawEnvelopeTimesArray);

			// Draw Envelope SynthDef
			SynthDef.new("drawEnvelopeSynth", {
				arg outBus=0, freq=440;
				var soundSource, envgen;

				envgen = EnvGen.ar(~drawEnvelope);

				soundSource = SinOsc.ar(freq,0,0.1) * envgen;

				Out.ar(outBus, soundSource);
			}).add;
			};



	// Reset plotter button values to the starting ones
~envelopeSoundCompileFunction.value;




	// Button to play the Percussive sounds
~playButtonPercussive = Button.new(w, Rect(10+700,10,100,20))
.states_([
	["Percussive", Color.white, Color.grey(0.5)]
])
	.action_({
		Env.perc(attackTime:~percattackTime.value, releaseTime:~percreleaseTime.value, level:~perclevel.value, curve:~perccurve.value).plot;

		{ SinOsc.ar(
			freq:~soundFrequencyBox.value,
			mul:EnvGen.kr(Env.perc(attackTime:~percattackTime.value, releaseTime:~percreleaseTime.value, level:~perclevel.value, curve:~perccurve.value
				// 0.05, 1, 1, -4
		))) }.play;

	});

	~playButtonReversePercussive = Button.new(w, Rect(10+700+100,10,100,20))
.states_([
	["Rev. Percussive", Color.white, Color.grey(0.5)]
])
	.action_({
		Env.perc(attackTime:~percreleaseTime.value, releaseTime:~percattackTime.value, level:~perclevel.value, curve:(~perccurve.value)*(-1)).plot;

		{ SinOsc.ar(
			freq:~soundFrequencyBox.value,
			mul:EnvGen.kr(Env.perc(attackTime:~percreleaseTime.value, releaseTime:~percattackTime.value, level:~perclevel.value, curve:(~perccurve.value)*(-1)
				// 0.05, 1, 1, -4
		))) }.play;

	});


	~percDataComposite = CompositeView(w, Rect(700, 100, 300, 300)).background_(Color.clear);

	~percattackTime = NumberBox.new(~percDataComposite, Rect(50,0,50,20)).value_(0.05).align_(\center).decimals_(4);
	~percattackTimeLabel = StaticText.new(~percDataComposite, Rect(0,0,50,20)).string_("attackTime (s)").align_(\center).font_(Font(nil, 7));

	~percreleaseTime = NumberBox.new(~percDataComposite, Rect(50+100,0,50,20)).value_(1).align_(\center);
	~percreleaseTimeLabel = StaticText.new(~percDataComposite, Rect(0+100,0,50,20)).string_("releaseTime (s)").align_(\center).font_(Font(nil, 7));

	~perclevel = NumberBox.new(~percDataComposite, Rect(50,0+20+20,50,20)).value_(1).align_(\center);
	~perclevelLabel = StaticText.new(~percDataComposite, Rect(0,0+20+20,50,20)).string_("level").align_(\center).font_(Font(nil, 7));

	~perccurve = NumberBox.new(~percDataComposite, Rect(50+100,0+20+20,50,20)).value_(-4).align_(\center);
	~perccurveLabel = StaticText.new(~percDataComposite, Rect(0+100,0+20+20,50,20)).string_("curve").align_(\center).font_(Font(nil, 7));



	// Button to repeat the Perc
~repeaterButtonPerc = Button.new(w, Rect(710,40,100,40))
.states_([
	["Repeat Perc
OFF", Color.white, Color.red(0.5)],
	["Repeat Perc
ON", Color.white, Color.green(0.5)]
])
.action_({
	arg obj, integer;
	if(obj.value == 1, {

			~sFB = ~soundFrequencyBox.value;
			~paT = ~percattackTime.value;
			~prT = ~percreleaseTime.value;
			~pl = ~perclevel.value;
			~pc = ~perccurve.value;

			(
				~repeaterTaskPerc = Task({
					inf.do({ arg i;
						("Beat number" + i).postln;
							{ SinOsc.ar(
			freq:~sFB,
			mul:EnvGen.kr(Env.perc(attackTime:~paT, releaseTime:~prT, level:~pl, curve:~pc))) }.play;
						~ioi.wait;
					});
				});
			);
			AppClock.sched(0.01, {
			"Repeater started.".postln;
			~repeaterTaskPerc.start;
			});
	},{
			"Repeater stopped.".postln;
			~repeaterTaskPerc.stop;
	});
});



	// Button to repeat the PercRev
~repeaterButtonPercRev = Button.new(w, Rect(710+100,40,100,40))
.states_([
	["Repeat PercRev
OFF", Color.white, Color.red(0.5)],
	["Repeat PercRev
ON", Color.white, Color.green(0.5)]
])
.action_({
	arg obj, integer;
	if(obj.value == 1, {

			~sFB = ~soundFrequencyBox.value;
			~paT = ~percattackTime.value;
			~prT = ~percreleaseTime.value;
			~pl = ~perclevel.value;
			~pc = ~perccurve.value;

			(
				~repeaterTaskPercRev = Task({
					inf.do({ arg i;
						("Beat number" + i).postln;
							{ SinOsc.ar(
			freq:~sFB,
						mul:EnvGen.kr(Env.perc(attackTime:~prT, releaseTime:~paT, level:~pl, curve:~pc*(-1)))) }.play;
						~ioi.wait;
					});
				});
			);
			AppClock.sched(0.01, {
			"Repeater started.".postln;
			~repeaterTaskPercRev.start;
			});
	},{
			"Repeater stopped.".postln;
			~repeaterTaskPercRev.stop;
	});
});


	// Button to play the Percussive sounds
~playButtonBender1 = Button.new(w, Rect(10+700,200,75,20))
.states_([
	["Freq. & Int. Bend", Color.white, Color.grey(0.5)],
	["Freq. & Int. Bend", Color.white, Color.grey(0.0)]
])
	.font_(Font(nil,8))
	.action_({
arg obj;

		if(obj.value == 1, {
			(
~freqEnvelope = "Env([6000, 700, 100], [1, 1], ['exp', 'lin'])";
~intenEnvelope = "Env([1, 0.05, 1], [1, 1], ['exp', 'lin'])";

(
~circleSound =
{ SinOsc.ar(
	freq:EnvGen.kr(~freqEnvelope.interpret.circle.postcs),
	mul:EnvGen.kr(~intenEnvelope.interpret.circle.postcs)
) * 0.1 }.play;
);

[~freqEnvelope.interpret, ~intenEnvelope.interpret].plot;
// Does not work when .circle is used, but can circumvent by seeing the source as a string and interpreting from there
)
		}, {
			~circleSound.free; // To end the bend cycle
		});

	});


	~playButtonBender2 = Button.new(w, Rect(10+700+75,200,75,20))
.states_([
	["Int. Beeps", Color.white, Color.grey(0.5)],
	["Int. Beeps", Color.white, Color.grey(0.0)]
])
	.font_(Font(nil,8))
	.action_({
arg obj;

		if(obj.value == 1, {
			(
~intensity = 0.5;
~beepDuration = 1;
~gap = 0.5;
~circleSoundBeep = { SinOsc.ar(440, mul:EnvGen.kr(Env.perc(0.05, 0.2, ~intensity, -4).circle([1,1,0], [~beepDuration,0,~gap]))) }.play;
)

		}, {
			~circleSoundBeep.free;
		});

	});


	~playButtonBender3 = Button.new(w, Rect(10+700+150,200,75,20))
.states_([
	["Mouse-controlled", Color.white, Color.grey(0.5)],
	["Mouse-controlled", Color.white, Color.grey(0.0)]
])
	.font_(Font(nil,8))
	.action_({
arg obj;

		if(obj.value == 1, {
			(
~mousePerc = { SinOsc.ar(440,
	mul:EnvGen.kr(
		Env.perc(
			MouseX.kr(0.0001,0.5), // Attack time
			0.5/*MouseY.kr(0.2,0.5)*/, // Release time
			0.5, // Intensity
			-4) // The curvature of the sound
		.circle(MouseY.kr(0,1)) // The gap between repeats
)) }.play;
)
		}, {
			~mousePerc.free;
		});

	});


	// Routine timings
	~customTimes = TextField.new(w, Rect(10+700,200+40+20,225,20)).value_("0.5,0.5,1,0.5");

	// Button to play the Routine
~playButtonRoutine = Button.new(w, Rect(10+700,200+40,225,20))
.states_([
	["Custom-delay Routine", Color.white, Color.grey(0.5)],
	["Custom-delay Routine", Color.white, Color.grey(0.0)]
])
	.font_(Font(nil,8))
	.action_({
arg obj;

		if(obj.value == 1, {

			(
~beatDelayArray = ("[" + ~customTimes.value + "]").interpret /*[0.5,0.5,1,0.5]*/;

// Use Routine for correct conditions
//var r;
~routineBeats = Routine {
	(~beatDelayArray.size+1).do({ arg a;
        a.postln;
        // Often you might see Wait being used to pause a routine
        // This waits for one second between each number

		Env.perc.test;


		if(a <= (~beatDelayArray.size-1), {
			~beatDelayArray.value[a].wait;
		},{
			0.wait;});
    });
    // Wait half second before saying we're done
    0.wait;
    "done".postln;
};

~routineBeats.reset;

~routineBeats.play;
)


		}, {

~routineBeats.stop; // To stop the next beat from playing

		});

	});


	~stopAll = Button.new(w, Rect(10+700+10,200+200-50+50,225-20,50))
.states_([
	["Emergency Stop Sounds", Color.white, Color.red(0.8)]
])
	.action_({
		s.freeAll;
	});

	/*~restart = Button.new(w, Rect(10+700+10,200+200,225-20,50))
.states_([
	["Emergency Restart", Color.white, Color.red(0.8)]
])
	.action_({
		s.freeAll;
//		w.close;
(thisProcess.nowExecutingPath.asString.dirname +/+  "MAPLE_Synthesizer.scd").asString.postln; //.load;
	});*/




	///END
});
);



// Example Code

// 1. Frequency and/or Intensity Benders
// 1.a) Frequency and intensity
(
~freqEnvelope = "Env([6000, 700, 100], [1, 1], ['exp', 'lin'])";
~intenEnvelope = "Env([1, 0.05, 1], [1, 1], ['exp', 'lin'])";

(
~circleSound =
{ SinOsc.ar(
	freq:EnvGen.kr(~freqEnvelope.interpret.circle.postcs),
	mul:EnvGen.kr(~intenEnvelope.interpret.circle.postcs)
) * 0.1 }.play;
);

[~freqEnvelope.interpret, ~intenEnvelope.interpret].plot;
// Does not work when .circle is used, but can circumvent by seeing the source as a string and interpreting from there
)

~circleSound.free; // To end the bend cycle

// 1.b) Intensity-only beeps
(
~intensity = 0.5;
~beepDuration = 1;
~gap = 0.5;
~circleSoundBeep = { SinOsc.ar(440, mul:EnvGen.kr(Env.perc(0.05, 0.2, ~intensity, -4).circle([1,1,0], [~beepDuration,0,~gap]))) }.play;
)

~circleSoundBeep.free;

// 1.c) Mouse-controlled percussive cycles
(
~mousePerc = { SinOsc.ar(440,
	mul:EnvGen.kr(
		Env.perc(
			MouseX.kr(0.0001,0.5), // Attack time
			0.5/*MouseY.kr(0.2,0.5)*/, // Release time
			0.5, // Intensity
			-4) // The curvature of the sound
		.circle(MouseY.kr(0,1)) // The gap between repeats
)) }.play;
)

~mousePerc.free;

// 2. Beat repeater with custom timing
(
~beatDelayArray = [0.5,0.5,1,0.5];

// Use Routine for correct conditions
//var r;
~routineBeats = Routine {
	(~beatDelayArray.size+1).do({ arg a;
        a.postln;
        // Often you might see Wait being used to pause a routine
        // This waits for one second between each number

		Env.perc.test;


		if(a <= (~beatDelayArray.size-1), {
			~beatDelayArray.value[a].wait;
		},{
			0.wait;});
    });
    // Wait half second before saying we're done
    0.wait;
    "done".postln;
};

~routineBeats.reset;

~routineBeats.play;
)

~routineBeats.stop; // To stop the next beat from playing












///////////////////////////////////////////////////////////////////////////////////////////////////

// x = Synth("basicSynth", [\freq, 500]);
// y = Synth("basicSynth", [\freq, 1000]);
//
// x.free
// y.free

// Spectra (FreqScopeView)
~freqscope = FreqScopeView.new(w, Rect(10,60,300,150))
.active_(true)
.freqMode_(1); // LOG view

/*f = Buffer.alloc(s,1024,2);
	b = Bus.audio(s,0);
	ScopeView(w, Rect(350,60,300,150));
	c.bufnum = f.bufnum;*/

//FreqScope.new(300,150,0, server:s);




// GOTO1
// Generic Envelopes:
Env.shapeNames;

Env.linen(0.1, 0.2, 0.1, 0.6).test.plot;
Env.linen(1, 2, 3, 0.6).test.plot;
Env.linen(1, 2, 3, 0.6, \sine).test.plot;
Env.linen(1, 2, 3, 0.6, \welch).test.plot;
Env.linen(1, 2, 3, 0.6, -3).test.plot;
Env.linen(1, 2, 3, 0.6, -3).test.plot;
Env.linen(1, 2, 3, 0.6, [[\sine, \welch, \lin, \exp]]).plot;

Env.triangle(1, 1).test.plot;

Env.sine(1, 1).test.plot;

Env.perc(0.05, 1, 1, -4).test.plot;
Env.perc(0.001, 1, 1, -4).test.plot;    // sharper attack
Env.perc(0.001, 1, 1, -8).test.plot;    // change curvature
Env.perc(1, 0.01, 1, 4).test.plot;    // reverse envelope


Env.pairs([[0, 1], [2.1, 0.5],  [3, 1.4]], \exp).test.plot;
Env.pairs([[0, 1], [3, 1.4], [2.1, 0.5], [3, 4]], \exp).test.plot; // *if possible*, pairs are sorted according to time
Env.pairs({ { 1.0.rand } ! 2 } ! 16, \exp).test.plot;

Env.xyc([[0, 1, \sin], [2.1, 0.5, \lin],  [3, 1.4, \lin]]).test.plot;
Env.xyc([[2.1, 0.5, \lin], [0, 1, \sin], [3, 1.4, \lin]]).plot; // *if possible*, pairs are sorted according to time
Env.xyc({ [1.0.rand, 10.0.rand, -4.rand2] } ! 16, \exp).plot;

Env.step([0, 3, 5, 2, 7, 3, 0, 3, 4, 0], [0.5, 0.1, 0.2, 1.0, 1.5, 2, 0.2, 0.1, 0.2, 0.1]).test.plot;

Env.adsr(0.02, 0.2, 0.25, 1, 1, -4).test(2).plot;
Env.adsr(0.001, 0.2, 0.25, 1, 1, -4).test(2).plot;
Env.adsr(0.001, 0.2, 0.25, 1, 1, -4).test(0.45).plot;    // release after 0.45 sec

Env.dadsr.test.plot;

Env.asr(0.02, 0.5, 1, -4).test(2).plot;
Env.asr(0.001, 0.5, 1, -4).test(2).plot; // sharper attack
Env.asr(0.02, 0.5, 1, 'linear').test(2).plot; // linear segments

Env.cutoff(1, 1).test(2).plot;
Env.cutoff(1, 1, 4).test(2).plot;
Env.cutoff(0.1, 0.2, \sine).test.plot;

{ SinOsc.ar(EnvGen.kr(Env.circle([0, 1, 0], [0.01, 0.5, 0.2])) * 440 + 200) * 0.2 }.play;
{ SinOsc.ar(EnvGen.kr(Env.circle([0, 1, 0, 2, 0, 1, 0], [0.01, 0.3])) * 440 + 200) * 0.2 }.play;
{ SinOsc.ar(EnvGen.kr(Env.circle([0, 1, 0, (2..4), 0, (1..3), 0], [0.01, 0.3])) * 440 + 200).sum * 0.2 }.play; // multichannel expanded levels

Env.circle([0, 1, 0], [0.01, 0.5, 0.2]).plot
~intensity = 0.5;
~beepDuration = 0.5;
~gap = 0.02;
Env.circle([~intensity,~intensity,0], [~beepDuration,0,~gap]).plot

{ SinOsc.ar(440, mul:EnvGen.kr(Env.circle([~intensity,~intensity,0], [~beepDuration,0,~gap]))) }.play;
	//EnvGen.kr(Env.circle([0, 1, 0], [0.01, 0.5, 0.2])) * 440 + 200) * 0.2
//Env.circle([0,0.1,0], [0.5,0.5,0.5]).plot

{ Impulse.ar(800, 0.0, 0.5, 0) }.play
{ Impulse.ar(XLine.kr(800,100,5), 0.0,  0.5, 0) }.play

//SynthDef(\imp, { OffsetOut.ar(0, Impulse.ar(0)); FreeSelf.kr(Impulse.kr(0)); }).add;
//fork { (1 / (1..60).scramble).do { |dt| Synth.grain(\imp);  dt.wait } };

/// Diagnostics
e = Env([0, 1, 0], [[1, 2], 2]);
e.duration;
e.totalDuration;
e = Env([0, 1, 0], [1, 2]);
e.duration;
e.duration = 2;
e.duration;


// GOTO2
//// NEW REPEATERS
//EnvGen.kr(Env.perc(0.05, 1, 1, -4))

/*{ Blip.ar(50, 200, Env.perc(1, 0.1, 0.2).kr(2)) }.play;

(
{ SinOsc.ar(
    EnvGen.kr(
        Env([6000, 700, 100], [1, 1], ['exp', 'lin']).circle.postcs)
    ) * 0.1
    + Impulse.ar(1) }.play;
)*/


// Frequency and Intensity Bender
(
~freqEnvelope = "Env([6000, 700, 100], [1, 1], ['exp', 'lin'])";
~intenEnvelope = "Env([1, 0.05, 1], [1, 1], ['exp', 'lin'])";

(
~circleSound =
{ SinOsc.ar(
	freq:EnvGen.kr(~freqEnvelope.interpret.circle.postcs),
	mul:EnvGen.kr(~intenEnvelope.interpret.circle.postcs)
) * 0.1 }.play;
);

[~freqEnvelope.interpret, ~intenEnvelope.interpret].plot;
// Does not work when .circle is used, but can circumvent by seeing the source as a string and interpreting from there
)

~circleSound.free; // To end the bend cycle

(
~intensity = 0.5;
~beepDuration = 1;
~gap = 0.5;
{ SinOsc.ar(440, mul:EnvGen.kr(Env.perc(0.05, 0.2, ~intensity, -4).circle([1,1,0], [~beepDuration,0,~gap]))) }.play;
)

//Env.perc(0.05, 0.2, ~intensity, -4).plot;
//{ SinOsc.ar(440, mul:EnvGen.kr(Env.perc(0.05, 0.2, ~intensity, -4).circle(~gap))) }.play;

(
{ SinOsc.ar(440,
	mul:EnvGen.kr(
		Env.perc(
			MouseX.kr(0.0001,0.5),
			0.5/*MouseY.kr(0.2,0.5)*/,
			~intensity,
			-4) // The curvature of the sound
		.circle(MouseY.kr(0,1)) // The gap between repeats
)) }.play;
);

// Beat repeater with custom timing
~beatDelayArray = [0.5,0.5,1,0.5];

// Use Routine for correct conditions
//var r;
~routineBeats = Routine {
	(~beatDelayArray.size+1).do({ arg a;
        a.postln;
        // Often you might see Wait being used to pause a routine
        // This waits for one second between each number
		~envelopeSoundSynthPlay.value;


		if(a <= (~beatDelayArray.size-1), {
			~beatDelayArray.value[a].wait;
		},{
			0.wait;});
    });
    // Wait half second before saying we're done
    0.wait;
    "done".postln;
};

~routineBeats.reset;

~routineBeats.play;

//~routineBeats.next;

~routineBeats.stop;

// CONDITIONS DO NOT WORK RIGHT in TASK, DANGEROUS - instead of stopping it sets .wait value to 0
// (
// ~repeaterTask2 = Task({
// 	inf.do({ arg i;
// 		("Beat number" + i).postln;
// 		//~envelopeSoundSynthPlay.value;
//
// 		if(i < 2, {
// 			~beatDelayArray.value[i].wait;
// 			},{
// 				~repeaterTask2.stop;
// 		});
// 	});
// });
// );
//~repeaterTask2.start



