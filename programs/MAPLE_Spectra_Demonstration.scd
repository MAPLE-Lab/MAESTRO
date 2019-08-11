//SPECTRA Module
(
//Provides code shorthand to call files in same or sub-folders.
var basePath = thisProcess.nowExecutingPath.asString.dirname;
~trace = basePath.asString;

//Ensure all other windows are closed
Window.closeAll;

//Opens the module only once the server is working completely
s.waitForBoot({

//Clear all nodes in the server
s.freeAll;

//Avoids delay when the Recording button is pressed
// s.prepareForRecord;


	// Title and labels
	// ~masterTitle = StaticText(w, Rect(0,0,800,40)).string_("Spectra").align_(\center).font_(Font(nil, 14, true));
~allShiftUp = 60;
	~expandWidth = 25;

//Creates the new window with title
w = Window.new("MAPLE Lab Spectra Demonstration", Rect.new(
	Window.screenBounds.width/2-400,
	Window.screenBounds.height/2-50,
	800+~expandWidth,570-~allShiftUp),TabFileReader.read(~trace +/+  "admin/access.txt").[4].[2].interpret)
	.background_(Color.white)
	.userCanClose_(false)
	.front
	.acceptsMouseOver_(true);

//ID Parameters
~module_ID = "spectra";
~inspectorExists = 0;

//Dirty bit used in GUI updating sync
~dirtyBit = 0;

//Spectra
(
//Spectra parameters:
~spectraScreenComposite_bounds_array = [410+~expandWidth,105-~allShiftUp,380,300];
~spectraButton_bounds_array = [690-40+~expandWidth, 112.5+40-~allShiftUp-20, 120, 20];
~spectraAutoscale_bounds_array = [690-40+~expandWidth, 112.5+40+20-~allShiftUp-20, 120, 20];
		~temporaryDisableAutoscale = 0;

//Load the spectra now that all the above parameters have been set:
(basePath +/+  "modules/spectra_screen.scd").load;
);

// Load Spectra-specific functions
	(basePath +/+  "data/spectra_specific_data/spectra_button_functions.scd").load; // Button controls
	(basePath +/+  "data/spectra_specific_data/spectra_harmonic_slider_functions.scd").load; // Shortcut to setting intensities
	(basePath +/+  "data/spectra_harmonics_panel_hover_enter.scd").load; // Load the function for updating the information panel below the harmonics panel
	~lowerButtons = 40; // For Button heights
	(basePath +/+  "data/spectra_specific_data/spectra_set_to_custom_functions.scd").load; // Any change from a preset goes to Custom name
		(~trace +/+  "data/oscilloscopeButtonFunctions.scd").load; // Load the oscilloscope button functions
	(~trace +/+  "data/spectra_specific_data/buffer_and_synthdef_create_functions.scd").load; // Load the oscilloscope button functions
(~trace +/+  "data/readTextFileFunction.scd").load; // Load the text reader function


//Label for paragraph
~para = StaticText(w,Rect(10,10-500,790-50,1)) // Moved because was blocking View Mode button for spectra
	.string_(~readTextFileFunction.value(path:"spectra/spectraIntro.txt"))
.font_(Font("nil", 12))
.align_(\topLeft)
.background_(Color(0,0,0,0))
.stringColor_(Color.clear); // Now shown in inspector

/*
	//HIDE SPECTRA EDGES
//Left cheap box
StaticText(w,Rect(0,105,410,300-290))
.background_(Color.blue);

//Right cheap box
StaticText(w,Rect(790,105+100,410,300-100))
.background_(Color.yellow);

	//Harmonics cheap box
StaticText(w,Rect(10,105,380,25))
.background_(Color(0,0,0,0.0));
	*/

//Aesthetic lines
//Button CompositeViews for hiding and showing
	(
		~play_image_left = Image.new(basePath +/+ "images/big_button_media/red_left.png");
		~play_image_right = Image.new(basePath +/+ "images/big_button_media/red_right.png");
		~play_image_indent = Image.new(basePath +/+ "images/big_button_media/red_indent_col.png");

		~stop_image_left = Image.new(basePath +/+ "images/big_button_media/black_left.png");
		~stop_image_right = Image.new(basePath +/+ "images/big_button_media/black_right.png");
		~stop_image_indent = Image.new(basePath +/+ "images/big_button_media/black_indent_col.png");

		~play_UserView = UserView(w, Rect(400-(100/2)-92,65-~allShiftUp,192,30));
		~play_UserView.drawFunc_({
			~play_image_left.drawInRect(Rect(0,0,100,30), Rect(0,0,200,60), 2, 1.0);
			~play_image_right.drawInRect(Rect(35,0,100,30), Rect(0,0,200,60), 2, 1.0);
			~play_image_indent.drawInRect(Rect(67,0,100,30), Rect(0,0,200,60), 2, 1.0);
		});

		~stop_UserView = UserView(w, Rect(400-(100/2)-92,65-~allShiftUp,192,30));
		~stop_UserView.drawFunc_({
			~stop_image_left.drawInRect(Rect(0,0,100,30), Rect(0,0,200,60), 2, 1.0);
			~stop_image_right.drawInRect(Rect(35,0,100,30), Rect(0,0,200,60), 2, 1.0);
			~stop_image_indent.drawInRect(Rect(67,0,100,30), Rect(0,0,200,60), 2, 1.0);
		});

		//~play_UserView.bounds_(Rect(400-(100/2),65,1,1)); //Hide the play button
		~stop_UserView.bounds_(Rect(400-(100/2)-92,65-~allShiftUp,1,1)); //Hide the stop button
	);

//Update June 2019 Patch for 3.10.2
	~fslider = 0.5632183908046; //~freqslider.value = 0.5632183908046; // This makes sure ~fslider exists and starts at Bb4, and that ~freqslider starts with the same value to allow for future updating to work (but this has been commented out as ~freqslider does not yet exist), so this must be added later
	//End of Update June 2019 Patch for 3.10.2
//Play Forced sounds button
~button = Button(w, Rect(400-(100/2)-92,65-~allShiftUp,100+35,30))
.states_([
		[" ", Color.white, Color.clear], //Color(0.7569,0.1373,0.1725,1)],
	[" ", Color.white, Color.clear] // Color.grey(0.251)]
])
.font_(Font("nil", 18))
.action_({
	arg obj;
	if(obj.value == 1,
		{//Update June 2019 Patch for 3.10.2
				~fslider = ~freqslider.value; // This updates ~fslider value to the on-screen value, if the user has moved the slider, as the screen slider is ~freqslider, and then this allows updating for all current ~freqslider.valueAction_(~fslider.value) functions.
	//End of Update June 2019 Patch for 3.10.2

				~freqslider.valueAction_(~fslider.value); //This allows it to refresh real-time

			x = Synth.new(
				\sound,
				[
						\freq, ~freqslider.value.linlin(0,1,21,108),
						\phase, pi,
						\vol, ~volslider.value.linlin(0,1,0,1),
						\f1, ~f1slider.value.linlin(0,1,0.0,2),
						\f2, ~f2slider.value.linlin(0,1,0.0,2),
						\f3, ~f3slider.value.linlin(0,1,0.0,2),
						\f4, ~f4slider.value.linlin(0,1,0.0,2),
						\f5, ~f5slider.value.linlin(0,1,0.0,2),
						\f6, ~f6slider.value.linlin(0,1,0.0,2),
						\f7, ~f7slider.value.linlin(0,1,0.0,2),
						\f8, ~f8slider.value.linlin(0,1,0.0,2),
						\f9, ~f9slider.value.linlin(0,1,0.0,2),
						\f10, ~f10slider.value.linlin(0,1,0.0,2),
						\f11, ~f11slider.value.linlin(0,1,0.0,2),
						\f12, ~f12slider.value.linlin(0,1,0.0,2),
						\f13, ~f13slider.value.linlin(0,1,0.0,2),
						\f14, ~f14slider.value.linlin(0,1,0.0,2),
						\f15, ~f15slider.value.linlin(0,1,0.0,2),
						\f16, ~f16slider.value.linlin(0,1,0.0,2),

						\p1, ~soundPhaseArray[0],
						\p2, ~soundPhaseArray[1],
						\p3, ~soundPhaseArray[2],
						\p4, ~soundPhaseArray[3],
						\p5, ~soundPhaseArray[4],
						\p6, ~soundPhaseArray[5],
						\p7, ~soundPhaseArray[6],
						\p8, ~soundPhaseArray[7],
						\p9, ~soundPhaseArray[8],
						\p10, ~soundPhaseArray[9],
						\p11, ~soundPhaseArray[10],
						\p12, ~soundPhaseArray[11],
						\p13, ~soundPhaseArray[12],
						\p14, ~soundPhaseArray[13],
						\p15, ~soundPhaseArray[14],
						\p16, ~soundPhaseArray[15]

						/*if(
						x.isPlaying,
						{
							16.do({
								arg i;
								(
						"\\" ++ "p" ++ (i+1) ++ ", ~soundPhaseArray[" ++ (i) ++ "],"
								).postln;
							});
					});*/

				]
			).register;
				l.free;

				~spectraFreeAudioAll.value;

				/*if(~fluteAudioButton.value == 1, {~fluteAudioButton.valueAction_(0)}); //z.free;
				if(~trumpetAudioButton.value == 1, {~trumpetAudioButton.valueAction_(0)}); //v.free;
				if(~hornAudioButton.value == 1, {~hornAudioButton.valueAction_(0)}); //t.free;
				if(~celloAudioButton.value == 1, {~celloAudioButton.valueAction_(0)}); //y.free;*/

				if(~synth_menu.item != "Instruments", {
					// If not instruments (e.g. sound presets)
				~stop_UserView.bounds_(Rect(400-(100/2)-92,65-~allShiftUp,150,30));
				~synth_menu.background_(Color.black);
					~synth_menu.stringColor_(Color.white);},{
					// If Instruments
					~stop_UserView.bounds_(Rect(400-(100/2)-92,65-~allShiftUp,1,1));
				~synth_menu.background_(Color.grey(0.7));
					~synth_menu.stringColor_(Color.white);
				});
		},
		{
				if(~synth_menu.item != "Instruments", {
				~synth_menu.background_(Color(0.7569-0.1,0.1373-0.1,0.1725-0.1,1));
				~synth_menu.stringColor_(Color.black);
				},{
					~synth_menu.background_(Color.grey(0.7));
					~synth_menu.stringColor_(Color.black);
				});

				if(x.isPlaying, {x.free;});//x.free;

				~vinbutton.valueAction_(0);

				(if(~j.value==1, {~j.value_(0)}));//Added so big button closes small buttons
				(if(~l.value==1, {~l.value_(0)}));
				(if(~k.value==1, {~k.value_(0)}));
				(if(~r.value==1, {~r.value_(0)}));

~spectraFreeDynamicAll.value;


~stop_UserView.bounds_(Rect(400-(100/2)-92,65-~allShiftUp,1,1));

			//Reset to base colours when not playing
						if(~key_vis.value == 1, {
						~color_array = Array.fill(200,1);
						(basePath +/+  "data/spectra_keyboard_GUI_colours.scd").load;
						});

			}
	);
});




//Dropdown menus
//Preset
	(
s.waitForBoot({

 var snd, funcs2, b;


 ~vinbutton = Button(w, Rect(620+500, -500, 170, 25)) //Pushed off-screen
			.states_([["            Click to Play", Color.white, Color(0.7569,0.1373,0.1725,0)], ["            Click to Stop", Color.white, Color.clear]])
   .mouseDownAction_(

				{
					arg obj;
	if(obj.value == 0,
						{
    snd = funcs2.at(~synth_menu.value).play;




						},{x.free; ~button.valueAction_(0); ~vinbutton.valueAction_(1);


						}
			)})
  .action_({ arg mod;
    snd.release;
   });


			// Button to quickly change the Phase of the sound so that it can create a triangle wave

			~soundPhaseArrayButtonLabel = StaticText(w, Rect(410+~expandWidth,70-10-~allShiftUp,70,20))
			.string_("Harmonic Phases")
			.align_(\center)
			.font_(Font(nil, 8));

			~soundPhaseArrayButton = Button(w, Rect(410+~expandWidth,70+5-~allShiftUp,70,20))
			.states_([
				["All Pi", Color.white, Color.grey(0.75)],
				["Triangle", Color.white, Color.grey(0.25)],
				["All 0", Color.white, Color.grey(0.5)]
			])
			.action_({
				arg obj;

				switch(obj.value,

					0, {~soundPhaseArray = [pi,pi,pi,pi,pi,pi,pi,pi,pi,pi,pi,pi,pi,pi,pi,pi]},
					1, {~soundPhaseArray = [1,1,0,0,1,1,0,0,1,1,0,0,1,1,0,0]*pi;},
					2, {~soundPhaseArray = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]},
				);

				/*if(obj.value == 0,
					{~soundPhaseArray = [pi,pi,pi,pi,pi,pi,pi,pi,pi,pi,pi,pi,pi,pi,pi,pi]},
					{~soundPhaseArray = [1,1,0,0,1,1,0,0,1,1,0,0,1,1,0,0]*pi;}
			);*/

if(x.isPlaying, {
x.set(
						\p1, ~soundPhaseArray[0],
						\p2, ~soundPhaseArray[1],
						\p3, ~soundPhaseArray[2],
						\p4, ~soundPhaseArray[3],
						\p5, ~soundPhaseArray[4],
						\p6, ~soundPhaseArray[5],
						\p7, ~soundPhaseArray[6],
						\p8, ~soundPhaseArray[7],
						\p9, ~soundPhaseArray[8],
						\p10, ~soundPhaseArray[9],
						\p11, ~soundPhaseArray[10],
						\p12, ~soundPhaseArray[11],
						\p13, ~soundPhaseArray[12],
						\p14, ~soundPhaseArray[13],
						\p15, ~soundPhaseArray[14],
						\p16, ~soundPhaseArray[15]
					);
				});

			});

~synth_menu = PopUpMenu(w, Rect(260, 70-3-~allShiftUp, 100, 25)); //Moved to next to big button
			~synth_menu.items_(["Sine", "Square", "Triangle", "Sawtooth", "Rev. Sawtooth", "Custom", "Instruments"]);
			~synth_menu.font_(Font(\size, 12));

			~synth_menu
			.mouseOverAction_({
				if(~inspectorExists == 1, {
					~inspectorText.string_("Select a sound preset from this dropdown menu, then press the play button.")
			});})
			.mouseLeaveAction_({
				if(~inspectorExists == 1, {
					~inspectorText.string_(" ")
			});});


			~synth_menu.background_(Color(0.7569-0.1,0.1373-0.1,0.1725-0.1,1));
			~synth_menu.stringColor_(Color.black);
			~synth_menu.action = { //arg menu;

				// [menu.value, menu.item, menu.action].postln; //These lines allow below allow the menu clicker to auto-set the choice selected (not requiring to click on-off the button to set the dropdown selection)

			//	~synth_menu.background_(Color.black);
			//	~synth_menu.stringColor_(Color.white);

//~vinbutton.valueAction_(0);
				if(x.isPlaying, {x.free});
//				~vinbutton.valueAction_(1);

								//~spectraFreePowerAll.value; // Not necessary, and conflicts with the ~button.value
				~spectraFreeAudioAll.value;

				~spectraPowerButtonStatus = 5 - (~celloAudioHaltKey + ~trumpetAudioHaltKey + ~fluteAudioHaltKey + ~hornAudioHaltKey + ~voicesAudioHaltKey);

				if(~spectraPowerButtonStatus > 0, { // If any Dynamic Spectra are playing

					~spectraFreeDynamicAllKeyMethod.value; // Halt the Dynamic Spectra but do not affect the ~button

					AppClock.sched(0.05, { // The delay is to ensure the Dynamic Spectra can finish before this activates; otherwise the sliders will be set to 0 because the 0 setting overprioritizes or comes after this Power set
				"AppClock for Dropdown Menu sent message after 0.05s.".postln;
				// The Power button seems to be reset to 0 coming off of Dynamic

						snd = funcs2.at(~synth_menu.value).value; // Changed from .play to .value to allow the ~instrumentsCover.bounds command to work without an error message

				nil;
			});

				}, { // If no Dynamic Spectra are playing, the change can be immediate (i.e. no AppClock delay necessary)

					/*if(~synth_menu.item == "Triangle", {
							~soundPhaseArray = Array.fill(16, {
								arg i, j;

								if((i+1)%4 > 1, {j = 1},{j = 0});

								j*pi;
							});
						},{
							~soundPhaseArray = [pi,pi,pi,pi,pi,pi,pi,pi,pi,pi,pi,pi,pi,pi,pi,pi];

						});*/


				snd = funcs2.at(~synth_menu.value).value; // Changed from .play to .value to allow the ~instrumentsCover.bounds command to work without an error message
				});
//l.free;



				// x.set(menu.action);

			};
//Updated Section - June 2019 Patch for SuperCollider Version 3.9.3
			//~button.value.postln;

			//End of Updated Section - June 2019 Patch for SuperCollider Version 3.9.3

 funcs2 = [
				{ //sine
			~synth_menu.background_(Color(0.7569-0.1,0.1373-0.1,0.1725-0.1,1));
~play_UserView.bounds_(Rect(400-(100/2)-92,65-~allShiftUp,192,30));
					~button.bounds_(Rect(400-(100/2)-92,65-~allShiftUp,100+35,30));
		//~freqslider.valueAction_(69.value.linlin(21,108,0,1)); //only need to affect slider to affect the number box and true sound value

							~volslider.valueAction_(0.4.value.linlin(0,1,0,1));

					~soundPhaseArrayButton.valueAction_(2);
					~fNsliderAction.value(intensityArray:[2]);

					if(x.isPlaying, {x.free}); // Must be before the button set to 1

					if(~button.value == 1,
						{~button.valueAction_(1)});

		~instrumentsCover.bounds_(Rect(10,410+2-~allShiftUp,(790-10+~expandWidth), 120+~lowerButtons))
					.string_(~readTextFileFunction.value(path:"spectra/spectraPresets/sine.txt")).align_(\topLeft);

	},


				{ //Square
			~synth_menu.background_(Color(0.7569-0.1,0.1373-0.1,0.1725-0.1,1));
~play_UserView.bounds_(Rect(400-(100/2)-92,65-~allShiftUp,192,30));
										~button.bounds_(Rect(400-(100/2)-92,65-~allShiftUp,100+35,30));
					//~freqslider.valueAction_(69.value.linlin(21,108,0,1)); //only need to affect slider to affect the number box and true sound value

							~volslider.valueAction_(0.4.value.linlin(0,1,0,1));

					~soundPhaseArrayButton.valueAction_(2);
					~fNsliderAction.value(intensityArray:[ 0.5, 0, 0.16, 0, 0.09, 0, 0.065, 0, 0.055, 0, 0.04, 0, 0.03, 0, 0.035, 0 ]*2);


			if(x.isPlaying, {x.free});  // Must be before the button set to 1

					if(~button.value == 1,
						{~button.valueAction_(1)});

					/*~l.valueAction_(0);
				~k.valueAction_(0);
								~j.valueAction_(0);*/


					~instrumentsCover.bounds_(Rect(10,410+2-~allShiftUp,(790-10+~expandWidth), 120+~lowerButtons)).string_(~readTextFileFunction.value(path:"spectra/spectraPresets/square.txt")).align_(\topLeft);

	},

				{//triangle
								~synth_menu.background_(Color(0.7569-0.1,0.1373-0.1,0.1725-0.1,1));
~play_UserView.bounds_(Rect(400-(100/2)-92,65-~allShiftUp,192,30));
										~button.bounds_(Rect(400-(100/2)-92,65-~allShiftUp,100+35,30));

					~triangleIntensityArray = Array.fill(16, {
						arg i, j, k, value;
						j = i+1;
						k = j**2;

						if(odd(j), {
							value = 1/k;
						},{
							value = 0;
						});
					});

					/*~soundPhaseArray = Array.fill(16, {
								arg i, j;

								if((i+1)%4 > 1, {j = 1},{j = 0});

								j*pi;
							});*/

					~soundPhaseArrayButton.valueAction_(1);
					~fNsliderAction.value(intensityArray:~triangleIntensityArray*2);

	//	~freqslider.valueAction_(440.value.explin(100,1000,0,1)); //only need to affect slider to affect the number box and true sound value
							~volslider.valueAction_(0.4.value.linlin(0,1,0,1));


		/*~f1slider.valueAction_(1.00.value.linlin(0.0,2,0,1));
		~f2slider.valueAction_(0.value.linlin(0.0,2,0,1));
		~f3slider.valueAction_(0.32.value.linlin(0.0,2,0,1));
		~f4slider.valueAction_(0.value.linlin(0.0,2,0,1));
		~f5slider.valueAction_(0.25.value.linlin(0.0,2,0,1));
		~f6slider.valueAction_(0.value.linlin(0.0,2,0,1));
		~f7slider.valueAction_(0.125.value.linlin(0.0,2,0,1));
		~f8slider.valueAction_(0.value.linlin(0.0,2,0,1));
		~f9slider.valueAction_(0.value.linlin(0.0,2,0,1));
		~f10slider.valueAction_(0.value.linlin(0.0,2,0,1));
		~f11slider.valueAction_(0.value.linlin(0.0,2,0,1));
		~f12slider.valueAction_(0.value.linlin(0.0,2,0,1));
		~f13slider.valueAction_(0.value.linlin(0.0,2,0,1));
		~f14slider.valueAction_(0.value.linlin(0.0,2,0,1));
		~f15slider.valueAction_(0.value.linlin(0.0,2,0,1));
		~f16slider.valueAction_(0.value.linlin(0.0,2,0,1));*/

				if(x.isPlaying, {x.free});  // Must be before the button set to 1

					if(~button.value == 1,
						{~button.valueAction_(1)});

					/*~l.valueAction_(0);
				~k.valueAction_(0);
								~j.valueAction_(0);*/

					~instrumentsCover.bounds_(Rect(10,410+2-~allShiftUp,(790-10+~expandWidth), 120+~lowerButtons)).string_(~readTextFileFunction.value(path:"spectra/spectraPresets/triangle.txt")).align_(\topLeft);


	},

				{ // Sawtooth
			~synth_menu.background_(Color(0.7569-0.1,0.1373-0.1,0.1725-0.1,1));
~play_UserView.bounds_(Rect(400-(100/2)-92,65-~allShiftUp,192,30));
										~button.bounds_(Rect(400-(100/2)-92,65-~allShiftUp,100+35,30));
		//~freqslider.valueAction_(69.value.linlin(21,108,0,1)); //only need to affect slider to affect the number box and true sound value
		~volslider.valueAction_(0.3.value.linlin(0,1,0,1));


					/*~sawIntensityArray = Array.fill(16, {
						arg i, j, value;
						j = i+1;
						value = 1/j;
					});*/

					~soundPhaseArrayButton.valueAction_(0);
					~fNsliderAction.value(intensityArray:[ 0.5, 0.25, 0.16666666666667, 0.125, 0.1, 0.083333333333333, 0.071428571428571, 0.0625, 0.055555555555556, 0.05, 0.045454545454545, 0.041666666666667, 0.038461538461538, 0.035714285714286, 0.033333333333333, 0.03125 ]*2/*~sawIntensityArray*/);

					if(x.isPlaying, {x.free});  // Must be before the button set to 1

					if(~button.value == 1,
						{~button.valueAction_(1)});

					/*~l.valueAction_(0);
				~k.valueAction_(0);
								~j.valueAction_(0);*/


					~instrumentsCover.bounds_(Rect(10,410+2-~allShiftUp,(790-10+~expandWidth), 120+~lowerButtons)).string_(~readTextFileFunction.value(path:"spectra/spectraPresets/sawtooth.txt")).align_(\topLeft);

	},
				{ // Reverse Sawtooth - same as Sawtooth except phase is 0
			~synth_menu.background_(Color(0.7569-0.1,0.1373-0.1,0.1725-0.1,1));
~play_UserView.bounds_(Rect(400-(100/2)-92,65-~allShiftUp,192,30));
										~button.bounds_(Rect(400-(100/2)-92,65-~allShiftUp,100+35,30));
		//~freqslider.valueAction_(69.value.linlin(21,108,0,1)); //only need to affect slider to affect the number box and true sound value
		~volslider.valueAction_(0.3.value.linlin(0,1,0,1));



					/*~sawIntensityArray = Array.fill(16, {
						arg i, j, value;
						j = i+1;
						value = 1/j;
					});*/

					~soundPhaseArrayButton.valueAction_(2);
					~fNsliderAction.value(intensityArray:[ 0.5, 0.25, 0.16666666666667, 0.125, 0.1, 0.083333333333333, 0.071428571428571, 0.0625, 0.055555555555556, 0.05, 0.045454545454545, 0.041666666666667, 0.038461538461538, 0.035714285714286, 0.033333333333333, 0.03125 ]*2/*~sawIntensityArray*/);

					if(x.isPlaying, {x.free});  // Must be before the button set to 1

					if(~button.value == 1,
						{~button.valueAction_(1)});

					/*~l.valueAction_(0);
				~k.valueAction_(0);
								~j.valueAction_(0);*/


					~instrumentsCover.bounds_(Rect(10,410+2-~allShiftUp,(790-10+~expandWidth), 120+~lowerButtons)).string_(~readTextFileFunction.value(path:"spectra/spectraPresets/reverse_sawtooth.txt")).align_(\topLeft);

	},


				{// Custom
			~synth_menu.background_(Color(0.7569-0.1,0.1373-0.1,0.1725-0.1,1));
~play_UserView.bounds_(Rect(400-(100/2)-92,65-~allShiftUp,192,30));
										~button.bounds_(Rect(400-(100/2)-92,65-~allShiftUp,100+35,30));
					~instrumentsCover.bounds_(Rect(10,410+2-~allShiftUp,(790-10+~expandWidth), 120+~lowerButtons)).string_(~readTextFileFunction.value(path:"spectra/spectraPresets/custom.txt")).align_(\topLeft);

					if(x.isPlaying, {x.free});  // Must be before the button set to 1

					if(~button.value == 1,
						{~button.valueAction_(1)});


				},
				{//"Instruments (harmonics panel)".postln;


					if(x.isPlaying, {x.free});


~play_UserView.bounds_(Rect(400-(100/2),65-~allShiftUp,1,1));

										~button.bounds_(Rect(400-(100/2)-92,65-~allShiftUp-500,100+35,30)); // Disappear


					~button.valueAction_(0); // Automatically start in the off position
							~volslider.valueAction_(0.4.value.linlin(0,1,0,1));

					/*~l.valueAction_(0);
				~k.valueAction_(0);
								~j.valueAction_(0);*/

					~synth_menu.background_(Color.grey(0.7));
					~synth_menu.stringColor_(Color.black);

					~reset.valueAction_(0); // Resets the intensities when set to Instruments.
					~soundPhaseArrayButton.valueAction_(2); // Change back phase to 0

					~instrumentsCover.bounds_(Rect(10,410+2-~allShiftUp,(790-10+~expandWidth), 0));
				}

 ];

			//Updated Section - June 2019 Patch for SuperCollider Version 3.9.3
			{ //sine
			~synth_menu.background_(Color(0.7569-0.1,0.1373-0.1,0.1725-0.1,1));
~play_UserView.bounds_(Rect(400-(100/2)-92,65-~allShiftUp,192,30));
					~button.bounds_(Rect(400-(100/2)-92,65-~allShiftUp,100+35,30));
		//~freqslider.valueAction_(69.value.linlin(21,108,0,1)); //only need to affect slider to affect the number box and true sound value

							~volslider.valueAction_(0.4.value.linlin(0,1,0,1));

					~soundPhaseArrayButton.valueAction_(2).postln;
					~fNsliderAction.value(intensityArray:[2]).postln;

					if(x.isPlaying, {x.free}); // Must be before the button set to 1

					if(~button.value == 1,
						{~button.valueAction_(1)});

		~instrumentsCover.bounds_(Rect(10,410+2-~allShiftUp,(790-10+~expandWidth), 120+~lowerButtons))
					.string_(~readTextFileFunction.value(path:"spectra/spectraPresets/sine.txt")).align_(\topLeft);

	}.value;
			//End Updated Section - June 2019 Patch for SuperCollider Version 3.9.3

 w.front;

 p = CmdPeriod.add({ b.value_(0) }); // set button to 0 on hitting Cmd-period
 w.onClose_{ snd.release; CmdPeriod.removeAll }; // clean up when window is closed

});

		// Start the dropdown menu at Sine // Instruments for testing now
		AppClock.sched(0.001,{
			~slider_hover = 1;
			~synth_menu.valueAction_(0);
			//nil;
		});

	);



	// Power Spectra Buttons

	~spectraPowerButtonStatus = 0; // Starts all off

	// Power Strings
	~stringsPowerButton = ~celloPowerButton = ~j = Button(w, Rect(240, 417.5+~lowerButtons-~allShiftUp, 90, 26))
	.states_([["Strings", Color.white, Color(0.7569,0.1373,0.1725,1)], ["Strings", Color.white, Color(0,0,0,1)]])
	.font_(Font("nil", 14))
	.action_({
		arg obj;
		~spectraFreePowerSpecifyValueOnly.value(instrument:"trumpet");
		~spectraFreePowerSpecifyValueOnly.value(instrument:"horn");
		~spectraFreePowerSpecifyValueOnly.value(instrument:"flute");
		~spectraFreePowerSpecifyValueOnly.value(instrument:"voices");


		switch(~instrumentGroupStringsDropdown.item,
			"Violin", {~spectraPowerButtonAction.value(obj:obj, instrument:"violin", fundamentalNote:60);},
			"Viola", {~spectraPowerButtonAction.value(obj:obj, instrument:"viola", fundamentalNote:60);},
			"Cello", {~spectraPowerButtonAction.value(obj:obj, instrument:"cello", fundamentalNote:60);},
			"Bass", {~spectraPowerButtonAction.value(obj:obj, instrument:"bass", fundamentalNote:60);}
		);

	}); //Ensure ~button.value is value not valueAction to avoid loop and ensure this turns off big button properly

	// Power Brass
	~brassPowerButton = ~trumpetPowerButton = ~l = Button(w, Rect(335, 417.5+~lowerButtons-~allShiftUp, 90, 26))
	.states_([["Brass", Color.white, Color(0.7569,0.1373,0.1725,1)],["Brass", Color.white, Color(0,0,0,1)]])
	.font_(Font("nil", 14))
	.action_({
		arg obj;
		~spectraFreePowerSpecifyValueOnly.value(instrument:"cello");
		~spectraFreePowerSpecifyValueOnly.value(instrument:"horn");
		~spectraFreePowerSpecifyValueOnly.value(instrument:"flute");
		~spectraFreePowerSpecifyValueOnly.value(instrument:"voices");

		switch(~instrumentGroupBrassDropdown.item,
			"Trumpet", {~spectraPowerButtonAction.value(obj:obj, instrument:"trumpet", fundamentalNote:60);},
			"Horn", {~spectraPowerButtonAction.value(obj:obj, instrument:"horn", fundamentalNote:60);},
			"Trombone", {~spectraPowerButtonAction.value(obj:obj, instrument:"trombone", fundamentalNote:60);},
			"Tuba", {~spectraPowerButtonAction.value(obj:obj, instrument:"tuba", fundamentalNote:60);}
		);

	});


	// Power Woodwinds
	~woodwindsPowerButton = ~flutePowerButton = ~k = Button(w, Rect(430, 417.5+~lowerButtons-~allShiftUp, 90, 26))
	.states_([["Woodwind", Color.white, Color(0.7569,0.1373,0.1725,1)], ["Woodwind", Color.white, Color(0,0,0,1)]])
	.font_(Font("nil", 14))
	.action_({ // Must be "action" and not "mouseDownAction" to avoid code not working
		arg obj;
		~spectraFreePowerSpecifyValueOnly.value(instrument:"trumpet");
		~spectraFreePowerSpecifyValueOnly.value(instrument:"horn");
		~spectraFreePowerSpecifyValueOnly.value(instrument:"cello");
		~spectraFreePowerSpecifyValueOnly.value(instrument:"voices");

		switch(~instrumentGroupWoodwindsDropdown.item,
			"Flute", {~spectraPowerButtonAction.value(obj:obj, instrument:"flute", fundamentalNote:72);},
			"Clarinet", {~spectraPowerButtonAction.value(obj:obj, instrument:"clarinet", fundamentalNote:60);},
			"Oboe", {~spectraPowerButtonAction.value(obj:obj, instrument:"oboe", fundamentalNote:60);},
			"Bassoon", {~spectraPowerButtonAction.value(obj:obj, instrument:"bassoon", fundamentalNote:60);}
		);
	});

	// Power Percussion
	~percussionPowerButton = ~hornPowerButton = ~r = Button(w, Rect(525, 417.5+~lowerButtons-~allShiftUp, 90, 26))
	.states_([["Percussion", Color.white, Color(0.7569,0.1373,0.1725,1)],["Percussion", Color.white, Color(0,0,0,1)]])
	.font_(Font("nil", 14))
	.action_({
		arg obj;
		~spectraFreePowerSpecifyValueOnly.value(instrument:"trumpet");
		~spectraFreePowerSpecifyValueOnly.value(instrument:"cello");
		~spectraFreePowerSpecifyValueOnly.value(instrument:"flute");
		~spectraFreePowerSpecifyValueOnly.value(instrument:"voices");


		switch(~instrumentGroupPercussionDropdown.item,
			"Xylophone", {~spectraPowerButtonAction.value(obj:obj, instrument:"xylophone", fundamentalNote:72);},
			"Marimba", {~spectraPowerButtonAction.value(obj:obj, instrument:"marimba", fundamentalNote:60);},
			"Vibraphone", {~spectraPowerButtonAction.value(obj:obj, instrument:"vibraphone", fundamentalNote:60);}
			//"Piano", {~spectraPowerButtonAction.value(obj:obj, instrument:"piano", fundamentalNote:60);}
		);
	});

	// Power Other/Voices
	~otherPowerButton = ~voicesPowerButton = ~voice_tenorPowerButton = Button(w, Rect(620, 417.5+~lowerButtons-~allShiftUp, 90, 26))
	.states_([["Other", Color.white, Color(0.7569,0.1373,0.1725,1)],["Other", Color.white, Color(0,0,0,1)]])
	.font_(Font("nil", 14))
	.action_({
		arg obj;
		~spectraFreePowerSpecifyValueOnly.value(instrument:"trumpet");
		~spectraFreePowerSpecifyValueOnly.value(instrument:"horn");
		~spectraFreePowerSpecifyValueOnly.value(instrument:"cello");
		~spectraFreePowerSpecifyValueOnly.value(instrument:"flute");

		switch(~instrumentGroupVoicesDropdown.item,
			"Piano", {~spectraPowerButtonAction.value(obj:obj, instrument:"piano", fundamentalNote:60);},
			"Guitar", {~spectraPowerButtonAction.value(obj:obj, instrument:"guitar", fundamentalNote:60);}
			// "Tenor", {~spectraPowerButtonAction.value(obj:obj, instrument:"voice_tenor", fundamentalNote:60);},
			// "Soprano", {~spectraPowerButtonAction.value(obj:obj, instrument:"voice_soprano", fundamentalNote:72);}
		);
	});


			//Label for Select Instrument
~labelPower = StaticText(w,Rect(10,420-~allShiftUp,160,20))
	.string_("Select Instrument")
.font_(Font("nil", 18))
.align_(\topLeft)
.background_(Color(0,0,0,0))
.stringColor_(Color.black);

		//Label for Forced Choice
~labelPower = StaticText(w,Rect(10,420+~lowerButtons-~allShiftUp,150,20))
	.string_("Power Spectra")
.font_(Font("nil", 18))
.align_(\topLeft)
.background_(Color(0,0,0,0))
.stringColor_(Color.black);

	//Label for Moving
~labelDynamic = StaticText(w,Rect(10,460+~lowerButtons-~allShiftUp,380,30))
	.string_("Dynamic Spectra")
.font_(Font("nil", 18))
.align_(\topLeft)
.background_(Color(0,0,0,0))
.stringColor_(Color.black);

//Label for Realistic
~labelAudio = StaticText(w,Rect(10,500+~lowerButtons-~allShiftUp,380,30))
	.string_("Audio Recordings")
.font_(Font("nil", 18))
.align_(\topLeft)
.background_(Color(0,0,0,0))
.stringColor_(Color.black);

//Label for Harmonics
~labelHarmonicsPanel = StaticText(w,Rect(15,110-~allShiftUp,380,20))
	.string_("Harmonics|")
.font_(Font("nil", 18))
.align_(\topLeft)
.background_(Color(0,0,0,0))
.stringColor_(Color.black);


	// Select Instrument Section

	// Strings Group

	~instrumentGroupStringsLabel = StaticText(w, Rect(240, 410-~allShiftUp, 90, 15))
	.string_("Strings")
	.background_(Color.clear)
	.align_(\center)
	.font_(Font(nil,10));

	~instrumentGroupStringsDropdown = PopUpMenu(w, Rect(240, 425-~allShiftUp, 90, 20))
	.items_(["Violin", "Viola", "Cello", "Bass"])
	.action_({
		~spectraInstrumentDropdownUpdate.value(instrumentGroup:"strings");
/*if(~stringsPowerButton.value == 1, {
		~stringsPowerButton.valueAction_(0);
		~stringsPowerButton.valueAction_(1);
		});*/
	});


	// Brass Group

	~instrumentGroupBrassLabel = StaticText(w, Rect(335, 410-~allShiftUp, 90, 15))
	.string_("Brass")
	.background_(Color.clear)
	.align_(\center)
	.font_(Font(nil,10));

	~instrumentGroupBrassDropdown = PopUpMenu(w, Rect(335, 425-~allShiftUp, 90, 20))
	.items_(["Trumpet", "Horn", "Trombone", "Tuba"]).action_({
		~spectraInstrumentDropdownUpdate.value(instrumentGroup:"brass")});


	// Woodwind Group

	~instrumentGroupWoodwindsLabel = StaticText(w, Rect(430, 410-~allShiftUp, 90, 15))
	.string_("Woodwinds")
	.background_(Color.clear)
	.align_(\center)
	.font_(Font(nil,10));

	~instrumentGroupWoodwindsDropdown = PopUpMenu(w, Rect(430, 425-~allShiftUp, 90, 20))
	.items_(["Flute", "Clarinet", "Oboe", "Bassoon"]).action_({
		~spectraInstrumentDropdownUpdate.value(instrumentGroup:"woodwinds")});


	// Percussion Group

	~instrumentGroupPercussionLabel = StaticText(w, Rect(525, 410-~allShiftUp, 90, 15))
	.string_("Percussion")
	.background_(Color.clear)
	.align_(\center)
	.font_(Font(nil,10));

	~instrumentGroupPercussionDropdown = PopUpMenu(w, Rect(525, 425-~allShiftUp, 90, 20))
	.items_(["Xylophone", "Marimba", "Vibraphone"]).action_({
		~spectraInstrumentDropdownUpdate.value(instrumentGroup:"percussion")});


	// Voices Group

	~instrumentGroupOtherLabel = ~instrumentGroupVoicesLabel = StaticText(w, Rect(620, 410-~allShiftUp, 90, 15))
	.string_("Other")
	.background_(Color.clear)
	.align_(\center)
	.font_(Font(nil,10));

	~instrumentGroupVoicesDropdown = PopUpMenu(w, Rect(620, 425-~allShiftUp, 90, 20))
	.items_(["Piano", "Guitar"]).action_({
		~spectraInstrumentDropdownUpdate.value(instrumentGroup:"voices")});




		//FUNDAMENTAL FREQUENCY
//Properties of the slider
~freqslider = Slider(w, Rect(250,110-~allShiftUp,140,20))
	.background_(Color(0.8,0.8,0.8,0.75)).value_(49/87) // Opens at A#4
	.step_(1/(108-21))
	.action_({
	arg obj;
	var cf;

	cf = obj.value.linlin(0,1,21,108); //.postln;
		~fundamental_note = obj.value.linlin(0,1,21,108);
		~fundamental_note; //.postln;
		~fund = ~fundamental_note-1;
		/*//C4
		(
		if( //This IF function provides the capability to control the system
		obj.value.linlin(0,1,40,75) == 40, {a.free; //Needs to be at front because when leaving the slider position calls the first
				// a = Synth(\SimpleSine);
			~c4.background_(Color.red);
	}, {a.free; ~c4.background_(Color.white)});
	);*/


/*A0*/(if(obj.value.linlin(0,1,21,108) == 21,{~note_name.string_("A0");}););
/*B0*/(if(obj.value.linlin(0,1,21,108) == 23,{~note_name.string_("B0");}););
/*C1*/(if(obj.value.linlin(0,1,21,108) == 24,{~note_name.string_("C1");}););
/*D1*/(if(obj.value.linlin(0,1,21,108) == 26,{~note_name.string_("D1");}););
/*E1*/(if(obj.value.linlin(0,1,21,108) == 28,{~note_name.string_("E1");}););
/*F1*/(if(obj.value.linlin(0,1,21,108) == 29,{~note_name.string_("F1");}););
/*G1*/(if(obj.value.linlin(0,1,21,108) == 31,{~note_name.string_("G1");}););
/*A1*/(if(obj.value.linlin(0,1,21,108) == 33,{~note_name.string_("A1");}););
/*B1*/(if(obj.value.linlin(0,1,21,108) == 35,{~note_name.string_("B1");}););
/*C2*/(if(obj.value.linlin(0,1,21,108) == 36,{~note_name.string_("C2");}););
/*D2*/(if(obj.value.linlin(0,1,21,108) == 38,{~note_name.string_("D2");}););
/*E2*/(if(obj.value.linlin(0,1,21,108) == 40,{~note_name.string_("E2");}););
/*F2*/(if(obj.value.linlin(0,1,21,108) == 41,{~note_name.string_("F2");}););
/*G2*/(if(obj.value.linlin(0,1,21,108) == 43,{~note_name.string_("G2");}););
/*A2*/(if(obj.value.linlin(0,1,21,108) == 45,{~note_name.string_("A2");}););
/*B2*/(if(obj.value.linlin(0,1,21,108) == 47,{~note_name.string_("B2");}););
/*C3*/(if(obj.value.linlin(0,1,21,108) == 48,{~note_name.string_("C3");}););
/*D3*/(if(obj.value.linlin(0,1,21,108) == 50,{~note_name.string_("D3");}););
/*E3*/(if(obj.value.linlin(0,1,21,108) == 52,{~note_name.string_("E3");}););
/*F3*/(if(obj.value.linlin(0,1,21,108) == 53,{~note_name.string_("F3");}););
/*G3*/(if(obj.value.linlin(0,1,21,108) == 55,{~note_name.string_("G3");}););
/*A3*/(if(obj.value.linlin(0,1,21,108) == 57,{~note_name.string_("A3");}););
/*B3*/(if(obj.value.linlin(0,1,21,108) == 59,{~note_name.string_("B3");}););
/*C4*/(if(obj.value.linlin(0,1,21,108) == 60,{~note_name.string_("C4");}););
/*D4*/(if(obj.value.linlin(0,1,21,108) == 62,{~note_name.string_("D4");}););
/*E4*/(if(obj.value.linlin(0,1,21,108) == 64,{~note_name.string_("E4");}););
/*F4*/(if(obj.value.linlin(0,1,21,108) == 65,{~note_name.string_("F4");}););
/*G4*/(if(obj.value.linlin(0,1,21,108) == 67,{~note_name.string_("G4");}););
/*A4*/(if(obj.value.linlin(0,1,21,108) == 69,{~note_name.string_("A4");}););
/*B4*/(if(obj.value.linlin(0,1,21,108) == 71,{~note_name.string_("B4");}););
/*C5*/(if(obj.value.linlin(0,1,21,108) == 72,{~note_name.string_("C5");}););
/*D5*/(if(obj.value.linlin(0,1,21,108) == 74,{~note_name.string_("D5");}););
/*E5*/(if(obj.value.linlin(0,1,21,108) == 76,{~note_name.string_("E5");}););
/*F5*/(if(obj.value.linlin(0,1,21,108) == 77,{~note_name.string_("F5");}););
/*G5*/(if(obj.value.linlin(0,1,21,108) == 79,{~note_name.string_("G5");}););
/*A5*/(if(obj.value.linlin(0,1,21,108) == 81,{~note_name.string_("A5");}););
/*B5*/(if(obj.value.linlin(0,1,21,108) == 83,{~note_name.string_("B5");}););
/*C6*/(if(obj.value.linlin(0,1,21,108) == 84,{~note_name.string_("C6");}););
/*D6*/(if(obj.value.linlin(0,1,21,108) == 86,{~note_name.string_("D6");}););
/*E6*/(if(obj.value.linlin(0,1,21,108) == 88,{~note_name.string_("E6");}););
/*F6*/(if(obj.value.linlin(0,1,21,108) == 89,{~note_name.string_("F6");}););
/*G6*/(if(obj.value.linlin(0,1,21,108) == 91,{~note_name.string_("G6");}););
/*A6*/(if(obj.value.linlin(0,1,21,108) == 93,{~note_name.string_("A6");}););
/*B6*/(if(obj.value.linlin(0,1,21,108) == 95,{~note_name.string_("B6");}););
/*C5*/(if(obj.value.linlin(0,1,21,108) == 96,{~note_name.string_("C5");}););
/*D7*/(if(obj.value.linlin(0,1,21,108) == 98,{~note_name.string_("D7");}););
/*E7*/(if(obj.value.linlin(0,1,21,108) == 100,{~note_name.string_("E7");}););
/*F7*/(if(obj.value.linlin(0,1,21,108) == 101,{~note_name.string_("F7");}););
/*G7*/(if(obj.value.linlin(0,1,21,108) == 103,{~note_name.string_("G7");}););
/*A7*/(if(obj.value.linlin(0,1,21,108) == 105,{~note_name.string_("A7");}););
/*B7*/(if(obj.value.linlin(0,1,21,108) == 107,{~note_name.string_("B7");}););
/*C8*/(if(obj.value.linlin(0,1,21,108) == 108,{~note_name.string_("C8");}););


/*ASHARP0*/(if(obj.value.linlin(0,1,21,108) ==22,{~note_name.string_("Bb0");}););
/*CSHARP1*/(if(obj.value.linlin(0,1,21,108) ==25,{~note_name.string_("Db1");}););
/*DSHARP1*/(if(obj.value.linlin(0,1,21,108) ==27,{~note_name.string_("Eb1");}););
/*FSHARP1*/(if(obj.value.linlin(0,1,21,108) ==30,{~note_name.string_("Gb1");}););
/*GSHARP1*/(if(obj.value.linlin(0,1,21,108) ==32,{~note_name.string_("Ab1");}););
/*ASHARP1*/(if(obj.value.linlin(0,1,21,108) ==34,{~note_name.string_("Bb1");}););
/*CSHARP2*/(if(obj.value.linlin(0,1,21,108) ==37,{~note_name.string_("Db2");}););
/*DSHARP2*/(if(obj.value.linlin(0,1,21,108) ==39,{~note_name.string_("Eb2");}););
/*FSHARP2*/(if(obj.value.linlin(0,1,21,108) ==42,{~note_name.string_("Gb2");}););
/*GSHARP2*/(if(obj.value.linlin(0,1,21,108) ==44,{~note_name.string_("Ab2");}););
/*ASHARP2*/(if(obj.value.linlin(0,1,21,108) ==46,{~note_name.string_("Bb2");}););
/*CSHARP3*/(if(obj.value.linlin(0,1,21,108) ==49,{~note_name.string_("Cb3");}););
/*DSHARP3*/(if(obj.value.linlin(0,1,21,108) ==51,{~note_name.string_("Eb3");}););
/*FSHARP3*/(if(obj.value.linlin(0,1,21,108) ==54,{~note_name.string_("Gb3");}););
/*GSHARP3*/(if(obj.value.linlin(0,1,21,108) ==56,{~note_name.string_("Ab3");}););
/*ASHARP3*/(if(obj.value.linlin(0,1,21,108) ==58,{~note_name.string_("Bb3");}););
/*CSHARP4*/(if(obj.value.linlin(0,1,21,108) ==61,{~note_name.string_("Db4");}););
/*DSHARP4*/(if(obj.value.linlin(0,1,21,108) ==63,{~note_name.string_("Eb4");}););
/*FSHARP4*/(if(obj.value.linlin(0,1,21,108) ==66,{~note_name.string_("Gb4");}););
/*GSHARP4*/(if(obj.value.linlin(0,1,21,108) ==68,{~note_name.string_("Ab4");}););
/*ASHARP4*/(if(obj.value.linlin(0,1,21,108) ==70,{~note_name.string_("Bb4");}););
/*CSHARP5*/(if(obj.value.linlin(0,1,21,108) ==73,{~note_name.string_("Db5");}););
/*DSHARP5*/(if(obj.value.linlin(0,1,21,108) ==75,{~note_name.string_("Eb5");}););
/*FSHARP5*/(if(obj.value.linlin(0,1,21,108) ==78,{~note_name.string_("Gb5");}););
/*GSHARP5*/(if(obj.value.linlin(0,1,21,108) ==80,{~note_name.string_("Ab5");}););
/*ASHARP5*/(if(obj.value.linlin(0,1,21,108) ==82,{~note_name.string_("Bb5");}););
/*CSHARP6*/(if(obj.value.linlin(0,1,21,108) ==85,{~note_name.string_("Db6");}););
/*DSHARP6*/(if(obj.value.linlin(0,1,21,108) ==87,{~note_name.string_("Eb6");}););
/*FSHARP6*/(if(obj.value.linlin(0,1,21,108) ==90,{~note_name.string_("Gb6");}););
/*GSHARP6*/(if(obj.value.linlin(0,1,21,108) ==92,{~note_name.string_("Ab6");}););
/*ASHARP6*/(if(obj.value.linlin(0,1,21,108) ==94,{~note_name.string_("Bb6");}););
/*CSHARP7*/(if(obj.value.linlin(0,1,21,108) ==97,{~note_name.string_("Db7");}););
/*DSHARP7*/(if(obj.value.linlin(0,1,21,108) ==99,{~note_name.string_("Eb7");}););
/*FSHARP7*/(if(obj.value.linlin(0,1,21,108) ==102,{~note_name.string_("Gb7");}););
/*GSHARP7*/(if(obj.value.linlin(0,1,21,108) ==104,{~note_name.string_("Ab7");}););
/*ASHARP7*/(if(obj.value.linlin(0,1,21,108) ==106,{~note_name.string_("Bb7");}););

		if(~key_vis.value == 1, {
if(~button.value == 1, {
(basePath +/+  "data/spectra_keyboard_GUI_colours.scd").load;
			}, {~color_array = Array.fill(200,1);
			(basePath +/+  "data/spectra_keyboard_GUI_colours.scd").load
		});
		});

(
// These y_var and x_var make the following lines of code more clear to read
			~energy = Array.fill(16,1);
			~gain = Array.fill(200,~knob.value.linexp(0,1,1,100);); //use linexp to make the Knob somewhat intuitive to use
			~gain_strength = 10; //Doesn't seem to actually affect the Gain

			//Allows the calculation of the keyboard GUI intensity with Knob Gain
~color_array = Array.fill(200,1);


// y_var values must be computed BEFORE the color_array block so that the values exist; thus when copying from the Excel generator the order of the two blocks must be inverted
				//if(~key_vis == 1, {
				(
					(0..15).do({
						arg i;
						var namer = i+1, slider_name;

						slider_name = "~f" ++ namer ++ "slider.value.linlin(0,1,0,1)";

						//[i, ("~energy["++i++"] =(~manipulated_harmonic["++i++"]*"++slider_name++")")].postln;

						//slider_name.compile.postln;
						("~energy["++i++"] =(~manipulated_harmonic["++i++"]*"++slider_name++")").interpret; //Needs to be interpret and not compile

					})
				//);}
		);


//HARMONICS
(
[0, 12, 19, 24, 28, 31, 34, 36, 38, 40, 41, 43,44, 46, 47, 48].do({
	arg i, item;
	var note_add = i, harmonic_index = item, shorthand;
	harmonic_index/*.postln*/;
	note_add/*.postln*/;
	~shorthand = ~freqslider.value.linlin(0,1,21,108)-1;
	~shorthand/*.postln*/;

	(if(~energy[harmonic_index]*~gain[harmonic_index] > 1, {
		~color_array[~shorthand+note_add]=0;
							//[harmonic_index, note_add, ~energy[harmonic_index], ~color_array[~shorthand+note_add]].postln;
						},
	{if(~gain[harmonic_index] == 100, {
							if(~energy[harmonic_index] > 0, {
								~color_array[~shorthand+note_add]=0;}, {//else do nothing
							};
							//[harmonic_index, note_add, ~energy[harmonic_index], ~color_array[~shorthand+note_add]].postln;
						)},
							{~color_array[~shorthand+note_add]=(-1)*((~energy[harmonic_index])*(~gain[harmonic_index])-1);
							//[harmonic_index, note_add, ~energy[harmonic_index], ~color_array[~shorthand+note_add]].postln;
						})}
	));

});
)


		);







//Ensure it updates
s.makeBundle(1.0, //sound delay -~knob.value.linlin(0,1,0,0.5)
			{~dirtyBit = 2; /*~dirtyBit.postln;*/

			(
					(basePath +/+  "data/spectra_keyboard_GUI_colours.scd").load;
				)
		});


		if(
		x.isPlaying,
		{x.set(\freq,cf)});



	//~numberBox.value_(obj.value.linlin(0,1,21,108));

		~fundamental_freq = ((2**((-69+~fundamental_note)/12))*440);
		~numberBox.value_(~fundamental_freq);



			if(~spectraAutoscaleButton.value == 1,{
			//{~spectraButton.valueAction_(1);}); // Automatically updates the Autoscaling
			~spectra_scopeAutoscaleFunction.value;}); // Bypass the Button system entirely to reduce CPU load

		// Updates the information panel
		~inspectorHarmonicsPanelUpdate.value;


		if(~d != nil, {~d.cycle_(5*44100/~fundamental_freq);}); // Scales the Oscilloscope to attempt to fit the H1 frequency


})
	.orientation_(\horizontal);

	//Update June 2019 for 3.10.2
	~freqslider.value = 0.5632183908046; //This ensures that ~freqslider starts with the same value to allow for future updating to work
	//End of June 2019 Update for 3.10.2


//Label for Freq.
~freqLabel = StaticText(w,Rect(123,116-~allShiftUp,80,25))
.string_("Fundamental")
.font_(Font("nil", 8))
.align_(\topRight)
.background_(Color(0,0,0,0))
.stringColor_(Color.black);



//Number box that can edit slider position
~numberBox = NumberBox(w,Rect(225,110-~allShiftUp,25,20))
	.value_(440)
	//.value_(69)
//.clipLo_(21)
//.clipHi_(108)
.font_(Font("nil",7))
.decimals_(0)
.align_(\center);
	// .action_({
	// 	arg obj;
	// 	//	~freqslider.valueAction_(obj.value.linlin(21,108,0,1))
	// });

// Cover to avoid editing frequency box
~numberBox_Cover = StaticText(w,Rect(225,110-~allShiftUp,25,20))
	.background_(Color.clear);




		///Starter harmonics array (sets everything to 0) arrays
	~harmonics_array = Array.fill(16, {arg i; 0});
~harmonic_count = 16;
~intensity_array = Array.fill(16, {arg i; 0});
~harmonic_sums = Array.fill(16, {arg i; 0});
~fundamental_note = ~freqslider.value.linlin(0,1,21,108); //Middle C
~fundamental_freq = ((2**((-69+~fundamental_note)/12))*440);
~manipulated_harmonic = Array.fill(16, {arg i; 1});
	~color_array = Array.fill(200,1);
~otherslider = 0;


//VOLUME
//Properties of the slider
~volslider = Slider(w, Rect(50,145-~allShiftUp,20,230))
	.background_(Color(0.0118,0.0118,0.0118,1))
	.value_(0.4)
	.mouseOverAction_({
	if(~inspectorExists == 1, {
			~inspectorText.string_("Use this black slider to change the volume of all sounds playing.")
});})
.mouseLeaveAction_({
	if(~inspectorExists == 1, {
		~inspectorText.string_(" ")
});})
	.action_({
	arg obj;
	var cf;
	cf = obj.value.linlin(0,1,0,1); //.postln;
		if(
		x.isPlaying,
		{x.set(\vol,cf)});
	//~numberVBox.value_(obj.value.linlin(0,1,0,1));

		// Update inspector (Currently does not work)
		({
	if(~inspectorExists == 1, {
		~inspectorText.string_(("Volume Slider status:
Volume:"++obj.value).asString
)
	});});

})
	.orientation_(\vertical);

//Label for Vol.
~volLabel = StaticText(w,Rect(50,130-~allShiftUp,20,15))
.string_("Vol.")
.font_(Font("nil", 10, italic:true))
.align_(\center)
.background_(Color(0,0,0,0.1))
.stringColor_(Color.black);



	// Audio Recordings
	// Each instrument comes in two parts: 1. Buffer, 2. Button
	// 1. The Buffer reads the WAVE file within the appropriate directory (i.e. audio)
	// 2. The Button plays the audio loaded by this Buffer/SynthDef
	//helpful notes for troubleshooting the Buffer: http://new-supercollider-mailing-lists-forums-use-these.2681727.n2.nabble.com/Generalizing-a-files-path-td7616651.html

	// Cello Audio Recording
	// Cello Buffer
	//~celloAudioBuffer = a = Buffer.read(s, basePath +/+ "audio/cello.wav");

	/*SynthDef("celloAudio",{ arg out=0,bufnum=0, trigger=1, startPos=0, loop=1;
		var rate;
		rate = 1.0; // Can be used to affect pitch/speed of playback
		Out.ar(out,
			Pan2.ar(PlayBuf.ar(1,bufnum, BufRateScale.kr(bufnum)*rate, trigger, BufFrames.ir(bufnum)*startPos, loop=0),0.0)
		);
	}).add;*/

	// ~audioGenerator.value(["cello", "violin"]);
	["cello", "violin", "viola", "bass"].do({arg instrument; ~audioGenerator.value(instrument);});

	// Violin Buffer
	/*~violinAudioBuffer = Buffer.read(s, basePath +/+ "audio/violin.wav");

	SynthDef("violinAudio",{ arg out=0,bufnum=0, trigger=1, startPos=0, loop=1;
		var rate;
		rate = 1.0; // Can be used to affect pitch/speed of playback
		Out.ar(out,
			Pan2.ar(PlayBuf.ar(1,bufnum, BufRateScale.kr(bufnum)*rate, trigger, BufFrames.ir(bufnum)*startPos, loop=0),0.0)
		);
	}).add;*/

	// Cello Button
	~stringsAudioButton = ~celloAudioButton = q = Button(w, Rect(240, 497.5+~lowerButtons-~allShiftUp, 90, 26))
	.states_([["Strings", Color.white, Color(0.7569,0.1373,0.1725,1)], ["Strings", Color.white, Color(0,0,0,1)]])
	.font_(Font("nil", 14))
	.action_({
		arg obj;

		switch(~instrumentGroupStringsDropdown.item,
			"Cello", {~spectraAudioButtonAction.value(obj:obj, instrument:"cello", instrumentGroup:"strings");
				~freqslider.valueAction_(60.value.linlin(21,108,0,1));},
			"Violin", {~spectraAudioButtonAction.value(obj:obj, instrument:"violin", instrumentGroup:"strings");
				~freqslider.valueAction_(60.value.linlin(21,108,0,1));},
			"Viola", {~spectraAudioButtonAction.value(obj:obj, instrument:"viola", instrumentGroup:"strings");
				~freqslider.valueAction_(60.value.linlin(21,108,0,1));},
			"Bass", {~spectraAudioButtonAction.value(obj:obj, instrument:"bass", instrumentGroup:"strings");
				~freqslider.valueAction_(60.value.linlin(21,108,0,1));}
		);

	});

	// Trumpet Audio Recording
	// Trumpet Buffer
	/*~trumpetAudioBuffer = c = Buffer.read(s, basePath +/+ "audio/trumpet.wav");

	SynthDef("trumpetAudio",{ arg out=0,bufnum=0, trigger=1, startPos=0, loop=1;
		var rate;
		rate = 1.00; //using rate because it was slightly out of tune (too high pitched)
		Out.ar(out,
			Pan2.ar(PlayBuf.ar(1,bufnum, BufRateScale.kr(bufnum)*rate, trigger, BufFrames.ir(bufnum)*startPos, loop=0),0.0)
		);
	}).add;*/

	// Horn Buffer
	/*~hornAudioBuffer = q = Buffer.read(s, basePath +/+ "audio/horn.wav");

	SynthDef("hornAudio",{ arg out=0,bufnum=0, trigger=1, startPos=0, loop=1;
		var rate;
		rate = 1.0; //using rate because it was slightly out of tune (too high pitched)
		Out.ar(out,
			Pan2.ar(PlayBuf.ar(1,bufnum, BufRateScale.kr(bufnum)*rate, trigger, BufFrames.ir(bufnum)*startPos, loop=0),0.0)
		);
	}).add;*/

	["horn", "trumpet", "tuba", "trombone"].do({arg instrument; ~audioGenerator.value(instrument);});


	// Audio Brass Button
	~brassAudioButton = ~trumpetAudioButton = e = Button(w, Rect(335, 497.5+~lowerButtons-~allShiftUp, 90, 26))
	.states_([["Brass", Color.white, Color(0.7569,0.1373,0.1725,1)], ["Brass", Color.white, Color(0,0,0,1)]])
	.font_(Font("nil", 14))
	.action_({
		arg obj;

		switch(~instrumentGroupBrassDropdown.item,
			"Horn", {~spectraAudioButtonAction.value(obj:obj, instrument:"horn", instrumentGroup:"brass");
				~freqslider.valueAction_(60.value.linlin(21,108,0,1));
			},
			"Trumpet", {~spectraAudioButtonAction.value(obj:obj, instrument:"trumpet", instrumentGroup:"brass");
				~freqslider.valueAction_(60.value.linlin(21,108,0,1));
			},
			"Tuba", {~spectraAudioButtonAction.value(obj:obj, instrument:"tuba", instrumentGroup:"brass");
				~freqslider.valueAction_(60.value.linlin(21,108,0,1));
			},
			"Trombone", {~spectraAudioButtonAction.value(obj:obj, instrument:"trombone", instrumentGroup:"brass");
				~freqslider.valueAction_(60.value.linlin(21,108,0,1));
			}
		);

	});

	// Flue Audio Recording
	/*// Flute Buffer
	~fluteAudioBuffer = b = Buffer.read(s, basePath +/+ "audio/flute.wav");

	SynthDef("fluteAudio",{ arg out=0,bufnum=0, trigger=1, startPos=0, loop=1;
		var rate;
		rate = 1.0; //using rate because it was slightly out of tune (too high pitched)
		Out.ar(out,
			Pan2.ar(PlayBuf.ar(1,bufnum, BufRateScale.kr(bufnum)*rate, trigger, BufFrames.ir(bufnum)*startPos, loop=0),0.0)
		);
	}).add;

	// Clarinet Buffer
	~clarinetAudioBuffer = b = Buffer.read(s, basePath +/+ "audio/clarinet.wav");

	SynthDef("clarinetAudio",{ arg out=0,bufnum=0, trigger=1, startPos=0, loop=1;
		var rate;
		rate = 1.0; //using rate because it was slightly out of tune (too high pitched)
		Out.ar(out,
			Pan2.ar(PlayBuf.ar(1,bufnum, BufRateScale.kr(bufnum)*rate, trigger, BufFrames.ir(bufnum)*startPos, loop=0),0.0)
		);
	}).add;*/

		["flute", "clarinet", "oboe", "bassoon"].do({arg instrument; ~audioGenerator.value(instrument);});


	// Flute Button
	~woodwindsAudioButton = ~fluteAudioButton = r = Button(w, Rect(430, 497.5+~lowerButtons-~allShiftUp, 90, 26))
	.states_([["Woodwind", Color.white, Color(0.7569,0.1373,0.1725,1)], ["Woodwind", Color.white, Color(0,0,0,1)]])
	.font_(Font("nil", 14))
	.action_({
		arg obj;

		switch(~instrumentGroupWoodwindsDropdown.item,
			"Flute", {~spectraAudioButtonAction.value(obj:obj, instrument:"flute", instrumentGroup:"woodwinds");
				~freqslider.valueAction_(72.value.linlin(21,108,0,1));},
			"Clarinet", {~spectraAudioButtonAction.value(obj:obj, instrument:"clarinet", instrumentGroup:"woodwinds");
				~freqslider.valueAction_(60.value.linlin(21,108,0,1));},
			"Oboe", {~spectraAudioButtonAction.value(obj:obj, instrument:"oboe", instrumentGroup:"woodwinds");
				~freqslider.valueAction_(60.value.linlin(21,108,0,1));},
			"Bassoon", {~spectraAudioButtonAction.value(obj:obj, instrument:"bassoon", instrumentGroup:"woodwinds");
				~freqslider.valueAction_(60.value.linlin(21,108,0,1));}
		);

		// ~spectraAudioButtonAction.value(obj:obj, instrument:"flute");
	});


	// Percussion Audio Recordings
	// Marimba Buffer
	/*~marimbaAudioBuffer = Buffer.read(s, basePath +/+ "audio/marimba.wav");

	SynthDef("marimbaAudio",{ arg out=0,bufnum=0, trigger=1, startPos=0, loop=1;
		var rate;
		rate = 1.0; //using rate because it was slightly out of tune (too high pitched)
		Out.ar(out,
			Pan2.ar(PlayBuf.ar(1,bufnum, BufRateScale.kr(bufnum)*rate, trigger, BufFrames.ir(bufnum)*startPos, loop=0),0.0)
		);
	}).add;

	// Piano Buffer
	~pianoAudioBuffer = Buffer.read(s, basePath +/+ "audio/piano.wav");

	SynthDef("pianoAudio",{ arg out=0,bufnum=0, trigger=1, startPos=0, loop=1;
		var rate;
		rate = 1.0; //using rate because it was slightly out of tune (too high pitched)
		Out.ar(out,
			Pan2.ar(PlayBuf.ar(1,bufnum, BufRateScale.kr(bufnum)*rate, trigger, BufFrames.ir(bufnum)*startPos, loop=0),0.0)
		);
	}).add;*/

			["xylophone", "marimba", "vibraphone"].do({arg instrument; ~audioGenerator.value(instrument);});


	// Percussion Button
	~percussionAudioButton = ~hornAudioButton = f = Button(w, Rect(525, 497.5+~lowerButtons-~allShiftUp, 90, 26))
	.states_([["Percussion", Color.white, Color(0.7569,0.1373,0.1725,1)], ["Percussion", Color.white, Color(0,0,0,1)]])
	.font_(Font("nil", 14))
	.action_({
		arg obj;

		switch(~instrumentGroupPercussionDropdown.item,
			"Xylophone", {~spectraAudioButtonAction.value(obj:obj, instrument:"xylophone", instrumentGroup:"percussion");
				~freqslider.valueAction_(72.value.linlin(21,108,0,1));},
			"Marimba", {~spectraAudioButtonAction.value(obj:obj, instrument:"marimba", instrumentGroup:"percussion");
				~freqslider.valueAction_(60.value.linlin(21,108,0,1));},
			"Vibraphone", {~spectraAudioButtonAction.value(obj:obj, instrument:"vibraphone", instrumentGroup:"percussion");
				~freqslider.valueAction_(60.value.linlin(21,108,0,1));},
		);

		// ~spectraAudioButtonAction.value(obj:obj, instrument:"horn");
	});

	// Voice Audio Recordings
	/*// Tenor Buffer
	~voice_tenorAudioBuffer = Buffer.read(s, basePath +/+ "audio/voice_tenor.wav");

	SynthDef("voice_tenorAudio",{ arg out=0,bufnum=0, trigger=1, startPos=0, loop=1;
		var rate;
		rate = 1.0; //using rate because it was slightly out of tune (too high pitched)
		Out.ar(out,
			Pan2.ar(PlayBuf.ar(1,bufnum, BufRateScale.kr(bufnum)*rate, trigger, BufFrames.ir(bufnum)*startPos, loop=0),0.0)
		);
	}).add;

	// Tenor Buffer
	~voice_sopranoAudioBuffer = Buffer.read(s, basePath +/+ "audio/voice_soprano.wav");

	SynthDef("voice_sopranoAudio",{ arg out=0,bufnum=0, trigger=1, startPos=0, loop=1;
		var rate;
		rate = 1.0; //using rate because it was slightly out of tune (too high pitched)
		Out.ar(out,
			Pan2.ar(PlayBuf.ar(1,bufnum, BufRateScale.kr(bufnum)*rate, trigger, BufFrames.ir(bufnum)*startPos, loop=0),0.0)
		);
	}).add;*/

				["piano", "guitar"].do({arg instrument; ~audioGenerator.value(instrument);});


	// Tenor Button
	~voicesAudioButton = ~voice_tenorAudioButton = Button(w, Rect(620, 497.5+~lowerButtons-~allShiftUp, 90, 26))
	.states_([["Other", Color.white, Color(0.7569,0.1373,0.1725,1)], ["Other", Color.white, Color(0,0,0,1)]])
	.font_(Font("nil", 14))
	.action_({
		arg obj;

		switch(~instrumentGroupVoicesDropdown.item,
			/*"Tenor", {~spectraAudioButtonAction.value(obj:obj, instrument:"voice_tenor", instrumentGroup:"voices");},
			"Soprano", {~spectraAudioButtonAction.value(obj:obj, instrument:"voice_soprano", instrumentGroup:"voices");}*/
			"Piano", {~spectraAudioButtonAction.value(obj:obj, instrument:"piano", instrumentGroup:"voices");
				~freqslider.valueAction_(60.value.linlin(21,108,0,1));},
			"Guitar", {~spectraAudioButtonAction.value(obj:obj, instrument:"guitar", instrumentGroup:"voices");
				~freqslider.valueAction_(60.value.linlin(21,108,0,1));},
		);

		// ~spectraAudioButtonAction.value(obj:obj, instrument:"voice_tenor");
	});


	// Dynamic Spectra

	// Set all starting AudioHaltKeys to 1
	// This is used for an IF statement in spectra_button_functions
	// where turning off a small button only allows turnning off the big button IF Sum = 4
	~celloAudioHaltKey = 1;
	~trumpetAudioHaltKey = 1;
	~fluteAudioHaltKey = 1;
	~hornAudioHaltKey = 1;
	~voicesAudioHaltKey = 1;

	// Horn Dynamic
	~percussionDynamicButton = ~hornDynamicButton = u = Button(w, Rect(525, 457.5+~lowerButtons-~allShiftUp, 90, 26))
	.states_([["Percussion", Color.white, Color(0.7569,0.1373,0.1725,1)],["Percussion", Color.white, Color(0,0,0,1)]])
	.font_(Font("nil", 14))
	.action_({ arg obj;
		//~haltKey = 1;
		//	if(~hornDynamicButton.value != 0, {~hornDynamicButton.valueAction_(0);});
		if(~fluteDynamicButton.value != 0, {
			//~fluteDynamicButton.valueAction_(0);
			~fluteAudioHaltKey = 1;
		});
		if(~trumpetDynamicButton.value != 0, {
			//~trumpetDynamicButton.valueAction_(0);
			~trumpetAudioHaltKey = 1;
		});
		if(~celloDynamicButton.value != 0, {
			//~celloDynamicButton.valueAction_(0);
			~celloAudioHaltKey = 1;
		});
		if(~voicesDynamicButton.value != 0, {
			~voicesAudioHaltKey = 1;
		});


		switch(~instrumentGroupPercussionDropdown.item,
						"Xylophone", {~spectraDynamicButtonAction.value(obj:obj, instrument:"xylophone", instrumentGroup:"horn", harmonicAmount:16, fundamentalNote:72);},
			"Marimba", {~spectraDynamicButtonAction.value(obj:obj, instrument:"marimba", instrumentGroup:"horn", harmonicAmount:16, fundamentalNote:60);},
			"Vibraphone", {~spectraDynamicButtonAction.value(obj:obj, instrument:"vibraphone", instrumentGroup:"horn", harmonicAmount:16, fundamentalNote:60);},
			// "Piano", {~spectraDynamicButtonAction.value(obj:obj, instrument:"piano", instrumentGroup:"horn", harmonicAmount:16, fundamentalNote:60);}
		);

		// ~spectraDynamicButtonAction.value(obj:obj, instrument:"horn", harmonicAmount:16, fundamentalNote:60);
	});

	// Flute Dynamic
	~woodwindsDynamicButton = ~fluteDynamicButton = r = Button(w, Rect(430, 457.5+~lowerButtons-~allShiftUp, 90, 26))
	.states_([["Woodwind", Color.white, Color(0.7569,0.1373,0.1725,1)], ["Woodwind", Color.white, Color(0,0,0,1)]])
	.font_(Font("nil", 14))
	.action_({
		arg obj;

		//~haltKey = 1;
		if(~hornDynamicButton.value != 0, {
			//~hornDynamicButton.valueAction_(0);
			~hornAudioHaltKey = 1;
		});
		//	if(~fluteDynamicButton.value != 0, {~fluteDynamicButton.valueAction_(0);});
		if(~trumpetDynamicButton.value != 0, {
			//~trumpetDynamicButton.valueAction_(0);
			~trumpetAudioHaltKey = 1;
		});
		if(~celloDynamicButton.value != 0, {
			//~celloDynamicButton.valueAction_(0);
			~celloAudioHaltKey = 1;
		});
		if(~voicesDynamicButton.value != 0, {
			~voicesAudioHaltKey = 1;
		});

		/*if(~instrumentGroupWoodwindsDropdown.value == 0, {
			// Flute
		~spectraDynamicButtonAction.value(obj:obj, instrument:"flute", harmonicAmount:16, fundamentalNote:72);
		},{
			// Clarinet
~spectraDynamicButtonAction.value(obj:obj, instrument:"clarinet", harmonicAmount:16, fundamentalNote:60);
		});*/


		switch(~instrumentGroupWoodwindsDropdown.item,
			"Flute", {~spectraDynamicButtonAction.value(obj:obj, instrument:"flute", instrumentGroup:"flute", harmonicAmount:16, fundamentalNote:72);},
			"Clarinet", {~spectraDynamicButtonAction.value(obj:obj, instrument:"clarinet", instrumentGroup:"flute", harmonicAmount:16, fundamentalNote:60);},
						"Oboe", {~spectraDynamicButtonAction.value(obj:obj, instrument:"oboe", instrumentGroup:"flute", harmonicAmount:16, fundamentalNote:60);},
						"Bassoon", {~spectraDynamicButtonAction.value(obj:obj, instrument:"bassoon", instrumentGroup:"flute", harmonicAmount:16, fundamentalNote:60);}
		);


	});

	// Trumpet Dynamic
	~brassDynamicButton = ~trumpetDynamicButton = r = Button(w, Rect(335, 457.5+~lowerButtons-~allShiftUp, 90, 26))
	.states_([["Brass", Color.white, Color(0.7569,0.1373,0.1725,1)], ["Brass", Color.white, Color(0,0,0,1)]])
	.font_(Font("nil", 14))
	.action_({
		arg obj;
		//~haltKey = 1;
		if(~hornDynamicButton.value != 0, {
			//~hornDynamicButton.valueAction_(0);
			~hornAudioHaltKey = 1;
		});
		//	if(~fluteDynamicButton.value != 0, {~fluteDynamicButton.valueAction_(0);});
		if(~fluteDynamicButton.value != 0, {
			//~trumpetDynamicButton.valueAction_(0);
			~fluteAudioHaltKey = 1;
		});
		if(~celloDynamicButton.value != 0, {
			//~celloDynamicButton.valueAction_(0);
			~celloAudioHaltKey = 1;
		});
		if(~voicesDynamicButton.value != 0, {
			~voicesAudioHaltKey = 1;
		});

		switch(~instrumentGroupBrassDropdown.item,
			"Horn", {~spectraDynamicButtonAction.value(obj:obj, instrument:"horn", instrumentGroup:"trumpet", harmonicAmount:16, fundamentalNote:60);},
			"Trumpet", {~spectraDynamicButtonAction.value(obj:obj, instrument:"trumpet", instrumentGroup:"trumpet", harmonicAmount:16, fundamentalNote:60);},
						"Trombone", {~spectraDynamicButtonAction.value(obj:obj, instrument:"trombone", instrumentGroup:"trumpet", harmonicAmount:16, fundamentalNote:60);},
						"Tuba", {~spectraDynamicButtonAction.value(obj:obj, instrument:"tuba", instrumentGroup:"trumpet", harmonicAmount:16, fundamentalNote:60);}

		);

		//~spectraDynamicButtonAction.value(obj:obj, instrument:"trumpet", harmonicAmount:16, fundamentalNote:60);
	});

	// Cello Dynamic
	~stringsDynamicButton = ~celloDynamicButton = r = Button(w, Rect(240, 457.5+~lowerButtons-~allShiftUp, 90, 26))
	.states_([["Strings", Color.white, Color(0.7569,0.1373,0.1725,1)], ["Strings", Color.white, Color(0,0,0,1)]])
	.font_(Font("nil", 14))
	.action_({
		arg obj;
		//~haltKey = 1;

		if(~hornDynamicButton.value != 0, {
			//~hornDynamicButton.valueAction_(0);
			~hornAudioHaltKey = 1;
		});
		//	if(~fluteDynamicButton.value != 0, {~fluteDynamicButton.valueAction_(0);});
		if(~trumpetDynamicButton.value != 0, {
			//~trumpetDynamicButton.valueAction_(0);
			~trumpetAudioHaltKey = 1;
		});
		if(~fluteDynamicButton.value != 0, {
			//~fluteDynamicButton.valueAction_(0);
			~fluteAudioHaltKey = 1;
		});
		if(~voicesDynamicButton.value != 0, {
			~voicesAudioHaltKey = 1;
		});

		switch(~instrumentGroupStringsDropdown.item,
			"Cello", {~spectraDynamicButtonAction.value(obj:obj, instrument:"cello", instrumentGroup:"cello", harmonicAmount:16, fundamentalNote:60);},
			"Violin", {~spectraDynamicButtonAction.value(obj:obj, instrument:"violin", instrumentGroup:"cello", harmonicAmount:16, fundamentalNote:60);},
						"Viola", {~spectraDynamicButtonAction.value(obj:obj, instrument:"viola", instrumentGroup:"cello", harmonicAmount:16, fundamentalNote:60);},
						"Bass", {~spectraDynamicButtonAction.value(obj:obj, instrument:"bass", instrumentGroup:"cello", harmonicAmount:16, fundamentalNote:60);}
		);

		//~spectraDynamicButtonAction.value(obj:obj, instrument:"cello", harmonicAmount:16, fundamentalNote:60);
	});

	// Tenor Dynamic
	~voicesDynamicButton = ~voicesDynamicButton = ~voice_tenorDynamicButton = r = Button(w, Rect(620, 457.5+~lowerButtons-~allShiftUp, 90, 26))
	.states_([["Other", Color.white, Color(0.7569,0.1373,0.1725,1)], ["Other", Color.white, Color(0,0,0,1)]])
	.font_(Font("nil", 14))
	.action_({
		arg obj;
		//~haltKey = 1;

		if(~hornDynamicButton.value != 0, {
			//~hornDynamicButton.valueAction_(0);
			~hornAudioHaltKey = 1;
		});
		//	if(~fluteDynamicButton.value != 0, {~fluteDynamicButton.valueAction_(0);});
		if(~trumpetDynamicButton.value != 0, {
			//~trumpetDynamicButton.valueAction_(0);
			~trumpetAudioHaltKey = 1;
		});
		if(~fluteDynamicButton.value != 0, {
			//~fluteDynamicButton.valueAction_(0);
			~fluteAudioHaltKey = 1;
		});
		if(~celloDynamicButton.value != 0, {
			//~celloDynamicButton.valueAction_(0);
			~celloAudioHaltKey = 1;
		});

		switch(~instrumentGroupVoicesDropdown.item,
			/*"Tenor", {~spectraDynamicButtonAction.value(obj:obj, instrument:"voice_tenor", instrumentGroup:"voices", harmonicAmount:16, fundamentalNote:60);},
			"Soprano", {~spectraDynamicButtonAction.value(obj:obj, instrument:"voice_soprano", instrumentGroup:"voices", harmonicAmount:16, fundamentalNote:72);}*/
			"Piano", {~spectraDynamicButtonAction.value(obj:obj, instrument:"piano", instrumentGroup:"voices", harmonicAmount:16, fundamentalNote:60);},
			"Guitar", {~spectraDynamicButtonAction.value(obj:obj, instrument:"guitar", instrumentGroup:"voices", harmonicAmount:16, fundamentalNote:60);}
		);


		//~spectraDynamicButtonAction.value(obj:obj, instrument:"voice_tenor", harmonicAmount:16, fundamentalNote:51);
	});


	// Hide Voices for now
	/*StaticText(w, Rect(620, 413, 90, 35)).background_(Color.white);
		StaticText(w, Rect(620, 413+40, 90, 35)).background_(Color.white);
		StaticText(w, Rect(620, 413+80, 90, 35)).background_(Color.white);
		StaticText(w, Rect(620, 413+120, 90, 35)).background_(Color.white);*/


//Define the slider sounds to be played
~soundSynthDef_call = {
	(
		//~soundPhaseArray = [pi,pi,pi,pi,pi,pi,pi,pi,pi,pi,pi,pi,pi,pi,pi,pi];

SynthDef.new("sound", {
			arg vol = 0.2, freq = 21, f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,
				p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,p11,p12,p13,p14,p15,p16;
	var mul, signal, freqU, phase = ~soundPhaseArray;

			mul = XLine.kr(0.01,1,0.01,0.1); //Ramps sound onset so not so harsh

			freqU = ((2**((-69+freq)/12))*440);

	signal =
				SinOsc.ar(freqU, p1, vol*mul*f1) +
				SinOsc.ar(freqU*2, p2, vol*mul*f2) +
				SinOsc.ar(freqU*3, p3, vol*mul*f3) +
				SinOsc.ar(freqU*4, p4, vol*mul*f4) +
				SinOsc.ar(freqU*5, p5, vol*mul*f5) +
				SinOsc.ar(freqU*6, p6, vol*mul*f6)+
				SinOsc.ar(freqU*7, p7, vol*mul*f7)+
				SinOsc.ar(freqU*8, p8, vol*mul*f8)+
				SinOsc.ar(freqU*9, p9, vol*mul*f9)+
				SinOsc.ar(freqU*10, p10, vol*mul*f10)+
				SinOsc.ar(freqU*11, p11, vol*mul*f11)+
				SinOsc.ar(freqU*12, p12, vol*mul*f12)+
				SinOsc.ar(freqU*13, p13, vol*mul*f13)+
				SinOsc.ar(freqU*14, p14, vol*mul*f14)+
				SinOsc.ar(freqU*15, p15, vol*mul*f15)+
				SinOsc.ar(freqU*16, p16, vol*mul*f16)
				;

	Out.ar([0,1], signal); //sends to busses 1 & 2 (stereo), and plays the var "signal"
}).add;
);
	};

	~soundSynthDef_call.value;


	// Harmonic Panel
	// 16 Sliders

	(basePath +/+  "data/spectra_harmonics_panel.scd").load; //This calls the naming function from another code block to help keep this program clean and modular

	// Adapted from previous ~inspector:
	(
// CompositeView for the SPECTRA Harmonics Panel
~inspectorHarmonicsPanel =
CompositeView(w, Rect(10,145+230+10-~allShiftUp,20*16+20+60,20)).background_(Color.clear);

		~inspectorHarmonicsPanel_harmonic_box =
		StaticText(~inspectorHarmonicsPanel, Rect(0,0,60,15))
		.background_(Color.grey(0.8));

~inspectorHarmonicsPanel_harmonic_text =
StaticText(~inspectorHarmonicsPanel, Rect(0,0,60,15))
.string_(" Harmonic:")
.font_(Font("Helvetica", 12, false))
.align_(\left)
				.stringColor_(Color.grey(0));

~inspectorHarmonicsPanel_harmonic_number =
NumberBox(~inspectorHarmonicsPanel, Rect(57+2,0,20,15))
.font_(Font("Helvetica", 11))
.align_(\center)
.background_(Color.grey(0.8));

		~inspectorHarmonicsPanel_pitch_box =
		StaticText(~inspectorHarmonicsPanel, Rect(90,0,55,15))
		.background_(Color.grey(0.8));

~inspectorHarmonicsPanel_pitch_text =
StaticText(~inspectorHarmonicsPanel, Rect(90,0,60,15))
.string_(" Pitch:")
.font_(Font("Helvetica", 12, false))
.align_(\left)
		.stringColor_(Color.grey(0));

~inspectorHarmonicsPanel_pitch_number =
StaticText(~inspectorHarmonicsPanel, Rect(122+1,0,25,15))
.font_(Font("Helvetica", 11))
.align_(\center)
.string_(~note_name.asString)
.background_(Color.grey(0.8));

		~inspectorHarmonicsPanel_frequency_box =
		StaticText(~inspectorHarmonicsPanel, Rect(160,0,55,15))
		.background_(Color.grey(0.8));

~inspectorHarmonicsPanel_frequency_text =
StaticText(~inspectorHarmonicsPanel, Rect(160,0,60,15))
.string_(" Freq.:")
.font_(Font("Helvetica", 12, false))
.align_(\left)
		.stringColor_(Color.grey(0));

~inspectorHarmonicsPanel_frequency_number =
NumberBox(~inspectorHarmonicsPanel, Rect(193+2,0,40,15))
.font_(Font("Helvetica", 11))
.align_(\center)
.decimals_(0)
.background_(Color.grey(0.8));


		~inspectorHarmonicsPanel_intensity_box =
		StaticText(~inspectorHarmonicsPanel, Rect(245,0,130,15))
		.background_(Color.grey(0.8));

~inspectorHarmonicsPanel_intensity_text =
StaticText(~inspectorHarmonicsPanel, Rect(245+2,0,115,15))
		.string_(" Rel. Intensity        :")
.font_(Font("Helvetica", 12, false))
.align_(\left)
		.stringColor_(Color.grey(0));

		~inspectorHarmonicsPanel_intensity_text_units =
StaticText(~inspectorHarmonicsPanel, Rect(245+2+74,-1,115,15))
		.string_("(1/H1)")
.font_(Font("Arial", 9, false))
.align_(\left)
		.stringColor_(Color.grey(0));

~inspectorHarmonicsPanel_intensity_number =
NumberBox(~inspectorHarmonicsPanel, Rect(294+55,0,45,15))
.font_(Font("Helvetica", 11))
.align_(\center)
.maxDecimals_(4)
.background_(Color.grey(0.8));


		~inspectorHarmonicsPanel_cover =
		StaticText(~inspectorHarmonicsPanel, Rect(0,0,20*16+20+60,20)).background_(Color.clear); // Stops the user from attempting to edit these information panel values (as they would have no effect and be only confusing)

);



~quit = Button.new(w, Rect(10,65-~allShiftUp,30,30))
	.states_([["", Color.white, Color.clear]])
	.font_(Font("nil", 12))
	.action_({
		x.free;

		if(~fluteAudioButton.value == 1, {~fluteAudioButton.valueAction_(0)}); //z.free;
		if(~trumpetAudioButton.value == 1, {~trumpetAudioButton.valueAction_(0)}); //v.free;
		if(~hornAudioButton.value == 1, {~hornAudioButton.valueAction_(0)}); //t.free;
		if(~celloAudioButton.value == 1, {~celloAudioButton.valueAction_(0)}); //y.free;

		s.freeAll;

		/*a.free; //clear buffers to help resolve memory leak
		b.free;
		//e.free;
		l.free;*/
		~spectra_scope.kill; // Kills the FreqScopeView
		// ~d.quit; causes issues if ~d doesn't exist before quitting, in any case ~d closes automatically because it is parented to the w window
		// ~w2.close; //similar issue, but this does leave the oscilloscope open - workaround on splashscreen command

		(if(~scopebutton.value == 1, {
			~scopebutton.valueAction_(0); // New because two-state now
			}));

		h.kill;

		(if(~record.value == 1, {
			s.stopRecording; // Auto-stops recording if started
			}));

		(if(~key_vis.value == 1, {
			~keyboardWindow.close;
		}));
		(if(~scopebutton.value == 1, {
				~oscilloscopeCloseFunction.value;
			}));
		(if(~inspectorExists == 1, {
				~inspectorWindow.close;
			}));

		w.close;
		(basePath +/+ "splashscreen.scd").loadPaths;
		});

	//Open Stethoscope
~scopebutton = Button(w, Rect((690-40+~expandWidth), 112.5-~allShiftUp, 120, 20))
.states_([
	["Open Oscilloscope", Color.white,Color(0.4824, 0.4863, 0.4863,1)],
	["Close Oscilloscope", Color.white, Color.grey(0.251)]
])
.font_(Font("nil", 12))
	.action_({ // This still seems to cause an Error message of "cycle_" - July 17 2017
	/*arg obj;
	if(obj.value == 1,
		{*/
		arg obj;
		~oscilloscopeButtonFunction.value(obj:obj);
		if(~d != nil, {~d.cycle_(5*44100/~fundamental_freq);}); // Scales the Oscilloscope to attempt to fit the H1 frequency

});


/*~scope2button = Button(w, Rect((690-40), 132.5-~allShiftUp, 120, 20))
.states_([
	["Set Osc. to ~H1", Color.white,Color(0.4824, 0.4863, 0.4863,1)]
])
.font_(Font("nil", 12))
	.action_({
		/*~d
		//.xZoom_((438.9105/1024)*1)
		.cycle_((501));*/
	/*	{x}.plot*/

	if(~d != nil, {
		~d.cycle_(5*44100/~fundamental_freq);
		});

	}
	);*/


	//Keyboard visualizer button
		~key_vis = Button.new(w, Rect(575,70-~allShiftUp,60,25))
	.states_([["", Color.black, Color.clear],["CLOSE", Color.white, Color.black]])
	.font_(Font("nil", 10))
	.action_({

arg obj;
		if(obj.value == 1,
				// ~keyboard_open.value == 1,
			{
					// ~keyboard_open = 0;
	(basePath +/+  "modules/keyboard.scd").loadPaths; //This line allows all contact buttons to be updated automatically
		~freqslider.valueAction_(~fslider.value); //This allows it to refresh real-time
			},{

~keyboardWindow.close;
					// ~keyboard_open = 1;
		};);

		});

// Load the functions used to change the keyboard when a SYNTH or RECORDING is played by button:
	(basePath +/+  "data/keyboard_colour_change_array_load.scd").load;
	(basePath +/+  "data/keyboard_colour_change_array_fast.scd").load;



	~house_icon = Image.new(basePath +/+ "images/house-small.png");
	~maple_icon = Image.new(basePath +/+ "images/mapleICON-small.png");
~keyboard_image = Image.new(basePath +/+ "images/keyboard_small.png");

//Aesthetic lines
	w.drawFunc = {

		~house_icon.drawInRect(Rect(10,65-~allShiftUp,30,30), Rect(0,0,30,30), 2, 1.0);
		~maple_icon.drawInRect(Rect(760+25,65-~allShiftUp,30,30), Rect(0,0,30,30), 2, 1.0);
		~keyboard_image.drawInRect(Rect(575,70-~allShiftUp,60,25), Rect(0,0,60,25), 2, 1.0);
		Pen.line(10@(530-~allShiftUp),(790+~expandWidth)@(530-~allShiftUp)); //Sixth line
		Pen.line(10@(490-~allShiftUp),(790+~expandWidth)@(490-~allShiftUp)); //Fifth line
		Pen.line(10@(450-~allShiftUp),(790+~expandWidth)@(450-~allShiftUp)); //Fourth line
		Pen.line(10@(410-~allShiftUp),(790+~expandWidth)@(410-~allShiftUp)); //Third line
		Pen.line(10@(100-~allShiftUp),(790+~expandWidth)@(100-~allShiftUp)); //Second line

	Pen.strokeColor = Color(0,0,0,0.5); //Top line, written differently in code
                Pen.width = 2;
		// Pen.moveTo(10@60);
		// Pen.lineTo(790@60);
                Pen.stroke;
        };


	~instrumentsCover = StaticText(w, Rect(10,410+2-~allShiftUp,(790-10), 120+~lowerButtons)).background_(Color.white).string_(""
//Select 'Instruments' from the dropdown menu to access these hidden instrument settings.
).align_(\center);

	/*// On start, because Instruments is pre-selected
	~instrumentsCover.bounds_(Rect(10,410+2,(790-10), 120-120));*/ //Now Sine is pre-selected



//Record button - sends to Supercollider file
~record_button_bounds_array = [35+35, 70-~allShiftUp, 85, 20];
(basePath +/+  "modules/record_button.scd").load;

	/*~tech = Button.new(w, Rect(35, 70, 85, 20))
	.states_([
	["Start Recording", Color.white,Color(0.4824, 0.4863, 0.4863,1)],
	["Stop Recording", Color.white, Color.grey(0.251)]
])
	.font_(Font("nil", 10))
	.action_({
	arg obj;
	if(obj.value == 1,
		{
					s.record;
				},
		{
					s.stopRecording;

				}
	);
}
		);*/







	//Button to reset harmonic intensities
~reset = Button(w, Rect(110,110-~allShiftUp,35,20))
.states_([
	["Reset
intensities", Color.white,Color(0.4824, 0.4863, 0.4863,1)]
])
.font_(Font("nil", 6))
.action_({
		~fNsliderAction.value(intensityArray:[]);

		//~volslider.valueAction_(0.2.value.linlin(0,1,0,1));
});

	/*

	//Keyboard MIDI notation image button
		~midi_table = Button.new(w, Rect(10, 100, 20, 20))
	.states_([["?", Color.white, Color.gray]])
	.font_(Font("nil", 10))
	.mouseDownAction_({

				(basePath +/+  "modules/keyboard_image.scd").loadPaths; //This line allows all contact buttons to be updated automatically
	});
	*/

/*
	//Keyboard visualizer button
		~key_vis = Button.new(w, Rect(250,330,60,25))
	.states_([["", Color.black, Color.clear],["CLOSE", Color.white, Color.black]])
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
*/



//Gain Knob/Slider
~knob = Slider(w, Rect(640+200,-70,60,25)); //Placed off-screen, as a knob on the keyboard itself controls this value
	~knob.action_({~freqslider.valueAction_(~fslider.value); //This allows it to refresh real-time
s.makeBundle(1.0, //sound delay
			{~dirtyBit = 13; /*~dirtyBit.postln;*/~freqslider.valueAction_(~fslider.value);});});




//True note value
	~note_name = StaticText(w,Rect(180,112.5-~allShiftUp,70,15))
	.string_("A4").align_(\center)
	.font_(Font("nil", 11));


//Inspector button (remove upon Release)
~inspector = Button.new(w, Rect(10+35, 70-~allShiftUp, 20, 20))
	.states_([["(i)", Color.white, Color.gray], ["(i)", Color.gray, Color.black]])
	.font_(Font("nil", 10))
	.action_
	({ arg obj;
		if(obj.value == 1, {
		(basePath +/+  "modules/inspector.scd").loadPaths;
		},
		{
~inspectorWindow.close;
		});
	});

	( // Start with windows open
AppClock.sched(0.01,{
			~inspector.valueAction_(1); // Start with the inspector window open

			~scopebutton.valueAction_(1); // Start with the oscilloscopes open

			~key_vis.valueAction_(1); // Start with the keyboard window open
    nil;
});
);

w.onClose_({

		(if(~key_vis.value == 1, {
			~keyboardWindow.close;
		}));
		s.quit;
	}); //not working, rerouted to back button
})
 //ends server when quit
)
// ~d.cycle_(501)//can only go to 0 decimals anyways, rounds up at 5th-ish decimal
// 300.99999
// (~d.cycle).postln
