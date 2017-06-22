// Step 1 - Import files, create envelopes, and generate SynthDef
// Uses the files created by the R code
// Outputs a plot of every harmonic envelope and a Synthdef contining (most) harmonics - the SynthDef is currently limited the number of harmonics as it seems to be too large for SC to handle
(
s.waitForBoot(
	{
		var basePath = thisProcess.nowExecutingPath.asString.dirname;

		~fundamental_frequency_of_player = (2**((60-69)/12))*440; // C4 Frequency

		~harmonicsDataArray = TabFileReader.readInterpret(basePath +/+ "R_working_files/harmonicMatrixScaled.txt").postcs; // Imports the tab delimited data file from the R export

		~timeInterval = ~harmonicsDataArray[0,0][0].interpret; // Needs the .interpret to work in Env

		//Loop to create envelopes
		~number_of_harmonics = Array.fill(16, { arg i; i+1 });
		~number_of_harmonics.do({ arg item, i;
		(
		"~envelope" ++ item ++ "= ~harmonicsDataArray[" ++ item ++ ",0].drop(1);
~harmonic" ++ item ++ "Env = Env.new(~envelope" ++ item ++ ", ~timeInterval);
~harmonic" ++ item ++ "Env.plot;" // Uncomment the line to plot the envelopes
			).postln.interpret;
		});



		//Loop to create SynthDef (not currently in use)
		/*~number_of_harmonics.do({ arg item, i;
			(
				"SinOsc.ar(262.53*" ++ item ++ ") * EnvGen.kr(~harmonic" ++ item ++ "Env, doneAction: 3)"
			).postln;

			});*/


/// INSTEAD OF ONE SYNTHDEF WITH 16 HARMONICS
		/// CREATE 16 SYNTHDEFS WITH 1 HARMONIC EACH
		// THEN SEND IN A BUNDLE
			/*(
		SynthDef(\harmonic_player, {
	Out.ar(0,
					SinOsc.ar(~fundamental_frequency_of_player*1) * EnvGen.kr(~harmonic1Env, doneAction: 5)
					+
					SinOsc.ar(~fundamental_frequency_of_player*2) * EnvGen.kr(~harmonic2Env, doneAction: 5)
					+
					SinOsc.ar(~fundamental_frequency_of_player*3) * EnvGen.kr(~harmonic3Env, doneAction: 5)
					+
					SinOsc.ar(~fundamental_frequency_of_player*4) * EnvGen.kr(~harmonic4Env, doneAction: 5)
					+
					SinOsc.ar(~fundamental_frequency_of_player*5) * EnvGen.kr(~harmonic5Env, doneAction: 5)
					+
					SinOsc.ar(~fundamental_frequency_of_player*6) * EnvGen.kr(~harmonic6Env, doneAction: 5)
					/*+
					SinOsc.ar(~fundamental_frequency_of_player*7) * EnvGen.kr(~harmonic7Env, doneAction: 3)
					+
					SinOsc.ar(~fundamental_frequency_of_player*8) * EnvGen.kr(~harmonic8Env, doneAction: 3)
					+
					SinOsc.ar(~fundamental_frequency_of_player*9) * EnvGen.kr(~harmonic9Env, doneAction: 3)
					+
					SinOsc.ar(~fundamental_frequency_of_player*10) * EnvGen.kr(~harmonic10Env, doneAction: 3)
					+
					SinOsc.ar(~fundamental_frequency_of_player*11) * EnvGen.kr(~harmonic11Env, doneAction: 3)
					+
					SinOsc.ar(~fundamental_frequency_of_player*12) * EnvGen.kr(~harmonic12Env, doneAction: 3)
					+
					SinOsc.ar(~fundamental_frequency_of_player*13) * EnvGen.kr(~harmonic13Env, doneAction: 3)
					+
					SinOsc.ar(~fundamental_frequency_of_player*14) * EnvGen.kr(~harmonic14Env, doneAction: 3)
					+
					SinOsc.ar(~fundamental_frequency_of_player*15) * EnvGen.kr(~harmonic15Env, doneAction: 3)
					+
					SinOsc.ar(~fundamental_frequency_of_player*16) * EnvGen.kr(~harmonic16Env, doneAction: 3)*/

	)
}).add;
		);*/

		~number_of_harmonics.do({ arg item, i;
		(
		"SynthDef.new(" ++ ("harmonic_play_" ++ item).asCompileString ++ ", {
arg freq, amp, pan, dur, ratio; // These arguments are given values at the s.sendBundle step
	var sound, env_gen, env;

env_gen = EnvGen.kr(~harmonic" ++ item ++ "Env ); //loads the envelope as a control UGen
	sound = SinOsc.ar((freq*ratio), mul: env_gen*amp); //uses envelope as a multiplier of amplitude

	Out.ar(0, Pan2.ar(sound, pan)); //sends to busses? // send output to audio bus zero.
}).send(s);"
			).postln.interpret;
		});




}
)
);

// Step 2 - Play the SynthDef
//Synth(\harmonic_player);

(
(
s.sendBundle(0.0, //sound delay
	["/s_new", "harmonic_play_1", x = s.nextNodeID, 1, 1, freq:(~fundamental_frequency_of_player), dur:1, amp:0.2, pan:0, ratio:(1/1)],
	["/s_new", "harmonic_play_2", x = s.nextNodeID, 1, 1, freq:(~fundamental_frequency_of_player), dur:1, amp:0.2, pan:0, ratio:(2/1)],
	["/s_new", "harmonic_play_3", x = s.nextNodeID, 1, 1, freq:(~fundamental_frequency_of_player), dur:1, amp:0.2, pan:0, ratio:(3/1)],
	["/s_new", "harmonic_play_4", x = s.nextNodeID, 1, 1, freq:(~fundamental_frequency_of_player), dur:1, amp:0.3, pan:0, ratio:(4/1)],
	["/s_new", "harmonic_play_5", x = s.nextNodeID, 1, 1, freq:(~fundamental_frequency_of_player), dur:1, amp:0.3, pan:0, ratio:(5/1)],
	["/s_new", "harmonic_play_6", x = s.nextNodeID, 1, 1, freq:(~fundamental_frequency_of_player), dur:1, amp:0.2, pan:0, ratio:(6/1)],
	["/s_new", "harmonic_play_7", x = s.nextNodeID, 1, 1, freq:(~fundamental_frequency_of_player), dur:1, amp:0.2, pan:0, ratio:(7/1)],
	["/s_new", "harmonic_play_8", x = s.nextNodeID, 1, 1, freq:(~fundamental_frequency_of_player), dur:1, amp:0.2, pan:0, ratio:(8/1)],
	["/s_new", "harmonic_play_9", x = s.nextNodeID, 1, 1, freq:(~fundamental_frequency_of_player), dur:1, amp:0.2, pan:0, ratio:(9/1)],
	["/s_new", "harmonic_play_10", x = s.nextNodeID, 1, 1, freq:(~fundamental_frequency_of_player), dur:1, amp:0.2, pan:0, ratio:(10/1)],
	["/s_new", "harmonic_play_11", x = s.nextNodeID, 1, 1, freq:(~fundamental_frequency_of_player), dur:1, amp:0.2, pan:0, ratio:(11/1)],
	["/s_new", "harmonic_play_12", x = s.nextNodeID, 1, 1, freq:(~fundamental_frequency_of_player), dur:1, amp:0.2, pan:0, ratio:(12/1)],
	["/s_new", "harmonic_play_13", x = s.nextNodeID, 1, 1, freq:(~fundamental_frequency_of_player), dur:1, amp:0.2, pan:0, ratio:(13/1)],
	["/s_new", "harmonic_play_14", x = s.nextNodeID, 1, 1, freq:(~fundamental_frequency_of_player), dur:1, amp:0.2, pan:0, ratio:(14/1)],
	["/s_new", "harmonic_play_15", x = s.nextNodeID, 1, 1, freq:(~fundamental_frequency_of_player), dur:1, amp:0.2, pan:0, ratio:(15/1)],
	["/s_new", "harmonic_play_16", x = s.nextNodeID, 1, 1, freq:(~fundamental_frequency_of_player), dur:1, amp:0.2, pan:0, ratio:(16/1)]
); //sound and ID for stacking (if multiple sounds bundled)


// s.sendBundle(100, ["/n_free", x],["/n_free", y],["/n_free", z]);//sound ends, at least frees up memory space
);
)