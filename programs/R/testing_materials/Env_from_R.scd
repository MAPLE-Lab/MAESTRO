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

~array1 = CSVFileReader.read(~basePath +/+ "comma_test.txt").flatten.postcs;
//NEEDS TO BE RECAST AS VALUES RATHER THAN CHARACTERS

([0,0,0,0.0676799132244755,0,0,0,0.0617430664415538,0,0,0.0643503076721293,0.0585289895998447,0.0768831838611304,0.0723013317215944,0.109876281519855,0.144695581535188,0.157431228422822,0.150982744288732,0.148878496846544,0.162919386742817,0.162617554985862,0.152242253414188,0.140576057106494,0.142735688520511,0.11377891709019,0.0915521739041673,0.0791732237087982,0.092318989158323,0.0823249224088215,0.0918657677350102,0.0592048270920026,0.0600629813985433,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]).asString.postln

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