~color_array[59]

//////////////////Start here



///GUI window with slider that selects which harmonic to affect
(var basePath = thisProcess.nowExecutingPath.asString.dirname;
s.waitForBoot({
	w = Window.new("Window", Rect(250,250,800,500)).front;

///Slider to select what note the Fundamental is
	//Label for Freq.
~fLabel = StaticText(w,Rect(250,0,72,15))
.string_("Fundamental")
.font_(Font("nil", 8))
.align_(\topLeft)
.background_(Color(0,0,0,0))
.stringColor_(Color.black);

	~color_array = Array.fill(200,1);

//Properties of the slider
~fslider = Slider(w, Rect(250,20,120,20))
	.background_(Color(0.8,0.8,0.8,0.75)).value_(0)
	.step_(1/(87))
	.action_({
	arg obj;
	var cf;
	cf = obj.value.linlin(0,1,21,108).postln;
		~fundamental_note = obj.value.linlin(0,1,21,108);
		~fundamental_note.postln;
		~fund = ~fundamental_note-1;
x.set(\fundamental_note, obj.value.linlin(0,1,21,108););


/*A0*/(if(obj.value.linlin(0,1,21,108) <= 21, {~a0.background_(Color(1,~color_array[21-1],~color_array[21-1]));~note_name.string_("A0");}, {~a0.background_(Color.white)}););
/*B0*/(if(obj.value.linlin(0,1,21,108) <= 23, {~b0.background_(Color(1,~color_array[23-1],~color_array[23-1]));~note_name.string_("B0");}, {~b0.background_(Color.white)}););
/*C1*/(if(obj.value.linlin(0,1,21,108) <= 24, {~c1.background_(Color(1,~color_array[24-1],~color_array[24-1]));~note_name.string_("C1");}, {~c1.background_(Color.white)}););
/*D1*/(if(obj.value.linlin(0,1,21,108) <= 26, {~d1.background_(Color(1,~color_array[26-1],~color_array[26-1]));~note_name.string_("D1");}, {~d1.background_(Color.white)}););
/*E1*/(if(obj.value.linlin(0,1,21,108) <= 28, {~e1.background_(Color(1,~color_array[28-1],~color_array[28-1]));~note_name.string_("E1");}, {~e1.background_(Color.white)}););
/*F1*/(if(obj.value.linlin(0,1,21,108) <= 29, {~f1.background_(Color(1,~color_array[29-1],~color_array[29-1]));~note_name.string_("F1");}, {~f1.background_(Color.white)}););
/*G1*/(if(obj.value.linlin(0,1,21,108) <= 31, {~g1.background_(Color(1,~color_array[31-1],~color_array[31-1]));~note_name.string_("G1");}, {~g1.background_(Color.white)}););
/*A1*/(if(obj.value.linlin(0,1,21,108) <= 33, {~a1.background_(Color(1,~color_array[33-1],~color_array[33-1]));~note_name.string_("A1");}, {~a1.background_(Color.white)}););
/*B1*/(if(obj.value.linlin(0,1,21,108) <= 35, {~b1.background_(Color(1,~color_array[35-1],~color_array[35-1]));~note_name.string_("B1");}, {~b1.background_(Color.white)}););
/*C2*/(if(obj.value.linlin(0,1,21,108) <= 36, {~c2.background_(Color(1,~color_array[36-1],~color_array[36-1]));~note_name.string_("C2");}, {~c2.background_(Color.white)}););
/*D2*/(if(obj.value.linlin(0,1,21,108) <= 38, {~d2.background_(Color(1,~color_array[38-1],~color_array[38-1]));~note_name.string_("D2");}, {~d2.background_(Color.white)}););
/*E2*/(if(obj.value.linlin(0,1,21,108) <= 40, {~e2.background_(Color(1,~color_array[40-1],~color_array[40-1]));~note_name.string_("E2");}, {~e2.background_(Color.white)}););
/*F2*/(if(obj.value.linlin(0,1,21,108) <= 41, {~f2.background_(Color(1,~color_array[41-1],~color_array[41-1]));~note_name.string_("F2");}, {~f2.background_(Color.white)}););
/*G2*/(if(obj.value.linlin(0,1,21,108) <= 43, {~g2.background_(Color(1,~color_array[43-1],~color_array[43-1]));~note_name.string_("G2");}, {~g2.background_(Color.white)}););
/*A2*/(if(obj.value.linlin(0,1,21,108) <= 45, {~a2.background_(Color(1,~color_array[45-1],~color_array[45-1]));~note_name.string_("A2");}, {~a2.background_(Color.white)}););
/*B2*/(if(obj.value.linlin(0,1,21,108) <= 47, {~b2.background_(Color(1,~color_array[47-1],~color_array[47-1]));~note_name.string_("B2");}, {~b2.background_(Color.white)}););
/*C3*/(if(obj.value.linlin(0,1,21,108) <= 48, {~c3.background_(Color(1,~color_array[48-1],~color_array[48-1]));~note_name.string_("C3");}, {~c3.background_(Color.white)}););
/*D3*/(if(obj.value.linlin(0,1,21,108) <= 50, {~d3.background_(Color(1,~color_array[50-1],~color_array[50-1]));~note_name.string_("D3");}, {~d3.background_(Color.white)}););
/*E3*/(if(obj.value.linlin(0,1,21,108) <= 52, {~e3.background_(Color(1,~color_array[52-1],~color_array[52-1]));~note_name.string_("E3");}, {~e3.background_(Color.white)}););
/*F3*/(if(obj.value.linlin(0,1,21,108) <= 53, {~f3.background_(Color(1,~color_array[53-1],~color_array[53-1]));~note_name.string_("F3");}, {~f3.background_(Color.white)}););
/*G3*/(if(obj.value.linlin(0,1,21,108) <= 55, {~g3.background_(Color(1,~color_array[55-1],~color_array[55-1]));~note_name.string_("G3");}, {~g3.background_(Color.white)}););
/*A3*/(if(obj.value.linlin(0,1,21,108) <= 57, {~a3.background_(Color(1,~color_array[57-1],~color_array[57-1]));~note_name.string_("A3");}, {~a3.background_(Color.white)}););
/*B3*/(if(obj.value.linlin(0,1,21,108) <= 59, {~b3.background_(Color(1,~color_array[59-1],~color_array[59-1]));~note_name.string_("B3");}, {~b3.background_(Color.white)}););
/*C4*/(if(obj.value.linlin(0,1,21,108) <= 60, {~c4.background_(Color(1,~color_array[60-1],~color_array[60-1]));~note_name.string_("C4");}, {~c4.background_(Color.white)}););
/*D4*/(if(obj.value.linlin(0,1,21,108) <= 62, {~d4.background_(Color(1,~color_array[62-1],~color_array[62-1]));~note_name.string_("D4");}, {~d4.background_(Color.white)}););
/*E4*/(if(obj.value.linlin(0,1,21,108) <= 64, {~e4.background_(Color(1,~color_array[64-1],~color_array[64-1]));~note_name.string_("E4");}, {~e4.background_(Color.white)}););
/*F4*/(if(obj.value.linlin(0,1,21,108) <= 65, {~f4.background_(Color(1,~color_array[65-1],~color_array[65-1]));~note_name.string_("F4");}, {~f4.background_(Color.white)}););
/*G4*/(if(obj.value.linlin(0,1,21,108) <= 67, {~g4.background_(Color(1,~color_array[67-1],~color_array[67-1]));~note_name.string_("G4");}, {~g4.background_(Color.white)}););
/*A4*/(if(obj.value.linlin(0,1,21,108) <= 69, {~a4.background_(Color(1,~color_array[69-1],~color_array[69-1]));~note_name.string_("A4");}, {~a4.background_(Color.white)}););
/*B4*/(if(obj.value.linlin(0,1,21,108) <= 71, {~b4.background_(Color(1,~color_array[71-1],~color_array[71-1]));~note_name.string_("B4");}, {~b4.background_(Color.white)}););
/*C5*/(if(obj.value.linlin(0,1,21,108) <= 72, {~c5.background_(Color(1,~color_array[72-1],~color_array[72-1]));~note_name.string_("C5");}, {~c5.background_(Color.white)}););
/*D5*/(if(obj.value.linlin(0,1,21,108) <= 74, {~d5.background_(Color(1,~color_array[74-1],~color_array[74-1]));~note_name.string_("D5");}, {~d5.background_(Color.white)}););
/*E5*/(if(obj.value.linlin(0,1,21,108) <= 76, {~e5.background_(Color(1,~color_array[76-1],~color_array[76-1]));~note_name.string_("E5");}, {~e5.background_(Color.white)}););
/*F5*/(if(obj.value.linlin(0,1,21,108) <= 77, {~f5.background_(Color(1,~color_array[77-1],~color_array[77-1]));~note_name.string_("F5");}, {~f5.background_(Color.white)}););
/*G5*/(if(obj.value.linlin(0,1,21,108) <= 79, {~g5.background_(Color(1,~color_array[79-1],~color_array[79-1]));~note_name.string_("G5");}, {~g5.background_(Color.white)}););
/*A5*/(if(obj.value.linlin(0,1,21,108) <= 81, {~a5.background_(Color(1,~color_array[81-1],~color_array[81-1]));~note_name.string_("A5");}, {~a5.background_(Color.white)}););
/*B5*/(if(obj.value.linlin(0,1,21,108) <= 83, {~b5.background_(Color(1,~color_array[83-1],~color_array[83-1]));~note_name.string_("B5");}, {~b5.background_(Color.white)}););
/*C6*/(if(obj.value.linlin(0,1,21,108) <= 84, {~c6.background_(Color(1,~color_array[84-1],~color_array[84-1]));~note_name.string_("C6");}, {~c6.background_(Color.white)}););
/*D6*/(if(obj.value.linlin(0,1,21,108) <= 86, {~d6.background_(Color(1,~color_array[86-1],~color_array[86-1]));~note_name.string_("D6");}, {~d6.background_(Color.white)}););
/*E6*/(if(obj.value.linlin(0,1,21,108) <= 88, {~e6.background_(Color(1,~color_array[88-1],~color_array[88-1]));~note_name.string_("E6");}, {~e6.background_(Color.white)}););
/*F6*/(if(obj.value.linlin(0,1,21,108) <= 89, {~f6.background_(Color(1,~color_array[89-1],~color_array[89-1]));~note_name.string_("F6");}, {~f6.background_(Color.white)}););
/*G6*/(if(obj.value.linlin(0,1,21,108) <= 91, {~g6.background_(Color(1,~color_array[91-1],~color_array[91-1]));~note_name.string_("G6");}, {~g6.background_(Color.white)}););
/*A6*/(if(obj.value.linlin(0,1,21,108) <= 93, {~a6.background_(Color(1,~color_array[93-1],~color_array[93-1]));~note_name.string_("A6");}, {~a6.background_(Color.white)}););
/*B6*/(if(obj.value.linlin(0,1,21,108) <= 95, {~b6.background_(Color(1,~color_array[95-1],~color_array[95-1]));~note_name.string_("B6");}, {~b6.background_(Color.white)}););
/*C5*/(if(obj.value.linlin(0,1,21,108) <= 96, {~c5.background_(Color(1,~color_array[96-1],~color_array[96-1]));~note_name.string_("C5");}, {~c5.background_(Color.white)}););
/*D7*/(if(obj.value.linlin(0,1,21,108) <= 98, {~d7.background_(Color(1,~color_array[98-1],~color_array[98-1]));~note_name.string_("D7");}, {~d7.background_(Color.white)}););
/*E7*/(if(obj.value.linlin(0,1,21,108) <= 100, {~e7.background_(Color(1,~color_array[100-1],~color_array[100-1]));~note_name.string_("E7");}, {~e7.background_(Color.white)}););
/*F7*/(if(obj.value.linlin(0,1,21,108) <= 101, {~f7.background_(Color(1,~color_array[101-1],~color_array[101-1]));~note_name.string_("F7");}, {~f7.background_(Color.white)}););
/*G7*/(if(obj.value.linlin(0,1,21,108) <= 103, {~g7.background_(Color(1,~color_array[103-1],~color_array[103-1]));~note_name.string_("G7");}, {~g7.background_(Color.white)}););
/*A7*/(if(obj.value.linlin(0,1,21,108) <= 105, {~a7.background_(Color(1,~color_array[105-1],~color_array[105-1]));~note_name.string_("A7");}, {~a7.background_(Color.white)}););
/*B7*/(if(obj.value.linlin(0,1,21,108) <= 107, {~b7.background_(Color(1,~color_array[107-1],~color_array[107-1]));~note_name.string_("B7");}, {~b7.background_(Color.white)}););
/*C8*/(if(obj.value.linlin(0,1,21,108) <= 108, {~c8.background_(Color(1,~color_array[108-1],~color_array[108-1]));~note_name.string_("C8");}, {~c8.background_(Color.white)}););

		/*
/*	C4	*/	(if(obj.value.linlin(0,1,60,72) <= 	60	, {~	c4	.background_(Color(1,	~color_array[60-1],~color_array[60-1]	));	~note_name.string_("C4");	}, {~	c4	.background_(Color.white)}););
/*	D4	*/	(if(obj.value.linlin(0,1,60,72) <= 	62	, {~	d4	.background_(Color(1,	~color_array[62-1],~color_array[62-1]	));	~note_name.string_("D4");	}, {~	d4	.background_(Color.white)}););
/*	E4	*/	(if(obj.value.linlin(0,1,60,72) <= 	64	, {~	e4	.background_(Color(1,	~color_array[64-1],~color_array[64-1]	));	~note_name.string_("E4");	}, {~	e4	.background_(Color.white)}););
/*	F4	*/	(if(obj.value.linlin(0,1,60,72) <= 	65	, {~	f4	.background_(Color(1,	~color_array[65-1],~color_array[65-1]	));	~note_name.string_("F4");	}, {~	f4	.background_(Color.white)}););
/*	G4	*/	(if(obj.value.linlin(0,1,60,72) <= 	67	, {~	g4	.background_(Color(1,	~color_array[67-1],~color_array[67-1]	));	~note_name.string_("G4");	}, {~	g4	.background_(Color.white)}););
/*	A4	*/	(if(obj.value.linlin(0,1,60,72) <= 	69	, {~	a4	.background_(Color(1,	~color_array[69-1],~color_array[69-1]	));	~note_name.string_("A4");	}, {~	a4	.background_(Color.white)}););
/*	B4	*/	(if(obj.value.linlin(0,1,60,72) <= 	71	, {~	b4	.background_(Color(1,	~color_array[71-1],~color_array[71-1]	));	~note_name.string_("B4");	}, {~	b4	.background_(Color.white)}););
/*	C5	*/	(if(obj.value.linlin(0,1,60,72) <= 	72	, {~	c5	.background_(Color(1,	~color_array[72-1],~color_array[72-1]	));	~note_name.string_("C5");	}, {~	c5	.background_(Color.white)}););
/*	D5	*/	(if(obj.value.linlin(0,1,60,72) <= 	74	, {~	d5	.background_(Color(1,	~color_array[74-1],~color_array[74-1]	));	~note_name.string_("D5");	}, {~	d5	.background_(Color.white)}););
/*	E5	*/	(if(obj.value.linlin(0,1,60,72) <= 	76	, {~	e5	.background_(Color(1,	~color_array[76-1],~color_array[76-1]	));	~note_name.string_("E5");	}, {~	e5	.background_(Color.white)}););
/*	F5	*/	(if(obj.value.linlin(0,1,60,72) <= 	77	, {~	f5	.background_(Color(1,	~color_array[77-1],~color_array[77-1]	));	~note_name.string_("F5");	}, {~	f5	.background_(Color.white)}););
/*	G5	*/	(if(obj.value.linlin(0,1,60,72) <= 	79	, {~	g5	.background_(Color(1,	~color_array[79-1],~color_array[79-1]	));	~note_name.string_("G5");	}, {~	g5	.background_(Color.white)}););
/*	A5	*/	(if(obj.value.linlin(0,1,60,72) <= 	81	, {~	a5	.background_(Color(1,	~color_array[81-1],~color_array[81-1]	));	~note_name.string_("A5");	}, {~	a5	.background_(Color.white)}););
/*	B5	*/	(if(obj.value.linlin(0,1,60,72) <= 	83	, {~	b5	.background_(Color(1,	~color_array[83-1],~color_array[83-1]	));	~note_name.string_("B5");	}, {~	b5	.background_(Color.white)}););
/*	C6	*/	(if(obj.value.linlin(0,1,60,72) <= 	84	, {~	c6	.background_(Color(1,	~color_array[84-1],~color_array[84-1]	));	~note_name.string_("C6");	}, {~	c6	.background_(Color.white)}););
/*	D6	*/	(if(obj.value.linlin(0,1,60,72) <= 	86	, {~	d6	.background_(Color(1,	~color_array[86-1],~color_array[86-1]	));	~note_name.string_("D6");	}, {~	d6	.background_(Color.white)}););
/*	E6	*/	(if(obj.value.linlin(0,1,60,72) <= 	88	, {~	e6	.background_(Color(1,	~color_array[88-1],~color_array[88-1]	));	~note_name.string_("E6");	}, {~	e6	.background_(Color.white)}););
/*	F6	*/	(if(obj.value.linlin(0,1,60,72) <= 	89	, {~	f6	.background_(Color(1,	~color_array[89-1],~color_array[89-1]	));	~note_name.string_("F6");	}, {~	f6	.background_(Color.white)}););
/*	G6	*/	(if(obj.value.linlin(0,1,60,72) <= 	91	, {~	g6	.background_(Color(1,	~color_array[91-1],~color_array[91-1]	));	~note_name.string_("G6");	}, {~	g6	.background_(Color.white)}););
/*	A6	*/	(if(obj.value.linlin(0,1,60,72) <= 	93	, {~	a6	.background_(Color(1,	~color_array[93-1],~color_array[93-1]	));	~note_name.string_("A6");	}, {~	a6	.background_(Color.white)}););
/*	B6	*/	(if(obj.value.linlin(0,1,60,72) <= 	95	, {~	b6	.background_(Color(1,	~color_array[95-1],~color_array[95-1]	));	~note_name.string_("B6");	}, {~	b6	.background_(Color.white)}););
		*/

/*ASHARP0*/(if(obj.value.linlin(0,1,21,108) <= 22, {~aSHARP0.background_(Color((1-~color_array[22-1]),0,0));~note_name.string_("A#0");}, {~aSHARP0.background_(Color.black)}););
/*CSHARP1*/(if(obj.value.linlin(0,1,21,108) <= 25, {~cSHARP1.background_(Color((1-~color_array[25-1]),0,0));~note_name.string_("C#1");}, {~cSHARP1.background_(Color.black)}););
/*DSHARP1*/(if(obj.value.linlin(0,1,21,108) <= 27, {~dSHARP1.background_(Color((1-~color_array[27-1]),0,0));~note_name.string_("D#1");}, {~dSHARP1.background_(Color.black)}););
/*FSHARP1*/(if(obj.value.linlin(0,1,21,108) <= 30, {~fSHARP1.background_(Color((1-~color_array[30-1]),0,0));~note_name.string_("F#1");}, {~fSHARP1.background_(Color.black)}););
/*GSHARP1*/(if(obj.value.linlin(0,1,21,108) <= 32, {~gSHARP1.background_(Color((1-~color_array[32-1]),0,0));~note_name.string_("G#1");}, {~gSHARP1.background_(Color.black)}););
/*ASHARP1*/(if(obj.value.linlin(0,1,21,108) <= 34, {~aSHARP1.background_(Color((1-~color_array[34-1]),0,0));~note_name.string_("A#1");}, {~aSHARP1.background_(Color.black)}););
/*CSHARP2*/(if(obj.value.linlin(0,1,21,108) <= 37, {~cSHARP2.background_(Color((1-~color_array[37-1]),0,0));~note_name.string_("C#2");}, {~cSHARP2.background_(Color.black)}););
/*DSHARP2*/(if(obj.value.linlin(0,1,21,108) <= 39, {~dSHARP2.background_(Color((1-~color_array[39-1]),0,0));~note_name.string_("D#2");}, {~dSHARP2.background_(Color.black)}););
/*FSHARP2*/(if(obj.value.linlin(0,1,21,108) <= 42, {~fSHARP2.background_(Color((1-~color_array[42-1]),0,0));~note_name.string_("F#2");}, {~fSHARP2.background_(Color.black)}););
/*GSHARP2*/(if(obj.value.linlin(0,1,21,108) <= 44, {~gSHARP2.background_(Color((1-~color_array[44-1]),0,0));~note_name.string_("G#2");}, {~gSHARP2.background_(Color.black)}););
/*ASHARP2*/(if(obj.value.linlin(0,1,21,108) <= 46, {~aSHARP2.background_(Color((1-~color_array[46-1]),0,0));~note_name.string_("A#2");}, {~aSHARP2.background_(Color.black)}););
/*CSHARP3*/(if(obj.value.linlin(0,1,21,108) <= 49, {~cSHARP3.background_(Color((1-~color_array[49-1]),0,0));~note_name.string_("C#3");}, {~cSHARP3.background_(Color.black)}););
/*DSHARP3*/(if(obj.value.linlin(0,1,21,108) <= 51, {~dSHARP3.background_(Color((1-~color_array[51-1]),0,0));~note_name.string_("D#3");}, {~dSHARP3.background_(Color.black)}););
/*FSHARP3*/(if(obj.value.linlin(0,1,21,108) <= 54, {~fSHARP3.background_(Color((1-~color_array[54-1]),0,0));~note_name.string_("F#3");}, {~fSHARP3.background_(Color.black)}););
/*GSHARP3*/(if(obj.value.linlin(0,1,21,108) <= 56, {~gSHARP3.background_(Color((1-~color_array[56-1]),0,0));~note_name.string_("G#3");}, {~gSHARP3.background_(Color.black)}););
/*ASHARP3*/(if(obj.value.linlin(0,1,21,108) <= 58, {~aSHARP3.background_(Color((1-~color_array[58-1]),0,0));~note_name.string_("A#3");}, {~aSHARP3.background_(Color.black)}););
/*CSHARP4*/(if(obj.value.linlin(0,1,21,108) <= 61, {~cSHARP4.background_(Color((1-~color_array[61-1]),0,0));~note_name.string_("C#4");}, {~cSHARP4.background_(Color.black)}););
/*DSHARP4*/(if(obj.value.linlin(0,1,21,108) <= 63, {~dSHARP4.background_(Color((1-~color_array[63-1]),0,0));~note_name.string_("D#4");}, {~dSHARP4.background_(Color.black)}););
/*FSHARP4*/(if(obj.value.linlin(0,1,21,108) <= 66, {~fSHARP4.background_(Color((1-~color_array[66-1]),0,0));~note_name.string_("F#4");}, {~fSHARP4.background_(Color.black)}););
/*GSHARP4*/(if(obj.value.linlin(0,1,21,108) <= 68, {~gSHARP4.background_(Color((1-~color_array[68-1]),0,0));~note_name.string_("G#4");}, {~gSHARP4.background_(Color.black)}););
/*ASHARP4*/(if(obj.value.linlin(0,1,21,108) <= 70, {~aSHARP4.background_(Color((1-~color_array[70-1]),0,0));~note_name.string_("A#4");}, {~aSHARP4.background_(Color.black)}););
/*CSHARP5*/(if(obj.value.linlin(0,1,21,108) <= 73, {~cSHARP5.background_(Color((1-~color_array[73-1]),0,0));~note_name.string_("C#5");}, {~cSHARP5.background_(Color.black)}););
/*DSHARP5*/(if(obj.value.linlin(0,1,21,108) <= 75, {~dSHARP5.background_(Color((1-~color_array[75-1]),0,0));~note_name.string_("D#5");}, {~dSHARP5.background_(Color.black)}););
/*FSHARP5*/(if(obj.value.linlin(0,1,21,108) <= 78, {~fSHARP5.background_(Color((1-~color_array[78-1]),0,0));~note_name.string_("F#5");}, {~fSHARP5.background_(Color.black)}););
/*GSHARP5*/(if(obj.value.linlin(0,1,21,108) <= 80, {~gSHARP5.background_(Color((1-~color_array[80-1]),0,0));~note_name.string_("G#5");}, {~gSHARP5.background_(Color.black)}););
/*ASHARP5*/(if(obj.value.linlin(0,1,21,108) <= 82, {~aSHARP5.background_(Color((1-~color_array[82-1]),0,0));~note_name.string_("A#5");}, {~aSHARP5.background_(Color.black)}););
/*CSHARP6*/(if(obj.value.linlin(0,1,21,108) <= 85, {~cSHARP6.background_(Color((1-~color_array[85-1]),0,0));~note_name.string_("C#6");}, {~cSHARP6.background_(Color.black)}););
/*DSHARP6*/(if(obj.value.linlin(0,1,21,108) <= 87, {~dSHARP6.background_(Color((1-~color_array[87-1]),0,0));~note_name.string_("D#6");}, {~dSHARP6.background_(Color.black)}););
/*FSHARP6*/(if(obj.value.linlin(0,1,21,108) <= 90, {~fSHARP6.background_(Color((1-~color_array[90-1]),0,0));~note_name.string_("F#6");}, {~fSHARP6.background_(Color.black)}););
/*GSHARP6*/(if(obj.value.linlin(0,1,21,108) <= 92, {~gSHARP6.background_(Color((1-~color_array[92-1]),0,0));~note_name.string_("G#6");}, {~gSHARP6.background_(Color.black)}););
/*ASHARP6*/(if(obj.value.linlin(0,1,21,108) <= 94, {~aSHARP6.background_(Color((1-~color_array[94-1]),0,0));~note_name.string_("A#6");}, {~aSHARP6.background_(Color.black)}););
/*CSHARP7*/(if(obj.value.linlin(0,1,21,108) <= 97, {~cSHARP7.background_(Color((1-~color_array[97-1]),0,0));~note_name.string_("C#7");}, {~cSHARP7.background_(Color.black)}););
/*DSHARP7*/(if(obj.value.linlin(0,1,21,108) <= 99, {~dSHARP7.background_(Color((1-~color_array[99-1]),0,0));~note_name.string_("D#7");}, {~dSHARP7.background_(Color.black)}););
/*FSHARP7*/(if(obj.value.linlin(0,1,21,108) <= 102, {~fSHARP7.background_(Color((1-~color_array[102-1]),0,0));~note_name.string_("F#7");}, {~fSHARP7.background_(Color.black)}););
/*GSHARP7*/(if(obj.value.linlin(0,1,21,108) <= 104, {~gSHARP7.background_(Color((1-~color_array[104-1]),0,0));~note_name.string_("G#7");}, {~gSHARP7.background_(Color.black)}););
/*ASHARP7*/(if(obj.value.linlin(0,1,21,108) <= 106, {~aSHARP7.background_(Color((1-~color_array[106-1]),0,0));~note_name.string_("A#7");}, {~aSHARP7.background_(Color.black)}););


(
~color_array = Array.fill(200,1);
			~color_array[~fslider.value.linlin(0,1,21,108)-1+0]=~harmonics_array[0]*~f1slider.value.linlin(0,1,1,0);
~color_array[~fslider.value.linlin(0,1,21,108)-1+12]=~harmonics_array[1]*~f2slider.value.linlin(0,1,1,0);
~color_array[~fslider.value.linlin(0,1,21,108)-1+19]=~harmonics_array[2]*~f3slider.value.linlin(0,1,1,0);
~color_array[~fslider.value.linlin(0,1,21,108)-1+24]=~harmonics_array[3]*~f4slider.value.linlin(0,1,1,0);
~color_array[~fslider.value.linlin(0,1,21,108)-1+28]=~harmonics_array[4]*~f5slider.value.linlin(0,1,1,0);
~color_array[~fslider.value.linlin(0,1,21,108)-1+31]=~harmonics_array[5]*~f6slider.value.linlin(0,1,1,0);
~color_array[~fslider.value.linlin(0,1,21,108)-1+34]=~harmonics_array[6]*~f7slider.value.linlin(0,1,1,0);
~color_array[~fslider.value.linlin(0,1,21,108)-1+36]=~harmonics_array[7]*~f8slider.value.linlin(0,1,1,0);
~color_array[~fslider.value.linlin(0,1,21,108)-1+38]=~harmonics_array[8]*~f9slider.value.linlin(0,1,1,0);
~color_array[~fslider.value.linlin(0,1,21,108)-1+40]=~harmonics_array[9]*~f10slider.value.linlin(0,1,1,0);
~color_array[~fslider.value.linlin(0,1,21,108)-1+41]=~harmonics_array[10]*~f11slider.value.linlin(0,1,1,0);
~color_array[~fslider.value.linlin(0,1,21,108)-1+43]=~harmonics_array[11]*~f12slider.value.linlin(0,1,1,0);
~color_array[~fslider.value.linlin(0,1,21,108)-1+44]=~harmonics_array[12]*~f13slider.value.linlin(0,1,1,0);
~color_array[~fslider.value.linlin(0,1,21,108)-1+46]=~harmonics_array[13]*~f14slider.value.linlin(0,1,1,0);
~color_array[~fslider.value.linlin(0,1,21,108)-1+47]=~harmonics_array[14]*~f15slider.value.linlin(0,1,1,0);
~color_array[~fslider.value.linlin(0,1,21,108)-1+48]=~harmonics_array[15]*~f16slider.value.linlin(0,1,1,0);

		);


		if(
		x.isPlaying,
		{x.set(\freqX,cf)});
	~numberfBox.value_(obj.value.linlin(0,1,21,108));
})
	.orientation_(\horizontal);

//Number box that can edit slider position
~numberfBox = NumberBox(w,Rect(250-30,20,30,20))
.value_(21)
.clipLo_(21)
.clipHi_(108)
.font_(Font("nil",12))
.decimals_(0)
.align_(\center)
.action_({
	arg obj;
	~fslider.valueAction_(obj.value.linlin(21,108,0,1))
});

//True note value
	~note_name = StaticText(w,Rect(250+70,0,72,15))
	.string_("A0")
	.font_(Font("nil", 12));


///Starter harmonics array (sets everything to 0)
~harmonics_array = Array.fill(0, {arg i; 0});
~harmonic_count = 0;
~intensity_array = Array.fill(1, {arg i; 0});
~harmonic_sums = Array.fill(0, {arg i; 0});
	~fundamental_note = ~fslider.value.linlin(0,1,21,108); //Middle C
~fundamental_freq = ((2**((-69+~fundamental_note)/12))*440);

///How many harmonics?
~amount_selectText = StaticText(w, Rect(20, 0, 200, 20)).string_("Select Number of Harmonics to Create").font_(Font("Helvetica", 11));
~amount_selectBox = NumberBox(w, Rect(20, 20, 150, 20)).clipLo_(1).clipHi_(16);
~amount_select = Slider(w, Rect(20, 40, 150, 20)).step_(1/(16-1)).action_({
	        ~amount_selectBox.value_(~amount_select.value.linlin(0,1,1,16));
		s.freeAll;
	///Cover the manipulator
	~manipulator_cover = StaticText(~manipulator_view, Rect(20, 0, 250, 60)).string_("Activate Harmonics to Reveal Manipulator").font_(Font("Helvetica", 11)).stringColor_(Color.white).background_(Color(0,0,0,1)).align_(\center);
        });
~amount_selectButton = Button(w, Rect(170, 20, 40, 40)).states_([["Click to
create", Color.black, Color.white]]).font_(Font("Helvetica", 11)).action_({
	~amount_selectBox.value.postln;
	~harmonics_array = Array.fill(~amount_selectBox.value, {arg i; 1}).postln;
	~intensity_array = Array.fill(~amount_selectBox.value, {arg i; 1});
	~harmonic_count = ~amount_selectBox.value;
	~manipulator_cover.remove;
	~manipulator_view.remove;
	~harmonic_sums = Array.fill(~harmonics_array.size, {arg i; i+1}).postln;
s.freeAll;

	///Which harmonic to manipulate?
(
~manipulator_view = CompositeView(w, Rect(0,80,400,100));
~slider_selectText = StaticText(~manipulator_view, Rect(20, 0, 150, 20)).string_("Select Harmonic to Manipulate").font_(Font("Helvetica", 11));
~slider_selectBox = NumberBox(~manipulator_view, Rect(20, 20, 150, 20)).clipLo_(1).clipHi_(~harmonic_count);
~slider_select = Slider(~manipulator_view, Rect(20, 40, 150, 20)).step_(1/(~harmonic_count-1)).action_({
				~slider_selectBox.value_(~slider_select.value.linlin(0,1,(1),~harmonic_count));
				(
					~slider_selectBox.value.postln;
	~harmonics_array[0..15]=1;
	~harmonics_array[~slider_selectBox.value-1]=0;
	~harmonics_array.postln;
					// ~sound_button.valueAction_(0);
					// ~sound_button.valueAction_(1);
				)
        });
(
	///Sound output
		/*(
			SynthDef("help-synth", {| freq = (~sound_frequencies), out = 0 |
    Out.ar(out, Mix(SinOsc.ar(freq, 0, 0.1)));
}).add;
);*/
		/*SynthDef(\synthdef, {Pan2.ar(Mix(SinOsc.ar(~sound_frequencies, 0, ~sound_amplitudes)))}).add;*/
		~sound_frequencies = 440*~harmonic_sums;//Array.with(440,880);
				~sound_amplitudes = ~intensity_array*0.1;//Array.with(0.2,0.1);
				// ~sound_function = Synth("help-synth"); //Synth(\synthdef);


(
SynthDef.new("deviant", {
        ({arg fundamental_note = ~fundamental_note;
						SinOsc.ar(((2**((-69+fundamental_note)/12))*440)*(1+~freqslider.value.linlin(0,1,-1,1)), 0, (0.5/~harmonic_count)) // try pi in the phase argument
        }).sum
						!2};);
				);


SynthDef.new(\others, {

					({arg i, fundamental_note = ~fundamental_note; var j = i + 1;
						SinOsc.ar((((2**((-69+fundamental_note)/12))*440)) * j, 0, ~intensity_array[i].value*~harmonics_array[i]*(0.5/~harmonic_count)) // try pi in the phase argument
					}.dup(~harmonic_count)).add
					!2};);




				~deviant_player = {
        ({
						SinOsc.ar(((2**((-69+~fundamental_note)/12))*440)*(1+~freqslider.value.linlin(0,1,-1,1)), 0, (1-~harmonics_array[~slider_selectBox.value-1])*(0.5/~harmonic_count)) // try pi in the phase argument
        }).sum
!2};
				~sound_player = {

					({arg i; var j = i + 1;
						SinOsc.ar((((2**((-69+~fundamental_note)/12))*440)) * j, 0, ~intensity_array[i].value*~harmonics_array[i]*(0.5/~harmonic_count)) // try pi in the phase argument
					}.dup(~harmonic_count)).sum

!2};


			(
			~sound_button =Button(~manipulator_view, Rect(170+60, 20+60-80+20, 60, 60-20)).states_([["Click to
play", Color.white, Color.blue],["Click to
mute", Color.white, Color.black]]).font_(Font("Helvetica", 11));
		~sound_button.action_(
			{
	arg obj;
	if(obj.value == 1,
								{~sound_player.play; ~deviant_player.play;
									//x = Synth(\others); y = Synth(\deviant);
									/*{Pan2.ar(Mix(SinOsc.ar(~sound_frequencies, 0, (~sound_amplitudes*~harmonics_array))))}.play*/

								},
		{s.freeAll}
	);
		});
			)
	);
		~slider_selectButton = Button(~manipulator_view, Rect(170, 20, 40, 40)).states_([["Click to
select", Color.black, Color.white],["Click to
release", Color.white, Color.black]]).font_(Font("Helvetica", 11)).action_({
	arg obj;
	if(obj.value == 1,
					{
						~slider_selectBox.value.postln;
	~harmonics_array[0..15]=1;
	~harmonics_array[~slider_selectBox.value-1]=0;
	~harmonics_array.postln;
				~sound_button.valueAction_(0);
				~sound_button.valueAction_(1);
					},
		{
					~harmonics_array[~slider_selectBox.value-1]=1;
						~sound_button.valueAction_(0);
				~sound_button.valueAction_(1);
					}
	);



});
);

});


///Intensities panel
// ~intensity_array[0]=1;

~composite = CompositeView(w, Rect(400,200,600,300)); //needs to use Spectra bounds to not crop FreqScope

///Spectra viewer
f = FreqScopeView(~composite, Rect.new(0,0,300,200)); //Prepares frequency scope (a.k.a. spectra) from (-120,355,800,300) to (-100,355,600,300)) - for harmonic marker transformation maths
	f.active_(true).freqMode_(1).dbRange_(70);

(
	//FREQUENCY of deviant
//Properties of the slider
~freqslider = Slider(w, Rect(290,60,150,30))
.background_(Color(0.8,0.8,0.8,0.75))
.value_(0.5)
.action_({
	arg obj;
	var cf;
	cf = obj.value.linlin(0,1,-1,1).postln;
		if(
		x.isPlaying,
		{x.set(\outoftune,cf)});
	~numberBox.value_(obj.value.linlin(0,1,-1,1));
});

//Label for Freq.
~freqLabel = StaticText(w,Rect(240,40,65,40))
.string_(" Deviation")
.font_(Font("nil", 12))
.align_(\topRight)
.background_(Color(0,0,0,0))
.stringColor_(Color.black);

//Number box that can edit slider position
~numberBox = NumberBox(w,Rect(220+35,60,72-35,30))
.value_(0)
.clipLo_(-1)
.clipHi_(1)
.font_(Font("nil",12))
.decimals_(2)
.align_(\center)
.action_({
	arg obj;
	~freqslider.valueAction_(obj.value.linlin(-1,1,0,1))
});

//Button to reset deviant
~reset = Button(w, Rect(220,60,35,30))
.states_([
	["Reset
to 0", Color.white,Color(0.4824, 0.4863, 0.4863,1)]
])
.font_(Font("nil", 8))
.action_({
		~freqslider.valueAction_(3.value.linlin(2,4,0,1));
});

	);

~keyboard_image = Image.new(basePath +/+ "images/keyboard_small.png");







//Aesthetic lines
	w.drawFunc = {
		~keyboard_image.drawInRect(Rect(0,0,60,25), Rect(0,0,60,25), 2, 1.0);};

	//Keyboard visualizer button
		~key_vis = Button.new(w, Rect(0,0,60,25))
	.states_([["", Color.black, Color.clear],["CLOSE", Color.white, Color(0,0,0,0.7)]])
	.font_(Font("nil", 10))
	.action_({

arg obj;
		if(obj.value == 1,
				// ~keyboard_open.value == 1,
			{
					// ~keyboard_open = 0;
	(basePath +/+  "modules/keyboard.scd").loadPaths; //This line allows all contact buttons to be updated automatically
		},{

~keyboard.close;
					// ~keyboard_open = 1;
		};);

		});




	(
		/////////////////SLIDERS
///F1
//Properties of the slider
~f1slider = Slider(w, Rect(70,145,20,230))
.background_(Color(0.8,0.8,0.8,0.75))
	.value_(0.5) //is converted to 1
	.orientation_(\vertical)
	.action_({
	arg obj;
	var cf;
	cf = obj.value.linlin(0,1,0.0,2).postln;
		if(
		x.isPlaying,
		{x.set(\f1,cf)});
	~number1Box.value_(obj.value.linlin(0,1,0.0,2));
});
//Label
~f1Label = StaticText(w,Rect(70,130,20,15))
.string_("1")
.font_(Font("nil", 12))
.align_(\top)
.background_(Color(0,0,0,0.1))
.stringColor_(Color.black);
//Number box that can edit slider position
~number1Box = NumberBox(w,Rect(70,375,20,15))
.value_(1)
.clipLo_(0.0)
.clipHi_(2)
.font_(Font("nil",7))
.decimals_(2)
.align_(\center)
.action_({
	arg obj;
	~f1slider.valueAction_(obj.value.linlin(0.0,2,0,1))
});
//Number box showing harmonic frequency
~f1Box = NumberBox(w,Rect(70,390,20,15))
.value_(240)
.clipLo_(100)
.clipHi_(20000)
.font_(Font("nil",5))
.decimals_(1)
.align_(\center);
	// .action_({
		// arg obj;
		// ~freqslider.valueAction_(obj.value.explin(100,1000,0,1))
// });

	///F2
//Properties of the slider
~f2slider = Slider(w, Rect(90,145,20,230))
.background_(Color(0.8,0.8,0.8,0.75))
	.value_(0.5) //is converted to 1
	.orientation_(\vertical)
	.action_({
	arg obj;
	var cf;
	cf = obj.value.linlin(0,1,0.0,2).postln;
		if(
		x.isPlaying,
		{x.set(\f2,cf)});
	~number2Box.value_(obj.value.linlin(0,1,0.0,2));
});
//Label
~f2Label = StaticText(w,Rect(90,130,20,15))
.string_("2")
.font_(Font("nil", 12))
.align_(\top)
.background_(Color(0,0,0,0.1))
.stringColor_(Color.black);
//Number box that can edit slider position
~number2Box = NumberBox(w,Rect(90,375,20,15))
.value_(1)
.clipLo_(0.0)
.clipHi_(2)
.font_(Font("nil",7))
.decimals_(2)
.align_(\center)
.action_({
	arg obj;
	~f2slider.valueAction_(obj.value.linlin(0.0,2,0,1))
});
//Number box showing harmonic frequency
~f2Box = NumberBox(w,Rect(90,390,20,15))
.value_(240*1)
.clipLo_(100)
.clipHi_(20000)
.font_(Font("nil",5))
.decimals_(1)
.align_(\center);
	// .action_({
		// arg obj;
		// ~freqslider.valueAction_(obj.value.explin(100,1000,0,1))
// });

	///F3
//Properties of the slider
~f3slider = Slider(w, Rect(110,145,20,230))
.background_(Color(0.8,0.8,0.8,0.75))
	.value_(0.5) //is converted to 1
	.orientation_(\vertical)
	.action_({
	arg obj;
	var cf;
	cf = obj.value.linlin(0,1,0.0,2).postln;
		if(
		x.isPlaying,
		{x.set(\f3,cf)});
	~number3Box.value_(obj.value.linlin(0,1,0.0,2));
});
//Label
~f3Label = StaticText(w,Rect(110,130,20,15))
.string_("3")
.font_(Font("nil", 12))
.align_(\top)
.background_(Color(0,0,0,0.1))
.stringColor_(Color.black);
//Number box that can edit slider position
~number3Box = NumberBox(w,Rect(110,375,20,15))
.value_(3)
.clipLo_(0.0)
.clipHi_(2)
.font_(Font("nil",7))
.decimals_(2)
.align_(\center)
.action_({
	arg obj;
	~f3slider.valueAction_(obj.value.linlin(0.0,2,0,1))
});
//Number box showing harmonic frequency
~f3Box = NumberBox(w,Rect(110,390,20,15))
.value_(240*3)
.clipLo_(100)
.clipHi_(20000)
.font_(Font("nil",5))
.decimals_(1)
.align_(\center);
	// .action_({
		// arg obj;
		// ~freqslider.valueAction_(obj.value.explin(100,1000,0,1))
// });

	///F4
//Properties of the slider
~f4slider = Slider(w, Rect(130,145,20,230))
.background_(Color(0.8,0.8,0.8,0.75))
	.value_(0.5) //is converted to 1
	.orientation_(\vertical)
	.action_({
	arg obj;
	var cf;
	cf = obj.value.linlin(0,1,0.0,2).postln;
		if(
		x.isPlaying,
		{x.set(\f4,cf)});
	~number4Box.value_(obj.value.linlin(0,1,0.0,2));
});
//Label
~f4Label = StaticText(w,Rect(130,130,20,15))
.string_("4")
.font_(Font("nil", 12))
.align_(\top)
.background_(Color(0,0,0,0.1))
.stringColor_(Color.black);
//Number box that can edit slider position
~number4Box = NumberBox(w,Rect(130,375,20,15))
.value_(1)
.clipLo_(0.0)
.clipHi_(2)
.font_(Font("nil",7))
.decimals_(2)
.align_(\center)
.action_({
	arg obj;
	~f4slider.valueAction_(obj.value.linlin(0.0,2,0,1))
});
//Number box showing harmonic frequency
~f4Box = NumberBox(w,Rect(130,390,20,15))
.value_(240*4)
.clipLo_(100)
.clipHi_(20000)
.font_(Font("nil",5))
.decimals_(1)
.align_(\center);
	// .action_({
		// arg obj;
		// ~freqslider.valueAction_(obj.value.explin(100,1000,0,1))
// });

	///F5
//Properties of the slider
~f5slider = Slider(w, Rect(150,145,20,230))
.background_(Color(0.8,0.8,0.8,0.75))
	.value_(0.5) //is converted to 1
	.orientation_(\vertical)
	.action_({
	arg obj;
	var cf;
	cf = obj.value.linlin(0,1,0.0,2).postln;
		if(
		x.isPlaying,
		{x.set(\f5,cf)});
	~number5Box.value_(obj.value.linlin(0,1,0.0,2));
});
//Label
~f5Label = StaticText(w,Rect(150,130,20,15))
.string_("5")
.font_(Font("nil", 12))
.align_(\top)
.background_(Color(0,0,0,0.1))
.stringColor_(Color.black);
//Number box that can edit slider position
~number5Box = NumberBox(w,Rect(150,375,20,15))
.value_(1)
.clipLo_(0.0)
.clipHi_(2)
.font_(Font("nil",7))
.decimals_(2)
.align_(\center)
.action_({
	arg obj;
	~f5slider.valueAction_(obj.value.linlin(0.0,2,0,1))
});
//Number box showing harmonic frequency
~f5Box = NumberBox(w,Rect(150,390,20,15))
.value_(240*5)
.clipLo_(100)
.clipHi_(20000)
.font_(Font("nil",5))
.decimals_(1)
.align_(\center);
	// .action_({
		// arg obj;
		// ~freqslider.valueAction_(obj.value.explin(100,1000,0,1))
// });

	///F6
//Properties of the slider
~f6slider = Slider(w, Rect(170,145,20,230))
.background_(Color(0.8,0.8,0.8,0.75))
	.value_(0.5) //is converted to 1
	.orientation_(\vertical)
	.action_({
	arg obj;
	var cf;
	cf = obj.value.linlin(0,1,0.0,2).postln;
		if(
		x.isPlaying,
		{x.set(\f6,cf)});
	~number6Box.value_(obj.value.linlin(0,1,0.0,2));
});
//Label
~f6Label = StaticText(w,Rect(170,130,20,15))
.string_("6")
.font_(Font("nil", 12))
.align_(\top)
.background_(Color(0,0,0,0.1))
.stringColor_(Color.black);
//Number box that can edit slider position
~number6Box = NumberBox(w,Rect(170,375,20,15))
.value_(1)
.clipLo_(0.0)
.clipHi_(2)
.font_(Font("nil",7))
.decimals_(2)
.align_(\center)
.action_({
	arg obj;
	~f6slider.valueAction_(obj.value.linlin(0.0,2,0,1))
});
//Number box showing harmonic frequency
~f6Box = NumberBox(w,Rect(170,390,20,15))
.value_(240)
.clipLo_(100)
.clipHi_(20000)
.font_(Font("nil",5))
.decimals_(1)
.align_(\center);
	// .action_({
		// arg obj;
		// ~freqslider.valueAction_(obj.value.explin(100,1000,0,1))
// });

	///F7
//Properties of the slider
~f7slider = Slider(w, Rect(190,145,20,230))
.background_(Color(0.8,0.8,0.8,0.75))
	.value_(0.5) //is converted to 1
	.orientation_(\vertical)
	.action_({
	arg obj;
	var cf;
	cf = obj.value.linlin(0,1,0.0,2).postln;
		if(
		x.isPlaying,
		{x.set(\f7,cf)});
	~number7Box.value_(obj.value.linlin(0,1,0.0,2));
});
//Label
~f7Label = StaticText(w,Rect(190,130,20,15))
.string_("7")
.font_(Font("nil", 12))
.align_(\top)
.background_(Color(0,0,0,0.1))
.stringColor_(Color.black);
//Number box that can edit slider position
~number7Box = NumberBox(w,Rect(190,375,20,15))
.value_(1)
.clipLo_(0.0)
.clipHi_(2)
.font_(Font("nil",7))
.decimals_(2)
.align_(\center)
.action_({
	arg obj;
	~f7slider.valueAction_(obj.value.linlin(0.0,2,0,1))
});
//Number box showing harmonic frequency
~f7Box = NumberBox(w,Rect(190,390,20,15))
.value_(240*7)
.clipLo_(100)
.clipHi_(20000)
.font_(Font("nil",5))
.decimals_(1)
.align_(\center);
	// .action_({
		// arg obj;
		// ~freqslider.valueAction_(obj.value.explin(100,1000,0,1))
// });

	///F8
//Properties of the slider
~f8slider = Slider(w, Rect(210,145,20,230))
.background_(Color(0.8,0.8,0.8,0.75))
	.value_(0.5) //is converted to 1
	.orientation_(\vertical)
	.action_({
	arg obj;
	var cf;
	cf = obj.value.linlin(0,1,0.0,2).postln;
		if(
		x.isPlaying,
		{x.set(\f8,cf)});
	~number8Box.value_(obj.value.linlin(0,1,0.0,2));
});
//Label
~f8Label = StaticText(w,Rect(210,130,20,15))
.string_("8")
.font_(Font("nil", 12))
.align_(\top)
.background_(Color(0,0,0,0.1))
.stringColor_(Color.black);
//Number box that can edit slider position
~number8Box = NumberBox(w,Rect(210,375,20,15))
.value_(1)
.clipLo_(0.0)
.clipHi_(2)
.font_(Font("nil",7))
.decimals_(2)
.align_(\center)
.action_({
	arg obj;
	~f8slider.valueAction_(obj.value.linlin(0.0,2,0,1))
});
//Number box showing harmonic frequency
~f8Box = NumberBox(w,Rect(210,390,20,15))
.value_(240*8)
.clipLo_(100)
.clipHi_(20000)
.font_(Font("nil",5))
.decimals_(1)
.align_(\center);
	// .action_({
		// arg obj;
		// ~freqslider.valueAction_(obj.value.explin(100,1000,0,1))
// });

	///F9
//Properties of the slider
~f9slider = Slider(w, Rect(230,145,20,230))
.background_(Color(0.8,0.8,0.8,0.75))
	.value_(0.5) //is converted to 1
	.orientation_(\vertical)
	.action_({
	arg obj;
	var cf;
	cf = obj.value.linlin(0,1,0.0,2).postln;
		if(
		x.isPlaying,
		{x.set(\f9,cf)});
	~number9Box.value_(obj.value.linlin(0,1,0.0,2));
});
//Label
~f9Label = StaticText(w,Rect(230,130,20,15))
.string_("9")
.font_(Font("nil", 12))
.align_(\top)
.background_(Color(0,0,0,0.1))
.stringColor_(Color.black);
//Number box that can edit slider position
~number9Box = NumberBox(w,Rect(230,375,20,15))
.value_(1)
.clipLo_(0.0)
.clipHi_(2)
.font_(Font("nil",7))
.decimals_(2)
.align_(\center)
.action_({
	arg obj;
	~f9slider.valueAction_(obj.value.linlin(0.0,2,0,1))
});
//Number box showing harmonic frequency
~f9Box = NumberBox(w,Rect(230,390,20,15))
.value_(240*9)
.clipLo_(100)
.clipHi_(20000)
.font_(Font("nil",5))
.decimals_(1)
.align_(\center);
	// .action_({
		// arg obj;
		// ~freqslider.valueAction_(obj.value.explin(100,1000,0,1))
// });

	///F10
//Properties of the slider
~f10slider = Slider(w, Rect(250,145,20,230))
.background_(Color(0.8,0.8,0.8,0.75))
	.value_(0.5) //is converted to 1
	.orientation_(\vertical)
	.action_({
	arg obj;
	var cf;
	cf = obj.value.linlin(0,1,0.0,2).postln;
		if(
		x.isPlaying,
		{x.set(\f10,cf)});
	~number10Box.value_(obj.value.linlin(0,1,0.0,2));
});
//Label
~f10Label = StaticText(w,Rect(250,130,20,15))
.string_("10")
.font_(Font("nil", 12))
.align_(\top)
.background_(Color(0,0,0,0.1))
.stringColor_(Color.black);
//Number box that can edit slider position
~number10Box = NumberBox(w,Rect(250,375,20,15))
.value_(1)
.clipLo_(0.0)
.clipHi_(2)
.font_(Font("nil",7))
.decimals_(2)
.align_(\center)
.action_({
	arg obj;
	~f10slider.valueAction_(obj.value.linlin(0.0,2,0,1))
});
//Number box showing harmonic frequency
~f10Box = NumberBox(w,Rect(250,390,20,15))
.value_(240*10)
.clipLo_(100)
.clipHi_(20000)
.font_(Font("nil",5))
.decimals_(1)
.align_(\center);
	// .action_({
		// arg obj;
		// ~freqslider.valueAction_(obj.value.explin(100,1000,0,1))
// });

	///F11
//Properties of the slider
~f11slider = Slider(w, Rect(270,145,20,230))
.background_(Color(0.8,0.8,0.8,0.75))
	.value_(0.5) //is converted to 1
	.orientation_(\vertical)
	.action_({
	arg obj;
	var cf;
	cf = obj.value.linlin(0,1,0.0,2).postln;
		if(
		x.isPlaying,
		{x.set(\f11,cf)});
	~number11Box.value_(obj.value.linlin(0,1,0.0,2));
});
//Label
~f11Label = StaticText(w,Rect(270,130,20,15))
.string_("11")
.font_(Font("nil", 12))
.align_(\top)
.background_(Color(0,0,0,0.1))
.stringColor_(Color.black);
//Number box that can edit slider position
~number11Box = NumberBox(w,Rect(270,375,20,15))
.value_(1)
.clipLo_(0.0)
.clipHi_(2)
.font_(Font("nil",7))
.decimals_(2)
.align_(\center)
.action_({
	arg obj;
	~f11slider.valueAction_(obj.value.linlin(0.0,2,0,1))
});
//Number box showing harmonic frequency
~f11Box = NumberBox(w,Rect(270,390,20,15))
.value_(240*11)
.clipLo_(100)
.clipHi_(20000)
.font_(Font("nil",5))
.decimals_(1)
.align_(\center);
	// .action_({
		// arg obj;
		// ~freqslider.valueAction_(obj.value.explin(100,1000,0,1))
// });

	///F12
//Properties of the slider
~f12slider = Slider(w, Rect(290,145,20,230))
.background_(Color(0.8,0.8,0.8,0.75))
	.value_(0.5) //is converted to 1
	.orientation_(\vertical)
	.action_({
	arg obj;
	var cf;
	cf = obj.value.linlin(0,1,0.0,2).postln;
		if(
		x.isPlaying,
		{x.set(\f12,cf)});
	~number12Box.value_(obj.value.linlin(0,1,0.0,2));
});
//Label
~f12Label = StaticText(w,Rect(290,130,20,15))
.string_("12")
.font_(Font("nil", 12))
.align_(\top)
.background_(Color(0,0,0,0.1))
.stringColor_(Color.black);
//Number box that can edit slider position
~number12Box = NumberBox(w,Rect(290,375,20,15))
.value_(1)
.clipLo_(0.0)
.clipHi_(2)
.font_(Font("nil",7))
.decimals_(2)
.align_(\center)
.action_({
	arg obj;
	~f12slider.valueAction_(obj.value.linlin(0.0,2,0,1))
});
//Number box showing harmonic frequency
~f12Box = NumberBox(w,Rect(290,390,20,15))
.value_(240*12)
.clipLo_(100)
.clipHi_(20000)
.font_(Font("nil",5))
.decimals_(1)
.align_(\center);
	// .action_({
		// arg obj;
		// ~freqslider.valueAction_(obj.value.explin(100,1000,0,1))
// });

	///F13
//Properties of the slider
~f13slider = Slider(w, Rect(310,145,20,230))
.background_(Color(0.8,0.8,0.8,0.75))
	.value_(0.5) //is converted to 1
	.orientation_(\vertical)
	.action_({
	arg obj;
	var cf;
	cf = obj.value.linlin(0,1,0.0,2).postln;
		if(
		x.isPlaying,
		{x.set(\f13,cf)});
	~number13Box.value_(obj.value.linlin(0,1,0.0,2));
});
//Label
~f13Label = StaticText(w,Rect(310,130,20,15))
.string_("13")
.font_(Font("nil", 12))
.align_(\top)
.background_(Color(0,0,0,0.1))
.stringColor_(Color.black);
//Number box that can edit slider position
~number13Box = NumberBox(w,Rect(310,375,20,15))
.value_(1)
.clipLo_(0.0)
.clipHi_(2)
.font_(Font("nil",7))
.decimals_(2)
.align_(\center)
.action_({
	arg obj;
	~f13slider.valueAction_(obj.value.linlin(0.0,2,0,1))
});
//Number box showing harmonic frequency
~f13Box = NumberBox(w,Rect(310,390,20,15))
.value_(240*13)
.clipLo_(100)
.clipHi_(20000)
.font_(Font("nil",5))
.decimals_(1)
.align_(\center);
	// .action_({
		// arg obj;
		// ~freqslider.valueAction_(obj.value.explin(100,1000,0,1))
// });

	///F14
//Properties of the slider
~f14slider = Slider(w, Rect(330,145,20,230))
.background_(Color(0.8,0.8,0.8,0.75))
	.value_(0.5) //is converted to 1
	.orientation_(\vertical)
	.action_({
	arg obj;
	var cf;
	cf = obj.value.linlin(0,1,0.0,2).postln;
		if(
		x.isPlaying,
		{x.set(\f14,cf)});
	~number14Box.value_(obj.value.linlin(0,1,0.0,2));
});
//Label
~f14Label = StaticText(w,Rect(330,130,20,15))
.string_("14")
.font_(Font("nil", 12))
.align_(\top)
.background_(Color(0,0,0,0.1))
.stringColor_(Color.black);
//Number box that can edit slider position
~number14Box = NumberBox(w,Rect(330,375,20,15))
.value_(1)
.clipLo_(0.0)
.clipHi_(2)
.font_(Font("nil",7))
.decimals_(2)
.align_(\center)
.action_({
	arg obj;
	~f14slider.valueAction_(obj.value.linlin(0.0,2,0,1))
});
//Number box showing harmonic frequency
~f14Box = NumberBox(w,Rect(330,390,20,15))
.value_(240*14)
.clipLo_(100)
.clipHi_(20000)
.font_(Font("nil",5))
.decimals_(1)
.align_(\center);
	// .action_({
		// arg obj;
		// ~freqslider.valueAction_(obj.value.explin(100,1000,0,1))
// });

	///F15
//Properties of the slider
~f15slider = Slider(w, Rect(350,145,20,230))
.background_(Color(0.8,0.8,0.8,0.75))
	.value_(0.5) //is converted to 1
	.orientation_(\vertical)
	.action_({
	arg obj;
	var cf;
	cf = obj.value.linlin(0,1,0.0,2).postln;
		if(
		x.isPlaying,
		{x.set(\f15,cf)});
	~number15Box.value_(obj.value.linlin(0,1,0.0,2));
});
//Label
~f15Label = StaticText(w,Rect(350,130,20,15))
.string_("15")
.font_(Font("nil", 12))
.align_(\top)
.background_(Color(0,0,0,0.1))
.stringColor_(Color.black);
//Number box that can edit slider position
~number15Box = NumberBox(w,Rect(350,375,20,15))
.value_(1)
.clipLo_(0.0)
.clipHi_(2)
.font_(Font("nil",7))
.decimals_(2)
.align_(\center)
.action_({
	arg obj;
	~f15slider.valueAction_(obj.value.linlin(0.0,2,0,1))
});
//Number box showing harmonic frequency
~f15Box = NumberBox(w,Rect(350,390,20,15))
.value_(240*15)
.clipLo_(100)
.clipHi_(20000)
.font_(Font("nil",5))
.decimals_(1)
.align_(\center);
	// .action_({
		// arg obj;
		// ~freqslider.valueAction_(obj.value.explin(100,1000,0,1))
// });

	///F16
//Properties of the slider
~f16slider = Slider(w, Rect(370,145,20,230))
.background_(Color(0.8,0.8,0.8,0.75))
	.value_(0.5) //is converted to 1
	.orientation_(\vertical)
	.action_({
	arg obj;
	var cf;
	cf = obj.value.linlin(0,1,0.0,2).postln;
		if(
		x.isPlaying,
		{x.set(\f16,cf)});
	~number16Box.value_(obj.value.linlin(0,1,0.0,2));
});
//Label
~f16Label = StaticText(w,Rect(370,130,20,15))
.string_("16")
.font_(Font("nil", 12))
.align_(\top)
.background_(Color(0,0,0,0.1))
.stringColor_(Color.black);
//Number box that can edit slider position
~number16Box = NumberBox(w,Rect(370,375,20,15))
.value_(1)
.clipLo_(0.0)
.clipHi_(2)
.font_(Font("nil",7))
.decimals_(2)
.align_(\center)
.action_({
	arg obj;
	~f16slider.valueAction_(obj.value.linlin(0.0,2,0,1))
});
//Number box showing harmonic frequency
~f16Box = NumberBox(w,Rect(370,390,20,15))
.value_(240*16)
.clipLo_(100)
.clipHi_(20000)
.font_(Font("nil",5))
.decimals_(1)
.align_(\center);
	// .action_({
		// arg obj;
		// ~freqslider.valueAction_(obj.value.explin(100,1000,0,1))
// });

	);



w.onClose_({s.quit; s.freeAll});

	})
)

~harmonic_sums.postln
~intensity_array.postln
~intensity_array[0]=0.01
~sum.postln
Array.newFrom(Set~sum)
~intensity_array[0].postln
~sound_frequencies.postln



////OLD
Array.with()


Array.with(7, 'eight',  9).postln;


~piano = Array.fill(36, { arg i; i * 0 });
~fund=99

~fund=3
~piano[~fund]=0.5;




~piano[~fund+12]=~slider1.value;
~piano[~fund+19]=0.125;
~piano[~fund+24]=0.025;

~harmonics=Array.with(12,19,24,29,33)
~harmonics[2]
~harmonicIndex=2
~pianoIndex=~fund+~harmonics[~harmonicIndex-1]

~pianoIndex=~fund+~harmonics[~harmonicIndex-1]=0

~pianoIndex
~piano[~pianoIndex]=0.2323

////////

~harmonics = Array.fill(16, {arg i; i*0}); //global array of 16 values, all 0
~harmonics[~slider_select.value.linlin(0,1,1,16)-1]=1

~edit = Array.fill(16, {arg i; i*0});
~edit[5..8]=5
~harmonics[6]=2

~multiplier = ~harmonics*~edit

~harmonics_array.postln


CompositeView

