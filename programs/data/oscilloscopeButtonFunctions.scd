~oscilloscopeButtonFunction = {
arg obj;

		if(obj.value == 1, {
				~oscilloscope1 = ~w2 = Window.new("Oscilloscope", Rect.new(
<<<<<<< HEAD
	w.bounds.left+w.bounds.width+29,
=======
	w.bounds.left+w.bounds.width,
>>>>>>> b65f3eb83bd1defa69283b8e359090cf0d25d1bf
	w.bounds.top+325,
		250,250),false).background_(Color.white).userCanClose_(true).front;

		~stethoscope1 = ~d = Stethoscope.new(s, 1,view:~w2, zoom:2) //.scope//nil causes it to open in its own window
				// .xZoom_(5) //is only setting slider, isn't changing view properly
				// .cycle_(50) //same problem as xZoom: workaround, use a button for 440Hz
				.yZoom_(4);

		~oscilloscope1Top = StaticText(~oscilloscope1, Rect(0,0,250,28)).background_(Color.white).string_("Oscilloscope").align_(\center);

				~oscilloscope2 = Window.new("Waveform", Rect.new(
<<<<<<< HEAD
	w.bounds.left+w.bounds.width+29,
	w.bounds.top+30,
=======
	w.bounds.left+w.bounds.width,
	w.bounds.top+25,
>>>>>>> b65f3eb83bd1defa69283b8e359090cf0d25d1bf
		250,250),false).background_(Color.white).userCanClose_(true).front;

		~stethoscope2 = Stethoscope.new(s, 1,view:~oscilloscope2, zoom:0.1) //.scope//nil causes it to open in its own window
				// .xZoom_(5) //is only setting slider, isn't changing view properly
				// .cycle_(50) //same problem as xZoom: workaround, use a button for 440Hz
				.yZoom_(4);

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