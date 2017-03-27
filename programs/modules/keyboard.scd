(
~keyboard = Window.new("Keyboard", Rect(
	Window.screenBounds.width/2-((420+20+20+620)/2),50,
	420+20+20+620,190), false, true).front.background_(Color.white).userCanClose_(true);

~title =StaticText(~keyboard,Rect(0,0,(420+20+20+620),300))
.string_("Keyboard")
.align_(\top)
.font_(Font(["Helvetica"], 15, true));
/*
/* d = SynthDef.new(\SimpleSine, {|freq = 440| Out.ar(0, SinOsc.ar(freq, 0, 0.2)) }); */

//INTENSITY of deviant
//Properties of the slider
~opslider = Slider(~keyboard, Rect(0,180-10,420+20+20,20))
.background_(Color(0.8,0.8,0.8,0.75))
	.valueAction_(0) //is converted to 1
// .step_(1/35)
.action_({
	arg obj;
	var white, black;
	white = obj.value.linlin(0,1,1,0).postln;
	black = obj.value.linlin(0,1,0,1).postln;
	~c6.background_(Color(1,white,white,1));
	~cSHARP6.background_(Color(black,0,0,1));


/*	cf = obj.value.linlin(0,1,40,75).postln;

	(
		if( //This IF function provides the capability to control the system
		obj.value.linlin(0,1,40,75) == 40, {a.free; //Needs to be at front because when leaving the slider position calls the first
				// a = Synth(\SimpleSine);
			~c4.background_(Color.red);
	}, {a.free; ~c4.background_(Color.white)});
	)*/

});
*/

//Keyboard visual
~outline = StaticText(~keyboard, Rect(20-1,20-1,420+1+620,150+2));
~outline.background = Color.black;

//White keys
~a0 = StaticText(~keyboard, Rect(20+0,20,19,150)).background_(Color.white).string_("").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~b0 = StaticText(~keyboard, Rect(20+20,20,19,150)).background_(Color.white).string_("").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~c1 = StaticText(~keyboard, Rect(20+40,20,19,150)).background_(Color.white).string_("").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~d1 = StaticText(~keyboard, Rect(20+60,20,19,150)).background_(Color.white).string_("").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~e1 = StaticText(~keyboard, Rect(20+80,20,19,150)).background_(Color.white).string_("").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~f1 = StaticText(~keyboard, Rect(20+100,20,19,150)).background_(Color.white).string_("").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~g1 = StaticText(~keyboard, Rect(20+120,20,19,150)).background_(Color.white).string_("").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~a1 = StaticText(~keyboard, Rect(20+140,20,19,150)).background_(Color.white).string_("").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~b1 = StaticText(~keyboard, Rect(20+160,20,19,150)).background_(Color.white).string_("").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~c2 = StaticText(~keyboard, Rect(20+180,20,19,150)).background_(Color.white).string_("").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~d2 = StaticText(~keyboard, Rect(20+200,20,19,150)).background_(Color.white).string_("").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~e2 = StaticText(~keyboard, Rect(20+220,20,19,150)).background_(Color.white).string_("").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~f2 = StaticText(~keyboard, Rect(20+240,20,19,150)).background_(Color.white).string_("").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~g2 = StaticText(~keyboard, Rect(20+260,20,19,150)).background_(Color.white).string_("").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~a2 = StaticText(~keyboard, Rect(20+280,20,19,150)).background_(Color.white).string_("").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~b2 = StaticText(~keyboard, Rect(20+300,20,19,150)).background_(Color.white).string_("").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~c3 = StaticText(~keyboard, Rect(20+320,20,19,150)).background_(Color.white).string_("").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~d3 = StaticText(~keyboard, Rect(20+340,20,19,150)).background_(Color.white).string_("").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~e3 = StaticText(~keyboard, Rect(20+360,20,19,150)).background_(Color.white).string_("").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~f3 = StaticText(~keyboard, Rect(20+380,20,19,150)).background_(Color.white).string_("").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~g3 = StaticText(~keyboard, Rect(20+400,20,19,150)).background_(Color.white).string_("").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~a3 = StaticText(~keyboard, Rect(20+420,20,19,150)).background_(Color.white).string_("").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~b3 = StaticText(~keyboard, Rect(20+440,20,19,150)).background_(Color.white).string_("").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~c4 = StaticText(~keyboard, Rect(20+460,20,19,150)).background_(Color.white).string_("").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~d4 = StaticText(~keyboard, Rect(20+480,20,19,150)).background_(Color.white).string_("").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~e4 = StaticText(~keyboard, Rect(20+500,20,19,150)).background_(Color.white).string_("").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~f4 = StaticText(~keyboard, Rect(20+520,20,19,150)).background_(Color.white).string_("").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~g4 = StaticText(~keyboard, Rect(20+540,20,19,150)).background_(Color.white).string_("").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~a4 = StaticText(~keyboard, Rect(20+560,20,19,150)).background_(Color.white).string_("").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~b4 = StaticText(~keyboard, Rect(20+580,20,19,150)).background_(Color.white).string_("").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~c5 = StaticText(~keyboard, Rect(20+600,20,19,150)).background_(Color.white).string_("").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~d5 = StaticText(~keyboard, Rect(20+620,20,19,150)).background_(Color.white).string_("").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~e5 = StaticText(~keyboard, Rect(20+640,20,19,150)).background_(Color.white).string_("").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~f5 = StaticText(~keyboard, Rect(20+660,20,19,150)).background_(Color.white).string_("").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~g5 = StaticText(~keyboard, Rect(20+680,20,19,150)).background_(Color.white).string_("").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~a5 = StaticText(~keyboard, Rect(20+700,20,19,150)).background_(Color.white).string_("").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~b5 = StaticText(~keyboard, Rect(20+720,20,19,150)).background_(Color.white).string_("").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~c6 = StaticText(~keyboard, Rect(20+740,20,19,150)).background_(Color.white).string_("").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~d6 = StaticText(~keyboard, Rect(20+760,20,19,150)).background_(Color.white).string_("").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~e6 = StaticText(~keyboard, Rect(20+780,20,19,150)).background_(Color.white).string_("").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~f6 = StaticText(~keyboard, Rect(20+800,20,19,150)).background_(Color.white).string_("").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~g6 = StaticText(~keyboard, Rect(20+820,20,19,150)).background_(Color.white).string_("").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~a6 = StaticText(~keyboard, Rect(20+840,20,19,150)).background_(Color.white).string_("").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~b6 = StaticText(~keyboard, Rect(20+860,20,19,150)).background_(Color.white).string_("").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~c7 = StaticText(~keyboard, Rect(20+880,20,19,150)).background_(Color.white).string_("").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~d7 = StaticText(~keyboard, Rect(20+900,20,19,150)).background_(Color.white).string_("").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~e7 = StaticText(~keyboard, Rect(20+920,20,19,150)).background_(Color.white).string_("").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~f7 = StaticText(~keyboard, Rect(20+940,20,19,150)).background_(Color.white).string_("").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~g7 = StaticText(~keyboard, Rect(20+960,20,19,150)).background_(Color.white).string_("").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~a7 = StaticText(~keyboard, Rect(20+980,20,19,150)).background_(Color.white).string_("").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~b7 = StaticText(~keyboard, Rect(20+1000,20,19,150)).background_(Color.white).string_("").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~c8 = StaticText(~keyboard, Rect(20+1020,20,19,150)).background_(Color.white).string_("").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));

/*
~c4 = StaticText(~keyboard, Rect(20+0,20,19,150)).background_(Color.white).string_("").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~d4 = StaticText(~keyboard, Rect(20+20,20,19,150)).background_(Color.white).string_("").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~e4 = StaticText(~keyboard, Rect(20+40,20,19,150)).background_(Color.white).string_("").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~f4 = StaticText(~keyboard, Rect(20+60,20,19,150)).background_(Color.white).string_("").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~g4 = StaticText(~keyboard, Rect(20+80,20,19,150)).background_(Color.white).string_("").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~a4 = StaticText(~keyboard, Rect(20+100,20,19,150)).background_(Color.white).string_("").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~b4 = StaticText(~keyboard, Rect(20+120,20,19,150)).background_(Color.white).string_("").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~c5 = StaticText(~keyboard, Rect(20+140,20,19,150)).background_(Color.white).string_("").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~d5 = StaticText(~keyboard, Rect(20+160,20,19,150)).background_(Color.white).string_("").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~e5 = StaticText(~keyboard, Rect(20+180,20,19,150)).background_(Color.white).string_("").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~f5 = StaticText(~keyboard, Rect(20+200,20,19,150)).background_(Color.white).string_("").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~g5 = StaticText(~keyboard, Rect(20+220,20,19,150)).background_(Color.white).string_("").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~a5 = StaticText(~keyboard, Rect(20+240,20,19,150)).background_(Color.white).string_("").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~b5 = StaticText(~keyboard, Rect(20+260,20,19,150)).background_(Color.white).string_("").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~c6 = StaticText(~keyboard, Rect(20+280,20,19,150)).background_(Color.white).string_("").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~d6 = StaticText(~keyboard, Rect(20+300,20,19,150)).background_(Color.white).string_("").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~e6 = StaticText(~keyboard, Rect(20+320,20,19,150)).background_(Color.white).string_("").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~f6 = StaticText(~keyboard, Rect(20+340,20,19,150)).background_(Color.white).string_("").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~g6 = StaticText(~keyboard, Rect(20+360,20,19,150)).background_(Color.white).string_("").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~a6 = StaticText(~keyboard, Rect(20+380,20,19,150)).background_(Color.white).string_("").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~b6 = StaticText(~keyboard, Rect(20+400,20,19,150)).background_(Color.white).string_("").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
*/

/*
~c4 = StaticText(~keyboard, Rect(20+0,20,19,150)).background_(Color.white).string_("").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~d4 = StaticText(~keyboard, Rect(20+20,20,19,150)).background_(Color.white).string_("D4
42").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~e4 = StaticText(~keyboard, Rect(20+40,20,19,150)).background_(Color.white).string_("E4
44").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~f4 = StaticText(~keyboard, Rect(20+60,20,19,150)).background_(Color.white).string_("F4
45").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~g4 = StaticText(~keyboard, Rect(20+80,20,19,150)).background_(Color.white).string_("G4
47").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~a4 = StaticText(~keyboard, Rect(20+100,20,19,150)).background_(Color.white).string_("A4
49").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~b4 = StaticText(~keyboard, Rect(20+120,20,19,150)).background_(Color.white).string_("B4
51").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~c5 = StaticText(~keyboard, Rect(20+140,20,19,150)).background_(Color.white).string_("C5
52").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~d5 = StaticText(~keyboard, Rect(20+160,20,19,150)).background_(Color.white).string_("D5
54").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~e5 = StaticText(~keyboard, Rect(20+180,20,19,150)).background_(Color.white).string_("E5
56").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~f5 = StaticText(~keyboard, Rect(20+200,20,19,150)).background_(Color.white).string_("F5
57").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~g5 = StaticText(~keyboard, Rect(20+220,20,19,150)).background_(Color.white).string_("G5
59").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~a5 = StaticText(~keyboard, Rect(20+240,20,19,150)).background_(Color.white).string_("A5
61").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~b5 = StaticText(~keyboard, Rect(20+260,20,19,150)).background_(Color.white).string_("B5
63").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~c6 = StaticText(~keyboard, Rect(20+280,20,19,150)).background_(Color.white).string_("C6
64").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~d6 = StaticText(~keyboard, Rect(20+300,20,19,150)).background_(Color.white).string_("D6
66").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~e6 = StaticText(~keyboard, Rect(20+320,20,19,150)).background_(Color.white).string_("E6
68").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~f6 = StaticText(~keyboard, Rect(20+340,20,19,150)).background_(Color.white).string_("F6
69").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~g6 = StaticText(~keyboard, Rect(20+360,20,19,150)).background_(Color.white).string_("G6
71").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~a6 = StaticText(~keyboard, Rect(20+380,20,19,150)).background_(Color.white).string_("A6
73").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~b6 = StaticText(~keyboard, Rect(20+400,20,19,150)).background_(Color.white).string_("B6
75").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
*/

//Black keys

~aSHARP0 = StaticText(~keyboard, Rect(30+0,20,19,100)).background_(Color.black).string_("");
~cSHARP1 = StaticText(~keyboard, Rect(30+40,20,19,100)).background_(Color.black).string_("");
~dSHARP1 = StaticText(~keyboard, Rect(30+60,20,19,100)).background_(Color.black).string_("");
~fSHARP1 = StaticText(~keyboard, Rect(30+100,20,19,100)).background_(Color.black).string_("");
~gSHARP1 = StaticText(~keyboard, Rect(30+120,20,19,100)).background_(Color.black).string_("");
~aSHARP1 = StaticText(~keyboard, Rect(30+140,20,19,100)).background_(Color.black).string_("");
~cSHARP2 = StaticText(~keyboard, Rect(30+180,20,19,100)).background_(Color.black).string_("");
~dSHARP2 = StaticText(~keyboard, Rect(30+200,20,19,100)).background_(Color.black).string_("");
~fSHARP2 = StaticText(~keyboard, Rect(30+240,20,19,100)).background_(Color.black).string_("");
~gSHARP2 = StaticText(~keyboard, Rect(30+260,20,19,100)).background_(Color.black).string_("");
~aSHARP2 = StaticText(~keyboard, Rect(30+280,20,19,100)).background_(Color.black).string_("");
~cSHARP3 = StaticText(~keyboard, Rect(30+320,20,19,100)).background_(Color.black).string_("");
~dSHARP3 = StaticText(~keyboard, Rect(30+340,20,19,100)).background_(Color.black).string_("");
~fSHARP3 = StaticText(~keyboard, Rect(30+380,20,19,100)).background_(Color.black).string_("");
~gSHARP3 = StaticText(~keyboard, Rect(30+400,20,19,100)).background_(Color.black).string_("");
~aSHARP3 = StaticText(~keyboard, Rect(30+420,20,19,100)).background_(Color.black).string_("");
~cSHARP4 = StaticText(~keyboard, Rect(30+460,20,19,100)).background_(Color.black).string_("");
~dSHARP4 = StaticText(~keyboard, Rect(30+480,20,19,100)).background_(Color.black).string_("");
~fSHARP4 = StaticText(~keyboard, Rect(30+520,20,19,100)).background_(Color.black).string_("");
~gSHARP4 = StaticText(~keyboard, Rect(30+540,20,19,100)).background_(Color.black).string_("");
~aSHARP4 = StaticText(~keyboard, Rect(30+560,20,19,100)).background_(Color.black).string_("");
~cSHARP5 = StaticText(~keyboard, Rect(30+600,20,19,100)).background_(Color.black).string_("");
~dSHARP5 = StaticText(~keyboard, Rect(30+620,20,19,100)).background_(Color.black).string_("");
~fSHARP5 = StaticText(~keyboard, Rect(30+660,20,19,100)).background_(Color.black).string_("");
~gSHARP5 = StaticText(~keyboard, Rect(30+680,20,19,100)).background_(Color.black).string_("");
~aSHARP5 = StaticText(~keyboard, Rect(30+700,20,19,100)).background_(Color.black).string_("");
~cSHARP6 = StaticText(~keyboard, Rect(30+740,20,19,100)).background_(Color.black).string_("");
~dSHARP6 = StaticText(~keyboard, Rect(30+760,20,19,100)).background_(Color.black).string_("");
~fSHARP6 = StaticText(~keyboard, Rect(30+800,20,19,100)).background_(Color.black).string_("");
~gSHARP6 = StaticText(~keyboard, Rect(30+820,20,19,100)).background_(Color.black).string_("");
~aSHARP6 = StaticText(~keyboard, Rect(30+840,20,19,100)).background_(Color.black).string_("");
~cSHARP7 = StaticText(~keyboard, Rect(30+880,20,19,100)).background_(Color.black).string_("");
~dSHARP7 = StaticText(~keyboard, Rect(30+900,20,19,100)).background_(Color.black).string_("");
~fSHARP7 = StaticText(~keyboard, Rect(30+940,20,19,100)).background_(Color.black).string_("");
~gSHARP7 = StaticText(~keyboard, Rect(30+960,20,19,100)).background_(Color.black).string_("");
~aSHARP7 = StaticText(~keyboard, Rect(30+980,20,19,100)).background_(Color.black).string_("");

~aSHARP0dev = StaticText(~keyboard, Rect(30+0,20,19,100)).background_(Color.clear).string_("");
~cSHARP1dev = StaticText(~keyboard, Rect(30+40,20,19,100)).background_(Color.clear).string_("");
~dSHARP1dev = StaticText(~keyboard, Rect(30+60,20,19,100)).background_(Color.clear).string_("");
~fSHARP1dev = StaticText(~keyboard, Rect(30+100,20,19,100)).background_(Color.clear).string_("");
~gSHARP1dev = StaticText(~keyboard, Rect(30+120,20,19,100)).background_(Color.clear).string_("");
~aSHARP1dev = StaticText(~keyboard, Rect(30+140,20,19,100)).background_(Color.clear).string_("");
~cSHARP2dev = StaticText(~keyboard, Rect(30+180,20,19,100)).background_(Color.clear).string_("");
~dSHARP2dev = StaticText(~keyboard, Rect(30+200,20,19,100)).background_(Color.clear).string_("");
~fSHARP2dev = StaticText(~keyboard, Rect(30+240,20,19,100)).background_(Color.clear).string_("");
~gSHARP2dev = StaticText(~keyboard, Rect(30+260,20,19,100)).background_(Color.clear).string_("");
~aSHARP2dev = StaticText(~keyboard, Rect(30+280,20,19,100)).background_(Color.clear).string_("");
~cSHARP3dev = StaticText(~keyboard, Rect(30+320,20,19,100)).background_(Color.clear).string_("");
~dSHARP3dev = StaticText(~keyboard, Rect(30+340,20,19,100)).background_(Color.clear).string_("");
~fSHARP3dev = StaticText(~keyboard, Rect(30+380,20,19,100)).background_(Color.clear).string_("");
~gSHARP3dev = StaticText(~keyboard, Rect(30+400,20,19,100)).background_(Color.clear).string_("");
~aSHARP3dev = StaticText(~keyboard, Rect(30+420,20,19,100)).background_(Color.clear).string_("");
~cSHARP4dev = StaticText(~keyboard, Rect(30+460,20,19,100)).background_(Color.clear).string_("");
~dSHARP4dev = StaticText(~keyboard, Rect(30+480,20,19,100)).background_(Color.clear).string_("");
~fSHARP4dev = StaticText(~keyboard, Rect(30+520,20,19,100)).background_(Color.clear).string_("");
~gSHARP4dev = StaticText(~keyboard, Rect(30+540,20,19,100)).background_(Color.clear).string_("");
~aSHARP4dev = StaticText(~keyboard, Rect(30+560,20,19,100)).background_(Color.clear).string_("");
~cSHARP5dev = StaticText(~keyboard, Rect(30+600,20,19,100)).background_(Color.clear).string_("");
~dSHARP5dev = StaticText(~keyboard, Rect(30+620,20,19,100)).background_(Color.clear).string_("");
~fSHARP5dev = StaticText(~keyboard, Rect(30+660,20,19,100)).background_(Color.clear).string_("");
~gSHARP5dev = StaticText(~keyboard, Rect(30+680,20,19,100)).background_(Color.clear).string_("");
~aSHARP5dev = StaticText(~keyboard, Rect(30+700,20,19,100)).background_(Color.clear).string_("");
~cSHARP6dev = StaticText(~keyboard, Rect(30+740,20,19,100)).background_(Color.clear).string_("");
~dSHARP6dev = StaticText(~keyboard, Rect(30+760,20,19,100)).background_(Color.clear).string_("");
~fSHARP6dev = StaticText(~keyboard, Rect(30+800,20,19,100)).background_(Color.clear).string_("");
~gSHARP6dev = StaticText(~keyboard, Rect(30+820,20,19,100)).background_(Color.clear).string_("");
~aSHARP6dev = StaticText(~keyboard, Rect(30+840,20,19,100)).background_(Color.clear).string_("");
~cSHARP7dev = StaticText(~keyboard, Rect(30+880,20,19,100)).background_(Color.clear).string_("");
~dSHARP7dev = StaticText(~keyboard, Rect(30+900,20,19,100)).background_(Color.clear).string_("");
~fSHARP7dev = StaticText(~keyboard, Rect(30+940,20,19,100)).background_(Color.clear).string_("");
~gSHARP7dev = StaticText(~keyboard, Rect(30+960,20,19,100)).background_(Color.clear).string_("");
~aSHARP7dev = StaticText(~keyboard, Rect(30+980,20,19,100)).background_(Color.clear).string_("");


/*
~cSHARP4 = StaticText(~keyboard, Rect(30+0,20,19,100)).background_(Color.black).string_("");
~dSHARP4 = StaticText(~keyboard, Rect(30+20,20,19,100)).background_(Color.black).string_("");
~fSHARP4 = StaticText(~keyboard, Rect(30+60,20,19,100)).background_(Color.black).string_("");
~gSHARP4 = StaticText(~keyboard, Rect(30+80,20,19,100)).background_(Color.black).string_("");
~aSHARP4 = StaticText(~keyboard, Rect(30+100,20,19,100)).background_(Color.black).string_("");
~cSHARP5 = StaticText(~keyboard, Rect(30+140,20,19,100)).background_(Color.black).string_("");
~dSHARP5 = StaticText(~keyboard, Rect(30+160,20,19,100)).background_(Color.black).string_("");
~fSHARP5 = StaticText(~keyboard, Rect(30+200,20,19,100)).background_(Color.black).string_("");
~gSHARP5 = StaticText(~keyboard, Rect(30+220,20,19,100)).background_(Color.black).string_("");
~aSHARP5 = StaticText(~keyboard, Rect(30+240,20,19,100)).background_(Color.black).string_("");
~cSHARP6 = StaticText(~keyboard, Rect(30+280,20,19,100)).background_(Color.black).string_("");
~dSHARP6 = StaticText(~keyboard, Rect(30+300,20,19,100)).background_(Color.black).string_("");
~fSHARP6 = StaticText(~keyboard, Rect(30+340,20,19,100)).background_(Color.black).string_("");
~gSHARP6 = StaticText(~keyboard, Rect(30+360,20,19,100)).background_(Color.black).string_("");
~aSHARP6 = StaticText(~keyboard, Rect(30+380,20,19,100)).background_(Color.black).string_("");
*/

/*
~cSHARP4 = StaticText(~keyboard, Rect(30+0,20,19,100)).background_(Color.black).string_("C#
41").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~dSHARP4 = StaticText(~keyboard, Rect(30+20,20,19,100)).background_(Color.black).string_("D#
43").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~fSHARP4 = StaticText(~keyboard, Rect(30+60,20,19,100)).background_(Color.black).string_("F#
46").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~gSHARP4 = StaticText(~keyboard, Rect(30+80,20,19,100)).background_(Color.black).string_("G#
48").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~aSHARP4 = StaticText(~keyboard, Rect(30+100,20,19,100)).background_(Color.black).string_("A#
50").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~cSHARP5 = StaticText(~keyboard, Rect(30+140,20,19,100)).background_(Color.black).string_("C#
53").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~dSHARP5 = StaticText(~keyboard, Rect(30+160,20,19,100)).background_(Color.black).string_("D#
55").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~fSHARP5 = StaticText(~keyboard, Rect(30+200,20,19,100)).background_(Color.black).string_("F#
58").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~gSHARP5 = StaticText(~keyboard, Rect(30+220,20,19,100)).background_(Color.black).string_("G#
60").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~aSHARP5 = StaticText(~keyboard, Rect(30+240,20,19,100)).background_(Color.black).string_("A#
62").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~cSHARP6 = StaticText(~keyboard, Rect(30+280,20,19,100)).background_(Color.black).string_("C#
65").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~dSHARP6 = StaticText(~keyboard, Rect(30+300,20,19,100)).background_(Color.black).string_("D#
67").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~fSHARP6 = StaticText(~keyboard, Rect(30+340,20,19,100)).background_(Color.black).string_("F#
70").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~gSHARP6 = StaticText(~keyboard, Rect(30+360,20,19,100)).background_(Color.black).string_("G#
72").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~aSHARP6 = StaticText(~keyboard, Rect(30+380,20,19,100)).background_(Color.black).string_("A#
74").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
*/

//Middle C note
~c4note = StaticText(~keyboard, Rect(20+460,20,19,150)).background_(Color.clear).string_("C4
60").align_(\bottom).stringColor_(Color.black).font_(Font("Helvetica", 10));

//Lowest note
~a0note = StaticText(~keyboard, Rect(20+0,20,19,150)).background_(Color.clear).string_("A0
21").align_(\bottom).stringColor_(Color.black).font_(Font("Helvetica", 10));

//Highest note
~c8note = StaticText(~keyboard, Rect(20+1020,20,19,150)).background_(Color.clear).string_("C8
108").align_(\bottom).stringColor_(Color.black).font_(Font("Helvetica", 10));

w.onClose_({a.free; ~keyboard_open = 0;});
)
