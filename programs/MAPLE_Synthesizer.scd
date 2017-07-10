// MAESTRO Sound Synthesizer
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
	800,500),true)
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

	~soundDurationBox = NumberBox.new(w, Rect(150,200+20,300-150,20)).value_(1).align_(\center);
				~soundDurationBoxLabel = StaticText.new(w, Rect(0,200+20,150,20)).string_("Draw Duration (s)").align_(\center);

				~soundFrequencyBox = NumberBox.new(w, Rect(150,220+20,300-150,20)).value_(440).align_(\center);
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
		("~sound" ++ item ++ "IntensityBox = NumberBox.new(w, Rect(150,280+(" ++ i ++ "*20),300-150,20)).value_(1);" + "~sound" ++ item ++ "IntensityBoxLabel = StaticText.new(w, Rect(0,280+(" ++ i ++ "*20),150,20)).string_(" ++ (item + "Intensity").asCompileString ++ ");"
).interpret;
});

		["Attack", "Decay", "Sustain", "Release"].do({
		arg item, i;
		("~sound" ++ item ++ "TimeBox = NumberBox.new(w, Rect(150,400+(" ++ i ++ "*20),300-150,20)).value_(1);" + "~sound" ++ item ++ "TimeBoxLabel = StaticText.new(w, Rect(0,400+(" ++ i ++ "*20),150,20)).string_(" ++ (item + "Time").asCompileString ++ ");"
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







		~plotCompositeView = CompositeView.new(w, Rect.new(400, 10, 300, 500)).background_(Color.blue).visible_(true);
	~envelopeEnvelopePlot = Plotter.new("Envelope", Rect(0,0,300,200), ~plotCompositeView).value_(~envelopeLevels/*~envelopeEnv*/).editMode_(false);
//	~plotCompositeView = CompositeView.new(w, Rect.new(400, 10, 300, 500)).background_(Color.red).visible_(true);
				~drawEnvelopePlot = Plotter.new("Draw", Rect(0,250,300,200), ~plotCompositeView).value_((0..100)).editMode_(true);

	// If forget to turn off the sounds, automatically turns them off
	w.onClose_({s.freeAll;});

});
)

x = Synth("basicSynth", [\freq, 500]);
y = Synth("basicSynth", [\freq, 1000]);

x.free
y.free

// Spectra (FreqScopeView)
~freqscope = FreqScopeView.new(w, Rect(10,60,300,150))
.active_(true)
.freqMode_(1); // LOG view

/*f = Buffer.alloc(s,1024,2);
	b = Bus.audio(s,0);
	ScopeView(w, Rect(350,60,300,150));
	c.bufnum = f.bufnum;*/

//FreqScope.new(300,150,0, server:s);







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
Env.cutoff(0.1, 1, \sine).test(2).plot;

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


//// NEW REPEATERS
//EnvGen.kr(Env.perc(0.05, 1, 1, -4))

{ Blip.ar(50, 200, Env.perc(1, 0.1, 0.2).kr(2)) }.play;

(
{ SinOsc.ar(
    EnvGen.kr(
        Env([6000, 700, 100], [1, 1], ['exp', 'lin']).circle.postcs)
    ) * 0.1
    + Impulse.ar(1) }.play;
)


~intensity = 0.5;
~beepDuration = 1;
~gap = 0.5;
{ SinOsc.ar(440, mul:EnvGen.kr(Env.perc(0.05, 0.2, ~intensity, -4).circle([1,1,0], [~beepDuration,0,~gap]))) }.play;
Env.perc(0.05, 0.2, ~intensity, -4).plot
{ SinOsc.ar(440, mul:EnvGen.kr(Env.perc(0.05, 0.2, ~intensity, -4).circle(~gap))) }.play;
{ SinOsc.ar(440, mul:EnvGen.kr(Env.perc(MouseX.kr(0.0001,0.5), MouseY.kr(0.2,0.5), ~intensity, -4).circle(MouseY.kr(0,1)))) }.play;

MouseY.kr(0,1)