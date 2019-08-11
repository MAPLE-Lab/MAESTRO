(
~inspectorWindow =
Window.new(
	"Inspector",
	Rect(
		w.bounds.left-235-10,
		w.bounds.top-202,
		235,
		w.bounds.height + 14 + 210),
	TabFileReader.read(~trace +/+  "admin/access.txt").[4].[2].interpret)
.front
.background_(Color.grey(0.85));

if(~module_ID != "spectra", {~inspectorWindow.bounds_(Rect(
	w.bounds.left-235-10,
		w.bounds.top,
	235/*+400*/,
	w.bounds.height)
)});

~inspectorExists = 1;

~internalText_WIP = StaticText(~inspectorWindow,Rect(10,15,280,280))
	.string_("

Release v1.0
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


~inspectorText = StaticText(~inspectorWindow,Rect(10,70+120+30+40,215/*280*/,210))
.string_("Hover over an object to get information.")
.font_(Font("Helvetica", 12, false))
.align_(\topLeft)
.background_(Color(1,1,1,0))
.stringColor_(Color(0.2510,0.2510,0.2510,1));


~inspectorModuleParagraph = StaticText(~inspectorWindow,Rect(10,70,215/*280*/,210))
.string_(~para.string)
.font_(Font("Helvetica", 12, true,usePointSize:true))
.align_(\topLeft)
.background_(Color(1,1,1,0))
.stringColor_(Color(0.2510,0.2510,0.2510,1));

 ~inspectorError = StaticText(~inspectorWindow,Rect(10+500,140,280,210)) // +500 to move out of view; exists to avoid code problems
 .string_("Errors posted here.")
 .font_(Font("Helvetica", 12, false, true))
 .align_(\topLeft)
 .background_(Color(1,1,1,0))
 .stringColor_(Color(0.8,0,0,1));

/*( // Moved to SPECTRA directly under the panel
// CompositeView for the SPECTRA Harmonics Panel
~inspectorHarmonicsPanel =
CompositeView(~inspectorWindow, Rect(10, 60, 280, 70)).background_(Color.grey(0.85));

~inspectorHarmonicsPanel.bounds_(Rect(10+300, 60, 280, 70));


~inspectorHarmonicsPanel_harmonic_text =
StaticText(~inspectorHarmonicsPanel, Rect(0,0,60,15))
.string_("Harmonic:")
.font_(Font("Helvetica", 12, false))
.align_(\left);

~inspectorHarmonicsPanel_harmonic_number =
NumberBox(~inspectorHarmonicsPanel, Rect(55,0,20,15))
.font_(Font("Helvetica", 11))
.align_(\center)
.background_(Color.grey(0.8));


~inspectorHarmonicsPanel_pitch_text =
StaticText(~inspectorHarmonicsPanel, Rect(90,0,60,15))
.string_("Pitch:")
.font_(Font("Helvetica", 12, false))
.align_(\left);

~inspectorHarmonicsPanel_pitch_number =
StaticText(~inspectorHarmonicsPanel, Rect(120,0,25,15))
.font_(Font("Helvetica", 11))
.align_(\center)
.string_(~note_name.string)
.background_(Color.white)
.background_(Color.grey(0.8));


~inspectorHarmonicsPanel_frequency_text =
StaticText(~inspectorHarmonicsPanel, Rect(165,0,60,15))
.string_("Freq.:")
.font_(Font("Helvetica", 12, false))
.align_(\left);

~inspectorHarmonicsPanel_frequency_number =
NumberBox(~inspectorHarmonicsPanel, Rect(197,0,55,15))
.font_(Font("Helvetica", 11))
.align_(\center)
.decimals_(2)
.background_(Color.grey(0.8));


~inspectorHarmonicsPanel_intensity_text =
StaticText(~inspectorHarmonicsPanel, Rect(0,20,50,15))
.string_("Intensity:")
.font_(Font("Helvetica", 12, false))
.align_(\left);

~inspectorHarmonicsPanel_intensity_number =
NumberBox(~inspectorHarmonicsPanel, Rect(50,20,50,15))
.font_(Font("Helvetica", 11))
.align_(\center)
.maxDecimals_(4)
.background_(Color.grey(0.8));
);*/

~inspectorWindow.onClose_({
	~inspector.valueAction_(0); //Oddly, using valueAction instead of value loads the window opening faster
	~inspectorExists = 0;
});


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
