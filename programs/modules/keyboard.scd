(
var basePath = thisProcess.nowExecutingPath.asString.dirname;

// Window for the Keyboard
~keyboardWindow = Window.new("Keyboard", Rect(
	Window.screenBounds.width/2-((420+20+20+620)/2),50,
	420+20+20+620,190), false, true).front.background_(Color.grey(1)).userCanClose_(true);

// Label for title // Necessary if remove the top part eventually to avoid confusion on closing - but maybe onClose it resets the key_vis button properly anyways so no need
~title =StaticText(~keyboardWindow,Rect(0,0,(420+20+20+620),300))
.string_("Keyboard")
.align_(\top)
.font_(Font(["Helvetica"], 15, true));

// Composite for all the drawing to be placed and thus allow octave shifting
~octave_shift = 0;
~keyboard = CompositeView(~keyboardWindow, Rect(~octave_shift*7*20,0, 420+20+20+620+50,190));

//Keyboard visual
//~outline = StaticText(~keyboard, Rect(20-1,20-1,420+1+620,150+2));
//~outline.background = Color.black;



//3D Effect buttons
StaticText.new(~keyboard, Rect(20,165,1055,500)).background_(Color.grey(0.88)); // Bottom edge of 3D keys
StaticText.new(~keyboard, Rect(20,175,1055,500)).background_(Color.grey(0.55)); // Bottom of keyboard
StaticText.new(~keyboard, Rect(-10,18,35,500)).background_(Color.grey(0.35)); // Left border
StaticText.new(~keyboard, Rect(1055,18,820,500)).background_(Color.grey(0.35)); // Right border
StaticText.new(~keyboard, Rect(20,172,6,30)).background_(Color.grey(0.25)); // Left shaded edge
StaticText.new(~keyboard, Rect(1055,172,6,30)).background_(Color.grey(0.25)); // Right shaded edge
//StaticText.new(~keyboard, Rect(1055+6,172,560,2)).background_(Color.grey(0.25)); // Extended shaded bottom
//StaticText.new(~keyboard, Rect(1055+6+560,18,6,156)).background_(Color.grey(0.25));


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

//Extended white keys
~d8 = StaticText(~keyboard, Rect(20+1040,20,19,150)).background_(Color.white).string_("").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~e8 = StaticText(~keyboard, Rect(20+1060,20,19,150)).background_(Color.white).string_("").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~f8 = StaticText(~keyboard, Rect(20+1080,20,19,150)).background_(Color.white).string_("").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~g8 = StaticText(~keyboard, Rect(20+1100,20,19,150)).background_(Color.white).string_("").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~a8 = StaticText(~keyboard, Rect(20+1120,20,19,150)).background_(Color.white).string_("").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~b8 = StaticText(~keyboard, Rect(20+1140,20,19,150)).background_(Color.white).string_("").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~c9 = StaticText(~keyboard, Rect(20+1160,20,19,150)).background_(Color.white).string_("").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~d9 = StaticText(~keyboard, Rect(20+1180,20,19,150)).background_(Color.white).string_("").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~e9 = StaticText(~keyboard, Rect(20+1200,20,19,150)).background_(Color.white).string_("").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~f9 = StaticText(~keyboard, Rect(20+1220,20,19,150)).background_(Color.white).string_("").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~g9 = StaticText(~keyboard, Rect(20+1240,20,19,150)).background_(Color.white).string_("").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~a9 = StaticText(~keyboard, Rect(20+1260,20,19,150)).background_(Color.white).string_("").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~b9 = StaticText(~keyboard, Rect(20+1280,20,19,150)).background_(Color.white).string_("").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~c10 = StaticText(~keyboard, Rect(20+1300,20,19,150)).background_(Color.white).string_("").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~d10 = StaticText(~keyboard, Rect(20+1320,20,19,150)).background_(Color.white).string_("").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~e10 = StaticText(~keyboard, Rect(20+1340,20,19,150)).background_(Color.white).string_("").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~f10 = StaticText(~keyboard, Rect(20+1360,20,19,150)).background_(Color.white).string_("").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~g10 = StaticText(~keyboard, Rect(20+1380,20,19,150)).background_(Color.white).string_("").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~a10 = StaticText(~keyboard, Rect(20+1400,20,19,150)).background_(Color.white).string_("").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~b10 = StaticText(~keyboard, Rect(20+1420,20,19,150)).background_(Color.white).string_("").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~c11 = StaticText(~keyboard, Rect(20+1440,20,19,150)).background_(Color.white).string_("").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~d11 = StaticText(~keyboard, Rect(20+1460,20,19,150)).background_(Color.white).string_("").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~e11 = StaticText(~keyboard, Rect(20+1480,20,19,150)).background_(Color.white).string_("").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~f11 = StaticText(~keyboard, Rect(20+1500,20,19,150)).background_(Color.white).string_("").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~g11 = StaticText(~keyboard, Rect(20+1520,20,19,150)).background_(Color.white).string_("").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~a11 = StaticText(~keyboard, Rect(20+1540,20,19,150)).background_(Color.white).string_("").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~b11 = StaticText(~keyboard, Rect(20+1560,20,19,150)).background_(Color.white).string_("").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));
~c12 = StaticText(~keyboard, Rect(20+1580,20,19,150)).background_(Color.white).string_("").align_(\bottom).stringColor_(Color(0.4824, 0.4863, 0.4863));

//White Key Dots
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

//Extended white key dots
~dot_d8 = StaticText(~keyboard, Rect(20+1040+7,20+150+5,5,5)).background_(Color(0, 0, 0, 0)).string_("").align_(\bottom).stringColor_(Color(0, 0, 0, 1));
~dot_e8 = StaticText(~keyboard, Rect(20+1060+7,20+150+5,5,5)).background_(Color(0, 0, 0, 0)).string_("").align_(\bottom).stringColor_(Color(0, 0, 0, 1));
~dot_f8 = StaticText(~keyboard, Rect(20+1080+7,20+150+5,5,5)).background_(Color(0, 0, 0, 0)).string_("").align_(\bottom).stringColor_(Color(0, 0, 0, 1));
~dot_g8 = StaticText(~keyboard, Rect(20+1100+7,20+150+5,5,5)).background_(Color(0, 0, 0, 0)).string_("").align_(\bottom).stringColor_(Color(0, 0, 0, 1));
~dot_a8 = StaticText(~keyboard, Rect(20+1120+7,20+150+5,5,5)).background_(Color(0, 0, 0, 0)).string_("").align_(\bottom).stringColor_(Color(0, 0, 0, 1));
~dot_b8 = StaticText(~keyboard, Rect(20+1140+7,20+150+5,5,5)).background_(Color(0, 0, 0, 0)).string_("").align_(\bottom).stringColor_(Color(0, 0, 0, 1));
~dot_c9 = StaticText(~keyboard, Rect(20+1160+7,20+150+5,5,5)).background_(Color(0, 0, 0, 0)).string_("").align_(\bottom).stringColor_(Color(0, 0, 0, 1));
~dot_d9 = StaticText(~keyboard, Rect(20+1180+7,20+150+5,5,5)).background_(Color(0, 0, 0, 0)).string_("").align_(\bottom).stringColor_(Color(0, 0, 0, 1));
~dot_e9 = StaticText(~keyboard, Rect(20+1200+7,20+150+5,5,5)).background_(Color(0, 0, 0, 0)).string_("").align_(\bottom).stringColor_(Color(0, 0, 0, 1));
~dot_f9 = StaticText(~keyboard, Rect(20+1220+7,20+150+5,5,5)).background_(Color(0, 0, 0, 0)).string_("").align_(\bottom).stringColor_(Color(0, 0, 0, 1));
~dot_g9 = StaticText(~keyboard, Rect(20+1240+7,20+150+5,5,5)).background_(Color(0, 0, 0, 0)).string_("").align_(\bottom).stringColor_(Color(0, 0, 0, 1));
~dot_a9 = StaticText(~keyboard, Rect(20+1260+7,20+150+5,5,5)).background_(Color(0, 0, 0, 0)).string_("").align_(\bottom).stringColor_(Color(0, 0, 0, 1));
~dot_b9 = StaticText(~keyboard, Rect(20+1280+7,20+150+5,5,5)).background_(Color(0, 0, 0, 0)).string_("").align_(\bottom).stringColor_(Color(0, 0, 0, 1));
~dot_c10 = StaticText(~keyboard, Rect(20+1300+7,20+150+5,5,5)).background_(Color(0, 0, 0, 0)).string_("").align_(\bottom).stringColor_(Color(0, 0, 0, 1));
~dot_d10 = StaticText(~keyboard, Rect(20+1320+7,20+150+5,5,5)).background_(Color(0, 0, 0, 0)).string_("").align_(\bottom).stringColor_(Color(0, 0, 0, 1));
~dot_e10 = StaticText(~keyboard, Rect(20+1340+7,20+150+5,5,5)).background_(Color(0, 0, 0, 0)).string_("").align_(\bottom).stringColor_(Color(0, 0, 0, 1));
~dot_f10 = StaticText(~keyboard, Rect(20+1360+7,20+150+5,5,5)).background_(Color(0, 0, 0, 0)).string_("").align_(\bottom).stringColor_(Color(0, 0, 0, 1));
~dot_g10 = StaticText(~keyboard, Rect(20+1380+7,20+150+5,5,5)).background_(Color(0, 0, 0, 0)).string_("").align_(\bottom).stringColor_(Color(0, 0, 0, 1));
~dot_a10 = StaticText(~keyboard, Rect(20+1400+7,20+150+5,5,5)).background_(Color(0, 0, 0, 0)).string_("").align_(\bottom).stringColor_(Color(0, 0, 0, 1));
~dot_b10 = StaticText(~keyboard, Rect(20+1420+7,20+150+5,5,5)).background_(Color(0, 0, 0, 0)).string_("").align_(\bottom).stringColor_(Color(0, 0, 0, 1));
~dot_c11 = StaticText(~keyboard, Rect(20+1440+7,20+150+5,5,5)).background_(Color(0, 0, 0, 0)).string_("").align_(\bottom).stringColor_(Color(0, 0, 0, 1));
~dot_d11 = StaticText(~keyboard, Rect(20+1460+7,20+150+5,5,5)).background_(Color(0, 0, 0, 0)).string_("").align_(\bottom).stringColor_(Color(0, 0, 0, 1));
~dot_e11 = StaticText(~keyboard, Rect(20+1480+7,20+150+5,5,5)).background_(Color(0, 0, 0, 0)).string_("").align_(\bottom).stringColor_(Color(0, 0, 0, 1));
~dot_f11 = StaticText(~keyboard, Rect(20+1500+7,20+150+5,5,5)).background_(Color(0, 0, 0, 0)).string_("").align_(\bottom).stringColor_(Color(0, 0, 0, 1));
~dot_g11 = StaticText(~keyboard, Rect(20+1520+7,20+150+5,5,5)).background_(Color(0, 0, 0, 0)).string_("").align_(\bottom).stringColor_(Color(0, 0, 0, 1));
~dot_a11 = StaticText(~keyboard, Rect(20+1540+7,20+150+5,5,5)).background_(Color(0, 0, 0, 0)).string_("").align_(\bottom).stringColor_(Color(0, 0, 0, 1));
~dot_b11 = StaticText(~keyboard, Rect(20+1560+7,20+150+5,5,5)).background_(Color(0, 0, 0, 0)).string_("").align_(\bottom).stringColor_(Color(0, 0, 0, 1));
~dot_c12 = StaticText(~keyboard, Rect(20+1580+7,20+150+5,5,5)).background_(Color(0, 0, 0, 0)).string_("").align_(\bottom).stringColor_(Color(0, 0, 0, 1));

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

//Extended black keys
~cSHARP8 = StaticText(~keyboard, Rect(30+1020,20,19,100)).background_(Color.grey(~black_key_opacity)).string_("");
~dSHARP8 = StaticText(~keyboard, Rect(30+1040,20,19,100)).background_(Color.grey(~black_key_opacity)).string_("");
~fSHARP8 = StaticText(~keyboard, Rect(30+1080,20,19,100)).background_(Color.grey(~black_key_opacity)).string_("");
~gSHARP8 = StaticText(~keyboard, Rect(30+1100,20,19,100)).background_(Color.grey(~black_key_opacity)).string_("");
~aSHARP8 = StaticText(~keyboard, Rect(30+1120,20,19,100)).background_(Color.grey(~black_key_opacity)).string_("");
~cSHARP9 = StaticText(~keyboard, Rect(30+1160,20,19,100)).background_(Color.grey(~black_key_opacity)).string_("");
~dSHARP9 = StaticText(~keyboard, Rect(30+1180,20,19,100)).background_(Color.grey(~black_key_opacity)).string_("");
~fSHARP9 = StaticText(~keyboard, Rect(30+1220,20,19,100)).background_(Color.grey(~black_key_opacity)).string_("");
~gSHARP9 = StaticText(~keyboard, Rect(30+1240,20,19,100)).background_(Color.grey(~black_key_opacity)).string_("");
~aSHARP9 = StaticText(~keyboard, Rect(30+1260,20,19,100)).background_(Color.grey(~black_key_opacity)).string_("");
~cSHARP10 = StaticText(~keyboard, Rect(30+1300,20,19,100)).background_(Color.grey(~black_key_opacity)).string_("");
~dSHARP10 = StaticText(~keyboard, Rect(30+1320,20,19,100)).background_(Color.grey(~black_key_opacity)).string_("");
~fSHARP10 = StaticText(~keyboard, Rect(30+1360,20,19,100)).background_(Color.grey(~black_key_opacity)).string_("");
~gSHARP10 = StaticText(~keyboard, Rect(30+1380,20,19,100)).background_(Color.grey(~black_key_opacity)).string_("");
~aSHARP10 = StaticText(~keyboard, Rect(30+1400,20,19,100)).background_(Color.grey(~black_key_opacity)).string_("");
~cSHARP11 = StaticText(~keyboard, Rect(30+1440,20,19,100)).background_(Color.grey(~black_key_opacity)).string_("");
~dSHARP11 = StaticText(~keyboard, Rect(30+1460,20,19,100)).background_(Color.grey(~black_key_opacity)).string_("");
~fSHARP11 = StaticText(~keyboard, Rect(30+1500,20,19,100)).background_(Color.grey(~black_key_opacity)).string_("");
~gSHARP11 = StaticText(~keyboard, Rect(30+1520,20,19,100)).background_(Color.grey(~black_key_opacity)).string_("");
~aSHARP11 = StaticText(~keyboard, Rect(30+1540,20,19,100)).background_(Color.grey(~black_key_opacity)).string_("");

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

//Extended black key dots
~dot_cSHARP8 = StaticText(~keyboard, Rect(30+1020+7,20+90,5,5)).background_(Color(1,1,1,0)).string_("");
~dot_dSHARP8 = StaticText(~keyboard, Rect(30+1040+7,20+90,5,5)).background_(Color(1,1,1,0)).string_("");
~dot_fSHARP8 = StaticText(~keyboard, Rect(30+1080+7,20+90,5,5)).background_(Color(1,1,1,0)).string_("");
~dot_gSHARP8 = StaticText(~keyboard, Rect(30+1100+7,20+90,5,5)).background_(Color(1,1,1,0)).string_("");
~dot_aSHARP8 = StaticText(~keyboard, Rect(30+1120+7,20+90,5,5)).background_(Color(1,1,1,0)).string_("");
~dot_cSHARP9 = StaticText(~keyboard, Rect(30+1160+7,20+90,5,5)).background_(Color(1,1,1,0)).string_("");
~dot_dSHARP9 = StaticText(~keyboard, Rect(30+1180+7,20+90,5,5)).background_(Color(1,1,1,0)).string_("");
~dot_fSHARP9 = StaticText(~keyboard, Rect(30+1220+7,20+90,5,5)).background_(Color(1,1,1,0)).string_("");
~dot_gSHARP9 = StaticText(~keyboard, Rect(30+1240+7,20+90,5,5)).background_(Color(1,1,1,0)).string_("");
~dot_aSHARP9 = StaticText(~keyboard, Rect(30+1260+7,20+90,5,5)).background_(Color(1,1,1,0)).string_("");
~dot_cSHARP10 = StaticText(~keyboard, Rect(30+1300+7,20+90,5,5)).background_(Color(1,1,1,0)).string_("");
~dot_dSHARP10 = StaticText(~keyboard, Rect(30+1320+7,20+90,5,5)).background_(Color(1,1,1,0)).string_("");
~dot_fSHARP10 = StaticText(~keyboard, Rect(30+1360+7,20+90,5,5)).background_(Color(1,1,1,0)).string_("");
~dot_gSHARP10 = StaticText(~keyboard, Rect(30+1380+7,20+90,5,5)).background_(Color(1,1,1,0)).string_("");
~dot_aSHARP10 = StaticText(~keyboard, Rect(30+1400+7,20+90,5,5)).background_(Color(1,1,1,0)).string_("");
~dot_cSHARP11 = StaticText(~keyboard, Rect(30+1440+7,20+90,5,5)).background_(Color(1,1,1,0)).string_("");
~dot_dSHARP11 = StaticText(~keyboard, Rect(30+1460+7,20+90,5,5)).background_(Color(1,1,1,0)).string_("");
~dot_fSHARP11 = StaticText(~keyboard, Rect(30+1500+7,20+90,5,5)).background_(Color(1,1,1,0)).string_("");
~dot_gSHARP11 = StaticText(~keyboard, Rect(30+1520+7,20+90,5,5)).background_(Color(1,1,1,0)).string_("");
~dot_aSHARP11 = StaticText(~keyboard, Rect(30+1540+7,20+90,5,5)).background_(Color(1,1,1,0)).string_("");


//Lowest note
~a1note = StaticText(~keyboard, Rect(20+0,20,19,150)).background_(Color.clear).string_("A1
21").align_(\bottom).stringColor_(Color.black).font_(Font("Helvetica", 10));

//Labelling every C note
//C1
~c1note = StaticText(~keyboard, Rect(20+40,20,19,150)).background_(Color.clear).string_("C1
24").align_(\bottom).stringColor_(Color.black).font_(Font("Helvetica", 10));

//C2
~c2note = StaticText(~keyboard, Rect(20+180,20,19,150)).background_(Color.clear).string_("C2
36").align_(\bottom).stringColor_(Color.black).font_(Font("Helvetica", 10));

//C3
~c3note = StaticText(~keyboard, Rect(20+180+140,20,19,150)).background_(Color.clear).string_("C3
48").align_(\bottom).stringColor_(Color.black).font_(Font("Helvetica", 10));

//Middle C note (C4)
~c4note = StaticText(~keyboard, Rect(20+460,20,19,150)).background_(Color.clear).string_("C4
60").align_(\bottom).stringColor_(Color.black).font_(Font("Helvetica", 10));

//C5
~c5note = StaticText(~keyboard, Rect(20+460+140,20,19,150)).background_(Color.clear).string_("C5
72").align_(\bottom).stringColor_(Color.black).font_(Font("Helvetica", 10));

//C6
~c6note = StaticText(~keyboard, Rect(20+460+280,20,19,150)).background_(Color.clear).string_("C6
84").align_(\bottom).stringColor_(Color.black).font_(Font("Helvetica", 10));

//C7
~c7note = StaticText(~keyboard, Rect(20+460+420,20,19,150)).background_(Color.clear).string_("C7
96").align_(\bottom).stringColor_(Color.black).font_(Font("Helvetica", 10));

//Highest note (old, C8)
~c8note = StaticText(~keyboard, Rect(20+1020,20,19,150)).background_(Color.clear).string_("C8
108").align_(\bottom).stringColor_(Color.black).font_(Font("Helvetica", 10));

//C9
~c9note = StaticText(~keyboard, Rect(20+1020+140,20,19,150)).background_(Color.clear).string_("C9
120").align_(\bottom).stringColor_(Color.black).font_(Font("Helvetica", 10));

//C10
~c10note = StaticText(~keyboard, Rect(20+1020+280,20,19,150)).background_(Color.clear).string_("C10
132").align_(\bottom).stringColor_(Color.black).font_(Font("Helvetica", 10));

//C11
~c11note = StaticText(~keyboard, Rect(20+1020+420,20,19,150)).background_(Color.clear).string_("C11
144").align_(\bottom).stringColor_(Color.black).font_(Font("Helvetica", 10));

//C12
~c12note = StaticText(~keyboard, Rect(20+1020+560,20,19,150)).background_(Color.clear).string_("C12
156").align_(\bottom).stringColor_(Color.black).font_(Font("Helvetica", 10));

//Overlay
~keyboardOverlay = UserView(~keyboard, Rect(0,0,420+20+20+620+562,190));


// Black dot for the harmonic motion
~keyboard_CompositeView_White = CompositeView(~keyboard, Rect(27+1,175+1,5-1,5-1));

~deviant_fill = StaticText(~keyboard_CompositeView_White, Rect(0,0,3,3)).background_(Color.black);

//Start null
~deviant_fill.background_(Color.clear);

//Aesthetic lines
// ~bar = StaticText(~keyboardOverlay, Rect(0,0,420+20+20+620,190)).background_(Color.red));

//(thisProcess.nowExecutingPath.asString.dirname +/+  "modules/spectra_screen.scd").load;

(
~keyboard_lines_retracted = UserView(~keyboard, Rect(0,0,
	420+20+20+620+560,190));

~keyboard_lines_retracted.drawFunc = {
		Pen.use{

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


		//Something?


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
);


(
~keyboard_lines_extended_A = UserView(~keyboard, Rect(0,190,
	420+20+20+620+560,190));

~keyboard_lines_extended_A.drawFunc = {
		Pen.use{


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

		//Pen.line((1099.5-40)@19,(1099.5-40)@(150+2+19-52));




		//Top border
Pen.line(19@19,(420+1+620+19-10)@19);

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


		//Something?


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


		// 3D Effect to give impression of the keyboard's edges and the extension on the right
		Pen.line(19.5@(150+2+19+0),(19.5+10)@(150+2+19+5)); // Left angle
		Pen.line((19.5+10)@(150+2+19+5),(19.5+1030)@(150+2+19+5)); // Bottom of the 3D
		Pen.line((19.5+1030+10)@(150+2+19),(19.5+1030)@(150+2+19+5));

		Pen.strokeColor = Color(0,0,0,0.5);
			    Pen.width = 2;
                Pen.stroke};
        };
);


(
~keyboard_lines_extended_B = UserView(~keyboard, Rect(0,190,
	420+20+20+620+560,190));

~keyboard_lines_extended_B.drawFunc = {
		Pen.use{

		//White keys bottom half Extended
		Pen.line(1079.5@119,1079.5@(150+2+19));
Pen.line(1099.5@119,1099.5@(150+2+19));
Pen.line(1119.5@119,1119.5@(150+2+19));
Pen.line(1139.5@119,1139.5@(150+2+19));
Pen.line(1159.5@119,1159.5@(150+2+19));
Pen.line(1179.5@119,1179.5@(150+2+19));
Pen.line(1199.5@119,1199.5@(150+2+19));
Pen.line(1219.5@119,1219.5@(150+2+19));
Pen.line(1239.5@119,1239.5@(150+2+19));
Pen.line(1259.5@119,1259.5@(150+2+19));
Pen.line(1279.5@119,1279.5@(150+2+19));
Pen.line(1299.5@119,1299.5@(150+2+19));
Pen.line(1319.5@119,1319.5@(150+2+19));
Pen.line(1339.5@119,1339.5@(150+2+19));
Pen.line(1359.5@119,1359.5@(150+2+19));
Pen.line(1379.5@119,1379.5@(150+2+19));
Pen.line(1399.5@119,1399.5@(150+2+19));
Pen.line(1419.5@119,1419.5@(150+2+19));
Pen.line(1439.5@119,1439.5@(150+2+19));
Pen.line(1459.5@119,1459.5@(150+2+19));
Pen.line(1479.5@119,1479.5@(150+2+19));
Pen.line(1499.5@119,1499.5@(150+2+19));
Pen.line(1519.5@119,1519.5@(150+2+19));
Pen.line(1539.5@119,1539.5@(150+2+19));
Pen.line(1559.5@119,1559.5@(150+2+19));
Pen.line(1579.5@119,1579.5@(150+2+19));
Pen.line(1599.5@119,1599.5@(150+2+19));

		//White keys top half Extended
Pen.line((1099.5-50)@19,(1099.5-50)@(150+2+19-52));
		Pen.line(1099.5@19,1099.5@(150+2+19-52));
		Pen.line(1179.5@19,1179.5@(150+2+19-52));
Pen.line(1239.5@19,1239.5@(150+2+19-52));
Pen.line(1319.5@19,1319.5@(150+2+19-52));
Pen.line(1379.5@19,1379.5@(150+2+19-52));
Pen.line(1459.5@19,1459.5@(150+2+19-52));
Pen.line(1519.5@19,1519.5@(150+2+19-52));
Pen.line(1599.5@19,1599.5@(150+2+19-52));
Pen.line((1659.5-40)@19,(1659.5-40)@(150+2+19));


	//Black keys Extended
		Pen.line(1069.5@19,1069.5@(150+2+19-52));
Pen.line(1089.5@19,1089.5@(150+2+19-52));
Pen.line(1109.5@19,1109.5@(150+2+19-52));
Pen.line(1129.5@19,1129.5@(150+2+19-52));
Pen.line(1149.5@19,1149.5@(150+2+19-52));
Pen.line(1169.5@19,1169.5@(150+2+19-52));
Pen.line(1189.5@19,1189.5@(150+2+19-52));
Pen.line(1209.5@19,1209.5@(150+2+19-52));
Pen.line(1229.5@19,1229.5@(150+2+19-52));
Pen.line(1249.5@19,1249.5@(150+2+19-52));
Pen.line(1269.5@19,1269.5@(150+2+19-52));
Pen.line(1289.5@19,1289.5@(150+2+19-52));
Pen.line(1309.5@19,1309.5@(150+2+19-52));
Pen.line(1329.5@19,1329.5@(150+2+19-52));
Pen.line(1349.5@19,1349.5@(150+2+19-52));
Pen.line(1369.5@19,1369.5@(150+2+19-52));
Pen.line(1389.5@19,1389.5@(150+2+19-52));
Pen.line(1409.5@19,1409.5@(150+2+19-52));
Pen.line(1429.5@19,1429.5@(150+2+19-52));
Pen.line(1449.5@19,1449.5@(150+2+19-52));
Pen.line(1469.5@19,1469.5@(150+2+19-52));
Pen.line(1489.5@19,1489.5@(150+2+19-52));
Pen.line(1509.5@19,1509.5@(150+2+19-52));
Pen.line(1529.5@19,1529.5@(150+2+19-52));
Pen.line(1549.5@19,1549.5@(150+2+19-52));
Pen.line(1569.5@19,1569.5@(150+2+19-52));
Pen.line(1589.5@19,1589.5@(150+2+19-52));


		//Bottom key black Extended
		Pen.line(1048@120,1071@120);
Pen.line(1068@120,1091@120);
Pen.line(1108@120,1131@120);
Pen.line(1128@120,1151@120);
Pen.line(1148@120,1171@120);
Pen.line(1188@120,1211@120);
Pen.line(1208@120,1231@120);
Pen.line(1248@120,1271@120);
Pen.line(1268@120,1291@120);
Pen.line(1288@120,1311@120);
Pen.line(1328@120,1351@120);
Pen.line(1348@120,1371@120);
Pen.line(1388@120,1411@120);
Pen.line(1408@120,1431@120);
Pen.line(1428@120,1451@120);
Pen.line(1468@120,1491@120);
Pen.line(1488@120,1511@120);
Pen.line(1528@120,1551@120);
Pen.line(1548@120,1571@120);
Pen.line(1568@120,1591@120);

		//Top border extension
Pen.line((420+1+620+19-10)@19,(420+1+620+19+560)@19);

//Bottom border extension
		Pen.line((420+1+620+19)@(150+2+19),(420+1+620+19+560)@(150+2+19));


		Pen.strokeColor = Color(0,0,0,0.5);
			    Pen.width = 2;
                Pen.stroke};
        };
);

/* THE EXTEND/RETRACT HAS BEEN DISCONTINUED IN FAVOUR OF OCTAVE SHIFTING

//Button to extend the bounds of the keyboard to show the additional higher frequencies
~keyboardExtend = Button.new(~keyboard, Rect(17+570,2,50,15))
.states_([
	["Extend", Color.black, Color.grey],
	["Retract", Color.black, Color.grey]
])
.action_({ arg obj;
if(~keyboardExtend.value == 1,
		{
			//Extend the Keyboard
~keyboard.bounds_(Rect(~keyboard.bounds.left-560,~keyboard.bounds.top,420+20+20+620+560,190));
			~keyboardExtendCover.background_(Color.clear);
			~cSHARP8.background_(Color.black);

			~keyboard_lines_retracted.bounds_(Rect(0,190,
	420+20+20+620+560,190));
			~keyboard_lines_extended_A.bounds_(Rect(0,0,
	420+20+20+620+560,190));
			~keyboard_lines_extended_B.bounds_(Rect(0,0,
	420+20+20+620+560,190));


		},{
			//Retract the Keyboard
			~keyboard.bounds_(Rect(~keyboard.bounds.left+600,~keyboard.bounds.top,420+20+20+620,190));

			~keyboardExtendCover.background_(Color.white);
						~cSHARP8.background_(Color.clear);

			~keyboard_lines_retracted.bounds_(Rect(0,0,
	420+20+20+620+560,190));
			~keyboard_lines_extended_A.bounds_(Rect(0,190,
	420+20+20+620+560,190));
			~keyboard_lines_extended_B.bounds_(Rect(0,190,
	420+20+20+620+560,190));

	});
}
);

//To hide the extended keys
~cSHARP8.background_(Color.clear);
~keyboardExtendCover = StaticText(~keyboard, Rect((420+20+20+620)-19,18,50,170)).background_(Color.white);

*/

// These have to be active to draw correctly, as if it was extended
~keyboard_lines_retracted.bounds_(Rect(0,190,
	420+20+20+620+560,190));
			~keyboard_lines_extended_A.bounds_(Rect(0,0,
	420+20+20+620+560,190));
			~keyboard_lines_extended_B.bounds_(Rect(0,0,
	420+20+20+620+560,190));




// Buttons to shift octave
~keyboardShiftRight = Button.new(~keyboardWindow, Rect(17+570+80,2,25,15))
.string_(">")
//.align_(\center) // SC doesn't seem to understand center?
.action_({ arg obj;
if(~octave_shift.value > -4,
		{(
~octave_shift = ~octave_shift-1;
~keyboard.bounds_(Rect(~octave_shift*7*20,0, 420+20+20+620+542+50,190););
			~keyboardMiniView_highlight.bounds_(Rect(0-~octave_shift*21,0,166,15))
	)})
});

~keyboardShiftLeft = Button.new(~keyboardWindow, Rect(17+570-120-80,2,25,15))
.string_("<")
//.align_(\center) // SC doesn't seem to understand center?
.action_({ arg obj;
if(~octave_shift.value < 0,
		{(
~octave_shift = ~octave_shift+1;
~keyboard.bounds_(Rect(~octave_shift*7*20,0, 420+20+20+620+542+50,190););
			~keyboardMiniView_highlight.bounds_(Rect(0-~octave_shift*21,0,166,15))
	)})
});

//Knob
if(~module_ID == "spectra",
		{
		~knob_text = StaticText(~keyboardWindow, Rect(0+1000, 1, (420+20+20+620)-20-1000, 17)).string_("Gain").stringColor_(Color.black).align_(\right);
~knob_keyboard = Knob.new(~keyboardWindow, Rect(580+430, 1, 17, 17)); //Knob version
		// Slider(~keyboard, Rect(580, 1, 170, 17)); //Slider version
~knob_keyboard.action_({
			~knob.valueAction_(~knob_keyboard.value);
			(
			if(~knob_keyboard.value.linlin(0,1,0,1) == 1,
				{~knob_keyboard.background_(Color.red)},{~knob_keyboard.background_(Color.white)})
		);
		});
}); //This controls the value of the invisible knob on the Spectra


//Keyboard-mini-view
(
~keyboardMiniView = CompositeView(~keyboardWindow, Rect(((420+20+20+620)/2)-(250/2), 2, 250, 15)).background_(Color.red);

~keyboardMiniView_UserView = UserView(~keyboardMiniView, Rect(0,0,250,15));
~keyboard_image = Image.new(basePath.dirname +/+ "images/keyboard_mini_small.png");

~keyboardMiniView_UserView.drawFunc = {
		~keyboard_image.drawInRect(Rect(0,0,250,15), Rect(0,0,400,39), 2, 1.0);
        };


~keyboardMiniView_greyout = StaticText(~keyboardMiniView_UserView, Rect(163,0,250-163,15)).background_(Color.grey(0.9,0.8));

~keyboardMiniView_highlight = StaticText(~keyboardMiniView_UserView, Rect(0,0,166,15)).background_(Color.grey(0.2,0.5));
);

~keyboardWindow.onClose_({
	~key_vis.valueAction_(0); //Oddly, using valueAction instead of value loads the window opening faster
	a.free;
	~keyboard_open = 0;
});
)
