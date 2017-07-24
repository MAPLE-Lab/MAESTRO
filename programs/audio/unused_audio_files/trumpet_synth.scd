////////////////////////////START OF PROGRAM/////////////////////////

//BLOCK1 - Replace the Env section to plot the envelope, to pretest
Env([0,0.2,0.9,1,0.4,0]*0.2, [0.2,0.1,0.1,1,5]*1,[2,0.1,-10,6,-20]).plot; //see below in BLOCK2 for the relevant arg locations

//BLOCK2 - Define the sound
(

var horn1Env, horn2Env, horn3Env, horn4Env, horn5Env, horn6Env, horn7Env, horn8Env, horn9Env;


horn1Env =
Env([
0	,
50	,
	45,
0	,
]*0.005, [
0.1,
3.48	,
	0.1,
],[
	1	,
1	,
	1,
]);
// horn1Env.plot;

horn7Env =
Env([
0	,
50	,
	45,
0	,
]*0.005, [
0.02,
3.58	,
	0.1,
],[
	1	,
1	,
	1,
]);
// horn7Env.plot;


horn8Env =
Env([
0	,
80	,
	45,
0	,
]*0.005, [
0.02,
3.46	,
	0.14,
],[
	1	,
1	,
	1,
]);
// horn8Env.plot;


horn9Env =
Env([
0	,
80	,
	45,
0	,
]*0.005, [
0.02,
3.43	,
	0.17,
],[
	1	,
1	,
	1,
]);
// horn9Env.plot;

SynthDef.new("hornHarmonic1", {
	arg freq, amp, pan, dur, ratio;
	var sound, env_gen, env;


	env_gen = EnvGen.kr(horn1Env); //loads the envelope as a control UGen
	sound = SinOsc.ar((freq*ratio), mul: (env_gen*amp*(1+WhiteNoise.kr(mul:0.07)))); //uses envelope as a multiplier of amplitude

	Out.ar(0, Pan2.ar(sound, pan)); //sends to busses? // send output to audio bus zero.
}).send(s);

SynthDef.new("hornHarmonic7", {
	arg freq, amp, pan, dur, ratio;
	var sound, env_gen, env;


	env_gen = EnvGen.kr(horn7Env); //loads the envelope as a control UGen
	sound = SinOsc.ar((freq*ratio), mul: env_gen*amp); //uses envelope as a multiplier of amplitude

	Out.ar(0, Pan2.ar(sound, pan)); //sends to busses? // send output to audio bus zero.
}).send(s);

SynthDef.new("hornHarmonic8", {
	arg freq, amp, pan, dur, ratio;
	var sound, env_gen, env;


	env_gen = EnvGen.kr(horn8Env); //loads the envelope as a control UGen
	sound = SinOsc.ar((freq*ratio), mul: env_gen*amp); //uses envelope as a multiplier of amplitude

	Out.ar(0, Pan2.ar(sound, pan)); //sends to busses? // send output to audio bus zero.
}).send(s);

SynthDef.new("hornHarmonic9", {
	arg freq, amp, pan, dur, ratio;
	var sound, env_gen, env;


	env_gen = EnvGen.kr(horn9Env); //loads the envelope as a control UGen
	sound = SinOsc.ar((freq*ratio), mul: env_gen*amp); //uses envelope as a multiplier of amplitude

	Out.ar(0, Pan2.ar(sound, pan)); //sends to busses? // send output to audio bus zero.
}).send(s);


)



//BLOCK4 -Bundled chords with tonic changer
(
(
s.sendBundle(0.0, //sound delay
	["/s_new", "hornHarmonic7", x = s.nextNodeID, 1, 1, freq:(261.6), dur:1, amp:0.035, pan:0, ratio:(1/1)],
	["/s_new", "hornHarmonic1", y = s.nextNodeID, 1, 1, freq:(261.6), dur:1, amp:0.07, pan:0, ratio:(2/1)],
	["/s_new", "hornHarmonic1", z = s.nextNodeID, 1, 1, freq:(261.6), dur:1, amp:0.14, pan:0, ratio:(3/1)],
	["/s_new", "hornHarmonic1", a = s.nextNodeID, 1, 1, freq:(261.6), dur:1, amp:0.18, pan:0, ratio:(4/1)],
	["/s_new", "hornHarmonic1", a = s.nextNodeID, 1, 1, freq:(261.6), dur:1, amp:0.23, pan:0, ratio:(5/1)],
	["/s_new", "hornHarmonic1", a = s.nextNodeID, 1, 1, freq:(261.6), dur:1, amp:0.15, pan:0, ratio:(6/1)],
	["/s_new", "hornHarmonic1", a = s.nextNodeID, 1, 1, freq:(261.6), dur:1, amp:0.12, pan:0, ratio:(7/1)],
	["/s_new", "hornHarmonic9", a = s.nextNodeID, 1, 1, freq:(261.6), dur:1, amp:0.08, pan:0, ratio:(8/1)],
	["/s_new", "hornHarmonic9", a = s.nextNodeID, 1, 1, freq:(261.6), dur:1, amp:0.06, pan:0, ratio:(9/1)],
	["/s_new", "hornHarmonic9", a = s.nextNodeID, 1, 1, freq:(261.6), dur:1, amp:0.03, pan:0, ratio:(10/1)],
	["/s_new", "hornHarmonic9", a = s.nextNodeID, 1, 1, freq:(261.6), dur:1, amp:0.02, pan:0, ratio:(11/1)],
	["/s_new", "hornHarmonic8", a = s.nextNodeID, 1, 1, freq:(261.6), dur:1, amp:0.01, pan:0, ratio:(12/1)],
	["/s_new", "hornHarmonic8", a = s.nextNodeID, 1, 1, freq:(261.6), dur:1, amp:0.008, pan:0, ratio:(13/1)],
	["/s_new", "hornHarmonic8", a = s.nextNodeID, 1, 1, freq:(261.6), dur:1, amp:0.003, pan:0, ratio:(14/1)],
	["/s_new", "hornHarmonic8", a = s.nextNodeID, 1, 1, freq:(261.6), dur:1, amp:0.002, pan:0, ratio:(15/1)],
	["/s_new", "hornHarmonic8", a = s.nextNodeID, 1, 1, freq:(261.6), dur:1, amp:0.001, pan:0, ratio:(16/1)],
); //sound and ID for stacking (if multiple sounds bundled)


// s.sendBundle(100, ["/n_free", x],["/n_free", y],["/n_free", z]);//sound ends, at least frees up memory space
);
)
