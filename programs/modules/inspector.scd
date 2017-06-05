(
~inspectorWindow =
Window.new(
	"Inspector",
	Rect(
		/*Window.screenBounds.width/2-150*/0,
		Window.screenBounds.height/2-150+0,
		300,
		200),
	false)
.front
.background_(Color.grey(0.85));

~inspectorExists = 1;

~internalText_WIP = StaticText(~inspectorWindow,Rect(10,15,280,280))
	.string_("
WIP Version 2017-06-05-0200
Towards: Pre-release v0.1.3-beta
")
.font_(Font("Helvetica", 12, false, true))
.align_(\topLeft)
.background_(Color(1,1,1,0))
.stringColor_(Color(0.2510,0.2510,0.2510,1));

~internalText_Title = StaticText(~inspectorWindow,Rect(10,10,280,280))
.string_("Inspector")
.font_(Font("Helvetica", 14, true))
.align_(\topLeft)
.background_(Color(1,1,1,0))
.stringColor_(Color(0.2510,0.2510,0.2510,1));

~inspectorText = StaticText(~inspectorWindow,Rect(10,70,280,210))
.string_("Hover over an object to get information.")
.font_(Font("Helvetica", 12, false))
.align_(\topLeft)
.background_(Color(1,1,1,0))
.stringColor_(Color(0.2510,0.2510,0.2510,1));

~inspectorError = StaticText(~inspectorWindow,Rect(10,140,280,210))
.string_("Errors posted here.")
.font_(Font("Helvetica", 12, false, true))
.align_(\topLeft)
.background_(Color(1,1,1,0))
.stringColor_(Color(0.8,0,0,1));

(
// CompositeView for the SPECTRA Harmonics Panel
~inspectorHarmonicsPanel =
CompositeView(~inspectorWindow, Rect(10, 60, 280, 70)).background_(Color.grey(0.85));

~inspectorHarmonicsPanel.bounds_(Rect(10+300, 60, 280, 70));


~inspectorHarmonicsPanel_harmonic_text =
StaticText(~inspectorHarmonicsPanel, Rect(0,0,150,15))
.string_("Harmonic Number:")
.font_(Font("Helvetica", 12, false))
.align_(\left);

~inspectorHarmonicsPanel_harmonic_number =
NumberBox(~inspectorHarmonicsPanel, Rect(105,0,30,15))
.font_(Font("Helvetica", 11))
.align_(\center);


~inspectorHarmonicsPanel_pitch_text =
StaticText(~inspectorHarmonicsPanel, Rect(0,0+15,150,15))
.string_("Pitch Name:")
.font_(Font("Helvetica", 12, false))
.align_(\left);

~inspectorHarmonicsPanel_pitch_number =
StaticText(~inspectorHarmonicsPanel, Rect(105,0+15,30,15))
.font_(Font("Helvetica", 11))
.align_(\center)
.string_(~note_name.string)
.background_(Color.white);


~inspectorHarmonicsPanel_frequency_text =
StaticText(~inspectorHarmonicsPanel, Rect(0,30,150,15))
.string_("Frequency (Hz):")
.font_(Font("Helvetica", 12, false))
.align_(\left);

~inspectorHarmonicsPanel_frequency_number =
NumberBox(~inspectorHarmonicsPanel, Rect(105,30,30,15))
.font_(Font("Helvetica", 11))
.align_(\center);


~inspectorHarmonicsPanel_intensity_text =
StaticText(~inspectorHarmonicsPanel, Rect(0,45,150,15))
.string_("Intensity:")
.font_(Font("Helvetica", 12, false))
.align_(\left);

~inspectorHarmonicsPanel_intensity_number =
NumberBox(~inspectorHarmonicsPanel, Rect(105,45,30,15))
.font_(Font("Helvetica", 11))
.align_(\center);






);




);


//Add the following code after the variable name of any object, but edit the section worded TEXTHERE:
/*
.mouseOverAction_({
	if(~inspectorExists == 1, {
		~inspectorText.string_("TEXTHERE")
});})
.mouseLeaveAction_({
	if(~inspectorExists == 1, {
		~inspectorText.string_(" ")
});});
*/

//For error messages, replace ERRORHERE:
/*
if(~inspectorExists == 1, {
								~inspectorError.string_("ERRORHERE");
							});
*/