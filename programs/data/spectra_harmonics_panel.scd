(

~harmonics_panel = Array.fill(16, { arg i; i+1 });

~harmonics_panel.do({ arg item, i;

	~embed = "data/spectra_harmonics_panel_hover_enter.scd";

	~gui_embed = "data/spectra_keyboard_GUI_colours.scd";

	~empty = " ";

//	~hovertext = "Change the heights of these sliders to modify the relative intensities of each harmonic";

// Compile it as a single function which is the executed, which finally sets the global variable names with their respective sliders
	(
		"~f"++item++"slider" + "=" + "Slider(w, Rect(" ++ i ++ "*20+70,145-~allShiftUp,20,230))"
		++
		"
.background_(Color(0.8,0.8,0.8,0.75))
.value_(0.5)
.mouseOverAction_({

if(~inspectorExists == 1, {
~inspectorText.string_(" ++ ("Change the heights of these sliders to modify the relative intensities of each harmonic").asCompileString ++ ")
});

		~slider_hover =" + item
		++
		"; ~inspectorHarmonicsPanelUpdate.value;
//(~trace.asString +/+ " ++ ~embed.asCompileString ++ ").load;

if(~harmonic_in_effect != nil, {
~harmonic_in_effect.interpret.background_(Color.grey(0.7));
});

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


~setToCustomFunction.value;

~freqslider.valueAction_(~freqslider.value); // Work-around for updating



});
"
		+
"
~f" ++ item ++ "Label = StaticText(w,Rect(" ++ i ++ "*20+70,130-~allShiftUp,20,15))
.string_(" ++ item.asCompileString ++")
.font_(Font(" ++ nil.asCompileString ++ ", 12))
.align_(" ++ "\\" ++ "top)
.background_(Color(0,0,0,0.1))
.stringColor_(Color.black);

"
	).interpret;
});
);