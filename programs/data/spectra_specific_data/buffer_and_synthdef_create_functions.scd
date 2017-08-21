~audioBufferCreate = {
	arg instrument;
	("~" ++ instrument ++ "AudioBuffer = Buffer.read(s, ~trace +/+ " ++ ("audio" +/+ instrument ++ ".wav").asCompileString ++");").interpret
};

~audioSynthDefCreate = {
	arg instrument;

	("SynthDef(" ++ (instrument ++ "Audio").asCompileString ++ ",{ arg out=0,bufnum=0, trigger=1, startPos=0, loop=1;
		var rate;
		rate = 1.0; // Can be used to affect pitch/speed of playback
		Out.ar(out,
			Pan2.ar(PlayBuf.ar(1,bufnum, BufRateScale.kr(bufnum)*rate, trigger, BufFrames.ir(bufnum)*startPos, loop=0),0.0)
		);
}).add;").interpret;
};


~audioGenerator = {
	arg instrument;
		~audioBufferCreate.value(instrument:instrument);
	~audioSynthDefCreate.value(instrument:instrument);
};