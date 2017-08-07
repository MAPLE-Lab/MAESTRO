~synthesizerPlotFunction = {
	arg j, attackTime, sustainTime, releaseTime, startTime, onCurve, offCurve, intensityValue, intensityPeak;
	j.postln;

	attackTime = (("~attack" ++ j).interpret.value.interpret)/1000;
	sustainTime = (("~sustain" ++ j).interpret.value.interpret)/1000;
	releaseTime = (("~release" ++ j).interpret.value.interpret)/1000;
	startTime = (("~startTime" ++ j).interpret.value.interpret)/1000;
	onCurve = ("~onCurve" ++ j).interpret.value.interpret;
	offCurve = ("~offCurve" ++ j).interpret.value.interpret;
	intensityValue = ("~intensity" ++ j).interpret.value.interpret;

	intensityPeak = intensityValue; //*0.2; This is confusing, as this *0.2 is hidden from the user during use

	Env.new(levels:[0,0,intensityPeak,intensityPeak,0], times:[startTime, attackTime, sustainTime, releaseTime], curve:[0,onCurve,0,offCurve]).plot;

				/*("~sound" ++ j ++ "Synth = Synth(" ++ ("sound" ++ j).asCompileString
	++ ", [
\\freq, ~freq" ++ j ++ ".value.interpret,
				\\attackTime, (~attack" ++ j ++ ".value.interpret)/1000,
				\\sustainTime, (~sustain" ++ j ++ ".value.interpret)/1000,
				\\releaseTime, (~release" ++ j ++ ".value.interpret)/1000,
				\\startTime, (~startTime" ++ j ++ ".value.interpret)/1000,
				\\onCurve, ~onCurve" ++ j ++ ".value.interpret,
				\\offCurve, ~offCurve" ++ j ++ ".value.interpret,
				\\intensityValue, ~intensity" ++ j ++ ".value.interpret
]);").interpret;*/
};

//~synthesizerPlotFunction.value(j:1)

/*
{
	arg j;

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
}
*/