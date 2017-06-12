// Step 1 - Import files, create envelopes, and generate SynthDef
// Uses the files created by the R code
// Outputs a plot of every harmonic envelope and a Synthdef contining (most) harmonics - the SynthDef is currently limited the number of harmonics as it seems to be too large for SC to handle
(
s.waitForBoot(
	{
		var basePath = thisProcess.nowExecutingPath.asString.dirname;

		~fundamental_frequency_of_player = 262.53;
		~timeArray = (basePath +/+  "timeRawArray.print.txt").load;

		//Loop to create envelopes
		~number_of_harmonics = Array.fill(16, { arg i; i+1 });

		~text1 = "harmonicMatrixScaled.";
		~text2 = ".array.print.txt";

		~number_of_harmonics.do({ arg item, i;
		(
				"~envelope" ++ item ++ " = (thisProcess.nowExecutingPath.asString.dirname +/+ "
				+
				(~text1 ++ item ++ ~text2).asCompileString
				++
				").load;
~harmonic" ++ item ++ "Env = Env.new(~envelope" ++ item ++ ", ~timeArray, 'lin');
~harmonic" ++ item ++ "Env.plot;"
			).postln.interpret;
		});
		//

		//Loop to create SynthDef (not currently in use)
		~number_of_harmonics.do({ arg item, i;
			(
				"SinOsc.ar(262.53*" ++ item ++ ") * EnvGen.kr(~harmonic" ++ item ++ "Env, doneAction: 3)"
			).postln;

			});



			(
		SynthDef(\harmonic_player, {
	Out.ar(0,
					SinOsc.ar(~fundamental_frequency_of_player*1) * EnvGen.kr(~harmonic1Env, doneAction: 3)
					+
					SinOsc.ar(~fundamental_frequency_of_player*2) * EnvGen.kr(~harmonic2Env, doneAction: 3)
					+
					SinOsc.ar(~fundamental_frequency_of_player*3) * EnvGen.kr(~harmonic3Env, doneAction: 3)
					+
					SinOsc.ar(~fundamental_frequency_of_player*4) * EnvGen.kr(~harmonic4Env, doneAction: 3)
					+
					SinOsc.ar(~fundamental_frequency_of_player*5) * EnvGen.kr(~harmonic5Env, doneAction: 3)
					+
					SinOsc.ar(~fundamental_frequency_of_player*6) * EnvGen.kr(~harmonic6Env, doneAction: 3)
					+
					SinOsc.ar(~fundamental_frequency_of_player*7) * EnvGen.kr(~harmonic7Env, doneAction: 3)
					+
					SinOsc.ar(~fundamental_frequency_of_player*8) * EnvGen.kr(~harmonic8Env, doneAction: 3)
					/*+
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
		);


}
)
);

// Step 2 - Play the SynthDef
Synth(\harmonic_player);