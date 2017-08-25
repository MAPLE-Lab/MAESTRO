~oscilloscopeButtonFunction = {
arg obj;

		if(obj.value == 1, {
				~oscilloscope1 = ~w2 = Window.new("Oscilloscope", Rect.new(
	w.bounds.left+w.bounds.width+5,
	w.bounds.top+325,
		250,250),false).background_(Color.white).userCanClose_(true).front
		.acceptsMouseOver_(true);


		~stethoscope1 = ~d = Stethoscope.new(s, 1,view:~w2, zoom:2) //.scope//nil causes it to open in its own window
				// .xZoom_(5) //is only setting slider, isn't changing view properly
				// .cycle_(50) //same problem as xZoom: workaround, use a button for 440Hz
				.yZoom_(4);

		//Implements the hovertext for the inspector window
		StaticText(~oscilloscope1, Rect(0,0,230,230)).mouseOverAction_({
	if(~inspectorExists == 1, {
		~inspectorText.string_(TabFileReader.read(~trace +/+  "paragraphs/mini-modules/oscilloscopeInspector.txt").flatten.join.asString)
});})
.mouseLeaveAction_({
	if(~inspectorExists == 1, {
		~inspectorText.string_(" ")
});});

		~oscilloscope1Top = StaticText(~oscilloscope1, Rect(0,0,250,28)).background_(Color.white).string_("Oscilloscope").align_(\center);

		if(~module_ID == "synthesizer", {
			Button(~oscilloscope1, Rect(150,4, 90, 20)).states_([["Scale to ~H1", Color.black, Color.grey]]).action_({
				~stethoscope1.cycle_(5*44100/~freq1.value);
			});
			~oscilloscope1Top.string_("          Oscilloscope").align_(\left);
		});

				~oscilloscope2 = Window.new("Waveform", Rect.new(
	w.bounds.left+w.bounds.width+5,
	w.bounds.top+10,
		250,250),false).background_(Color.white).userCanClose_(true).front
		.acceptsMouseOver_(true);

		~stethoscope2 = Stethoscope.new(s, 1,view:~oscilloscope2, zoom:0.1) //.scope//nil causes it to open in its own window
				// .xZoom_(5) //is only setting slider, isn't changing view properly
				// .cycle_(50) //same problem as xZoom: workaround, use a button for 440Hz
				.yZoom_(4);


		//Implements the hovertext for the inspector window
		StaticText(~oscilloscope2, Rect(0,0,230,230)).mouseOverAction_({
	if(~inspectorExists == 1, {
		~inspectorText.string_(TabFileReader.read(~trace +/+  "paragraphs/mini-modules/waveformInspector.txt").flatten.join.asString)
});})
.mouseLeaveAction_({
	if(~inspectorExists == 1, {
		~inspectorText.string_(" ")
});});


				~oscilloscope2Top = StaticText(~oscilloscope2, Rect(0,0,250,28)).background_(Color.white).string_("Waveform").align_(\center);


		},{
			~oscilloscope1.close;
			~oscilloscope2.close;
		});
};

~oscilloscopeCloseFunction = {
	~oscilloscope1.close;
	~oscilloscope2.close;
};