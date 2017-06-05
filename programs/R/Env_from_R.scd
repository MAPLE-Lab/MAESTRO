(
s.waitForBoot(
{
	var basePath = thisProcess.nowExecutingPath.asString.dirname;

	(basePath +/+  "env_harmonic1").load;

    SinOsc.ar(100) * EnvGen.kr(~envelope1, doneAction: 2)
}.play
)
)