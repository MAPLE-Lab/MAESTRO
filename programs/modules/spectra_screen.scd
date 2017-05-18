
~spectraScreenComposite_bounds_left = ~spectraScreenComposite_bounds_array[0];
~spectraScreenComposite_bounds_top = ~spectraScreenComposite_bounds_array[1];
~spectraScreenComposite_bounds_width = ~spectraScreenComposite_bounds_array[2];
~spectraScreenComposite_bounds_height = ~spectraScreenComposite_bounds_array[3];

~composite = CompositeView(w, Rect(
	~spectraScreenComposite_bounds_left,
	~spectraScreenComposite_bounds_top,
	~spectraScreenComposite_bounds_width,
	~spectraScreenComposite_bounds_height));
//needs to use Spectra bounds to not crop FreqScope

	~intensifier = 1;


//Currently the if exists because SPECTRA uses h, while TUNING uses f. These should both be chaned to a single, common global variable.

if(~module_ID == "spectra",
	{
//Spectra viewer
// ~spectra_x = 500;
// ~spectra_y = 300;
// ~spectra_db = 70;
h = FreqScopeView.new(~composite, Rect.new(0,0,~spectra_x,~spectra_y)); //Prepares frequency scope (a.k.a. spectra)
h.active_(true).freqMode_(1).dbRange_(~spectra_db);

		~thingy = StaticText.new(~composite, Rect(0,0,500,50)).background_(Color.red);


	~spectra_x = Slider(~composite, Rect(0,~spectraScreenComposite_bounds_height-15,~spectraScreenComposite_bounds_width,15)).value_(0).action_({
		~spectra_width = ~spectra_x.value.linlin(0,1,~spectraScreenComposite_bounds_width,~spectraScreenComposite_bounds_width*10);
		h.bounds_(Rect.new(0,0,~spectra_width,~spectra_height));
	});

	~spectra_y = Slider(~composite, Rect(~spectraScreenComposite_bounds_width-15,0,15,~spectraScreenComposite_bounds_height-15)).value_(0.5).action_({
		~spectra_db = ~spectra_y.value.linlin(0,1,40,100);
h.dbRange_(~spectra_db);
	});


/*
///SPECTRA BUTTON
	//Add swapables for the pen lines to switch the frequency views

	~spectraButton = Button(w, Rect(250-(200/2)-65,200+135,110,20))
.states_([
		["Log View", Color.white,Color(0.7569,0.1373,0.1725,1)]
		,["Linear View", Color.white,Color(0.7569,0.1373,0.1725,1)]]

)
.font_(Font("nil", 12))
.action_(


				{

					arg obj;
	if(obj.value == 1,
						{


					f.freqMode_(0);
					~composite.bounds_(Rect(320,355,600,300));
					p.visible = false;

					// f.set(\bounds, Rect.new(100,100,600,300));
					// f.bounds_(Rect(100, 0, 300, 300);

						},{f.freqMode_(1); ~composite.bounds_(Rect(320-200,355,600,300));}
			)});
*/
	},

	{//~module_ID == "tuning",
f = FreqScopeView(~composite, Rect.new(0,0,~spectra_width,~spectra_height)); //Prepares frequency scope (a.k.a. spectra) from (-120,355,800,300) to (-100,355,600,300)) - for harmonic marker transformation maths
	f.active_(true).freqMode_(1).dbRange_(~spectra_db);	f.mouseOverAction_({~inspectorText.string_("This black screen shows a live (i.e. real-time, updating) spectra of the sounds being played.")}).mouseLeaveAction_({~inspectorText.string_(" ")});



~spectra_x = Slider(~composite, Rect(0,~spectraScreenComposite_bounds_height-15,~spectraScreenComposite_bounds_width,15)).value_(0).action_({
		~spectra_width = ~spectra_x.value.linlin(0,1,~spectraScreenComposite_bounds_width,~spectraScreenComposite_bounds_width*10);
		f.bounds_(Rect.new(0,0,~spectra_width,~spectra_height));
	});

	~spectra_y = Slider(~composite, Rect(~spectraScreenComposite_bounds_width-15,0,15,~spectraScreenComposite_bounds_height-15)).value_(0.5).action_({
		~spectra_db = ~spectra_y.value.linlin(0,1,40,100);
f.dbRange_(~spectra_db);
	});


});
