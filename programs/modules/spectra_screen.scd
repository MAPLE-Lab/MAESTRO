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
StaticText(~composite,Rect(10,~spectraScreenComposite_bounds_height-33,100,15))
.string_("Frequency")
.align_(\topLeft)
.stringColor_(Color.white)
.background_(Color(0,0,0,0));

//Starting variable values for the sliders
~spectra_width = ~spectraScreenComposite_bounds_width;
~spectra_height = ~spectraScreenComposite_bounds_height;

//Sliders to scale the spectra
~spectra_x = Slider(~composite, Rect(
	0,
	~spectraScreenComposite_bounds_height-15,
	~spectraScreenComposite_bounds_width,
	15))
.value_(0)
.action_({
	~spectra_width = ~spectra_x.value.linlin(0,1,~spectraScreenComposite_bounds_width,~spectraScreenComposite_bounds_width*10);
	~spectra_scope.bounds_(Rect.new(0,0,~spectra_width,~spectra_height));
	});

~spectra_y = Slider(~composite, Rect(
	~spectraScreenComposite_bounds_width-15,
	0,
	15,
	~spectraScreenComposite_bounds_height-15))
.value_(0.5)
.action_({
	~spectra_db = ~spectra_y.value.linlin(0,1,0,140);
	~spectra_scope.dbRange_(~spectra_db);
	});

//Button to change between Log to Linear view
~spectraButton = Button(w, Rect(
		~spectraButton_bounds_array[0],
		~spectraButton_bounds_array[1],
		~spectraButton_bounds_array[2],
		~spectraButton_bounds_array[3]))
.states_([
		["Log View", Color.white,Color(0.4824, 0.4863, 0.4863,1)],
		["Linear View", Color.white,Color(0.4824, 0.4863, 0.4863,1)]]
	)
.font_(Font("nil", 12))
.action_({
	arg obj;
	if(obj.value == 1,
		{~spectra_scope.freqMode_(0);},
		{~spectra_scope.freqMode_(1);})
});

//Button to auto-scale
~spectraButton = Button(w, Rect(
		~spectraAutoscale_bounds_array[0],
		~spectraAutoscale_bounds_array[1],
		~spectraAutoscale_bounds_array[2],
		~spectraAutoscale_bounds_array[3]))
.states_([
		["Autoscale", Color.white,Color(0.4824, 0.4863, 0.4863,1)]]
	)
.font_(Font("nil", 12))
.action_({

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

//4. Calculate the position of ~spectra_x to autoscale the screen
if(~spectra_scope.freqMode == 1,{

		//If the spectra is set to Log view
		~spectra_x.valueAction = 2 ** ((-0.01)*(~sixteenth_of_max_freq+310));
	},{
		//If the spectra is set to Linear view
		~spectra_x.valueAction = 2 ** ((-0.008)*(~sixteenth_of_max_freq-110));
	});
};);

//Activate this line of code for a width and top representation of the screen position (for WIP coding help)
//~thingy = StaticText.new(~composite, Rect(10,0,500,50)).background_(Color.red);