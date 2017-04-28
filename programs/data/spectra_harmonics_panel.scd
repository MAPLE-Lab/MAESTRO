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
		~freqslider.valueAction_(~fslider.value); //This allows it to refresh real-time

s.makeBundle(1.0, //sound delay
			{~dirtyBit = 5; ~dirtyBit.postln;~freqslider.valueAction_(~fslider.value);});
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
		~freqslider.valueAction_(~fslider.value); //This allows it to refresh real-time
s.makeBundle(1.0, //sound delay
			{~dirtyBit = 5; ~dirtyBit.postln;~freqslider.valueAction_(~fslider.value);});
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
		~freqslider.valueAction_(~fslider.value); //This allows it to refresh real-time
s.makeBundle(1.0, //sound delay
			{~dirtyBit = 5; ~dirtyBit.postln;~freqslider.valueAction_(~fslider.value);});
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
		~freqslider.valueAction_(~fslider.value); //This allows it to refresh real-time
s.makeBundle(1.0, //sound delay
			{~dirtyBit = 5; ~dirtyBit.postln;~freqslider.valueAction_(~fslider.value);});
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
		~freqslider.valueAction_(~fslider.value); //This allows it to refresh real-time
s.makeBundle(1.0, //sound delay
			{~dirtyBit = 5; ~dirtyBit.postln;~freqslider.valueAction_(~fslider.value);});
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
		~freqslider.valueAction_(~fslider.value); //This allows it to refresh real-time
s.makeBundle(1.0, //sound delay
			{~dirtyBit = 5; ~dirtyBit.postln;~freqslider.valueAction_(~fslider.value);});
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
		~freqslider.valueAction_(~fslider.value); //This allows it to refresh real-time
s.makeBundle(1.0, //sound delay
			{~dirtyBit = 5; ~dirtyBit.postln;~freqslider.valueAction_(~fslider.value);});
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
		~freqslider.valueAction_(~fslider.value); //This allows it to refresh real-time
s.makeBundle(1.0, //sound delay
			{~dirtyBit = 5; ~dirtyBit.postln;~freqslider.valueAction_(~fslider.value);});
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
		~freqslider.valueAction_(~fslider.value); //This allows it to refresh real-time
s.makeBundle(1.0, //sound delay
			{~dirtyBit = 5; ~dirtyBit.postln;~freqslider.valueAction_(~fslider.value);});
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
		~freqslider.valueAction_(~fslider.value); //This allows it to refresh real-time
s.makeBundle(1.0, //sound delay
			{~dirtyBit = 5; ~dirtyBit.postln;~freqslider.valueAction_(~fslider.value);});
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
		~freqslider.valueAction_(~fslider.value); //This allows it to refresh real-time
s.makeBundle(1.0, //sound delay
			{~dirtyBit = 5; ~dirtyBit.postln;~freqslider.valueAction_(~fslider.value);});
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
		~freqslider.valueAction_(~fslider.value); //This allows it to refresh real-time
s.makeBundle(1.0, //sound delay
			{~dirtyBit = 5; ~dirtyBit.postln;~freqslider.valueAction_(~fslider.value);});
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
		~freqslider.valueAction_(~fslider.value); //This allows it to refresh real-time
s.makeBundle(1.0, //sound delay
			{~dirtyBit = 5; ~dirtyBit.postln;~freqslider.valueAction_(~fslider.value);});
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
		~freqslider.valueAction_(~fslider.value); //This allows it to refresh real-time
s.makeBundle(1.0, //sound delay
			{~dirtyBit = 5; ~dirtyBit.postln;~freqslider.valueAction_(~fslider.value);});
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
		~freqslider.valueAction_(~fslider.value); //This allows it to refresh real-time
s.makeBundle(1.0, //sound delay
			{~dirtyBit = 5; ~dirtyBit.postln;~freqslider.valueAction_(~fslider.value);});
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
		~freqslider.valueAction_(~fslider.value); //This allows it to refresh real-time
s.makeBundle(1.0, //sound delay
			{~dirtyBit = 5; ~dirtyBit.postln;~freqslider.valueAction_(~fslider.value);});
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