//Modularized code that creates a spectra. Requires the following code in the starting code:
// ~spectraScreenComposite_bounds_array = [?,?,?,?];
// ~spectraButton_bounds_array = [?,?,?,?];
// (basePath +/+  "modules/spectra_screen.scd").load;

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
~spectra_scope.active_(true).freqMode_(1).dbRange_(~spectra_db).mouseOverAction_({~inspectorText.string_("This black screen shows a live (i.e. real-time, updating) spectra of the sounds being played.")}).mouseLeaveAction_({~inspectorText.string_(" ")});

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
}
);

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

	~spectra_y = Slider(~composite, Rect(~spectraScreenComposite_bounds_width-15,0,15,~spectraScreenComposite_bounds_height-15))
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

//~thingy = StaticText.new(~composite, Rect(10,0,500,50)).background_(Color.red);