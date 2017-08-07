//Modularized code that creates a spectra. Requires the following code in the starting code:
// ~spectraScreenComposite_bounds_array = [?,?,?,?];
// ~spectraButton_bounds_array = [?,?,?,?];
// (basePath +/+  "modules/spectra_screen.scd").load;

// Remove any residual FreqScope
// (only if the FreqScope has been created previously, using the IF structure)
if(~spectra_scope != nil, {
	~spectra_scope.kill;
});

//Define variable values for the spectra composite view
~spectraScreenComposite_bounds_left = ~spectraScreenComposite_bounds_array[0];
~spectraScreenComposite_bounds_top = ~spectraScreenComposite_bounds_array[1];
~spectraScreenComposite_bounds_width = ~spectraScreenComposite_bounds_array[2];
~spectraScreenComposite_bounds_height = ~spectraScreenComposite_bounds_array[3];

//Create the CompositeView for the spectra
//This allows scaling and cropping of the spectra without changing the frequency scale on first creation of the spectra
~composite = CompositeView(w, Rect(
	~spectraScreenComposite_bounds_left,
	~spectraScreenComposite_bounds_top,
	~spectraScreenComposite_bounds_width,
	~spectraScreenComposite_bounds_height));

//Set the decibel range of the spectra
~spectra_db = 70;

// Create black background
StaticText.new(~composite, Rect(
	0,
	0,
	~spectraScreenComposite_bounds_width,
	~spectraScreenComposite_bounds_height
)).background_(Color.black);

//Creates the spectra
~spectra_scope = f = h = FreqScopeView.new(~composite, Rect.new(0,0,~spectraScreenComposite_bounds_width,~spectraScreenComposite_bounds_height));

//Prepares frequency scope (a.k.a. spectra)
~spectra_scope.active_(true).freqMode_(1).dbRange_(~spectra_db)

//Implements the hovertext for the inspector window
.mouseOverAction_({
	if(~inspectorExists == 1, {
		~inspectorText.string_("This black screen shows a live (i.e. real-time, updating) spectra of the sounds being played.")
});})
.mouseLeaveAction_({
	if(~inspectorExists == 1, {
		~inspectorText.string_(" ")
});});

//Label for Spectra
if(~module_ID == "spectra",
{
~spectraTitle = StaticText(~composite,Rect(0,0,~spectraScreenComposite_bounds_width,20))
.string_("Spectra")
.font_(Font("nil", 18))
.align_(\top)
.background_(Color(0,0,0,0))
.stringColor_(Color.white);
},{
~spectraTitle = StaticText(w,Rect(10,335,480,80))
.string_("Spectra")
.font_(Font("nil", 16))
.align_(\topLeft)
.background_(Color(0,0,0,0))
.stringColor_(Color.black);
});

//x-axis (Frequency) label
StaticText(~composite,Rect(10,~spectraScreenComposite_bounds_height-33-15,100,15))
.string_("Frequency")
.align_(\topLeft)
.stringColor_(Color.white)
.background_(Color(0,0,0,0));

//Starting variable values for the sliders
~spectra_width = ~spectraScreenComposite_bounds_width;
~spectra_height = ~spectraScreenComposite_bounds_height;
~spectraShiftHorizontal = 0;

//Sliders to scale the spectra
~spectra_xLabel = StaticText(~composite, Rect(
	0,
	~spectraScreenComposite_bounds_height-30+1,
	~spectraScreenComposite_bounds_width-10,
	15))
.string_("Scale of Spectra")
.align_(\right)
.stringColor_(Color.white)
.font_(Font("Helvetica", 8));

~spectra_xShiftLabel = StaticText(~composite, Rect(
	0,
	~spectraScreenComposite_bounds_height-30+15+1,
	~spectraScreenComposite_bounds_width-10,
	15))
.string_("Horizontal Shift of Spectra")
.align_(\right)
.stringColor_(Color.white)
.font_(Font("Helvetica", 8));

~spectra_x = Slider(~composite, Rect(
	0,
	~spectraScreenComposite_bounds_height-30,
	~spectraScreenComposite_bounds_width,
	15))
.value_(0)
.background_(Color.grey(0.75,0)) // Sliders cannot do alpha 0, but can do alpha 0.25
.action_({
	~spectra_width = ~spectra_x.value.linlin(0,1,~spectraScreenComposite_bounds_width,~spectraScreenComposite_bounds_width*10);
	~spectra_scope.bounds_(Rect.new(~spectraShiftHorizontal,0,~spectra_width,~spectra_height));

			//~sliderDataPost.value;
	});

~spectra_y = Slider(~composite, Rect(
	~spectraScreenComposite_bounds_width-15,
	0,
	15,
	~spectraScreenComposite_bounds_height-15-15))
.value_(0.5)
.action_({
	~spectra_db = ~spectra_y.value.linlin(0,1,0,140);
	~spectra_scope.dbRange_(~spectra_db);
	});

~spectra_xShift = Slider(~composite, Rect(
	0,
	~spectraScreenComposite_bounds_height-15,
	~spectraScreenComposite_bounds_width,
	15))
.value_(1)
.background_(Color.grey(0.25,0))
.action_({
	~spectraShiftHorizontal = ~spectra_xShift.value.linlin(0,1,-700,0);
	~spectra_scope.bounds_(Rect.new(~spectraShiftHorizontal,0,~spectra_width,~spectra_height));

	//~sliderDataPost.value;
	});

// Function to see the values of the sliders (currently not in use but is fully functional if needed for troubleshooting)
~sliderDataPost = {
	["~spectra_x", ~spectra_x.value].postln;
	["~spectra_xShift", ~spectra_xShift.value].postln;
	["~spectra_y", ~spectra_y.value].postln;
};

// View button toggle design
StaticText(w, Rect(
		~spectraButton_bounds_array[0]+1,
		~spectraButton_bounds_array[1]+1,
		~spectraButton_bounds_array[2]-1,
		~spectraButton_bounds_array[3]-2))
.background_(Color.grey(0.8));

StaticText(w, Rect(
		~spectraButton_bounds_array[0]+5,
		~spectraButton_bounds_array[1]+5,
		~spectraButton_bounds_array[2]-5,
		~spectraButton_bounds_array[3]-5-5))
.string_("Log.  ")
.font_(Font(nil, 8))
.align_(\right);

StaticText(w, Rect(
		~spectraButton_bounds_array[0]+5,
		~spectraButton_bounds_array[1]+5,
		~spectraButton_bounds_array[2]-5,
		~spectraButton_bounds_array[3]-5-5))
.string_("Lin.            ")
.font_(Font(nil, 8))
.align_(\right);

~spectraViewButtonToggleKnob = Button(w, Rect(
		~spectraButton_bounds_array[0]+~spectraButton_bounds_array[2]-50,
		~spectraButton_bounds_array[1]+1,
		25,
		~spectraButton_bounds_array[3]-2))
.action_({

	if(~spectraViewButton.value == 0, {
		~spectraViewButton.valueAction_(1)
	},{
		~spectraViewButton.valueAction_(0)
	});

});

~spectraViewButtonMain = Button(w, Rect(
		~spectraButton_bounds_array[0],
		~spectraButton_bounds_array[1],
		~spectraButton_bounds_array[2]-50,
		~spectraButton_bounds_array[3]))
.states_([
		["View Mode", Color.white,Color(0.4824, 0.4863, 0.4863,1)],
		["View Mode", Color.white,Color(0.4824, 0.4863, 0.4863,1)]]
	);

//Button to change between Log to Linear view
~spectraViewButton = Button(w, Rect(
		~spectraButton_bounds_array[0],
		~spectraButton_bounds_array[1],
		~spectraButton_bounds_array[2],
		~spectraButton_bounds_array[3]))
.states_([
		["View Mode", Color.clear,Color(0.4824, 0.4863, 0.4863,0)],
		["View Mode", Color.clear,Color(0.4824, 0.4863, 0.4863,0)]]
	)
.font_(Font("nil", 12))
.action_({
	arg obj;

	if(obj.value == 1,
		{~spectra_scope.freqMode_(0);},
		{~spectra_scope.freqMode_(1);});

	if(obj.value == 1,  {

		// Set to ON toggle position
		~spectraViewButtonToggleKnob.bounds_(Rect(
		~spectraButton_bounds_array[0]+~spectraButton_bounds_array[2]-50+25,
		~spectraButton_bounds_array[1]+1,
		25,
		~spectraButton_bounds_array[3]-2));
	},{
		// Reset to OFF toggle position
		~spectraViewButtonToggleKnob.bounds_(Rect(
		~spectraButton_bounds_array[0]+~spectraButton_bounds_array[2]-50,
		~spectraButton_bounds_array[1]+1,
		25,
		~spectraButton_bounds_array[3]-2));
	}
	);


	//~spectra_scopeAutoscaleFunction.value; // If uncommented, automatically updates the Autoscale

	if(~spectraAutoscaleButton.value == 1, {

		if(~temporaryDisableAutoscale == 0, {

		~spectra_scopeAutoscaleFunction.value;
		});

		});

});


// Autoscale button toggle design
StaticText(w, Rect(
		~spectraAutoscale_bounds_array[0]+1,
		~spectraAutoscale_bounds_array[1]+1,
		~spectraAutoscale_bounds_array[2]-1,
		~spectraAutoscale_bounds_array[3]-2))
.background_(Color.grey(0.8));

StaticText(w, Rect(
		~spectraAutoscale_bounds_array[0]+5,
		~spectraAutoscale_bounds_array[1]+5,
		~spectraAutoscale_bounds_array[2]-5,
		~spectraAutoscale_bounds_array[3]-5-5))
.string_("OFF  ")
.font_(Font(nil, 8))
.align_(\right);

StaticText(w, Rect(
		~spectraAutoscale_bounds_array[0]+5,
		~spectraAutoscale_bounds_array[1]+5,
		~spectraAutoscale_bounds_array[2]-5,
		~spectraAutoscale_bounds_array[3]-5-5))
.string_("ON            ")
.font_(Font(nil, 8, true))
.align_(\right)
.stringColor_(Color.black);

~spectraAutoscaleButtonToggleKnob = Button(w, Rect(
		~spectraAutoscale_bounds_array[0]+~spectraAutoscale_bounds_array[2]-50,
		~spectraAutoscale_bounds_array[1]+1,
		25,
		~spectraAutoscale_bounds_array[3]-2))
.action_({

	if(~spectraAutoscaleButton.value == 0, {
		~spectraAutoscaleButton.valueAction_(1)
	},{
		~spectraAutoscaleButton.valueAction_(0)
	});

});

~spectraAutoscaleButtonMain = Button(w, Rect(
		~spectraAutoscale_bounds_array[0],
		~spectraAutoscale_bounds_array[1],
		~spectraAutoscale_bounds_array[2]-50,
		~spectraAutoscale_bounds_array[3]))
.states_([
	["Autoscale", Color.white,Color(0.4824, 0.4863, 0.4863,1)],
	["Autoscale", Color.white, Color(0.4824, 0.4863, 0.4863,1)]
]
	);


//Button to auto-scale
~spectraAutoscaleButton = Button(w, Rect(
		~spectraAutoscale_bounds_array[0],
		~spectraAutoscale_bounds_array[1],
		~spectraAutoscale_bounds_array[2],
		~spectraAutoscale_bounds_array[3]))
.states_([
	["Autoscale", Color.clear,Color(0.4824, 0.4863, 0.4863,0)],
	["Autoscale", Color.clear, Color(0.4824, 0.4863, 0.4863,0)]
]
	)
.font_(Font("nil", 12))
.action_({
	arg obj;

	if(obj.value == 1,  {

~spectra_scopeAutoscaleFunction.value;


		// Set to ON toggle position
		~spectraAutoscaleButtonToggleKnob.bounds_(Rect(
		~spectraAutoscale_bounds_array[0]+~spectraAutoscale_bounds_array[2]-50+25,
		~spectraAutoscale_bounds_array[1]+1,
		25,
		~spectraAutoscale_bounds_array[3]-2));

		/*~spectraButton.bounds_(Rect(
		~spectraAutoscale_bounds_array[0]+50+2,
		~spectraAutoscale_bounds_array[1]+2,
		~spectraAutoscale_bounds_array[2]-50-2,
		~spectraAutoscale_bounds_array[3]-2-2));*/

	},{
		// Reset to OFF toggle position
		~spectraAutoscaleButtonToggleKnob.bounds_(Rect(
		~spectraAutoscale_bounds_array[0]+~spectraAutoscale_bounds_array[2]-50,
		~spectraAutoscale_bounds_array[1]+1,
		25,
		~spectraAutoscale_bounds_array[3]-2));
	/*~spectraButton.bounds_(Rect(
		~spectraAutoscale_bounds_array[0]+2,
		~spectraAutoscale_bounds_array[1]+2,
		~spectraAutoscale_bounds_array[2]-50-2,
		~spectraAutoscale_bounds_array[3]-2-2));*/
	}
	);


};);

// The autoscale function
~spectra_scopeAutoscaleFunction = {

//The following sequence of code calculates how the ~spectra_x slider should move to fit all played harmonics on screen

//1. Calculates the fundamental frequency from the MIDINN
~fundamental_freq = ((2**((-69+~fundamental_note)/12))*440);

//2. Calculates the frequency of highest harmonic being played, method depending on the module

//If the module is SPECTRA
if(~module_ID == "spectra",{

		//Create new array from original harmonic intensity array
		~energyTruncated = ~energy;

		//Check if the last harmonic intensity in the array (i.e. 16th harmonic) is 0
		//If it is, all 16 harmonics are playing; otherwise, run a WHILE code
		if(
			and(
				(~celloAudioHaltKey + ~trumpetAudioHaltKey + ~fluteAudioHaltKey + ~hornAudioHaltKey + ~voicesAudioHaltKey) == 5,

				and(

				(~stringsAudioButton.value + ~brassAudioButton.value + ~woodwindsAudioButton.value + ~percussionAudioButton.value + ~voicesAudioButton.value) == 0,

					(~stringsPowerButton.value + ~brassPowerButton.value + ~woodwindsPowerButton.value + ~percussionPowerButton.value + ~voicesPowerButton.value) == 0
				)
			), { // If a Dynamic sound is NOT playing, caluclate; otherwise just assume 16
			if(~energyTruncated.last == 0, {

			//While the last harmonic intensity in the array is 0, remove the last item from the array
			while ( { ~energyTruncated.last == 0 }, {
				~energyTruncated = ~energyTruncated.drop(-1);
				~energyTruncated.postln;

				//This line will not activate until the new truncated harmonic intensity array has not 0 as the last harmonic
				if (~energyTruncated.last != 0, {("Done: Up to the"+~energyTruncated.size++"th harmonic is being played").postln});
			});
		},{
			//This line activates if all 16 harmonics have a non-zero intensity
			"All 16 harmonics being played".postln;
		});
		},{ // Dynamic or Audio is playing
			~energyTruncated = Array.fill(16,1);
		});

		//The maximum frequency is calculated
		~max_freq = ~energyTruncated.size*~fundamental_freq;
	},{
		//If the module is TUNING
		//This does NOT take into account deviation, as the deviation is generally inconsequential for scaling
		~max_freq = ~harmonic_count*~fundamental_freq;
});

//3. Using the previously calculated maximum frequency, take the 16th of that value
//If all 16 harmonics are being played, the functions follows a reasonable curve (from trial and error testing) based on the fundamental frequency; however, because the maximum frequency cannot be higher than the 16th harmonic, this formula allows the auto-adjustment of the scaling regardless of whether it is the 16th harmonic or less.
~sixteenth_of_max_freq = ~max_freq/16;

	if(~module_ID == "spectra",{
		// For Spectra:
		~freqSurrogateVar = ((~energyTruncated.size+1)*~fundamental_freq)/16;
	},{
		~freqSurrogateVar = ((~harmonic_count+1)*~fundamental_freq)/16;
	});

//4. Calculate the position of ~spectra_x to autoscale the screen
if(~spectra_scope.freqMode == 1,{

		//If the spectra is set to Log view
		//~spectra_x.valueAction = 2 ** ((-0.01)*(~freqSurrogateVar+310));

		if(~freqSurrogateVar > 90, {
			// Above 90Hz

			if(~freqSurrogateVar < 900, {
					// Between 90Hz and 900Hz


					if(~freqSurrogateVar < 115, {
						// Between 90Hz and 115Hz
						~spectra_xShift.valueAction = (log10(~freqSurrogateVar-70))*(-0.39)+1.5;
					},{
						// Between 115Hz and 1200Hz

						// In SC, log = ln, and log10 = log_10. In Excel, LOG = log_10
						~spectra_xShift.valueAction = (log10(~freqSurrogateVar-70))*(-0.375)+1.5;
					});


					if(~freqSurrogateVar < 290, {
						// Between 90Hz and 290Hz
						~spectra_x.valueAction =0.013*sqrt(~freqSurrogateVar/10-9.276)+0.07;
					},{
						// Between 290Hz and 900Hz
						~spectra_x.valueAction = ~freqSurrogateVar*0.00001+0.125;
					});




					/* When it used to be < 1900Hz
				// Between 90Hz and 1900Hz


				if(~freqSurrogateVar < 1200, {
					// Between 90Hz and 1200Hz

					if(~freqSurrogateVar < 115, {
						// Between 90Hz and 115Hz
						~spectra_xShift.valueAction = (log10(~freqSurrogateVar-70))*(-0.39)+1.5;
					},{
						// Between 115Hz and 1200Hz

				~spectra_xShift.valueAction = (log10(~freqSurrogateVar-70))*(-0.375)+1.5;
				// In SC, log = ln, and log10 = log_10. In Excel, LOG = log_10
					});


				},{
					// Between 1200Hz and 1900Hz
					~spectra_xShift.valueAction = (log10(~freqSurrogateVar-70))*(-0.4)+1.5;
				});


				if(~freqSurrogateVar < 290, {
					// Between 90Hz and 290Hz
					~spectra_x.valueAction =0.013*sqrt(~freqSurrogateVar/10-9.276)+0.07;
				},{
					// Between 290Hz and 1900Hz
					~spectra_x.valueAction = ~freqSurrogateVar*0.00001+0.125;
				});*/


			},{
				// Above 900Hz
					~spectra_xShift.valueAction = 0.530726257;
					~spectra_x.valueAction = 0.092178771;

				/*if(~freqSurrogateVar < 2900, {
					// Between 1900Hz and 2900Hz
					~spectra_x.valueAction = 0.198;
				},{
					// Above 2900Hz
					~spectra_x.valueAction = 0.207;
				});*/

			});

		},{
			// Less than 90Hz
			~spectra_xShift.valueAction = 1;
			~spectra_x.valueAction = ~freqSurrogateVar*(-0.0015)+0.155;
		});


	},{
		//If the spectra is set to Linear view

		~spectra_xShift.valueAction = 1;

		if(~freqSurrogateVar > 150, {
			//  150Hz or higher
			if(~freqSurrogateVar < 1400, {
				// Between 150Hz and 1400 Hz
				~spectra_x.valueAction = (2.9-log10(~freqSurrogateVar-139))*(0.5)
			}, {
				// Above 1400 Hz
				~spectra_x.valueAction = 0
			}
			);
		}, {
			// Less than 150Hz
			~spectra_x.valueAction = 1
		});

	});
		};

//Activate this line of code for a width and top representation of the screen position (for WIP coding help)
//~thingy = StaticText.new(~composite, Rect(10,0,500,50)).background_(Color.red);