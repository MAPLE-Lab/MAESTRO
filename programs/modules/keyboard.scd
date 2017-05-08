(
~keyboard = Window.new("Keyboard", Rect(
	Window.screenBounds.width/2-((420+20+20+620)/2),50,
	420+20+20+620,190), false, true).front.background_(Color.white).userCanClose_(false);

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

//White Dots
~dot_a0 = StaticText(~keyboard, Rect(20+0+7,20+150+5,5,5)).background_(Color(0, 0, 0, 0)).string_("").align_(\bottom).stringColor_(Color(0, 0, 0, 1));
~dot_b0 = StaticText(~keyboard, Rect(20+20+7,20+150+5,5,5)).background_(Color(0, 0, 0, 0)).string_("").align_(\bottom).stringColor_(Color(0, 0, 0, 1));
~dot_c1 = StaticText(~keyboard, Rect(20+40+7,20+150+5,5,5)).background_(Color(0, 0, 0, 0)).string_("").align_(\bottom).stringColor_(Color(0, 0, 0, 1));
~dot_d1 = StaticText(~keyboard, Rect(20+60+7,20+150+5,5,5)).background_(Color(0, 0, 0, 0)).string_("").align_(\bottom).stringColor_(Color(0, 0, 0, 1));
~dot_e1 = StaticText(~keyboard, Rect(20+80+7,20+150+5,5,5)).background_(Color(0, 0, 0, 0)).string_("").align_(\bottom).stringColor_(Color(0, 0, 0, 1));
~dot_f1 = StaticText(~keyboard, Rect(20+100+7,20+150+5,5,5)).background_(Color(0, 0, 0, 0)).string_("").align_(\bottom).stringColor_(Color(0, 0, 0, 1));
~dot_g1 = StaticText(~keyboard, Rect(20+120+7,20+150+5,5,5)).background_(Color(0, 0, 0, 0)).string_("").align_(\bottom).stringColor_(Color(0, 0, 0, 1));
~dot_a1 = StaticText(~keyboard, Rect(20+140+7,20+150+5,5,5)).background_(Color(0, 0, 0, 0)).string_("").align_(\bottom).stringColor_(Color(0, 0, 0, 1));
~dot_b1 = StaticText(~keyboard, Rect(20+160+7,20+150+5,5,5)).background_(Color(0, 0, 0, 0)).string_("").align_(\bottom).stringColor_(Color(0, 0, 0, 1));
~dot_c2 = StaticText(~keyboard, Rect(20+180+7,20+150+5,5,5)).background_(Color(0, 0, 0, 0)).string_("").align_(\bottom).stringColor_(Color(0, 0, 0, 1));
~dot_d2 = StaticText(~keyboard, Rect(20+200+7,20+150+5,5,5)).background_(Color(0, 0, 0, 0)).string_("").align_(\bottom).stringColor_(Color(0, 0, 0, 1));
~dot_e2 = StaticText(~keyboard, Rect(20+220+7,20+150+5,5,5)).background_(Color(0, 0, 0, 0)).string_("").align_(\bottom).stringColor_(Color(0, 0, 0, 1));
~dot_f2 = StaticText(~keyboard, Rect(20+240+7,20+150+5,5,5)).background_(Color(0, 0, 0, 0)).string_("").align_(\bottom).stringColor_(Color(0, 0, 0, 1));
~dot_g2 = StaticText(~keyboard, Rect(20+260+7,20+150+5,5,5)).background_(Color(0, 0, 0, 0)).string_("").align_(\bottom).stringColor_(Color(0, 0, 0, 1));
~dot_a2 = StaticText(~keyboard, Rect(20+280+7,20+150+5,5,5)).background_(Color(0, 0, 0, 0)).string_("").align_(\bottom).stringColor_(Color(0, 0, 0, 1));
~dot_b2 = StaticText(~keyboard, Rect(20+300+7,20+150+5,5,5)).background_(Color(0, 0, 0, 0)).string_("").align_(\bottom).stringColor_(Color(0, 0, 0, 1));
~dot_c3 = StaticText(~keyboard, Rect(20+320+7,20+150+5,5,5)).background_(Color(0, 0, 0, 0)).string_("").align_(\bottom).stringColor_(Color(0, 0, 0, 1));
~dot_d3 = StaticText(~keyboard, Rect(20+340+7,20+150+5,5,5)).background_(Color(0, 0, 0, 0)).string_("").align_(\bottom).stringColor_(Color(0, 0, 0, 1));
~dot_e3 = StaticText(~keyboard, Rect(20+360+7,20+150+5,5,5)).background_(Color(0, 0, 0, 0)).string_("").align_(\bottom).stringColor_(Color(0, 0, 0, 1));
~dot_f3 = StaticText(~keyboard, Rect(20+380+7,20+150+5,5,5)).background_(Color(0, 0, 0, 0)).string_("").align_(\bottom).stringColor_(Color(0, 0, 0, 1));
~dot_g3 = StaticText(~keyboard, Rect(20+400+7,20+150+5,5,5)).background_(Color(0, 0, 0, 0)).string_("").align_(\bottom).stringColor_(Color(0, 0, 0, 1));
~dot_a3 = StaticText(~keyboard, Rect(20+420+7,20+150+5,5,5)).background_(Color(0, 0, 0, 0)).string_("").align_(\bottom).stringColor_(Color(0, 0, 0, 1));
~dot_b3 = StaticText(~keyboard, Rect(20+440+7,20+150+5,5,5)).background_(Color(0, 0, 0, 0)).string_("").align_(\bottom).stringColor_(Color(0, 0, 0, 1));
~dot_c4 = StaticText(~keyboard, Rect(20+460+7,20+150+5,5,5)).background_(Color(0, 0, 0, 0)).string_("").align_(\bottom).stringColor_(Color(0, 0, 0, 1));
~dot_d4 = StaticText(~keyboard, Rect(20+480+7,20+150+5,5,5)).background_(Color(0, 0, 0, 0)).string_("").align_(\bottom).stringColor_(Color(0, 0, 0, 1));
~dot_e4 = StaticText(~keyboard, Rect(20+500+7,20+150+5,5,5)).background_(Color(0, 0, 0, 0)).string_("").align_(\bottom).stringColor_(Color(0, 0, 0, 1));
~dot_f4 = StaticText(~keyboard, Rect(20+520+7,20+150+5,5,5)).background_(Color(0, 0, 0, 0)).string_("").align_(\bottom).stringColor_(Color(0, 0, 0, 1));
~dot_g4 = StaticText(~keyboard, Rect(20+540+7,20+150+5,5,5)).background_(Color(0, 0, 0, 0)).string_("").align_(\bottom).stringColor_(Color(0, 0, 0, 1));
~dot_a4 = StaticText(~keyboard, Rect(20+560+7,20+150+5,5,5)).background_(Color(0, 0, 0, 0)).string_("").align_(\bottom).stringColor_(Color(0, 0, 0, 1));
~dot_b4 = StaticText(~keyboard, Rect(20+580+7,20+150+5,5,5)).background_(Color(0, 0, 0, 0)).string_("").align_(\bottom).stringColor_(Color(0, 0, 0, 1));
~dot_c5 = StaticText(~keyboard, Rect(20+600+7,20+150+5,5,5)).background_(Color(0, 0, 0, 0)).string_("").align_(\bottom).stringColor_(Color(0, 0, 0, 1));
~dot_d5 = StaticText(~keyboard, Rect(20+620+7,20+150+5,5,5)).background_(Color(0, 0, 0, 0)).string_("").align_(\bottom).stringColor_(Color(0, 0, 0, 1));
~dot_e5 = StaticText(~keyboard, Rect(20+640+7,20+150+5,5,5)).background_(Color(0, 0, 0, 0)).string_("").align_(\bottom).stringColor_(Color(0, 0, 0, 1));
~dot_f5 = StaticText(~keyboard, Rect(20+660+7,20+150+5,5,5)).background_(Color(0, 0, 0, 0)).string_("").align_(\bottom).stringColor_(Color(0, 0, 0, 1));
~dot_g5 = StaticText(~keyboard, Rect(20+680+7,20+150+5,5,5)).background_(Color(0, 0, 0, 0)).string_("").align_(\bottom).stringColor_(Color(0, 0, 0, 1));
~dot_a5 = StaticText(~keyboard, Rect(20+700+7,20+150+5,5,5)).background_(Color(0, 0, 0, 0)).string_("").align_(\bottom).stringColor_(Color(0, 0, 0, 1));
~dot_b5 = StaticText(~keyboard, Rect(20+720+7,20+150+5,5,5)).background_(Color(0, 0, 0, 0)).string_("").align_(\bottom).stringColor_(Color(0, 0, 0, 1));
~dot_c6 = StaticText(~keyboard, Rect(20+740+7,20+150+5,5,5)).background_(Color(0, 0, 0, 0)).string_("").align_(\bottom).stringColor_(Color(0, 0, 0, 1));
~dot_d6 = StaticText(~keyboard, Rect(20+760+7,20+150+5,5,5)).background_(Color(0, 0, 0, 0)).string_("").align_(\bottom).stringColor_(Color(0, 0, 0, 1));
~dot_e6 = StaticText(~keyboard, Rect(20+780+7,20+150+5,5,5)).background_(Color(0, 0, 0, 0)).string_("").align_(\bottom).stringColor_(Color(0, 0, 0, 1));
~dot_f6 = StaticText(~keyboard, Rect(20+800+7,20+150+5,5,5)).background_(Color(0, 0, 0, 0)).string_("").align_(\bottom).stringColor_(Color(0, 0, 0, 1));
~dot_g6 = StaticText(~keyboard, Rect(20+820+7,20+150+5,5,5)).background_(Color(0, 0, 0, 0)).string_("").align_(\bottom).stringColor_(Color(0, 0, 0, 1));
~dot_a6 = StaticText(~keyboard, Rect(20+840+7,20+150+5,5,5)).background_(Color(0, 0, 0, 0)).string_("").align_(\bottom).stringColor_(Color(0, 0, 0, 1));
~dot_b6 = StaticText(~keyboard, Rect(20+860+7,20+150+5,5,5)).background_(Color(0, 0, 0, 0)).string_("").align_(\bottom).stringColor_(Color(0, 0, 0, 1));
~dot_c7 = StaticText(~keyboard, Rect(20+880+7,20+150+5,5,5)).background_(Color(0, 0, 0, 0)).string_("").align_(\bottom).stringColor_(Color(0, 0, 0, 1));
~dot_d7 = StaticText(~keyboard, Rect(20+900+7,20+150+5,5,5)).background_(Color(0, 0, 0, 0)).string_("").align_(\bottom).stringColor_(Color(0, 0, 0, 1));
~dot_e7 = StaticText(~keyboard, Rect(20+920+7,20+150+5,5,5)).background_(Color(0, 0, 0, 0)).string_("").align_(\bottom).stringColor_(Color(0, 0, 0, 1));
~dot_f7 = StaticText(~keyboard, Rect(20+940+7,20+150+5,5,5)).background_(Color(0, 0, 0, 0)).string_("").align_(\bottom).stringColor_(Color(0, 0, 0, 1));
~dot_g7 = StaticText(~keyboard, Rect(20+960+7,20+150+5,5,5)).background_(Color(0, 0, 0, 0)).string_("").align_(\bottom).stringColor_(Color(0, 0, 0, 1));
~dot_a7 = StaticText(~keyboard, Rect(20+980+7,20+150+5,5,5)).background_(Color(0, 0, 0, 0)).string_("").align_(\bottom).stringColor_(Color(0, 0, 0, 1));
~dot_b7 = StaticText(~keyboard, Rect(20+1000+7,20+150+5,5,5)).background_(Color(0, 0, 0, 0)).string_("").align_(\bottom).stringColor_(Color(0, 0, 0, 1));
~dot_c8 = StaticText(~keyboard, Rect(20+1020+7,20+150+5,5,5)).background_(Color(0, 0, 0, 0)).string_("").align_(\bottom).stringColor_(Color(0, 0, 0, 1));

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

//Black dots
~dot_aSHARP0 = StaticText(~keyboard, Rect(30+0+7,20+90,5,5)).background_(Color(1,1,1,0)).string_("");
~dot_cSHARP1 = StaticText(~keyboard, Rect(30+40+7,20+90,5,5)).background_(Color(1,1,1,0)).string_("");
~dot_dSHARP1 = StaticText(~keyboard, Rect(30+60+7,20+90,5,5)).background_(Color(1,1,1,0)).string_("");
~dot_fSHARP1 = StaticText(~keyboard, Rect(30+100+7,20+90,5,5)).background_(Color(1,1,1,0)).string_("");
~dot_gSHARP1 = StaticText(~keyboard, Rect(30+120+7,20+90,5,5)).background_(Color(1,1,1,0)).string_("");
~dot_aSHARP1 = StaticText(~keyboard, Rect(30+140+7,20+90,5,5)).background_(Color(1,1,1,0)).string_("");
~dot_cSHARP2 = StaticText(~keyboard, Rect(30+180+7,20+90,5,5)).background_(Color(1,1,1,0)).string_("");
~dot_dSHARP2 = StaticText(~keyboard, Rect(30+200+7,20+90,5,5)).background_(Color(1,1,1,0)).string_("");
~dot_fSHARP2 = StaticText(~keyboard, Rect(30+240+7,20+90,5,5)).background_(Color(1,1,1,0)).string_("");
~dot_gSHARP2 = StaticText(~keyboard, Rect(30+260+7,20+90,5,5)).background_(Color(1,1,1,0)).string_("");
~dot_aSHARP2 = StaticText(~keyboard, Rect(30+280+7,20+90,5,5)).background_(Color(1,1,1,0)).string_("");
~dot_cSHARP3 = StaticText(~keyboard, Rect(30+320+7,20+90,5,5)).background_(Color(1,1,1,0)).string_("");
~dot_dSHARP3 = StaticText(~keyboard, Rect(30+340+7,20+90,5,5)).background_(Color(1,1,1,0)).string_("");
~dot_fSHARP3 = StaticText(~keyboard, Rect(30+380+7,20+90,5,5)).background_(Color(1,1,1,0)).string_("");
~dot_gSHARP3 = StaticText(~keyboard, Rect(30+400+7,20+90,5,5)).background_(Color(1,1,1,0)).string_("");
~dot_aSHARP3 = StaticText(~keyboard, Rect(30+420+7,20+90,5,5)).background_(Color(1,1,1,0)).string_("");
~dot_cSHARP4 = StaticText(~keyboard, Rect(30+460+7,20+90,5,5)).background_(Color(1,1,1,0)).string_("");
~dot_dSHARP4 = StaticText(~keyboard, Rect(30+480+7,20+90,5,5)).background_(Color(1,1,1,0)).string_("");
~dot_fSHARP4 = StaticText(~keyboard, Rect(30+520+7,20+90,5,5)).background_(Color(1,1,1,0)).string_("");
~dot_gSHARP4 = StaticText(~keyboard, Rect(30+540+7,20+90,5,5)).background_(Color(1,1,1,0)).string_("");
~dot_aSHARP4 = StaticText(~keyboard, Rect(30+560+7,20+90,5,5)).background_(Color(1,1,1,0)).string_("");
~dot_cSHARP5 = StaticText(~keyboard, Rect(30+600+7,20+90,5,5)).background_(Color(1,1,1,0)).string_("");
~dot_dSHARP5 = StaticText(~keyboard, Rect(30+620+7,20+90,5,5)).background_(Color(1,1,1,0)).string_("");
~dot_fSHARP5 = StaticText(~keyboard, Rect(30+660+7,20+90,5,5)).background_(Color(1,1,1,0)).string_("");
~dot_gSHARP5 = StaticText(~keyboard, Rect(30+680+7,20+90,5,5)).background_(Color(1,1,1,0)).string_("");
~dot_aSHARP5 = StaticText(~keyboard, Rect(30+700+7,20+90,5,5)).background_(Color(1,1,1,0)).string_("");
~dot_cSHARP6 = StaticText(~keyboard, Rect(30+740+7,20+90,5,5)).background_(Color(1,1,1,0)).string_("");
~dot_dSHARP6 = StaticText(~keyboard, Rect(30+760+7,20+90,5,5)).background_(Color(1,1,1,0)).string_("");
~dot_fSHARP6 = StaticText(~keyboard, Rect(30+800+7,20+90,5,5)).background_(Color(1,1,1,0)).string_("");
~dot_gSHARP6 = StaticText(~keyboard, Rect(30+820+7,20+90,5,5)).background_(Color(1,1,1,0)).string_("");
~dot_aSHARP6 = StaticText(~keyboard, Rect(30+840+7,20+90,5,5)).background_(Color(1,1,1,0)).string_("");
~dot_cSHARP7 = StaticText(~keyboard, Rect(30+880+7,20+90,5,5)).background_(Color(1,1,1,0)).string_("");
~dot_dSHARP7 = StaticText(~keyboard, Rect(30+900+7,20+90,5,5)).background_(Color(1,1,1,0)).string_("");
~dot_fSHARP7 = StaticText(~keyboard, Rect(30+940+7,20+90,5,5)).background_(Color(1,1,1,0)).string_("");
~dot_gSHARP7 = StaticText(~keyboard, Rect(30+960+7,20+90,5,5)).background_(Color(1,1,1,0)).string_("");
~dot_aSHARP7 = StaticText(~keyboard, Rect(30+980+7,20+90,5,5)).background_(Color(1,1,1,0)).string_("");

/*
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
*/

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

//Overlay
~keyboardOverlay = UserView(~keyboard, Rect(0,0,420+20+20+620,190));

//Aesthetic lines
// ~bar = StaticText(~keyboardOverlay, Rect(0,0,420+20+20+620,190)).background_(Color.red));

	~keyboardOverlay.drawFunc = {
		Pen.use{
		// Pen.line(19@19,(420+1+620+19)@(150+2+19));
		//White keys bottom half
		Pen.line(19.5@119,19.5@(150+2+19));
Pen.line(39.5@119,39.5@(150+2+19));
Pen.line(59.5@119,59.5@(150+2+19));
Pen.line(79.5@119,79.5@(150+2+19));
Pen.line(99.5@119,99.5@(150+2+19));
Pen.line(119.5@119,119.5@(150+2+19));
Pen.line(139.5@119,139.5@(150+2+19));
Pen.line(159.5@119,159.5@(150+2+19));
Pen.line(179.5@119,179.5@(150+2+19));
Pen.line(199.5@119,199.5@(150+2+19));
Pen.line(219.5@119,219.5@(150+2+19));
Pen.line(239.5@119,239.5@(150+2+19));
Pen.line(259.5@119,259.5@(150+2+19));
Pen.line(279.5@119,279.5@(150+2+19));
Pen.line(299.5@119,299.5@(150+2+19));
Pen.line(319.5@119,319.5@(150+2+19));
Pen.line(339.5@119,339.5@(150+2+19));
Pen.line(359.5@119,359.5@(150+2+19));
Pen.line(379.5@119,379.5@(150+2+19));
Pen.line(399.5@119,399.5@(150+2+19));
Pen.line(419.5@119,419.5@(150+2+19));
Pen.line(439.5@119,439.5@(150+2+19));
Pen.line(459.5@119,459.5@(150+2+19));
Pen.line(479.5@119,479.5@(150+2+19));
Pen.line(499.5@119,499.5@(150+2+19));
Pen.line(519.5@119,519.5@(150+2+19));
Pen.line(539.5@119,539.5@(150+2+19));
Pen.line(559.5@119,559.5@(150+2+19));
Pen.line(579.5@119,579.5@(150+2+19));
Pen.line(599.5@119,599.5@(150+2+19));
Pen.line(619.5@119,619.5@(150+2+19));
Pen.line(639.5@119,639.5@(150+2+19));
Pen.line(659.5@119,659.5@(150+2+19));
Pen.line(679.5@119,679.5@(150+2+19));
Pen.line(699.5@119,699.5@(150+2+19));
Pen.line(719.5@119,719.5@(150+2+19));
Pen.line(739.5@119,739.5@(150+2+19));
Pen.line(759.5@119,759.5@(150+2+19));
Pen.line(779.5@119,779.5@(150+2+19));
Pen.line(799.5@119,799.5@(150+2+19));
Pen.line(819.5@119,819.5@(150+2+19));
Pen.line(839.5@119,839.5@(150+2+19));
Pen.line(859.5@119,859.5@(150+2+19));
Pen.line(879.5@119,879.5@(150+2+19));
Pen.line(899.5@119,899.5@(150+2+19));
Pen.line(919.5@119,919.5@(150+2+19));
Pen.line(939.5@119,939.5@(150+2+19));
Pen.line(959.5@119,959.5@(150+2+19));
Pen.line(979.5@119,979.5@(150+2+19));
Pen.line(999.5@119,999.5@(150+2+19));
Pen.line(1019.5@119,1019.5@(150+2+19));
Pen.line(1039.5@119,1039.5@(150+2+19));
Pen.line(1059.5@119,1059.5@(150+2+19));


//Top half
Pen.line(19.5@19,19.5@(150+2+19-52));
Pen.line(59.5@19,59.5@(150+2+19-52));
Pen.line(119.5@19,119.5@(150+2+19-52));
Pen.line(199.5@19,199.5@(150+2+19-52));
Pen.line(259.5@19,259.5@(150+2+19-52));
Pen.line(339.5@19,339.5@(150+2+19-52));
Pen.line(399.5@19,399.5@(150+2+19-52));
Pen.line(479.5@19,479.5@(150+2+19-52));
Pen.line(539.5@19,539.5@(150+2+19-52));
Pen.line(619.5@19,619.5@(150+2+19-52));
Pen.line(679.5@19,679.5@(150+2+19-52));
Pen.line(759.5@19,759.5@(150+2+19-52));
Pen.line(819.5@19,819.5@(150+2+19-52));
Pen.line(899.5@19,899.5@(150+2+19-52));
Pen.line(959.5@19,959.5@(150+2+19-52));
Pen.line(1039.5@19,1039.5@(150+2+19-52));
Pen.line((1099.5-40)@19,(1099.5-40)@(150+2+19-52));


		//Top border
Pen.line(19@19,(420+1+620+19)@19);

		//Bottom border
Pen.line(19@(150+2+19),(420+1+620+19)@(150+2+19));


		//Black keys
Pen.line(29.5@19,29.5@(150+2+19-52));
Pen.line(49.5@19,49.5@(150+2+19-52));
Pen.line(69.5@19,69.5@(150+2+19-52));
Pen.line(89.5@19,89.5@(150+2+19-52));
Pen.line(109.5@19,109.5@(150+2+19-52));
Pen.line(129.5@19,129.5@(150+2+19-52));
Pen.line(149.5@19,149.5@(150+2+19-52));
Pen.line(169.5@19,169.5@(150+2+19-52));
Pen.line(189.5@19,189.5@(150+2+19-52));
Pen.line(209.5@19,209.5@(150+2+19-52));
Pen.line(229.5@19,229.5@(150+2+19-52));
Pen.line(249.5@19,249.5@(150+2+19-52));
Pen.line(269.5@19,269.5@(150+2+19-52));
Pen.line(289.5@19,289.5@(150+2+19-52));
Pen.line(309.5@19,309.5@(150+2+19-52));
Pen.line(329.5@19,329.5@(150+2+19-52));
Pen.line(349.5@19,349.5@(150+2+19-52));
Pen.line(369.5@19,369.5@(150+2+19-52));
Pen.line(389.5@19,389.5@(150+2+19-52));
Pen.line(409.5@19,409.5@(150+2+19-52));
Pen.line(429.5@19,429.5@(150+2+19-52));
Pen.line(449.5@19,449.5@(150+2+19-52));
Pen.line(469.5@19,469.5@(150+2+19-52));
Pen.line(489.5@19,489.5@(150+2+19-52));
Pen.line(509.5@19,509.5@(150+2+19-52));
Pen.line(529.5@19,529.5@(150+2+19-52));
Pen.line(549.5@19,549.5@(150+2+19-52));
Pen.line(569.5@19,569.5@(150+2+19-52));
Pen.line(589.5@19,589.5@(150+2+19-52));
Pen.line(609.5@19,609.5@(150+2+19-52));
Pen.line(629.5@19,629.5@(150+2+19-52));
Pen.line(649.5@19,649.5@(150+2+19-52));
Pen.line(669.5@19,669.5@(150+2+19-52));
Pen.line(689.5@19,689.5@(150+2+19-52));
Pen.line(709.5@19,709.5@(150+2+19-52));
Pen.line(729.5@19,729.5@(150+2+19-52));
Pen.line(749.5@19,749.5@(150+2+19-52));
Pen.line(769.5@19,769.5@(150+2+19-52));
Pen.line(789.5@19,789.5@(150+2+19-52));
Pen.line(809.5@19,809.5@(150+2+19-52));
Pen.line(829.5@19,829.5@(150+2+19-52));
Pen.line(849.5@19,849.5@(150+2+19-52));
Pen.line(869.5@19,869.5@(150+2+19-52));
Pen.line(889.5@19,889.5@(150+2+19-52));
Pen.line(909.5@19,909.5@(150+2+19-52));
Pen.line(929.5@19,929.5@(150+2+19-52));
Pen.line(949.5@19,949.5@(150+2+19-52));
Pen.line(969.5@19,969.5@(150+2+19-52));
Pen.line(989.5@19,989.5@(150+2+19-52));
Pen.line(1009.5@19,1009.5@(150+2+19-52));
Pen.line(1029.5@19,1029.5@(150+2+19-52));

Pen.line(28@120,51@120);
Pen.line(68@120,91@120);
Pen.line(88@120,111@120);
Pen.line(128@120,151@120);
Pen.line(148@120,171@120);
Pen.line(168@120,191@120);
Pen.line(208@120,231@120);
Pen.line(228@120,251@120);
Pen.line(268@120,291@120);
Pen.line(288@120,311@120);
Pen.line(308@120,331@120);
Pen.line(348@120,371@120);
Pen.line(368@120,391@120);
Pen.line(408@120,431@120);
Pen.line(428@120,451@120);
Pen.line(448@120,471@120);
Pen.line(488@120,511@120);
Pen.line(508@120,531@120);
Pen.line(548@120,571@120);
Pen.line(568@120,591@120);
Pen.line(588@120,611@120);
Pen.line(628@120,651@120);
Pen.line(648@120,671@120);
Pen.line(688@120,711@120);
Pen.line(708@120,731@120);
Pen.line(728@120,751@120);
Pen.line(768@120,791@120);
Pen.line(788@120,811@120);
Pen.line(828@120,851@120);
Pen.line(848@120,871@120);
Pen.line(868@120,891@120);
Pen.line(908@120,931@120);
Pen.line(928@120,951@120);
Pen.line(968@120,991@120);
Pen.line(988@120,1011@120);
Pen.line(1008@120,1031@120);

		Pen.strokeColor = Color(0,0,0,0.5);
			    Pen.width = 2;
                Pen.stroke};
        };
//
// ///Knob for colour intensity
// ~intensifier = 1;
// ~knob = Knob.new(~keyboard, Rect(580, 1, 17, 17)).action_(~intensifier = ~knob.value.linlin(0,1,1,10));

if(~module_ID == "spectra",
		{
		~knob_text = StaticText(~keyboard, Rect(0, 1, (420+20+20+620)-20, 17)).string_("Gain").stringColor_(Color.black).align_(\right);
~knob_keyboard = Knob.new(~keyboard, Rect(580+430, 1, 17, 17)); //Knob version
		// Slider(~keyboard, Rect(580, 1, 170, 17)); //Slider version
~knob_keyboard.action_({
			~knob.valueAction_(~knob_keyboard.value);
			(
			if(~knob_keyboard.value.linlin(0,1,0,1) == 1,
				{~knob_keyboard.background_(Color.red)},{~knob_keyboard.background_(Color.white)})
		);
		});



}); //This controls the value of the invisible knob on the Spectra

//(if(obj.value.linlin(0,1,21,108) <= 98, {~d7.background_(Color(1,~color_array[98-1],~color_array[98-1]));}, {~d7.background_(Color.white)});)

~keyboard_CompositeView_White = CompositeView(~keyboard, Rect(27+1,175+1,5-1,5-1));

~deviant_fill = StaticText(~keyboard_CompositeView_White, Rect(0,0,3,3)).background_(Color.red);

w.onClose_({a.free; ~keyboard_open = 0;});
)
