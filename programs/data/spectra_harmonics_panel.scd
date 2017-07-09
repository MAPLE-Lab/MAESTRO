(
~harmonics_panel = Array.fill(16, { arg i; i+1 });

~harmonics_panel.do({ arg item, i;

	~embed = "data/spectra_harmonics_panel_hover_enter.scd";

	~gui_embed = "data/spectra_keyboard_GUI_colours.scd";

	~empty = " ";

// Compile it as a single function which is the executed, which finally sets the global variable names with their respective sliders
	(
		"~f"++item++"slider" + "=" + "Slider(w, Rect(" ++ i ++ "*20+70,145,20,230))"
		++
		"
.background_(Color(0.8,0.8,0.8,0.75))
.value_(0.5)
.mouseOverAction_({
		~slider_hover =" + item
		++
		"; ~inspectorHarmonicsPanelUpdate.value;
//(~trace.asString +/+ " ++ ~embed.asCompileString ++ ").load;
})
.mouseLeaveAction_({
	if(~inspectorExists == 1, {
~inspectorText.string_(" ++ ~empty.asCompileString ++ ");
		// ~inspectorHarmonicsPanel.bounds_(Rect(10+300, 60, 280, 70));
});})
	.action_({
	arg obj;
	var cf;
	cf = obj.value.linlin(0,1,0.0,2); //.postln;
		if(
		x.isPlaying,
{x.set("
		++ "\\" ++ "f" ++ item ++
",cf)});

//(~trace.asString +/+  " ++ ~embed.asCompileString ++").load;
~inspectorHarmonicsPanelUpdate.value; // Replaces the previous .load line, could reduce CPU load

// (~trace.asString +/+  " ++ ~gui_embed.asCompileString ++ ").load.postln; // Not sure yet why this does not auto-update

~freqslider.valueAction_(~freqslider.value); // Work-around for updating

});
"
		+
"
~f" ++ item ++ "Label = StaticText(w,Rect(" ++ i ++ "*20+70,130,20,15))
.string_(" ++ item.asCompileString ++")
.font_(Font(" ++ nil.asCompileString ++ ", 12))
.align_(" ++ "\\" ++ "top)
.background_(Color(0,0,0,0.1))
.stringColor_(Color.black);
"
	).interpret;
});
);

/*
(
var basePath = thisProcess.nowExecutingPath.asString.dirname;

///F1
//Properties of the slider
~f1slider = Slider(w, Rect(70,145,20,230))
.background_(Color(0.8,0.8,0.8,0.75))
	.value_(0.5) //is converted to 1

.mouseOverAction_({
	if(~inspectorExists == 1, {
~slider_hover = 1;
(basePath +/+  "spectra_harmonics_panel_hover_enter.scd").load;
});})
.mouseLeaveAction_({
	if(~inspectorExists == 1, {
		~inspectorText.string_(" ");
		~inspectorHarmonicsPanel.bounds_(Rect(10+300, 60, 280, 70));
});})
	.action_({
	arg obj;
	var cf;
	cf = obj.value.linlin(0,1,0.0,2).postln;
		if(
		x.isPlaying,
		{x.set(\f1,cf)});

(basePath +/+  "spectra_harmonics_panel_hover_enter.scd").load;


//s.makeBundle(1.0, //sound delay
	//		{~dirtyBit = 5; ~dirtyBit.postln;~freqslider.valueAction_(~fslider.value);});

});
//Label
~f1Label = StaticText(w,Rect(70,130,20,15))
.string_("1")
.font_(Font("nil", 12))
.align_(\top)
.background_(Color(0,0,0,0.1))
.stringColor_(Color.black);

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
	//~number2Box.value_(obj.value.linlin(0,1,0.0,2));
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
	//~number3Box.value_(obj.value.linlin(0,1,0.0,2));
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
	//~number4Box.value_(obj.value.linlin(0,1,0.0,2));
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
	//~number5Box.value_(obj.value.linlin(0,1,0.0,2));
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
	//~number6Box.value_(obj.value.linlin(0,1,0.0,2));
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
	//~number7Box.value_(obj.value.linlin(0,1,0.0,2));
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
	//~number8Box.value_(obj.value.linlin(0,1,0.0,2));
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
	//~number9Box.value_(obj.value.linlin(0,1,0.0,2));
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
	//~number10Box.value_(obj.value.linlin(0,1,0.0,2));
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
	//~number11Box.value_(obj.value.linlin(0,1,0.0,2));
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
	//~number12Box.value_(obj.value.linlin(0,1,0.0,2));
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
	//~number13Box.value_(obj.value.linlin(0,1,0.0,2));
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
	//~number14Box.value_(obj.value.linlin(0,1,0.0,2));
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
	//~number15Box.value_(obj.value.linlin(0,1,0.0,2));
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
	//~number16Box.value_(obj.value.linlin(0,1,0.0,2));
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
)
*/