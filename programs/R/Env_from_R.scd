(
s.waitForBoot(
{
	var basePath = thisProcess.nowExecutingPath.asString.dirname;

	(basePath +/+  "env_harmonic1").load;

    SinOsc.ar(100) * EnvGen.kr(~envelope1, doneAction: 2)
}.play
)
)

// Make it a do that creates only as many harmonics as necessary.


~basePath = thisProcess.nowExecutingPath.asString.dirname;

~array1 = CSVFileReader.read(~basePath +/+ "harmonicMatrixScaled.1.array.print.txt").postcs;

~array1_prep = ~array1.flatten

~array1_prep[2]


(
s.waitForBoot(
	{
		var basePath = thisProcess.nowExecutingPath.asString.dirname;

		~timeArray = CSVFileReader.read(basePath +/+  "timeRawArray.print.txt").postcs;
		~tim = ~timeArray;
		~array1 = CSVFileReader.read(basePath +/+  "harmonicMatrixScaled.1.array.print.txt").postln;

		~array1sav = ~array1;
		~harmonic1Env = Env.new(~array1sav, ~tim, 'lin').plot;

		SinOsc.ar(100) * EnvGen.kr(~envelope1, doneAction: 2)
}.play
)
)


~timeArray.size
~array1.size

~arraytest = [0,1,2]
~timetest = [0.5,0.5]

~harmonic1Envtest = Env.new(~array1, ~timetest, 'lin').plot;

~basePath = thisProcess.nowExecutingPath.asString.dirname;

~array1 = (~basePath +/+  "harmonicMatrixScaled.1.array.print.txt").load;
~timeArray = (~basePath +/+  "timeRawArray.print.txt").load;


~newAR[0..2]

~harmonic1Envtest2 = Env.new(~newAR[0..2], ~timetest, 'lin').plot;

~harmonic1Env = Env.new(~array1, ~timeArray, 'lin').plot;



SynthDef(\harmonic_player, {
	Out.ar(0,
		SinOsc.ar(262.53) * EnvGen.kr(~harmonic1Env, doneAction: 3)
	)
}).add;