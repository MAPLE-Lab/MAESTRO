//~menu2.valueAction_(5);
// s.boot;
//
// (
// s.makeBundle(2.0, {
// 	//~menu2.valueAction_(5); // Activates it as being 5
// 	//~coverComposite.visible = false;
// 	//~menu2.value_(5);
// 	"activated".postln;
// });
// )
//
// s.boot;
// (
// // send a synth def to server
// SynthDef("tpulse", { arg out=0,freq=700,sawFreq=440.0;
// 	    Out.ar(out, SyncSaw.ar(freq,  sawFreq,0.1) ); "activated".postln;
// }).play;
// )
//
// (
// s.makeBundle(2.0, {
// 	    x = Synth.new("tpulse");
// 	    a = Bus.control.set(440);
// 	    x.map(\freq, a);
// 	"activated".postln;
// });
// )
// x.free;

(
~delta = 0;
~run = Routine({
    loop {
        ~delta = rrand(1, 3) * 0.5;
        "Will wait ".post; ~delta.postln;
		if(~delta == 1.5, {"YES".postln; ~menu2.valueAction_(5);}, {});
        ~delta.yield;
    }
});

//r.next;

TempoClock.default.sched(0, ~run);

)

//~run.stop;