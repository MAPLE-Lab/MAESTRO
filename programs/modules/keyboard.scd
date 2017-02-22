(
~keyboard = Window.new("Keyboard", Rect(50,200,420+20+20,200), false, true).front.background_(Color.white);

~title =StaticText(~keyboard,Rect(0,0,420+20+20,300))
.string_("Keyboard")
.align_(\top)
.font_(Font(["Helvetica"], 15, true));

/* d = SynthDef.new(\SimpleSine, {|freq = 440| Out.ar(0, SinOsc.ar(freq, 0, 0.2)) }); */
/*
//INTENSITY of deviant
//Properties of the slider
~mulslider = Slider(~keyboard, Rect(0,180,420+20+20,20))
.background_(Color(0.8,0.8,0.8,0.75))
	.valueAction_(0) //is converted to 1
 .step_(1/35)
.action_({
	arg obj;
	var cf;
	cf = obj.value.linlin(0,1,40,75).postln;
/*
	(
		if( //This IF function provides the capability to control the system
		obj.value.linlin(0,1,40,76) == 40, {a.free; //Needs to be at front because when leaving the slider position calls the first
				// a = Synth(\SimpleSine);
			~c4.background_(Color.red);
	}, {a.free; ~c4.background_(Color.white)});
	)
*/
});
*/

//Keyboard visual
~outline = StaticText(~keyboard, Rect(20-1,20-1,420+1,150+2));
~outline.background = Color.black;

//White keys
~c4 = StaticText(~keyboard, Rect(20+0,20,19,150)).background_(Color.white).string_("C4
40").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~d4 = StaticText(~keyboard, Rect(20+20,20,19,150)).background_(Color.white).string_("D4").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~e4 = StaticText(~keyboard, Rect(20+40,20,19,150)).background_(Color.white).string_("E4").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~f4 = StaticText(~keyboard, Rect(20+60,20,19,150)).background_(Color.white).string_("F4").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~g4 = StaticText(~keyboard, Rect(20+80,20,19,150)).background_(Color.white).string_("G4").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~a4 = StaticText(~keyboard, Rect(20+100,20,19,150)).background_(Color.white).string_("A4").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~b4 = StaticText(~keyboard, Rect(20+120,20,19,150)).background_(Color.white).string_("B4").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~c5 = StaticText(~keyboard, Rect(20+140,20,19,150)).background_(Color.white).string_("C5").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~d5 = StaticText(~keyboard, Rect(20+160,20,19,150)).background_(Color.white).string_("D5").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~e5 = StaticText(~keyboard, Rect(20+180,20,19,150)).background_(Color.white).string_("E5").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~f5 = StaticText(~keyboard, Rect(20+200,20,19,150)).background_(Color.white).string_("F5").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~g5 = StaticText(~keyboard, Rect(20+220,20,19,150)).background_(Color.white).string_("G5").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~a5 = StaticText(~keyboard, Rect(20+240,20,19,150)).background_(Color.white).string_("A5").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~b5 = StaticText(~keyboard, Rect(20+260,20,19,150)).background_(Color.white).string_("B5").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~c6 = StaticText(~keyboard, Rect(20+280,20,19,150)).background_(Color.white).string_("C6").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~d6 = StaticText(~keyboard, Rect(20+300,20,19,150)).background_(Color.white).string_("D6").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~e6 = StaticText(~keyboard, Rect(20+320,20,19,150)).background_(Color.white).string_("E6").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~f6 = StaticText(~keyboard, Rect(20+340,20,19,150)).background_(Color.white).string_("F6").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~g6 = StaticText(~keyboard, Rect(20+360,20,19,150)).background_(Color.white).string_("G6").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~a6 = StaticText(~keyboard, Rect(20+380,20,19,150)).background_(Color.white).string_("A6").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~b6 = StaticText(~keyboard, Rect(20+400,20,19,150)).background_(Color.white).string_("B6
75").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));

//Black keys
~cSHARP4 = StaticText(~keyboard, Rect(30+0,20,19,100)).background_(Color.black).string_("C#").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~dSHARP4 = StaticText(~keyboard, Rect(30+20,20,19,100)).background_(Color.black).string_("D#").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~fSHARP4 = StaticText(~keyboard, Rect(30+60,20,19,100)).background_(Color.black).string_("F#").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~gSHARP4 = StaticText(~keyboard, Rect(30+80,20,19,100)).background_(Color.black).string_("G#").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~aSHARP4 = StaticText(~keyboard, Rect(30+100,20,19,100)).background_(Color.black).string_("A#").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~cSHARP5 = StaticText(~keyboard, Rect(30+140,20,19,100)).background_(Color.black).string_("C#").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~dSHARP5 = StaticText(~keyboard, Rect(30+160,20,19,100)).background_(Color.black).string_("D#").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~fSHARP5 = StaticText(~keyboard, Rect(30+200,20,19,100)).background_(Color.black).string_("F#").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~gSHARP5 = StaticText(~keyboard, Rect(30+220,20,19,100)).background_(Color.black).string_("G#").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~aSHARP5 = StaticText(~keyboard, Rect(30+240,20,19,100)).background_(Color.black).string_("A#").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~cSHARP6 = StaticText(~keyboard, Rect(30+280,20,19,100)).background_(Color.black).string_("C#").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~dSHARP6 = StaticText(~keyboard, Rect(30+300,20,19,100)).background_(Color.black).string_("D#").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~fSHARP6 = StaticText(~keyboard, Rect(30+340,20,19,100)).background_(Color.black).string_("F#").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~gSHARP6 = StaticText(~keyboard, Rect(30+360,20,19,100)).background_(Color.black).string_("G#").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~aSHARP6 = StaticText(~keyboard, Rect(30+380,20,19,100)).background_(Color.black).string_("A#").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));

//Note name



w.onClose_({a.free});
)
