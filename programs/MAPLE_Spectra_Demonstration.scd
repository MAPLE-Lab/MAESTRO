// "Spectra Demonstration"
(var basePath = thisProcess.nowExecutingPath.asString.dirname;
Window.closeAll;

s.waitForBoot({
a.free; //clear buffers to help resolve memory leak
		b.free;
		e.free;
	s.freeAll;
	//Ensures it only opens once the server is working completely, and automatically opens server
	s.prepareForRecord; //Avoid recording delay
	w = Window.new("MAPLE Lab Spectra Demonstration (Beta)", Rect.new(
	Window.screenBounds.width/2-400,
	Window.screenBounds.height/2-50,
		800,530),false).background_(Color.white).userCanClose_(false).front;//Creates the new window with title
	// w.view.background = Color(0.9,0.9,0.9,1);


//Dirty bit used in GUI updating sync
	~dirtyBit = 0;



	////Spectra

	~composite = CompositeView(w, Rect(320,105,500,300)); //needs to use Spectra bounds to not crop FreqScope

//Spectra viewer
h = FreqScopeView.new(~composite, Rect.new(0,0,500,300)); //Prepares frequency scope (a.k.a. spectra)
h.active_(true).freqMode_(1).dbRange_(70);

	// s.onBootAdd({~scopebutton.valueAction_(1);});

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






//Label for paragraph
~para = StaticText(w,Rect(10,10,790,80))
	.string_("Welcome to the MAPLE Lab Spectra Demonstration (Beta)! Using the parameters below, you can examine timbre of sounds. Select the fundamental frequency and the intensity of each harmonic. Use the Play/Mute button to start and stop the sound. To explore how power spectra are not representative of real instruments, try playing a dynamic spectra sound.")
.font_(Font("nil", 12))
.align_(\topLeft)
.background_(Color(0,0,0,0))
.stringColor_(Color.black);


//Left cheap box
StaticText(w,Rect(0,105,410,300))
.background_(Color.white);

//Right cheap box
StaticText(w,Rect(790,105,410,300))
.background_(Color.white);

	//Harmonics cheap box
StaticText(w,Rect(10,105,380,25))
.background_(Color(0,0,0,0.0));


/*
//Axes

	//Harmonic positions marker

	~fsliderharm3 = Slider(w, Rect(410,360,380,20))
	.background_(Color(0,0,0,0))
	.value_(0.43121693121693)
	.thumbSize_(0)
	.knobColor_(Color(1,1,1,0))
	.orientation_(\horizontal)
	.action_({
	arg obj;
	var cf;
		// cf = obj.value.linlin(0,1,0,1).postln;
	});

		~fsliderharm2 = Slider(w, Rect(410,360,380,20))
	.background_(Color(0,0,0,0))
	.value_(0.35185185185185)
	.thumbSize_(0)
	.knobColor_(Color(1,1,1,0)) //QGUI does not handle transparent sliders yet http://new-supercollider-mailing-lists-forums-use-these.2681727.n2.nabble.com/QSlider-background-alpha-0-0-not-transparent-td7590743.html
	.orientation_(\horizontal)
	.action_({
	arg obj;
	var cf;
		// cf = obj.value.linlin(0,1,0,1).postln;
	});

	~fsliderharm1 = Slider(w, Rect(410,360,380,20))
	.background_(Color(0,0,0,0))
	.value_(0.22222222222222)
	.thumbSize_(0)
	.knobColor_(Color(1,1,1,0))
	.orientation_(\horizontal)
	.action_({
	arg obj;
	var cf;
		// cf = obj.value.linlin(0,1,0,1).postln;
	});


	/*StaticText(w,Rect(430,380,2,20)) ////COMMENTED UNTIL COMPLETE
	.background_(Color.white);*/



StaticText(w,Rect(410,360,500,2))
	.background_(Color.white);

	// StaticText(w,Rect(0,622,500,33))
	// .background_(Color(0,0,0,0.8)); //old dark bottom cover
	*/

	StaticText(w,Rect(420,380,500,33))
	.string_("Frequency")
	.align_(\topLeft)
	.stringColor_(Color.white)
	.background_(Color(0,0,0,0));



//Play Forced sounds button
~button = Button(w, Rect(400-(330/2),65,330,30))
.states_([
	["Click to Play Power Spectra Sounds", Color.white,Color(0.7569,0.1373,0.1725,1)],
	["Click to Mute Power Spectra Sounds", Color.white, Color.grey(0.251)]
])
.font_(Font("nil", 18))
.action_({
	arg obj;
	if(obj.value == 1,
		{~freqslider.valueAction_(~fslider.value); //This allows it to refresh real-time
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

				]
			).register;
				l.free;
				y.free;
				z.free;
				v.free;
		t.free;

		},
		{x.free; ~vinbutton.valueAction_(0);}
	);
});


	//Label for Forced Choice
~para = StaticText(w,Rect(10,420,380,20))
	.string_("Power Spectra")
.font_(Font("nil", 18))
.align_(\topLeft)
.background_(Color(0,0,0,0))
.stringColor_(Color.black);

//Dropdown menus
//Preset
	(
s.waitForBoot({

 var menu, snd, funcs2, b;


 ~vinbutton = Button(w, Rect(620, 417.5, 170, 25))
			.states_([["            Click to Play", Color.white, Color(0.7569,0.1373,0.1725,1)], ["            Click to Stop", Color.white, Color.black]])
   .mouseDownAction_(

				{
					arg obj;
	if(obj.value == 0,
						{
    snd = funcs2.at(menu.value).play;
						},{x.free; ~button.valueAction_(0); ~vinbutton.valueAction_(1);}
			)})
  .action_({ arg mod;
    snd.release;
   });

menu = PopUpMenu(w, Rect(622.5, 420, 60, 20));
			menu.items_(["Sine", "Sawtooth", /*"Triangle",*/ "Square"]);
			menu.font_(Font(\size, 12));
			menu.action = { arg menu;

				// [menu.value, menu.item, menu.action].postln; //These lines allow below allow the menu clicker to auto-set the choice selected (not requiring to click on-off the button to set the dropdown selection)
~vinbutton.valueAction_(0);
				x.free;
				~vinbutton.valueAction_(1);
snd = funcs2.at(menu.value).play;
l.free;
		z.free;
		v.free;
		t.free;
		y.free;

				// x.set(menu.action);

			};


 funcs2 = [
				{ //sine
		var variable;
		variable = SinOsc.kr(2); //unfortunately the QtGUI cannot use variables in this slider (error message)
		~freqslider.valueAction_(69.value.linlin(21,108,0,1)); //only need to affect slider to affect the number box and true sound value

					~volslider.valueAction_(1.value.linlin(0,1,0,1));

					~f1slider.valueAction_(2.value.linlin(0.0,2,0,1));
		~f2slider.valueAction_(0.value.linlin(0.0,2,0,1));
		~f3slider.valueAction_(0.value.linlin(0.0,2,0,1));
		~f4slider.valueAction_(0.value.linlin(0.0,2,0,1));
		~f5slider.valueAction_(0.value.linlin(0.0,2,0,1));
		~f6slider.valueAction_(0.value.linlin(0.0,2,0,1));
		~f7slider.valueAction_(0.value.linlin(0.0,2,0,1));
		~f8slider.valueAction_(0.value.linlin(0.0,2,0,1));
		~f9slider.valueAction_(0.value.linlin(0.0,2,0,1));
		~f10slider.valueAction_(0.value.linlin(0.0,2,0,1));
		~f11slider.valueAction_(0.value.linlin(0.0,2,0,1));
		~f12slider.valueAction_(0.value.linlin(0.0,2,0,1));
		~f13slider.valueAction_(0.value.linlin(0.0,2,0,1));
		~f14slider.valueAction_(0.value.linlin(0.0,2,0,1));
		~f15slider.valueAction_(0.value.linlin(0.0,2,0,1));
		~f16slider.valueAction_(0.value.linlin(0.0,2,0,1));
		x.free; ///NEED TO ADD OSC DELAY
		~button.valueAction_(1);
					~l.valueAction_(0);
				~k.valueAction_(0);
								~j.valueAction_(0);

	},
{ //saw
		var variable;
		variable = SinOsc.kr(2); //unfortunately the QtGUI cannot use variables in this slider (error message)
		~freqslider.valueAction_(69.value.linlin(21,108,0,1)); //only need to affect slider to affect the number box and true sound value
		~volslider.valueAction_(0.8.value.linlin(0,1,0,1));
		~f1slider.valueAction_(1.value.linlin(0.0,2,0,1));
					~f2slider.valueAction_((0.5**1).value.linlin(0.0,2,0,1));
					~f3slider.valueAction_((1/3**1).value.linlin(0.0,2,0,1));
					~f4slider.valueAction_((1/4**1).value.linlin(0.0,2,0,1));
					~f5slider.valueAction_((1/5**1).value.linlin(0.0,2,0,1));
					~f6slider.valueAction_((1/6**1).value.linlin(0.0,2,0,1));
					~f7slider.valueAction_((1/7**1).value.linlin(0.0,2,0,1));
					~f8slider.valueAction_((1/8**1).value.linlin(0.0,2,0,1));
					~f9slider.valueAction_((1/9**1).value.linlin(0.0,2,0,1));
					~f10slider.valueAction_((1/10**1).value.linlin(0.0,2,0,1));
					~f11slider.valueAction_((1/11**1).value.linlin(0.0,2,0,1));
					~f12slider.valueAction_((1/12**1).value.linlin(0.0,2,0,1));
					~f13slider.valueAction_((1/13**1).value.linlin(0.0,2,0,1));
					~f14slider.valueAction_((1/14**1).value.linlin(0.0,2,0,1));
					~f15slider.valueAction_((1/15**1).value.linlin(0.0,2,0,1));
					~f16slider.valueAction_((1/16**1).value.linlin(0.0,2,0,1));
		x.free; ///NEED TO ADD OSC DELAY
		~button.valueAction_(1);
	},
		/*		{//triangle
		var variable;
		variable = SinOsc.kr(2); //unfortunately the QtGUI cannot use variables in this slider (error message)
		~freqslider.valueAction_(440.value.explin(100,1000,0,1)); //only need to affect slider to affect the number box and true sound value
		~volslider.valueAction_(1.value.linlin(0,1,0,1));
		~f1slider.valueAction_(1.00.value.linlin(0.0,2,0,1));
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
		~f16slider.valueAction_(0.value.linlin(0.0,2,0,1));
		x.free; ///NEED TO ADD OSC DELAY
		~button.valueAction_(1);
					~l.valueAction_(0);
				~k.valueAction_(0);
								~j.valueAction_(0);

	},*/
				{
		var variable;
		variable = SinOsc.kr(2); //unfortunately the QtGUI cannot use variables in this slider (error message)
		~freqslider.valueAction_(69.value.linlin(21,108,0,1)); //only need to affect slider to affect the number box and true sound value
		~volslider.valueAction_(1.value.linlin(0,1,0,1));
					~f1slider.valueAction_(1.value.linlin(0.0,2,0,1));
		~f2slider.valueAction_(0.value.linlin(0.0,2,0,1));
		~f3slider.valueAction_(0.32.value.linlin(0.0,2,0,1));
		~f4slider.valueAction_(0.value.linlin(0.0,2,0,1));
		~f5slider.valueAction_(0.18.value.linlin(0.0,2,0,1));
		~f6slider.valueAction_(0.value.linlin(0.0,2,0,1));
		~f7slider.valueAction_(0.13.value.linlin(0.0,2,0,1));
		~f8slider.valueAction_(0.value.linlin(0.0,2,0,1));
		~f9slider.valueAction_(0.11.value.linlin(0.0,2,0,1));
		~f10slider.valueAction_(0.value.linlin(0.0,2,0,1));
		~f11slider.valueAction_(0.08.value.linlin(0.0,2,0,1));
		~f12slider.valueAction_(0.value.linlin(0.0,2,0,1));
		~f13slider.valueAction_(0.06.value.linlin(0.0,2,0,1));
		~f14slider.valueAction_(0.value.linlin(0.0,2,0,1));
		~f15slider.valueAction_(0.07.value.linlin(0.0,2,0,1));
		~f16slider.valueAction_(0.value.linlin(0.0,2,0,1));
		x.free; ///NEED TO ADD OSC DELAY
		~button.valueAction_(1);
					~l.valueAction_(0);
				~k.valueAction_(0);
								~j.valueAction_(0);

	}

 ];


 w.front;

 p = CmdPeriod.add({ b.value_(0) }); // set button to 0 on hitting Cmd-period
 w.onClose_{ snd.release; CmdPeriod.removeAll }; // clean up when window is closed

})
	);




//FORCED cello preset
~j = Button(w, Rect(240, 417.5, 90, 26))
	.states_([["Cello", Color.white, Color(0.7569,0.1373,0.1725,1)], ["Cello", Color.white, Color(0,0,0,1)]])
	.font_(Font("nil", 14))
	.mouseDownAction_({

		arg obj;
	if(obj.value == 0,
		{
		var variable;
		variable = SinOsc.kr(2); //unfortunately the QtGUI cannot use variables in this slider (error message)
		~freqslider.valueAction_(60.value.linlin(21,108,0,1)); //only need to affect slider to affect the number box and true sound value
		~volslider.valueAction_(0.5.value.linlin(0,1,0,1));
		~f1slider.valueAction_(0.09.value.linlin(0.0,2,0,1));
		~f2slider.valueAction_(0.39.value.linlin(0.0,2,0,1));
		~f3slider.valueAction_(0.63.value.linlin(0.0,2,0,1));
		~f4slider.valueAction_(0.53.value.linlin(0.0,2,0,1));
		~f5slider.valueAction_(0.06.value.linlin(0.0,2,0,1));
		~f6slider.valueAction_(0.1.value.linlin(0.0,2,0,1));
		~f7slider.valueAction_(0.19.value.linlin(0.0,2,0,1));
		~f8slider.valueAction_(0.11.value.linlin(0.0,2,0,1));
		~f9slider.valueAction_(0.03.value.linlin(0.0,2,0,1));
		~f10slider.valueAction_(0.05.value.linlin(0.0,2,0,1));
		~f11slider.valueAction_(0.03.value.linlin(0.0,2,0,1));
		~f12slider.valueAction_(0.02.value.linlin(0.0,2,0,1));
		~f13slider.valueAction_(0.01.value.linlin(0.0,2,0,1));
		~f14slider.valueAction_(0.01.value.linlin(0.0,2,0,1));
		~f15slider.valueAction_(0.02.value.linlin(0.0,2,0,1));
		~f16slider.valueAction_(0.value.linlin(0.0,2,0,1));
		x.free; ///requires OSC delay?
l.free;
		z.free;
		v.free;
		t.free;
		y.free;
		~button.valueAction_(1);
					~l.valueAction_(0);
				~k.valueAction_(0);
								~vinbutton.valueAction_(0);

	}, {x.free; ~j.valueAction_(1);~button.valueAction_(0)});});

	//FORCED trumpet preset
~l = Button(w, Rect(335, 417.5, 90, 26))
	.states_([["Trumpet", Color.white, Color(0.7569,0.1373,0.1725,1)],["Trumpet", Color.white, Color(0,0,0,1)]])
	.font_(Font("nil", 14))
	.mouseDownAction_({

		arg obj;
	if(obj.value == 0,
		{
		var variable;
		variable = SinOsc.kr(2); //unfortunately the QtGUI cannot use variables in this slider (error message)
		~freqslider.valueAction_(60.value.linlin(21,108,0,1)); //only need to affect slider to affect the number box and true sound value
				~volslider.valueAction_(0.7.value.linlin(0,1,0,1));
		~f1slider.valueAction_(0.05.value.linlin(0.0,2,0,1));
		~f2slider.valueAction_(0.13.value.linlin(0.0,2,0,1));
		~f3slider.valueAction_(0.24.value.linlin(0.0,2,0,1));
		~f4slider.valueAction_(0.36.value.linlin(0.0,2,0,1));
		~f5slider.valueAction_(0.49.value.linlin(0.0,2,0,1));
		~f6slider.valueAction_(0.37.value.linlin(0.0,2,0,1));
		~f7slider.valueAction_(0.29.value.linlin(0.0,2,0,1));
		~f8slider.valueAction_(0.15.value.linlin(0.0,2,0,1));
		~f9slider.valueAction_(0.17.value.linlin(0.0,2,0,1));
		~f10slider.valueAction_(0.12.value.linlin(0.0,2,0,1));
		~f11slider.valueAction_(0.11.value.linlin(0.0,2,0,1));
		~f12slider.valueAction_(0.08.value.linlin(0.0,2,0,1));
		~f13slider.valueAction_(0.05.value.linlin(0.0,2,0,1));
		~f14slider.valueAction_(0.03.value.linlin(0.0,2,0,1));
		~f15slider.valueAction_(0.02.value.linlin(0.0,2,0,1));
		~f16slider.valueAction_(0.01.value.linlin(0.0,2,0,1));
		x.free;
				l.free;
				z.free;
		v.free;
		t.free;
		y.free;
		~button.valueAction_(1);
					~k.valueAction_(0);
				~j.valueAction_(0);
				~r.valueAction_(0);
								~vinbutton.valueAction_(0);

	}, {x.free; ~l.valueAction_(1);~button.valueAction_(0)});});


//FORCED flute preset
~k = Button(w, Rect(430, 417.5, 90, 26))
	.states_([["Flute", Color.white, Color(0.7569,0.1373,0.1725,1)], ["Flute", Color.white, Color(0,0,0,1)]])
	.font_(Font("nil", 14))
	.mouseDownAction_({

		arg obj;
	if(obj.value == 0,
		{
		var variable;
		variable = SinOsc.kr(2); //unfortunately the QtGUI cannot use variables in this slider (error message)
		~freqslider.valueAction_(72.value.linlin(21,108,0,1)); //only need to affect slider to affect the number box and true sound value
				~volslider.valueAction_(1.value.linlin(0,1,0,1));
		~f1slider.valueAction_(0.33.value.linlin(0.0,2,0,1));
		~f2slider.valueAction_(0.20.value.linlin(0.0,2,0,1));
		~f3slider.valueAction_(0.17.value.linlin(0.0,2,0,1));
		~f4slider.valueAction_(0.11.value.linlin(0.0,2,0,1));
		~f5slider.valueAction_(0.01.value.linlin(0.0,2,0,1));
		~f6slider.valueAction_(0.01.value.linlin(0.0,2,0,1));
		~f7slider.valueAction_(0.015.value.linlin(0.0,2,0,1));
		~f8slider.valueAction_(0.015.value.linlin(0.0,2,0,1));
		~f9slider.valueAction_(0.value.linlin(0.0,2,0,1));
		~f10slider.valueAction_(0.value.linlin(0.0,2,0,1));
		~f11slider.valueAction_(0.value.linlin(0.0,2,0,1));
		~f12slider.valueAction_(0.value.linlin(0.0,2,0,1));
		~f13slider.valueAction_(0.value.linlin(0.0,2,0,1));
		~f14slider.valueAction_(0.value.linlin(0.0,2,0,1));
		~f15slider.valueAction_(0.value.linlin(0.0,2,0,1));
		~f16slider.valueAction_(0.value.linlin(0.0,2,0,1));
		x.free;
				l.free;
				z.free;
		v.free;
		t.free;
		y.free;
	~button.valueAction_(1);
				~l.valueAction_(0);
				~j.valueAction_(0);
				~r.valueAction_(0);
				~vinbutton.valueAction_(0);
	}, {x.free; ~k.valueAction_(1);~button.valueAction_(0)});});

	//FORCED horn preset
~r = Button(w, Rect(525, 417.5, 90, 26))
	.states_([["Horn", Color.white, Color(0.7569,0.1373,0.1725,1)],["Horn", Color.white, Color(0,0,0,1)]])
	.font_(Font("nil", 14))
	.mouseDownAction_({

		arg obj;
	if(obj.value == 0,
		{
		var variable;
		variable = SinOsc.kr(2); //unfortunately the QtGUI cannot use variables in this slider (error message)
		~freqslider.valueAction_(60.value.linlin(21,108,0,1)); //only need to affect slider to affect the number box and true sound value
				~volslider.valueAction_(0.4.value.linlin(0,1,0,1));
		~f1slider.valueAction_(1.4134615384615

.value.linlin(0.0,2,0,1));
		~f2slider.valueAction_(1.6634615384615
.value.linlin(0.0,2,0,1));
		~f3slider.valueAction_(0.77884615384615

.value.linlin(0.0,2,0,1));
		~f4slider.valueAction_(0.41346153846154

.value.linlin(0.0,2,0,1));
		~f5slider.valueAction_(0.20192307692308

.value.linlin(0.0,2,0,1));
		~f6slider.valueAction_(0.076923076923077
.value.linlin(0.0,2,0,1));
		~f7slider.valueAction_(0.038461538461538
.value.linlin(0.0,2,0,1));
		~f8slider.valueAction_(0.value.linlin(0.0,2,0,1));
		~f9slider.valueAction_(0.value.linlin(0.0,2,0,1));
		~f10slider.valueAction_(0.value.linlin(0.0,2,0,1));
		~f11slider.valueAction_(0.value.linlin(0.0,2,0,1));
		~f12slider.valueAction_(0.value.linlin(0.0,2,0,1));
		~f13slider.valueAction_(0.value.linlin(0.0,2,0,1));
		~f14slider.valueAction_(0.value.linlin(0.0,2,0,1));
		~f15slider.valueAction_(0.value.linlin(0.0,2,0,1));
		~f16slider.valueAction_(0.value.linlin(0.0,2,0,1));
		x.free;
				l.free;
				z.free;
		v.free;
		t.free;
		y.free;
	~button.valueAction_(1);
			~k.valueAction_(0);
				~j.valueAction_(0);
		~l.valueAction_(0);
								~vinbutton.valueAction_(0);

	}, {x.free; ~r.valueAction_(1);~button.valueAction_(0)});});


	//Label for Moving
~para = StaticText(w,Rect(10,460,380,30))
	.string_("Dynamic Spectra")
.font_(Font("nil", 18))
.align_(\topLeft)
.background_(Color(0,0,0,0))
.stringColor_(Color.black);

//Label for Realistic
~para = StaticText(w,Rect(10,500,380,30))
	.string_("Audio Recordings")
.font_(Font("nil", 18))
.align_(\topLeft)
.background_(Color(0,0,0,0))
.stringColor_(Color.black);

//Label for Harmonics
~para = StaticText(w,Rect(15,110,380,20))
	.string_("Harmonics|")
.font_(Font("nil", 18))
.align_(\topLeft)
.background_(Color(0,0,0,0))
.stringColor_(Color.black);

//Label for Spectra
~para = StaticText(w,Rect(410,110,380,80))
	.string_("Spectra")
.font_(Font("nil", 18))
.align_(\top)
.background_(Color(0,0,0,0))
.stringColor_(Color.white);


		//FUNDAMENTAL FREQUENCY
//Properties of the slider
~freqslider = Slider(w, Rect(250,110,140,20))
	.background_(Color(0.8,0.8,0.8,0.75)).value_(0)
	.step_(1/(108-21)) //Math of linexp: y=100e^(kx)
	//y1(1)=1000=y3(1) and y2(0)=100=y3(0) and y3=100e^(kx) what is k?
	//hence: ln(y3/100)/x = k -->ln(1000/100)/1 = k = 2.3025 (using y2 makes no sense but should...)
	//--> k = ln(10) EXACTLY
	//new is k=ln(8)
	.action_({
	arg obj;
	var cf;
	cf = obj.value.linlin(0,1,21,108).postln;
		~fundamental_note = obj.value.linlin(0,1,21,108);
		~fundamental_note.postln;
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


/*ASHARP0*/(if(obj.value.linlin(0,1,21,108) ==22,{~note_name.string_("A#0");}););
/*CSHARP1*/(if(obj.value.linlin(0,1,21,108) ==25,{~note_name.string_("C#1");}););
/*DSHARP1*/(if(obj.value.linlin(0,1,21,108) ==27,{~note_name.string_("D#1");}););
/*FSHARP1*/(if(obj.value.linlin(0,1,21,108) ==30,{~note_name.string_("F#1");}););
/*GSHARP1*/(if(obj.value.linlin(0,1,21,108) ==32,{~note_name.string_("G#1");}););
/*ASHARP1*/(if(obj.value.linlin(0,1,21,108) ==34,{~note_name.string_("A#1");}););
/*CSHARP2*/(if(obj.value.linlin(0,1,21,108) ==37,{~note_name.string_("C#2");}););
/*DSHARP2*/(if(obj.value.linlin(0,1,21,108) ==39,{~note_name.string_("D#2");}););
/*FSHARP2*/(if(obj.value.linlin(0,1,21,108) ==42,{~note_name.string_("F#2");}););
/*GSHARP2*/(if(obj.value.linlin(0,1,21,108) ==44,{~note_name.string_("G#2");}););
/*ASHARP2*/(if(obj.value.linlin(0,1,21,108) ==46,{~note_name.string_("A#2");}););
/*CSHARP3*/(if(obj.value.linlin(0,1,21,108) ==49,{~note_name.string_("C#3");}););
/*DSHARP3*/(if(obj.value.linlin(0,1,21,108) ==51,{~note_name.string_("D#3");}););
/*FSHARP3*/(if(obj.value.linlin(0,1,21,108) ==54,{~note_name.string_("F#3");}););
/*GSHARP3*/(if(obj.value.linlin(0,1,21,108) ==56,{~note_name.string_("G#3");}););
/*ASHARP3*/(if(obj.value.linlin(0,1,21,108) ==58,{~note_name.string_("A#3");}););
/*CSHARP4*/(if(obj.value.linlin(0,1,21,108) ==61,{~note_name.string_("C#4");}););
/*DSHARP4*/(if(obj.value.linlin(0,1,21,108) ==63,{~note_name.string_("D#4");}););
/*FSHARP4*/(if(obj.value.linlin(0,1,21,108) ==66,{~note_name.string_("F#4");}););
/*GSHARP4*/(if(obj.value.linlin(0,1,21,108) ==68,{~note_name.string_("G#4");}););
/*ASHARP4*/(if(obj.value.linlin(0,1,21,108) ==70,{~note_name.string_("A#4");}););
/*CSHARP5*/(if(obj.value.linlin(0,1,21,108) ==73,{~note_name.string_("C#5");}););
/*DSHARP5*/(if(obj.value.linlin(0,1,21,108) ==75,{~note_name.string_("D#5");}););
/*FSHARP5*/(if(obj.value.linlin(0,1,21,108) ==78,{~note_name.string_("F#5");}););
/*GSHARP5*/(if(obj.value.linlin(0,1,21,108) ==80,{~note_name.string_("G#5");}););
/*ASHARP5*/(if(obj.value.linlin(0,1,21,108) ==82,{~note_name.string_("A#5");}););
/*CSHARP6*/(if(obj.value.linlin(0,1,21,108) ==85,{~note_name.string_("C#6");}););
/*DSHARP6*/(if(obj.value.linlin(0,1,21,108) ==87,{~note_name.string_("D#6");}););
/*FSHARP6*/(if(obj.value.linlin(0,1,21,108) ==90,{~note_name.string_("F#6");}););
/*GSHARP6*/(if(obj.value.linlin(0,1,21,108) ==92,{~note_name.string_("G#6");}););
/*ASHARP6*/(if(obj.value.linlin(0,1,21,108) ==94,{~note_name.string_("A#6");}););
/*CSHARP7*/(if(obj.value.linlin(0,1,21,108) ==97,{~note_name.string_("C#7");}););
/*DSHARP7*/(if(obj.value.linlin(0,1,21,108) ==99,{~note_name.string_("D#7");}););
/*FSHARP7*/(if(obj.value.linlin(0,1,21,108) ==102,{~note_name.string_("F#7");}););
/*GSHARP7*/(if(obj.value.linlin(0,1,21,108) ==104,{~note_name.string_("G#7");}););
/*ASHARP7*/(if(obj.value.linlin(0,1,21,108) ==106,{~note_name.string_("A#7");}););


(if(~key_vis.value == 1, {

/*A0*/(if(obj.value.linlin(0,1,21,108) <= 21, {~a0.background_(Color(1,~color_array[21-1],~color_array[21-1]));}, {~a0.background_(Color.white)}););
/*B0*/(if(obj.value.linlin(0,1,21,108) <= 23, {~b0.background_(Color(1,~color_array[23-1],~color_array[23-1]));}, {~b0.background_(Color.white)}););
/*C1*/(if(obj.value.linlin(0,1,21,108) <= 24, {~c1.background_(Color(1,~color_array[24-1],~color_array[24-1]));}, {~c1.background_(Color.white)}););
/*D1*/(if(obj.value.linlin(0,1,21,108) <= 26, {~d1.background_(Color(1,~color_array[26-1],~color_array[26-1]));}, {~d1.background_(Color.white)}););
/*E1*/(if(obj.value.linlin(0,1,21,108) <= 28, {~e1.background_(Color(1,~color_array[28-1],~color_array[28-1]));}, {~e1.background_(Color.white)}););
/*F1*/(if(obj.value.linlin(0,1,21,108) <= 29, {~f1.background_(Color(1,~color_array[29-1],~color_array[29-1]));}, {~f1.background_(Color.white)}););
/*G1*/(if(obj.value.linlin(0,1,21,108) <= 31, {~g1.background_(Color(1,~color_array[31-1],~color_array[31-1]));}, {~g1.background_(Color.white)}););
/*A1*/(if(obj.value.linlin(0,1,21,108) <= 33, {~a1.background_(Color(1,~color_array[33-1],~color_array[33-1]));}, {~a1.background_(Color.white)}););
/*B1*/(if(obj.value.linlin(0,1,21,108) <= 35, {~b1.background_(Color(1,~color_array[35-1],~color_array[35-1]));}, {~b1.background_(Color.white)}););
/*C2*/(if(obj.value.linlin(0,1,21,108) <= 36, {~c2.background_(Color(1,~color_array[36-1],~color_array[36-1]));}, {~c2.background_(Color.white)}););
/*D2*/(if(obj.value.linlin(0,1,21,108) <= 38, {~d2.background_(Color(1,~color_array[38-1],~color_array[38-1]));}, {~d2.background_(Color.white)}););
/*E2*/(if(obj.value.linlin(0,1,21,108) <= 40, {~e2.background_(Color(1,~color_array[40-1],~color_array[40-1]));}, {~e2.background_(Color.white)}););
/*F2*/(if(obj.value.linlin(0,1,21,108) <= 41, {~f2.background_(Color(1,~color_array[41-1],~color_array[41-1]));}, {~f2.background_(Color.white)}););
/*G2*/(if(obj.value.linlin(0,1,21,108) <= 43, {~g2.background_(Color(1,~color_array[43-1],~color_array[43-1]));}, {~g2.background_(Color.white)}););
/*A2*/(if(obj.value.linlin(0,1,21,108) <= 45, {~a2.background_(Color(1,~color_array[45-1],~color_array[45-1]));}, {~a2.background_(Color.white)}););
/*B2*/(if(obj.value.linlin(0,1,21,108) <= 47, {~b2.background_(Color(1,~color_array[47-1],~color_array[47-1]));}, {~b2.background_(Color.white)}););
/*C3*/(if(obj.value.linlin(0,1,21,108) <= 48, {~c3.background_(Color(1,~color_array[48-1],~color_array[48-1]));}, {~c3.background_(Color.white)}););
/*D3*/(if(obj.value.linlin(0,1,21,108) <= 50, {~d3.background_(Color(1,~color_array[50-1],~color_array[50-1]));}, {~d3.background_(Color.white)}););
/*E3*/(if(obj.value.linlin(0,1,21,108) <= 52, {~e3.background_(Color(1,~color_array[52-1],~color_array[52-1]));}, {~e3.background_(Color.white)}););
/*F3*/(if(obj.value.linlin(0,1,21,108) <= 53, {~f3.background_(Color(1,~color_array[53-1],~color_array[53-1]));}, {~f3.background_(Color.white)}););
/*G3*/(if(obj.value.linlin(0,1,21,108) <= 55, {~g3.background_(Color(1,~color_array[55-1],~color_array[55-1]));}, {~g3.background_(Color.white)}););
/*A3*/(if(obj.value.linlin(0,1,21,108) <= 57, {~a3.background_(Color(1,~color_array[57-1],~color_array[57-1]));}, {~a3.background_(Color.white)}););
/*B3*/(if(obj.value.linlin(0,1,21,108) <= 59, {~b3.background_(Color(1,~color_array[59-1],~color_array[59-1]));}, {~b3.background_(Color.white)}););
/*C4*/(if(obj.value.linlin(0,1,21,108) <= 60, {~c4.background_(Color(1,~color_array[60-1],~color_array[60-1]));}, {~c4.background_(Color.white)}););
/*D4*/(if(obj.value.linlin(0,1,21,108) <= 62, {~d4.background_(Color(1,~color_array[62-1],~color_array[62-1]));}, {~d4.background_(Color.white)}););
/*E4*/(if(obj.value.linlin(0,1,21,108) <= 64, {~e4.background_(Color(1,~color_array[64-1],~color_array[64-1]));}, {~e4.background_(Color.white)}););
/*F4*/(if(obj.value.linlin(0,1,21,108) <= 65, {~f4.background_(Color(1,~color_array[65-1],~color_array[65-1]));}, {~f4.background_(Color.white)}););
/*G4*/(if(obj.value.linlin(0,1,21,108) <= 67, {~g4.background_(Color(1,~color_array[67-1],~color_array[67-1]));}, {~g4.background_(Color.white)}););
/*A4*/(if(obj.value.linlin(0,1,21,108) <= 69, {~a4.background_(Color(1,~color_array[69-1],~color_array[69-1]));}, {~a4.background_(Color.white)}););
/*B4*/(if(obj.value.linlin(0,1,21,108) <= 71, {~b4.background_(Color(1,~color_array[71-1],~color_array[71-1]));}, {~b4.background_(Color.white)}););
/*C5*/(if(obj.value.linlin(0,1,21,108) <= 72, {~c5.background_(Color(1,~color_array[72-1],~color_array[72-1]));}, {~c5.background_(Color.white)}););
/*D5*/(if(obj.value.linlin(0,1,21,108) <= 74, {~d5.background_(Color(1,~color_array[74-1],~color_array[74-1]));}, {~d5.background_(Color.white)}););
/*E5*/(if(obj.value.linlin(0,1,21,108) <= 76, {~e5.background_(Color(1,~color_array[76-1],~color_array[76-1]));}, {~e5.background_(Color.white)}););
/*F5*/(if(obj.value.linlin(0,1,21,108) <= 77, {~f5.background_(Color(1,~color_array[77-1],~color_array[77-1]));}, {~f5.background_(Color.white)}););
/*G5*/(if(obj.value.linlin(0,1,21,108) <= 79, {~g5.background_(Color(1,~color_array[79-1],~color_array[79-1]));}, {~g5.background_(Color.white)}););
/*A5*/(if(obj.value.linlin(0,1,21,108) <= 81, {~a5.background_(Color(1,~color_array[81-1],~color_array[81-1]));}, {~a5.background_(Color.white)}););
/*B5*/(if(obj.value.linlin(0,1,21,108) <= 83, {~b5.background_(Color(1,~color_array[83-1],~color_array[83-1]));}, {~b5.background_(Color.white)}););
/*C6*/(if(obj.value.linlin(0,1,21,108) <= 84, {~c6.background_(Color(1,~color_array[84-1],~color_array[84-1]));}, {~c6.background_(Color.white)}););
/*D6*/(if(obj.value.linlin(0,1,21,108) <= 86, {~d6.background_(Color(1,~color_array[86-1],~color_array[86-1]));}, {~d6.background_(Color.white)}););
/*E6*/(if(obj.value.linlin(0,1,21,108) <= 88, {~e6.background_(Color(1,~color_array[88-1],~color_array[88-1]));}, {~e6.background_(Color.white)}););
/*F6*/(if(obj.value.linlin(0,1,21,108) <= 89, {~f6.background_(Color(1,~color_array[89-1],~color_array[89-1]));}, {~f6.background_(Color.white)}););
/*G6*/(if(obj.value.linlin(0,1,21,108) <= 91, {~g6.background_(Color(1,~color_array[91-1],~color_array[91-1]));}, {~g6.background_(Color.white)}););
/*A6*/(if(obj.value.linlin(0,1,21,108) <= 93, {~a6.background_(Color(1,~color_array[93-1],~color_array[93-1]));}, {~a6.background_(Color.white)}););
/*B6*/(if(obj.value.linlin(0,1,21,108) <= 95, {~b6.background_(Color(1,~color_array[95-1],~color_array[95-1]));}, {~b6.background_(Color.white)}););
/*C7*/(if(obj.value.linlin(0,1,21,108) <= 96, {~c7.background_(Color(1,~color_array[96-1],~color_array[96-1]));}, {~c7.background_(Color.white)}););
/*D7*/(if(obj.value.linlin(0,1,21,108) <= 98, {~d7.background_(Color(1,~color_array[98-1],~color_array[98-1]));}, {~d7.background_(Color.white)}););
/*E7*/(if(obj.value.linlin(0,1,21,108) <= 100, {~e7.background_(Color(1,~color_array[100-1],~color_array[100-1]));}, {~e7.background_(Color.white)}););
/*F7*/(if(obj.value.linlin(0,1,21,108) <= 101, {~f7.background_(Color(1,~color_array[101-1],~color_array[101-1]));}, {~f7.background_(Color.white)}););
/*G7*/(if(obj.value.linlin(0,1,21,108) <= 103, {~g7.background_(Color(1,~color_array[103-1],~color_array[103-1]));}, {~g7.background_(Color.white)}););
/*A7*/(if(obj.value.linlin(0,1,21,108) <= 105, {~a7.background_(Color(1,~color_array[105-1],~color_array[105-1]));}, {~a7.background_(Color.white)}););
/*B7*/(if(obj.value.linlin(0,1,21,108) <= 107, {~b7.background_(Color(1,~color_array[107-1],~color_array[107-1]));}, {~b7.background_(Color.white)}););
/*C8*/(if(obj.value.linlin(0,1,21,108) <= 108, {~c8.background_(Color(1,~color_array[108-1],~color_array[108-1]));}, {~c8.background_(Color.white)}););


/*
/*ASHARP0*/(if(obj.value.linlin(0,1,21,108) <= 22, {
				if(~color_array[22-1] < 1, {~aSHARP0.background_(Color(1,~color_array[22-1],~color_array[22-1]));},
					{~aSHARP0.background_(Color.black)})
			}, {~aSHARP0.background_(Color.black)}););
/*CSHARP1*/(if(obj.value.linlin(0,1,21,108) <= 25, {~cSHARP1.background_(Color((1-~color_array[25-1])**(0.25),0,0));}, {~cSHARP1.background_(Color.black)}););
/*DSHARP1*/(if(obj.value.linlin(0,1,21,108) <= 27, {~dSHARP1.background_(Color((1-~color_array[27-1])**(0.25),0,0));}, {~dSHARP1.background_(Color.black)}););
/*FSHARP1*/(if(obj.value.linlin(0,1,21,108) <= 30, {~fSHARP1.background_(Color((1-~color_array[30-1])**(0.25),0,0));}, {~fSHARP1.background_(Color.black)}););
/*GSHARP1*/(if(obj.value.linlin(0,1,21,108) <= 32, {~gSHARP1.background_(Color((1-~color_array[32-1])**(0.25),0,0));}, {~gSHARP1.background_(Color.black)}););
/*ASHARP1*/(if(obj.value.linlin(0,1,21,108) <= 34, {~aSHARP1.background_(Color((1-~color_array[34-1])**(0.25),0,0));}, {~aSHARP1.background_(Color.black)}););
/*CSHARP2*/(if(obj.value.linlin(0,1,21,108) <= 37, {~cSHARP2.background_(Color((1-~color_array[37-1])**(0.25),0,0));}, {~cSHARP2.background_(Color.black)}););
/*DSHARP2*/(if(obj.value.linlin(0,1,21,108) <= 39, {~dSHARP2.background_(Color((1-~color_array[39-1])**(0.25),0,0));}, {~dSHARP2.background_(Color.black)}););
/*FSHARP2*/(if(obj.value.linlin(0,1,21,108) <= 42, {~fSHARP2.background_(Color((1-~color_array[42-1])**(0.25),0,0));}, {~fSHARP2.background_(Color.black)}););
/*GSHARP2*/(if(obj.value.linlin(0,1,21,108) <= 44, {~gSHARP2.background_(Color((1-~color_array[44-1])**(0.25),0,0));}, {~gSHARP2.background_(Color.black)}););
/*ASHARP2*/(if(obj.value.linlin(0,1,21,108) <= 46, {~aSHARP2.background_(Color((1-~color_array[46-1])**(0.25),0,0));}, {~aSHARP2.background_(Color.black)}););
/*CSHARP3*/(if(obj.value.linlin(0,1,21,108) <= 49, {~cSHARP3.background_(Color((1-~color_array[49-1])**(0.25),0,0));}, {~cSHARP3.background_(Color.black)}););
/*DSHARP3*/(if(obj.value.linlin(0,1,21,108) <= 51, {~dSHARP3.background_(Color((1-~color_array[51-1])**(0.25),0,0));}, {~dSHARP3.background_(Color.black)}););
/*FSHARP3*/(if(obj.value.linlin(0,1,21,108) <= 54, {~fSHARP3.background_(Color((1-~color_array[54-1])**(0.25),0,0));}, {~fSHARP3.background_(Color.black)}););
/*GSHARP3*/(if(obj.value.linlin(0,1,21,108) <= 56, {~gSHARP3.background_(Color((1-~color_array[56-1])**(0.25),0,0));}, {~gSHARP3.background_(Color.black)}););
/*ASHARP3*/(if(obj.value.linlin(0,1,21,108) <= 58, {~aSHARP3.background_(Color((1-~color_array[58-1])**(0.25),0,0));}, {~aSHARP3.background_(Color.black)}););
/*CSHARP4*/(if(obj.value.linlin(0,1,21,108) <= 61, {~cSHARP4.background_(Color((1-~color_array[61-1])**(0.25),0,0));}, {~cSHARP4.background_(Color.black)}););
/*DSHARP4*/(if(obj.value.linlin(0,1,21,108) <= 63, {~dSHARP4.background_(Color((1-~color_array[63-1])**(0.25),0,0));}, {~dSHARP4.background_(Color.black)}););
/*FSHARP4*/(if(obj.value.linlin(0,1,21,108) <= 66, {~fSHARP4.background_(Color((1-~color_array[66-1])**(0.25),0,0));}, {~fSHARP4.background_(Color.black)}););
/*GSHARP4*/(if(obj.value.linlin(0,1,21,108) <= 68, {~gSHARP4.background_(Color((1-~color_array[68-1])**(0.25),0,0));}, {~gSHARP4.background_(Color.black)}););
/*ASHARP4*/(if(obj.value.linlin(0,1,21,108) <= 70, {~aSHARP4.background_(Color((1-~color_array[70-1])**(0.25),0,0));}, {~aSHARP4.background_(Color.black)}););
/*CSHARP5*/(if(obj.value.linlin(0,1,21,108) <= 73, {~cSHARP5.background_(Color((1-~color_array[73-1])**(0.25),0,0));}, {~cSHARP5.background_(Color.black)}););
/*DSHARP5*/(if(obj.value.linlin(0,1,21,108) <= 75, {~dSHARP5.background_(Color((1-~color_array[75-1])**(0.25),0,0));}, {~dSHARP5.background_(Color.black)}););
/*FSHARP5*/(if(obj.value.linlin(0,1,21,108) <= 78, {~fSHARP5.background_(Color((1-~color_array[78-1])**(0.25),0,0));}, {~fSHARP5.background_(Color.black)}););
/*GSHARP5*/(if(obj.value.linlin(0,1,21,108) <= 80, {~gSHARP5.background_(Color((1-~color_array[80-1])**(0.25),0,0));}, {~gSHARP5.background_(Color.black)}););
/*ASHARP5*/(if(obj.value.linlin(0,1,21,108) <= 82, {~aSHARP5.background_(Color((1-~color_array[82-1])**(0.25),0,0));}, {~aSHARP5.background_(Color.black)}););
/*CSHARP6*/(if(obj.value.linlin(0,1,21,108) <= 85, {~cSHARP6.background_(Color((1-~color_array[85-1])**(0.25),0,0));}, {~cSHARP6.background_(Color.black)}););
/*DSHARP6*/(if(obj.value.linlin(0,1,21,108) <= 87, {~dSHARP6.background_(Color((1-~color_array[87-1])**(0.25),0,0));}, {~dSHARP6.background_(Color.black)}););
/*FSHARP6*/(if(obj.value.linlin(0,1,21,108) <= 90, {~fSHARP6.background_(Color((1-~color_array[90-1])**(0.25),0,0));}, {~fSHARP6.background_(Color.black)}););
/*GSHARP6*/(if(obj.value.linlin(0,1,21,108) <= 92, {~gSHARP6.background_(Color((1-~color_array[92-1])**(0.25),0,0));}, {~gSHARP6.background_(Color.black)}););
/*ASHARP6*/(if(obj.value.linlin(0,1,21,108) <= 94, {~aSHARP6.background_(Color((1-~color_array[94-1])**(0.25),0,0));}, {~aSHARP6.background_(Color.black)}););
/*CSHARP7*/(if(obj.value.linlin(0,1,21,108) <= 97, {~cSHARP7.background_(Color((1-~color_array[97-1])**(0.25),0,0));}, {~cSHARP7.background_(Color.black)}););
/*DSHARP7*/(if(obj.value.linlin(0,1,21,108) <= 99, {~dSHARP7.background_(Color((1-~color_array[99-1])**(0.25),0,0));}, {~dSHARP7.background_(Color.black)}););
/*FSHARP7*/(if(obj.value.linlin(0,1,21,108) <= 102, {~fSHARP7.background_(Color((1-~color_array[102-1])**(0.25),0,0));}, {~fSHARP7.background_(Color.black)}););
/*GSHARP7*/(if(obj.value.linlin(0,1,21,108) <= 104, {~gSHARP7.background_(Color((1-~color_array[104-1])**(0.25),0,0));}, {~gSHARP7.background_(Color.black)}););
/*ASHARP7*/(if(obj.value.linlin(0,1,21,108) <= 106, {~aSHARP7.background_(Color((1-~color_array[106-1])**(0.25),0,0));}, {~aSHARP7.background_(Color.black)}););*/

/*ASHARP0*/(if(obj.value.linlin(0,1,21,108) <=22,{if(~color_array[22-1]<1,{~aSHARP0.background_(Color(1,~color_array[22-1],~color_array[22-1]));},{~aSHARP0.background_(Color.black)})},{~aSHARP0.background_(Color.black)}););
/*CSHARP1*/(if(obj.value.linlin(0,1,21,108) <=25,{if(~color_array[25-1]<1,{~cSHARP1.background_(Color(1,~color_array[25-1],~color_array[25-1]));},{~cSHARP1.background_(Color.black)})},{~cSHARP1.background_(Color.black)}););
/*DSHARP1*/(if(obj.value.linlin(0,1,21,108) <=27,{if(~color_array[27-1]<1,{~dSHARP1.background_(Color(1,~color_array[27-1],~color_array[27-1]));},{~dSHARP1.background_(Color.black)})},{~dSHARP1.background_(Color.black)}););
/*FSHARP1*/(if(obj.value.linlin(0,1,21,108) <=30,{if(~color_array[30-1]<1,{~fSHARP1.background_(Color(1,~color_array[30-1],~color_array[30-1]));},{~fSHARP1.background_(Color.black)})},{~fSHARP1.background_(Color.black)}););
/*GSHARP1*/(if(obj.value.linlin(0,1,21,108) <=32,{if(~color_array[32-1]<1,{~gSHARP1.background_(Color(1,~color_array[32-1],~color_array[32-1]));},{~gSHARP1.background_(Color.black)})},{~gSHARP1.background_(Color.black)}););
/*ASHARP1*/(if(obj.value.linlin(0,1,21,108) <=34,{if(~color_array[34-1]<1,{~aSHARP1.background_(Color(1,~color_array[34-1],~color_array[34-1]));},{~aSHARP1.background_(Color.black)})},{~aSHARP1.background_(Color.black)}););
/*CSHARP2*/(if(obj.value.linlin(0,1,21,108) <=37,{if(~color_array[37-1]<1,{~cSHARP2.background_(Color(1,~color_array[37-1],~color_array[37-1]));},{~cSHARP2.background_(Color.black)})},{~cSHARP2.background_(Color.black)}););
/*DSHARP2*/(if(obj.value.linlin(0,1,21,108) <=39,{if(~color_array[39-1]<1,{~dSHARP2.background_(Color(1,~color_array[39-1],~color_array[39-1]));},{~dSHARP2.background_(Color.black)})},{~dSHARP2.background_(Color.black)}););
/*FSHARP2*/(if(obj.value.linlin(0,1,21,108) <=42,{if(~color_array[42-1]<1,{~fSHARP2.background_(Color(1,~color_array[42-1],~color_array[42-1]));},{~fSHARP2.background_(Color.black)})},{~fSHARP2.background_(Color.black)}););
/*GSHARP2*/(if(obj.value.linlin(0,1,21,108) <=44,{if(~color_array[44-1]<1,{~gSHARP2.background_(Color(1,~color_array[44-1],~color_array[44-1]));},{~gSHARP2.background_(Color.black)})},{~gSHARP2.background_(Color.black)}););
/*ASHARP2*/(if(obj.value.linlin(0,1,21,108) <=46,{if(~color_array[46-1]<1,{~aSHARP2.background_(Color(1,~color_array[46-1],~color_array[46-1]));},{~aSHARP2.background_(Color.black)})},{~aSHARP2.background_(Color.black)}););
/*CSHARP3*/(if(obj.value.linlin(0,1,21,108) <=49,{if(~color_array[49-1]<1,{~cSHARP3.background_(Color(1,~color_array[49-1],~color_array[49-1]));},{~cSHARP3.background_(Color.black)})},{~cSHARP3.background_(Color.black)}););
/*DSHARP3*/(if(obj.value.linlin(0,1,21,108) <=51,{if(~color_array[51-1]<1,{~dSHARP3.background_(Color(1,~color_array[51-1],~color_array[51-1]));},{~dSHARP3.background_(Color.black)})},{~dSHARP3.background_(Color.black)}););
/*FSHARP3*/(if(obj.value.linlin(0,1,21,108) <=54,{if(~color_array[54-1]<1,{~fSHARP3.background_(Color(1,~color_array[54-1],~color_array[54-1]));},{~fSHARP3.background_(Color.black)})},{~fSHARP3.background_(Color.black)}););
/*GSHARP3*/(if(obj.value.linlin(0,1,21,108) <=56,{if(~color_array[56-1]<1,{~gSHARP3.background_(Color(1,~color_array[56-1],~color_array[56-1]));},{~gSHARP3.background_(Color.black)})},{~gSHARP3.background_(Color.black)}););
/*ASHARP3*/(if(obj.value.linlin(0,1,21,108) <=58,{if(~color_array[58-1]<1,{~aSHARP3.background_(Color(1,~color_array[58-1],~color_array[58-1]));},{~aSHARP3.background_(Color.black)})},{~aSHARP3.background_(Color.black)}););
/*CSHARP4*/(if(obj.value.linlin(0,1,21,108) <=61,{if(~color_array[61-1]<1,{~cSHARP4.background_(Color(1,~color_array[61-1],~color_array[61-1]));},{~cSHARP4.background_(Color.black)})},{~cSHARP4.background_(Color.black)}););
/*DSHARP4*/(if(obj.value.linlin(0,1,21,108) <=63,{if(~color_array[63-1]<1,{~dSHARP4.background_(Color(1,~color_array[63-1],~color_array[63-1]));},{~dSHARP4.background_(Color.black)})},{~dSHARP4.background_(Color.black)}););
/*FSHARP4*/(if(obj.value.linlin(0,1,21,108) <=66,{if(~color_array[66-1]<1,{~fSHARP4.background_(Color(1,~color_array[66-1],~color_array[66-1]));},{~fSHARP4.background_(Color.black)})},{~fSHARP4.background_(Color.black)}););
/*GSHARP4*/(if(obj.value.linlin(0,1,21,108) <=68,{if(~color_array[68-1]<1,{~gSHARP4.background_(Color(1,~color_array[68-1],~color_array[68-1]));},{~gSHARP4.background_(Color.black)})},{~gSHARP4.background_(Color.black)}););
/*ASHARP4*/(if(obj.value.linlin(0,1,21,108) <=70,{if(~color_array[70-1]<1,{~aSHARP4.background_(Color(1,~color_array[70-1],~color_array[70-1]));},{~aSHARP4.background_(Color.black)})},{~aSHARP4.background_(Color.black)}););
/*CSHARP5*/(if(obj.value.linlin(0,1,21,108) <=73,{if(~color_array[73-1]<1,{~cSHARP5.background_(Color(1,~color_array[73-1],~color_array[73-1]));},{~cSHARP5.background_(Color.black)})},{~cSHARP5.background_(Color.black)}););
/*DSHARP5*/(if(obj.value.linlin(0,1,21,108) <=75,{if(~color_array[75-1]<1,{~dSHARP5.background_(Color(1,~color_array[75-1],~color_array[75-1]));},{~dSHARP5.background_(Color.black)})},{~dSHARP5.background_(Color.black)}););
/*FSHARP5*/(if(obj.value.linlin(0,1,21,108) <=78,{if(~color_array[78-1]<1,{~fSHARP5.background_(Color(1,~color_array[78-1],~color_array[78-1]));},{~fSHARP5.background_(Color.black)})},{~fSHARP5.background_(Color.black)}););
/*GSHARP5*/(if(obj.value.linlin(0,1,21,108) <=80,{if(~color_array[80-1]<1,{~gSHARP5.background_(Color(1,~color_array[80-1],~color_array[80-1]));},{~gSHARP5.background_(Color.black)})},{~gSHARP5.background_(Color.black)}););
/*ASHARP5*/(if(obj.value.linlin(0,1,21,108) <=82,{if(~color_array[82-1]<1,{~aSHARP5.background_(Color(1,~color_array[82-1],~color_array[82-1]));},{~aSHARP5.background_(Color.black)})},{~aSHARP5.background_(Color.black)}););
/*CSHARP6*/(if(obj.value.linlin(0,1,21,108) <=85,{if(~color_array[85-1]<1,{~cSHARP6.background_(Color(1,~color_array[85-1],~color_array[85-1]));},{~cSHARP6.background_(Color.black)})},{~cSHARP6.background_(Color.black)}););
/*DSHARP6*/(if(obj.value.linlin(0,1,21,108) <=87,{if(~color_array[87-1]<1,{~dSHARP6.background_(Color(1,~color_array[87-1],~color_array[87-1]));},{~dSHARP6.background_(Color.black)})},{~dSHARP6.background_(Color.black)}););
/*FSHARP6*/(if(obj.value.linlin(0,1,21,108) <=90,{if(~color_array[90-1]<1,{~fSHARP6.background_(Color(1,~color_array[90-1],~color_array[90-1]));},{~fSHARP6.background_(Color.black)})},{~fSHARP6.background_(Color.black)}););
/*GSHARP6*/(if(obj.value.linlin(0,1,21,108) <=92,{if(~color_array[92-1]<1,{~gSHARP6.background_(Color(1,~color_array[92-1],~color_array[92-1]));},{~gSHARP6.background_(Color.black)})},{~gSHARP6.background_(Color.black)}););
/*ASHARP6*/(if(obj.value.linlin(0,1,21,108) <=94,{if(~color_array[94-1]<1,{~aSHARP6.background_(Color(1,~color_array[94-1],~color_array[94-1]));},{~aSHARP6.background_(Color.black)})},{~aSHARP6.background_(Color.black)}););
/*CSHARP7*/(if(obj.value.linlin(0,1,21,108) <=97,{if(~color_array[97-1]<1,{~cSHARP7.background_(Color(1,~color_array[97-1],~color_array[97-1]));},{~cSHARP7.background_(Color.black)})},{~cSHARP7.background_(Color.black)}););
/*DSHARP7*/(if(obj.value.linlin(0,1,21,108) <=99,{if(~color_array[99-1]<1,{~dSHARP7.background_(Color(1,~color_array[99-1],~color_array[99-1]));},{~dSHARP7.background_(Color.black)})},{~dSHARP7.background_(Color.black)}););
/*FSHARP7*/(if(obj.value.linlin(0,1,21,108) <=102,{if(~color_array[102-1]<1,{~fSHARP7.background_(Color(1,~color_array[102-1],~color_array[102-1]));},{~fSHARP7.background_(Color.black)})},{~fSHARP7.background_(Color.black)}););
/*GSHARP7*/(if(obj.value.linlin(0,1,21,108) <=104,{if(~color_array[104-1]<1,{~gSHARP7.background_(Color(1,~color_array[104-1],~color_array[104-1]));},{~gSHARP7.background_(Color.black)})},{~gSHARP7.background_(Color.black)}););
/*ASHARP7*/(if(obj.value.linlin(0,1,21,108) <=106,{if(~color_array[106-1]<1,{~aSHARP7.background_(Color(1,~color_array[106-1],~color_array[106-1]));},{~aSHARP7.background_(Color.black)})},{~aSHARP7.background_(Color.black)}););


		}));
		//
(
~color_array = Array.fill(200,1);
~color_array[~freqslider.value.linlin(0,1,21,108)-1+0]=(~harmonics_array[0]+(~otherslider.value.linlin(0,1,1,0)*(1-~harmonics_array[0])))-(~manipulated_harmonic[0]*~f1slider.value.linlin(0,1,0,1););
~color_array[~freqslider.value.linlin(0,1,21,108)-1+12]=(~harmonics_array[1]+(~otherslider.value.linlin(0,1,1,0)*(1-~harmonics_array[1])))-(~manipulated_harmonic[1]*~f2slider.value.linlin(0,1,0,1););
~color_array[~freqslider.value.linlin(0,1,21,108)-1+19]=(~harmonics_array[2]+(~otherslider.value.linlin(0,1,1,0)*(1-~harmonics_array[2])))-(~manipulated_harmonic[2]*~f3slider.value.linlin(0,1,0,1););
~color_array[~freqslider.value.linlin(0,1,21,108)-1+24]=(~harmonics_array[3]+(~otherslider.value.linlin(0,1,1,0)*(1-~harmonics_array[3])))-(~manipulated_harmonic[3]*~f4slider.value.linlin(0,1,0,1););
~color_array[~freqslider.value.linlin(0,1,21,108)-1+28]=(~harmonics_array[4]+(~otherslider.value.linlin(0,1,1,0)*(1-~harmonics_array[4])))-(~manipulated_harmonic[4]*~f5slider.value.linlin(0,1,0,1););
~color_array[~freqslider.value.linlin(0,1,21,108)-1+31]=(~harmonics_array[5]+(~otherslider.value.linlin(0,1,1,0)*(1-~harmonics_array[5])))-(~manipulated_harmonic[5]*~f6slider.value.linlin(0,1,0,1););
~color_array[~freqslider.value.linlin(0,1,21,108)-1+34]=(~harmonics_array[6]+(~otherslider.value.linlin(0,1,1,0)*(1-~harmonics_array[6])))-(~manipulated_harmonic[6]*~f7slider.value.linlin(0,1,0,1););
~color_array[~freqslider.value.linlin(0,1,21,108)-1+36]=(~harmonics_array[7]+(~otherslider.value.linlin(0,1,1,0)*(1-~harmonics_array[7])))-(~manipulated_harmonic[7]*~f8slider.value.linlin(0,1,0,1););
~color_array[~freqslider.value.linlin(0,1,21,108)-1+38]=(~harmonics_array[8]+(~otherslider.value.linlin(0,1,1,0)*(1-~harmonics_array[8])))-(~manipulated_harmonic[8]*~f9slider.value.linlin(0,1,0,1););
~color_array[~freqslider.value.linlin(0,1,21,108)-1+40]=(~harmonics_array[9]+(~otherslider.value.linlin(0,1,1,0)*(1-~harmonics_array[9])))-(~manipulated_harmonic[9]*~f10slider.value.linlin(0,1,0,1););
~color_array[~freqslider.value.linlin(0,1,21,108)-1+41]=(~harmonics_array[10]+(~otherslider.value.linlin(0,1,1,0)*(1-~harmonics_array[10])))-(~manipulated_harmonic[10]*~f11slider.value.linlin(0,1,0,1););
~color_array[~freqslider.value.linlin(0,1,21,108)-1+43]=(~harmonics_array[11]+(~otherslider.value.linlin(0,1,1,0)*(1-~harmonics_array[11])))-(~manipulated_harmonic[11]*~f12slider.value.linlin(0,1,0,1););
~color_array[~freqslider.value.linlin(0,1,21,108)-1+44]=(~harmonics_array[12]+(~otherslider.value.linlin(0,1,1,0)*(1-~harmonics_array[12])))-(~manipulated_harmonic[12]*~f13slider.value.linlin(0,1,0,1););
~color_array[~freqslider.value.linlin(0,1,21,108)-1+46]=(~harmonics_array[13]+(~otherslider.value.linlin(0,1,1,0)*(1-~harmonics_array[13])))-(~manipulated_harmonic[13]*~f14slider.value.linlin(0,1,0,1););
~color_array[~freqslider.value.linlin(0,1,21,108)-1+47]=(~harmonics_array[14]+(~otherslider.value.linlin(0,1,1,0)*(1-~harmonics_array[14])))-(~manipulated_harmonic[14]*~f15slider.value.linlin(0,1,0,1););
~color_array[~freqslider.value.linlin(0,1,21,108)-1+48]=(~harmonics_array[15]+(~otherslider.value.linlin(0,1,1,0)*(1-~harmonics_array[15])))-(~manipulated_harmonic[15]*~f16slider.value.linlin(0,1,0,1););
		);



		if(
		x.isPlaying,
		{x.set(\freq,cf)});

	~numberBox.value_(obj.value.linlin(0,1,21,108));
		/*
		~f1Box.value_(obj.value.linlin(0,1,40,75));
		~f2Box.value_(obj.value.linexp(0,1,200,2000));
		~f3Box.value_(obj.value.linexp(0,1,300,3000));
		~f4Box.value_(obj.value.linexp(0,1,400,4000));
		~f5Box.value_(obj.value.linexp(0,1,500,5000));
		~f6Box.value_(obj.value.linexp(0,1,600,6000));
		~f7Box.value_(obj.value.linexp(0,1,700,7000));
		~f8Box.value_(obj.value.linexp(0,1,800,8000));
		~f9Box.value_(obj.value.linexp(0,1,900,9000));
		~f10Box.value_(obj.value.linexp(0,1,1000,10000));
		~f11Box.value_(obj.value.linexp(0,1,1100,11000));
		~f12Box.value_(obj.value.linexp(0,1,1200,12000));
		~f13Box.value_(obj.value.linexp(0,1,1300,13000));
		~f14Box.value_(obj.value.linexp(0,1,1400,14000));
		~f15Box.value_(obj.value.linexp(0,1,1500,15000));
		~f16Box.value_(obj.value.linexp(0,1,1600,16000));
		*/

		/* ~fsliderharm1.valueAction_(obj.value.linlin(0,1,0.065,0.495));//must be linlin because a slider to slider is using the same exact values (no transformation required)
		 ~fsliderharm2.valueAction_(obj.value.linlin(0,1,0.19047619047619,0.63));
				~fsliderharm3.valueAction_(obj.value.linlin(0,1,0.26190476190476,0.705)); */
})
	.orientation_(\horizontal);

//Label for Freq.
~freqLabel = StaticText(w,Rect(115,110,80,25))
.string_("Fundamental Frequency")
.font_(Font("nil", 8))
.align_(\topRight)
.background_(Color(0,0,0,0))
.stringColor_(Color.black);



//Number box that can edit slider position
~numberBox = NumberBox(w,Rect(225,110,25,20))
.value_(21)
.clipLo_(21)
.clipHi_(108)
.font_(Font("nil",12))
.decimals_(0)
.align_(\center)
.action_({
	arg obj;
	~freqslider.valueAction_(obj.value.linlin(21,108,0,1))
});




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
~volslider = Slider(w, Rect(50,145,20,230))
	.background_(Color(0.0118,0.0118,0.0118,1))
	.value_(0.1)
	.action_({
	arg obj;
	var cf;
	cf = obj.value.linlin(0,1,0,1).postln;
		if(
		x.isPlaying,
		{x.set(\vol,cf)});
	~numberVBox.value_(obj.value.linlin(0,1,0,1));

})
	.orientation_(\vertical);

//Label for Vol.
~volLabel = StaticText(w,Rect(50,130,20,15))
.string_("Vol.")
.font_(Font("nil", 10, italic:true))
.align_(\center)
.background_(Color(0,0,0,0.1))
.stringColor_(Color.black);

//Number box that can edit slider position
~numberVBox = NumberBox(w,Rect(50,375,20,15))
	.normalColor_(Color.white)
	.background_(Color(0.0118,0.0118,0.0118,1))
	.value_(0.1)
.clipLo_(0)
.clipHi_(1)
.font_(Font("nil",7))
.decimals_(1)
.align_(\center)
.action_({
	arg obj;
	~volslider.valueAction_(obj.value.linlin(0,1,0,1))
});

	//Labels
~intensity = StaticText(w,Rect(12,377.5,40,15))
.string_("Intensity")
.font_(Font("nil", 8,true))
.align_(\topLeft)
.background_(Color(0,0,0,0))
.stringColor_(Color.black);

	~frequencyname = StaticText(w,Rect(12,392.5,50,15))
.string_("Frequency")
.font_(Font("nil", 8,true))
.align_(\topLeft)
.background_(Color(0,0,0,0))
.stringColor_(Color.black);


///add sound to a buffer as an import - cello
(
a = Buffer.read(s, basePath +/+ "audio/cello-2.wav"); //helpful notes for troubleshooting: http://new-supercollider-mailing-lists-forums-use-these.2681727.n2.nabble.com/Generalizing-a-files-path-td7616651.html

SynthDef("import1",{ arg out=0,bufnum=0, trigger=1, startPos=0, loop=1;
	var rate;
			rate = 1.0; //using rate because it was slightly out of tune (too high pitched)
	Out.ar(out,
		Pan2.ar(PlayBuf.ar(1,bufnum, BufRateScale.kr(bufnum)*rate, trigger, BufFrames.ir(bufnum)*startPos, loop=0),0.0)
	);
}).add;
);


//Play a sound... cello preset
q = Button(w, Rect(240, 497.5, 90, 26))
	.states_([["Cello", Color.white, Color(0.7569,0.1373,0.1725,1)]])
	.font_(Font("nil", 14))
	.action_({
		y.free;
			y = Synth.new(\import1, [\out, 0, \bufnum, a.bufnum]);
		x.free;
		z.free;
		v.free;
		t.free;
		l.free;
		~button.valueAction_(0);

				~l.valueAction_(0);
				~j.valueAction_(0);
				~r.valueAction_(0);
				~k.valueAction_(0);
				~vinbutton.valueAction_(0);
		});


///add sound to a buffer as an import - trumpet
(
c = Buffer.read(s, basePath +/+ "audio/trumpet.wav");

SynthDef("import3",{ arg out=0,bufnum=0, trigger=1, startPos=0, loop=1;
	var rate;
			rate = 1.00; //using rate because it was slightly out of tune (too high pitched)
	Out.ar(out,
		Pan2.ar(PlayBuf.ar(1,bufnum, BufRateScale.kr(bufnum)*rate, trigger, BufFrames.ir(bufnum)*startPos, loop=0),0.0)
	);
}).add;
);


//Play a sound... trumpet preset
e = Button(w, Rect(335, 497.5, 90, 26))
	.states_([["Trumpet", Color.white, Color(0.7569,0.1373,0.1725,1)]])
	.font_(Font("nil", 14))
	.action_({
		v.free;
		v = Synth.new(\import3, [\out, 0, \bufnum, c.bufnum]);
		x.free;
		y.free;
		z.free;
		t.free;
		l.free;
		~button.valueAction_(0);

						~l.valueAction_(0);
				~j.valueAction_(0);
				~r.valueAction_(0);
				~k.valueAction_(0);
				~vinbutton.valueAction_(0);


		// s.sendMsg("/s_new", "import3", v = s.nextNodeID, 1, 1);
	/*
	(
s.sendBundle(0.0, //sound delay
				["/s_new", "import3", v = Synth.new(\import3, [\out, 0, \bufnum, c.bufnum])]); //sound and ID for stacking (if multiple sounds bundled)
s.sendBundle(1, ["/n_free", v.free]);//sound ends, at least frees up memory space
);*/


	});

///add sound to a buffer as an import - flute
(
b = Buffer.read(s, basePath +/+ "audio/flute.wav");

SynthDef("import2",{ arg out=0,bufnum=0, trigger=1, startPos=0, loop=1;
	var rate;
			rate = 1.0; //using rate because it was slightly out of tune (too high pitched)
	Out.ar(out,
		Pan2.ar(PlayBuf.ar(1,bufnum, BufRateScale.kr(bufnum)*rate, trigger, BufFrames.ir(bufnum)*startPos, loop=0),0.0)
	);
}).add;
);


//Play a sound... flute preset
r = Button(w, Rect(430, 497.5, 90, 26))
	.states_([["Flute", Color.white, Color(0.7569,0.1373,0.1725,1)]])
	.font_(Font("nil", 14))
	.action_({
		z.free;
			z = Synth.new(\import2, [\out, 0, \bufnum, b.bufnum]);
		x.free;
		y.free;
		v.free;
		t.free;
		l.free;
		~button.valueAction_(0);

						~l.valueAction_(0);
				~j.valueAction_(0);
				~r.valueAction_(0);
				~k.valueAction_(0);
				~vinbutton.valueAction_(0);
		});


///add sound to a buffer as an import - horn
(
q = Buffer.read(s, basePath +/+ "audio/horn.wav");

SynthDef("import5",{ arg out=0,bufnum=0, trigger=1, startPos=0, loop=1;
	var rate;
			rate = 1.0; //using rate because it was slightly out of tune (too high pitched)
	Out.ar(out,
		Pan2.ar(PlayBuf.ar(1,bufnum, BufRateScale.kr(bufnum)*rate, trigger, BufFrames.ir(bufnum)*startPos, loop=0),0.0)
	);
}).add;
);


//Play a sound... horn preset
f = Button(w, Rect(525, 497.5, 90, 26))
	.states_([["Horn", Color.white, Color(0.7569,0.1373,0.1725,1)]])
	.font_(Font("nil", 14))
	.action_({
t.free;
			t = Synth.new(\import5, [\out, 0, \bufnum, q.bufnum]);
		x.free;
		y.free;
		z.free;
		v.free;
		l.free;
		~button.valueAction_(0);

						~l.valueAction_(0);
				~j.valueAction_(0);
				~r.valueAction_(0);
				~k.valueAction_(0);
				~vinbutton.valueAction_(0);
		});


///////SYNTHS
///add sound to a buffer as an import - horn
(
o = Buffer.read(s, basePath +/+ "audio/horn_synth_cut_new.wav");

SynthDef("importhorn_synth",{ arg out=0,bufnum=0, trigger=1, startPos=0, loop=1;
	var rate;
			rate = 1.0; //using rate because it was slightly out of tune (too high pitched)
	Out.ar(out,
		Pan2.ar(PlayBuf.ar(1,bufnum, BufRateScale.kr(bufnum)*rate, trigger, BufFrames.ir(bufnum)*startPos, loop=0),0.0)
	);
}).add;
);


//Play a sound... horn preset
u = Button(w, Rect(525, 457.5, 90, 26))
	.states_([["Horn", Color.white, Color(0.7569,0.1373,0.1725,1)]])
	.font_(Font("nil", 14))
	.action_({
	l.free;
			l = Synth.new(\importhorn_synth, [\out, 0, \bufnum, o.bufnum]);
		x.free;
		y.free;
		z.free;
		t.free;
		v.free;
		~button.valueAction_(0);
				~l.valueAction_(0);
				~j.valueAction_(0);
				~r.valueAction_(0);
				~k.valueAction_(0);
				~vinbutton.valueAction_(0);
		});


///add sound to a buffer as an import - flute
(
k = Buffer.read(s, basePath +/+ "audio/flute_synth-2.wav");

SynthDef("importflute_synth",{ arg out=0,bufnum=0, trigger=1, startPos=0, loop=1;
	var rate;
			rate = 1.0; //using rate because it was slightly out of tune (too high pitched)
	Out.ar(out,
		Pan2.ar(PlayBuf.ar(1,bufnum, BufRateScale.kr(bufnum)*rate, trigger, BufFrames.ir(bufnum)*startPos, loop=0),0.0)
	);
}).add;
);


r = Button(w, Rect(430, 457.5, 90, 26))
	.states_([["Flute", Color.white, Color(0.7569,0.1373,0.1725,1)]])
	.font_(Font("nil", 14))
	.action_({
		l.free;

		l = Synth.new(\importflute_synth, [\out, 0, \bufnum, k.bufnum]);
		x.free;
		y.free;
		z.free;
				t.free;
		v.free;
		~button.valueAction_(0);
				~l.valueAction_(0);
				~j.valueAction_(0);
				~r.valueAction_(0);
				~k.valueAction_(0);
				~vinbutton.valueAction_(0);

	});

	(
e = Buffer.read(s, basePath +/+ "audio/trumpet_synth.wav");

SynthDef("importflute_synth",{ arg out=0,bufnum=0, trigger=1, startPos=0, loop=1;
	var rate;
			rate = 1.0; //using rate because it was slightly out of tune (too high pitched)
	Out.ar(out,
		Pan2.ar(PlayBuf.ar(1,bufnum, BufRateScale.kr(bufnum)*rate, trigger, BufFrames.ir(bufnum)*startPos, loop=0),0.0)
	);
}).add;
);

	r = Button(w, Rect(335, 457.5, 90, 26))
	.states_([["Trumpet", Color.white, Color(0.7569,0.1373,0.1725,1)]])
	.font_(Font("nil", 14))
	.action_({
			l.free;

		l = Synth.new(\importhorn_synth, [\out, 0, \bufnum, e.bufnum]);
		x.free;
		y.free;
		z.free;
				t.free;
		v.free;
		~button.valueAction_(0);
				~l.valueAction_(0);
				~j.valueAction_(0);
				~r.valueAction_(0);
				~k.valueAction_(0);
				~vinbutton.valueAction_(0);

	});


(
f = Buffer.read(s, basePath +/+ "audio/cello_synth.wav");

SynthDef("importflute_synth",{ arg out=0,bufnum=0, trigger=1, startPos=0, loop=1;
	var rate;
			rate = 1.0; //using rate because it was slightly out of tune (too high pitched)
	Out.ar(out,
		Pan2.ar(PlayBuf.ar(1,bufnum, BufRateScale.kr(bufnum)*rate, trigger, BufFrames.ir(bufnum)*startPos, loop=0),0.0)
	);
}).add;
);

r = Button(w, Rect(240, 457.5, 90, 26))
	.states_([["Cello", Color.white, Color(0.7569,0.1373,0.1725,1)]])
	.font_(Font("nil", 14))
	.action_({
			l.free;
		l = Synth.new(\importhorn_synth, [\out, 0, \bufnum, f.bufnum]);
		x.free;
		y.free;
		z.free;
				t.free;
		v.free;
		~button.valueAction_(0);
				~l.valueAction_(0);
				~j.valueAction_(0);
				~r.valueAction_(0);
				~k.valueAction_(0);
				~vinbutton.valueAction_(0);

	});











//Define the slider sounds to be played
(
SynthDef.new("sound", {
			arg vol = 0.2, freq = 21, outoftune = 720, phase = pi, f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16;
	var mul, signal, freqU;

			mul = XLine.kr(0.01,1,0.01,0.1); //Ramps sound onset so not so harsh

			freqU = ((2**((-69+freq)/12))*440);

	signal =
	SinOsc.ar(freqU, phase, vol*mul*f1) +
	SinOsc.ar(freqU*2, phase, vol*mul*f2) +
	SinOsc.ar(freqU*3, phase, vol*mul*f3) +
	SinOsc.ar(freqU*4, phase, vol*mul*f4) +
	SinOsc.ar(freqU*5, phase, vol*mul*f5) +
	SinOsc.ar(freqU*6, phase, vol*mul*f6)+
	SinOsc.ar(freqU*7, phase, vol*mul*f7)+
	SinOsc.ar(freqU*8, phase, vol*mul*f8)+
	SinOsc.ar(freqU*9, phase, vol*mul*f9)+
	SinOsc.ar(freqU*10, phase, vol*mul*f10)+
	SinOsc.ar(freqU*11, phase, vol*mul*f11)+
	SinOsc.ar(freqU*12, phase, vol*mul*f12)+
	SinOsc.ar(freqU*13, phase, vol*mul*f13)+
	SinOsc.ar(freqU*14, phase, vol*mul*f14)+
	SinOsc.ar(freqU*15, phase, vol*mul*f15)+
	SinOsc.ar(freqU*16, phase, vol*mul*f16)
	;

	Out.ar([0,1], signal); //sends to busses 1 & 2 (stereo), and plays the var "signal"
}).add;
);





	/////////////////SLIDERS
///F1
//Properties of the slider
~f1slider = Slider(w, Rect(70,145,20,230))
.background_(Color(0.8,0.8,0.8,0.75))
	.value_(0.5) //is converted to 1
	.orientation_(\vertical)
	.action_({
	arg obj;
	var cf;
	cf = obj.value.linlin(0,1,0.0,2).postln;
		if(
		x.isPlaying,
		{x.set(\f1,cf)});
	~number1Box.value_(obj.value.linlin(0,1,0.0,2));
		~freqslider.valueAction_(~fslider.value); //This allows it to refresh real-time
});
//Label
~f1Label = StaticText(w,Rect(70,130,20,15))
.string_("1")
.font_(Font("nil", 12))
.align_(\top)
.background_(Color(0,0,0,0.1))
.stringColor_(Color.black);
//Number box that can edit slider position
~number1Box = NumberBox(w,Rect(70,375,20,15))
.value_(1)
.clipLo_(0.0)
.clipHi_(2)
.font_(Font("nil",7))
.decimals_(2)
.align_(\center)
.action_({
	arg obj;
	~f1slider.valueAction_(obj.value.linlin(0.0,2,0,1))
});
//Number box showing harmonic frequency
~f1Box = NumberBox(w,Rect(70,390,20,15))
.value_(240)
.clipLo_(100)
.clipHi_(20000)
.font_(Font("nil",5))
.decimals_(1)
.align_(\center);
	// .action_({
		// arg obj;
		// ~freqslider.valueAction_(obj.value.explin(100,1000,0,1))
// });

	///F2
//Properties of the slider
~f2slider = Slider(w, Rect(90,145,20,230))
.background_(Color(0.8,0.8,0.8,0.75))
	.value_(0.5) //is converted to 1
	.orientation_(\vertical)
	.action_({
	arg obj;
	var cf;
	cf = obj.value.linlin(0,1,0.0,2).postln;
		if(
		x.isPlaying,
		{x.set(\f2,cf)});
	~number2Box.value_(obj.value.linlin(0,1,0.0,2));
		~freqslider.valueAction_(~fslider.value); //This allows it to refresh real-time
});
//Label
~f2Label = StaticText(w,Rect(90,130,20,15))
.string_("2")
.font_(Font("nil", 12))
.align_(\top)
.background_(Color(0,0,0,0.1))
.stringColor_(Color.black);
//Number box that can edit slider position
~number2Box = NumberBox(w,Rect(90,375,20,15))
.value_(1)
.clipLo_(0.0)
.clipHi_(2)
.font_(Font("nil",7))
.decimals_(2)
.align_(\center)
.action_({
	arg obj;
	~f2slider.valueAction_(obj.value.linlin(0.0,2,0,1))
});
//Number box showing harmonic frequency
~f2Box = NumberBox(w,Rect(90,390,20,15))
.value_(240*1)
.clipLo_(100)
.clipHi_(20000)
.font_(Font("nil",5))
.decimals_(1)
.align_(\center);
	// .action_({
		// arg obj;
		// ~freqslider.valueAction_(obj.value.explin(100,1000,0,1))
// });

	///F3
//Properties of the slider
~f3slider = Slider(w, Rect(110,145,20,230))
.background_(Color(0.8,0.8,0.8,0.75))
	.value_(0.5) //is converted to 1
	.orientation_(\vertical)
	.action_({
	arg obj;
	var cf;
	cf = obj.value.linlin(0,1,0.0,2).postln;
		if(
		x.isPlaying,
		{x.set(\f3,cf)});
	~number3Box.value_(obj.value.linlin(0,1,0.0,2));
		~freqslider.valueAction_(~fslider.value); //This allows it to refresh real-time
});
//Label
~f3Label = StaticText(w,Rect(110,130,20,15))
.string_("3")
.font_(Font("nil", 12))
.align_(\top)
.background_(Color(0,0,0,0.1))
.stringColor_(Color.black);
//Number box that can edit slider position
~number3Box = NumberBox(w,Rect(110,375,20,15))
.value_(3)
.clipLo_(0.0)
.clipHi_(2)
.font_(Font("nil",7))
.decimals_(2)
.align_(\center)
.action_({
	arg obj;
	~f3slider.valueAction_(obj.value.linlin(0.0,2,0,1))
});
//Number box showing harmonic frequency
~f3Box = NumberBox(w,Rect(110,390,20,15))
.value_(240*3)
.clipLo_(100)
.clipHi_(20000)
.font_(Font("nil",5))
.decimals_(1)
.align_(\center);
	// .action_({
		// arg obj;
		// ~freqslider.valueAction_(obj.value.explin(100,1000,0,1))
// });

	///F4
//Properties of the slider
~f4slider = Slider(w, Rect(130,145,20,230))
.background_(Color(0.8,0.8,0.8,0.75))
	.value_(0.5) //is converted to 1
	.orientation_(\vertical)
	.action_({
	arg obj;
	var cf;
	cf = obj.value.linlin(0,1,0.0,2).postln;
		if(
		x.isPlaying,
		{x.set(\f4,cf)});
	~number4Box.value_(obj.value.linlin(0,1,0.0,2));
		~freqslider.valueAction_(~fslider.value); //This allows it to refresh real-time
});
//Label
~f4Label = StaticText(w,Rect(130,130,20,15))
.string_("4")
.font_(Font("nil", 12))
.align_(\top)
.background_(Color(0,0,0,0.1))
.stringColor_(Color.black);
//Number box that can edit slider position
~number4Box = NumberBox(w,Rect(130,375,20,15))
.value_(1)
.clipLo_(0.0)
.clipHi_(2)
.font_(Font("nil",7))
.decimals_(2)
.align_(\center)
.action_({
	arg obj;
	~f4slider.valueAction_(obj.value.linlin(0.0,2,0,1))
});
//Number box showing harmonic frequency
~f4Box = NumberBox(w,Rect(130,390,20,15))
.value_(240*4)
.clipLo_(100)
.clipHi_(20000)
.font_(Font("nil",5))
.decimals_(1)
.align_(\center);
	// .action_({
		// arg obj;
		// ~freqslider.valueAction_(obj.value.explin(100,1000,0,1))
// });

	///F5
//Properties of the slider
~f5slider = Slider(w, Rect(150,145,20,230))
.background_(Color(0.8,0.8,0.8,0.75))
	.value_(0.5) //is converted to 1
	.orientation_(\vertical)
	.action_({
	arg obj;
	var cf;
	cf = obj.value.linlin(0,1,0.0,2).postln;
		if(
		x.isPlaying,
		{x.set(\f5,cf)});
	~number5Box.value_(obj.value.linlin(0,1,0.0,2));
		~freqslider.valueAction_(~fslider.value); //This allows it to refresh real-time
});
//Label
~f5Label = StaticText(w,Rect(150,130,20,15))
.string_("5")
.font_(Font("nil", 12))
.align_(\top)
.background_(Color(0,0,0,0.1))
.stringColor_(Color.black);
//Number box that can edit slider position
~number5Box = NumberBox(w,Rect(150,375,20,15))
.value_(1)
.clipLo_(0.0)
.clipHi_(2)
.font_(Font("nil",7))
.decimals_(2)
.align_(\center)
.action_({
	arg obj;
	~f5slider.valueAction_(obj.value.linlin(0.0,2,0,1))
});
//Number box showing harmonic frequency
~f5Box = NumberBox(w,Rect(150,390,20,15))
.value_(240*5)
.clipLo_(100)
.clipHi_(20000)
.font_(Font("nil",5))
.decimals_(1)
.align_(\center);
	// .action_({
		// arg obj;
		// ~freqslider.valueAction_(obj.value.explin(100,1000,0,1))
// });

	///F6
//Properties of the slider
~f6slider = Slider(w, Rect(170,145,20,230))
.background_(Color(0.8,0.8,0.8,0.75))
	.value_(0.5) //is converted to 1
	.orientation_(\vertical)
	.action_({
	arg obj;
	var cf;
	cf = obj.value.linlin(0,1,0.0,2).postln;
		if(
		x.isPlaying,
		{x.set(\f6,cf)});
	~number6Box.value_(obj.value.linlin(0,1,0.0,2));
		~freqslider.valueAction_(~fslider.value); //This allows it to refresh real-time
});
//Label
~f6Label = StaticText(w,Rect(170,130,20,15))
.string_("6")
.font_(Font("nil", 12))
.align_(\top)
.background_(Color(0,0,0,0.1))
.stringColor_(Color.black);
//Number box that can edit slider position
~number6Box = NumberBox(w,Rect(170,375,20,15))
.value_(1)
.clipLo_(0.0)
.clipHi_(2)
.font_(Font("nil",7))
.decimals_(2)
.align_(\center)
.action_({
	arg obj;
	~f6slider.valueAction_(obj.value.linlin(0.0,2,0,1))
});
//Number box showing harmonic frequency
~f6Box = NumberBox(w,Rect(170,390,20,15))
.value_(240)
.clipLo_(100)
.clipHi_(20000)
.font_(Font("nil",5))
.decimals_(1)
.align_(\center);
	// .action_({
		// arg obj;
		// ~freqslider.valueAction_(obj.value.explin(100,1000,0,1))
// });

	///F7
//Properties of the slider
~f7slider = Slider(w, Rect(190,145,20,230))
.background_(Color(0.8,0.8,0.8,0.75))
	.value_(0.5) //is converted to 1
	.orientation_(\vertical)
	.action_({
	arg obj;
	var cf;
	cf = obj.value.linlin(0,1,0.0,2).postln;
		if(
		x.isPlaying,
		{x.set(\f7,cf)});
	~number7Box.value_(obj.value.linlin(0,1,0.0,2));
		~freqslider.valueAction_(~fslider.value); //This allows it to refresh real-time
});
//Label
~f7Label = StaticText(w,Rect(190,130,20,15))
.string_("7")
.font_(Font("nil", 12))
.align_(\top)
.background_(Color(0,0,0,0.1))
.stringColor_(Color.black);
//Number box that can edit slider position
~number7Box = NumberBox(w,Rect(190,375,20,15))
.value_(1)
.clipLo_(0.0)
.clipHi_(2)
.font_(Font("nil",7))
.decimals_(2)
.align_(\center)
.action_({
	arg obj;
	~f7slider.valueAction_(obj.value.linlin(0.0,2,0,1))
});
//Number box showing harmonic frequency
~f7Box = NumberBox(w,Rect(190,390,20,15))
.value_(240*7)
.clipLo_(100)
.clipHi_(20000)
.font_(Font("nil",5))
.decimals_(1)
.align_(\center);
	// .action_({
		// arg obj;
		// ~freqslider.valueAction_(obj.value.explin(100,1000,0,1))
// });

	///F8
//Properties of the slider
~f8slider = Slider(w, Rect(210,145,20,230))
.background_(Color(0.8,0.8,0.8,0.75))
	.value_(0.5) //is converted to 1
	.orientation_(\vertical)
	.action_({
	arg obj;
	var cf;
	cf = obj.value.linlin(0,1,0.0,2).postln;
		if(
		x.isPlaying,
		{x.set(\f8,cf)});
	~number8Box.value_(obj.value.linlin(0,1,0.0,2));
		~freqslider.valueAction_(~fslider.value); //This allows it to refresh real-time
});
//Label
~f8Label = StaticText(w,Rect(210,130,20,15))
.string_("8")
.font_(Font("nil", 12))
.align_(\top)
.background_(Color(0,0,0,0.1))
.stringColor_(Color.black);
//Number box that can edit slider position
~number8Box = NumberBox(w,Rect(210,375,20,15))
.value_(1)
.clipLo_(0.0)
.clipHi_(2)
.font_(Font("nil",7))
.decimals_(2)
.align_(\center)
.action_({
	arg obj;
	~f8slider.valueAction_(obj.value.linlin(0.0,2,0,1))
});
//Number box showing harmonic frequency
~f8Box = NumberBox(w,Rect(210,390,20,15))
.value_(240*8)
.clipLo_(100)
.clipHi_(20000)
.font_(Font("nil",5))
.decimals_(1)
.align_(\center);
	// .action_({
		// arg obj;
		// ~freqslider.valueAction_(obj.value.explin(100,1000,0,1))
// });

	///F9
//Properties of the slider
~f9slider = Slider(w, Rect(230,145,20,230))
.background_(Color(0.8,0.8,0.8,0.75))
	.value_(0.5) //is converted to 1
	.orientation_(\vertical)
	.action_({
	arg obj;
	var cf;
	cf = obj.value.linlin(0,1,0.0,2).postln;
		if(
		x.isPlaying,
		{x.set(\f9,cf)});
	~number9Box.value_(obj.value.linlin(0,1,0.0,2));
		~freqslider.valueAction_(~fslider.value); //This allows it to refresh real-time
});
//Label
~f9Label = StaticText(w,Rect(230,130,20,15))
.string_("9")
.font_(Font("nil", 12))
.align_(\top)
.background_(Color(0,0,0,0.1))
.stringColor_(Color.black);
//Number box that can edit slider position
~number9Box = NumberBox(w,Rect(230,375,20,15))
.value_(1)
.clipLo_(0.0)
.clipHi_(2)
.font_(Font("nil",7))
.decimals_(2)
.align_(\center)
.action_({
	arg obj;
	~f9slider.valueAction_(obj.value.linlin(0.0,2,0,1))
});
//Number box showing harmonic frequency
~f9Box = NumberBox(w,Rect(230,390,20,15))
.value_(240*9)
.clipLo_(100)
.clipHi_(20000)
.font_(Font("nil",5))
.decimals_(1)
.align_(\center);
	// .action_({
		// arg obj;
		// ~freqslider.valueAction_(obj.value.explin(100,1000,0,1))
// });

	///F10
//Properties of the slider
~f10slider = Slider(w, Rect(250,145,20,230))
.background_(Color(0.8,0.8,0.8,0.75))
	.value_(0.5) //is converted to 1
	.orientation_(\vertical)
	.action_({
	arg obj;
	var cf;
	cf = obj.value.linlin(0,1,0.0,2).postln;
		if(
		x.isPlaying,
		{x.set(\f10,cf)});
	~number10Box.value_(obj.value.linlin(0,1,0.0,2));
		~freqslider.valueAction_(~fslider.value); //This allows it to refresh real-time
});
//Label
~f10Label = StaticText(w,Rect(250,130,20,15))
.string_("10")
.font_(Font("nil", 12))
.align_(\top)
.background_(Color(0,0,0,0.1))
.stringColor_(Color.black);
//Number box that can edit slider position
~number10Box = NumberBox(w,Rect(250,375,20,15))
.value_(1)
.clipLo_(0.0)
.clipHi_(2)
.font_(Font("nil",7))
.decimals_(2)
.align_(\center)
.action_({
	arg obj;
	~f10slider.valueAction_(obj.value.linlin(0.0,2,0,1))
});
//Number box showing harmonic frequency
~f10Box = NumberBox(w,Rect(250,390,20,15))
.value_(240*10)
.clipLo_(100)
.clipHi_(20000)
.font_(Font("nil",5))
.decimals_(1)
.align_(\center);
	// .action_({
		// arg obj;
		// ~freqslider.valueAction_(obj.value.explin(100,1000,0,1))
// });

	///F11
//Properties of the slider
~f11slider = Slider(w, Rect(270,145,20,230))
.background_(Color(0.8,0.8,0.8,0.75))
	.value_(0.5) //is converted to 1
	.orientation_(\vertical)
	.action_({
	arg obj;
	var cf;
	cf = obj.value.linlin(0,1,0.0,2).postln;
		if(
		x.isPlaying,
		{x.set(\f11,cf)});
	~number11Box.value_(obj.value.linlin(0,1,0.0,2));
		~freqslider.valueAction_(~fslider.value); //This allows it to refresh real-time
});
//Label
~f11Label = StaticText(w,Rect(270,130,20,15))
.string_("11")
.font_(Font("nil", 12))
.align_(\top)
.background_(Color(0,0,0,0.1))
.stringColor_(Color.black);
//Number box that can edit slider position
~number11Box = NumberBox(w,Rect(270,375,20,15))
.value_(1)
.clipLo_(0.0)
.clipHi_(2)
.font_(Font("nil",7))
.decimals_(2)
.align_(\center)
.action_({
	arg obj;
	~f11slider.valueAction_(obj.value.linlin(0.0,2,0,1))
});
//Number box showing harmonic frequency
~f11Box = NumberBox(w,Rect(270,390,20,15))
.value_(240*11)
.clipLo_(100)
.clipHi_(20000)
.font_(Font("nil",5))
.decimals_(1)
.align_(\center);
	// .action_({
		// arg obj;
		// ~freqslider.valueAction_(obj.value.explin(100,1000,0,1))
// });

	///F12
//Properties of the slider
~f12slider = Slider(w, Rect(290,145,20,230))
.background_(Color(0.8,0.8,0.8,0.75))
	.value_(0.5) //is converted to 1
	.orientation_(\vertical)
	.action_({
	arg obj;
	var cf;
	cf = obj.value.linlin(0,1,0.0,2).postln;
		if(
		x.isPlaying,
		{x.set(\f12,cf)});
	~number12Box.value_(obj.value.linlin(0,1,0.0,2));
		~freqslider.valueAction_(~fslider.value); //This allows it to refresh real-time
});
//Label
~f12Label = StaticText(w,Rect(290,130,20,15))
.string_("12")
.font_(Font("nil", 12))
.align_(\top)
.background_(Color(0,0,0,0.1))
.stringColor_(Color.black);
//Number box that can edit slider position
~number12Box = NumberBox(w,Rect(290,375,20,15))
.value_(1)
.clipLo_(0.0)
.clipHi_(2)
.font_(Font("nil",7))
.decimals_(2)
.align_(\center)
.action_({
	arg obj;
	~f12slider.valueAction_(obj.value.linlin(0.0,2,0,1))
});
//Number box showing harmonic frequency
~f12Box = NumberBox(w,Rect(290,390,20,15))
.value_(240*12)
.clipLo_(100)
.clipHi_(20000)
.font_(Font("nil",5))
.decimals_(1)
.align_(\center);
	// .action_({
		// arg obj;
		// ~freqslider.valueAction_(obj.value.explin(100,1000,0,1))
// });

	///F13
//Properties of the slider
~f13slider = Slider(w, Rect(310,145,20,230))
.background_(Color(0.8,0.8,0.8,0.75))
	.value_(0.5) //is converted to 1
	.orientation_(\vertical)
	.action_({
	arg obj;
	var cf;
	cf = obj.value.linlin(0,1,0.0,2).postln;
		if(
		x.isPlaying,
		{x.set(\f13,cf)});
	~number13Box.value_(obj.value.linlin(0,1,0.0,2));
		~freqslider.valueAction_(~fslider.value); //This allows it to refresh real-time
});
//Label
~f13Label = StaticText(w,Rect(310,130,20,15))
.string_("13")
.font_(Font("nil", 12))
.align_(\top)
.background_(Color(0,0,0,0.1))
.stringColor_(Color.black);
//Number box that can edit slider position
~number13Box = NumberBox(w,Rect(310,375,20,15))
.value_(1)
.clipLo_(0.0)
.clipHi_(2)
.font_(Font("nil",7))
.decimals_(2)
.align_(\center)
.action_({
	arg obj;
	~f13slider.valueAction_(obj.value.linlin(0.0,2,0,1))
});
//Number box showing harmonic frequency
~f13Box = NumberBox(w,Rect(310,390,20,15))
.value_(240*13)
.clipLo_(100)
.clipHi_(20000)
.font_(Font("nil",5))
.decimals_(1)
.align_(\center);
	// .action_({
		// arg obj;
		// ~freqslider.valueAction_(obj.value.explin(100,1000,0,1))
// });

	///F14
//Properties of the slider
~f14slider = Slider(w, Rect(330,145,20,230))
.background_(Color(0.8,0.8,0.8,0.75))
	.value_(0.5) //is converted to 1
	.orientation_(\vertical)
	.action_({
	arg obj;
	var cf;
	cf = obj.value.linlin(0,1,0.0,2).postln;
		if(
		x.isPlaying,
		{x.set(\f14,cf)});
	~number14Box.value_(obj.value.linlin(0,1,0.0,2));
		~freqslider.valueAction_(~fslider.value); //This allows it to refresh real-time
});
//Label
~f14Label = StaticText(w,Rect(330,130,20,15))
.string_("14")
.font_(Font("nil", 12))
.align_(\top)
.background_(Color(0,0,0,0.1))
.stringColor_(Color.black);
//Number box that can edit slider position
~number14Box = NumberBox(w,Rect(330,375,20,15))
.value_(1)
.clipLo_(0.0)
.clipHi_(2)
.font_(Font("nil",7))
.decimals_(2)
.align_(\center)
.action_({
	arg obj;
	~f14slider.valueAction_(obj.value.linlin(0.0,2,0,1))
});
//Number box showing harmonic frequency
~f14Box = NumberBox(w,Rect(330,390,20,15))
.value_(240*14)
.clipLo_(100)
.clipHi_(20000)
.font_(Font("nil",5))
.decimals_(1)
.align_(\center);
	// .action_({
		// arg obj;
		// ~freqslider.valueAction_(obj.value.explin(100,1000,0,1))
// });

	///F15
//Properties of the slider
~f15slider = Slider(w, Rect(350,145,20,230))
.background_(Color(0.8,0.8,0.8,0.75))
	.value_(0.5) //is converted to 1
	.orientation_(\vertical)
	.action_({
	arg obj;
	var cf;
	cf = obj.value.linlin(0,1,0.0,2).postln;
		if(
		x.isPlaying,
		{x.set(\f15,cf)});
	~number15Box.value_(obj.value.linlin(0,1,0.0,2));
		~freqslider.valueAction_(~fslider.value); //This allows it to refresh real-time
});
//Label
~f15Label = StaticText(w,Rect(350,130,20,15))
.string_("15")
.font_(Font("nil", 12))
.align_(\top)
.background_(Color(0,0,0,0.1))
.stringColor_(Color.black);
//Number box that can edit slider position
~number15Box = NumberBox(w,Rect(350,375,20,15))
.value_(1)
.clipLo_(0.0)
.clipHi_(2)
.font_(Font("nil",7))
.decimals_(2)
.align_(\center)
.action_({
	arg obj;
	~f15slider.valueAction_(obj.value.linlin(0.0,2,0,1))
});
//Number box showing harmonic frequency
~f15Box = NumberBox(w,Rect(350,390,20,15))
.value_(240*15)
.clipLo_(100)
.clipHi_(20000)
.font_(Font("nil",5))
.decimals_(1)
.align_(\center);
	// .action_({
		// arg obj;
		// ~freqslider.valueAction_(obj.value.explin(100,1000,0,1))
// });

	///F16
//Properties of the slider
~f16slider = Slider(w, Rect(370,145,20,230))
.background_(Color(0.8,0.8,0.8,0.75))
	.value_(0.5) //is converted to 1
	.orientation_(\vertical)
	.action_({
	arg obj;
	var cf;
	cf = obj.value.linlin(0,1,0.0,2).postln;
		if(
		x.isPlaying,
		{x.set(\f16,cf)});
	~number16Box.value_(obj.value.linlin(0,1,0.0,2));
		~freqslider.valueAction_(~fslider.value); //This allows it to refresh real-time
});
//Label
~f16Label = StaticText(w,Rect(370,130,20,15))
.string_("16")
.font_(Font("nil", 12))
.align_(\top)
.background_(Color(0,0,0,0.1))
.stringColor_(Color.black);
//Number box that can edit slider position
~number16Box = NumberBox(w,Rect(370,375,20,15))
.value_(1)
.clipLo_(0.0)
.clipHi_(2)
.font_(Font("nil",7))
.decimals_(2)
.align_(\center)
.action_({
	arg obj;
	~f16slider.valueAction_(obj.value.linlin(0.0,2,0,1))
});
//Number box showing harmonic frequency
~f16Box = NumberBox(w,Rect(370,390,20,15))
.value_(240*16)
.clipLo_(100)
.clipHi_(20000)
.font_(Font("nil",5))
.decimals_(1)
.align_(\center);
	// .action_({
		// arg obj;
		// ~freqslider.valueAction_(obj.value.explin(100,1000,0,1))
// });


~quit = Button.new(w, Rect(760,65,30,30))
	.states_([["", Color.white, Color.clear]])
	.font_(Font("nil", 12))
	.mouseDownAction_({
		x.free;
		y.free;
		z.free;
		v.free;
		t.free;
		a.free; //clear buffers to help resolve memory leak
		b.free;
		e.free;
		l.free;
		// ~d.quit; causes issues if ~d doesn't exist before quitting, in any case ~d closes automatically because it is parented to the w window
		// ~w2.close; //similar issue, but this does leave the oscilloscope open - workaround on splashscreen command
		~scopebutton.valueAction_(0); //this works instead of closing the window as now the global variable is always available
		h.kill;
		w.close;
		(basePath +/+ "splashscreen.scd").loadPaths;
		});

	//Open Stethoscope
~scopebutton = Button(w, Rect((690-27.5), 112.5, 120, 20))
.states_([
	["Open Oscilloscope", Color.white,Color(0.4824, 0.4863, 0.4863,1)]/*,
	["Close Oscilloscope", Color.white, Color.grey(0.251)]*/
])
.font_(Font("nil", 12))
.mouseDownAction_({
	/*arg obj;
	if(obj.value == 1,
		{*/
				~w2 = Window.new("Oscilloscope", Rect.new(
	Window.screenBounds.width/2+420,
	500,
		250,250),false).background_(Color.white).userCanClose_(true).front;

		~d = Stethoscope.new(s, 2,view:~w2) //.scope//nil causes it to open in its own window
				// .xZoom_(5) //is only setting slider, isn't changing view properly
				// .cycle_(50) //same problem as xZoom: workaround, use a button for 440Hz
				.yZoom_(4);

				( //still not auto-setting
s.sendBundle(2, //sound delay
				["/s_new", "d", ~nam = s.nextNodeID, 1, 1, s.cycle_(501)]; //nam to ensure it doesn't override any other variables
				););

				// ~d.cycle_((501));
				// ~d.scope(zoom:4);
		/*	}*//*,
		{
				// ~w2.close;
				// ~d.quit //had to comment these two to make it not error as can't interpret - maybe these should open as default?
			}*/
	/*);*/
});


~scope2button = Button(w, Rect((690-27.5), 132.5, 120, 20))
.states_([
	["Set Osc. to ~440Hz", Color.white,Color(0.4824, 0.4863, 0.4863,1)]
])
.font_(Font("nil", 12))
	.action_({
		~d
		//.xZoom_((438.9105/1024)*1)
		.cycle_((501));
	/*	{x}.plot*/
	}
	);


	//Keyboard visualizer button
		~key_vis = Button.new(w, Rect(575,70,60,25))
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



	~i = Image.new(basePath +/+ "images/mapleICON-small.png");
~keyboard_image = Image.new(basePath +/+ "images/keyboard_small.png");

//Aesthetic lines
	w.drawFunc = {
		~i.drawInRect(Rect(760,65,30,30), Rect(0,0,30,30), 2, 1.0);
		~keyboard_image.drawInRect(Rect(575,70,60,25), Rect(0,0,60,25), 2, 1.0);
		Pen.line(10@490,790@490); //Fifth line
		Pen.line(10@450,790@450); //Fourth line
		Pen.line(10@410,790@410); //Third line
		Pen.line(10@100,790@100); //Second line
	Pen.strokeColor = Color(0,0,0,0.5); //Top line, written differently in code
                Pen.width = 2;
                Pen.moveTo(10@60);
                Pen.lineTo(790@60);
                Pen.stroke;
        };

/*
			//TECHNICAL DETAILS
		~tech = Button.new(w, Rect(10, 70, 20, 20))
	.states_([["?", Color.white, Color.gray]])
	.font_(Font("nil", 10))
	.mouseDownAction_({
(basePath +/+  "modules/technical_details.scd").loadPaths; //This line allows all contact buttons to be updated automatically

		});
*/

//Record button - sends to Supercollider file
	~tech = Button.new(w, Rect(35, 70, 85, 20))
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
		);




	///SPECTRA BUTTON
	//Add swapables for the pen lines to switch the frequency views

	~spectraButton = Button(w, Rect((690-27.5), 112.5+40, 120, 20))
.states_([
		["Log View", Color.white,Color(0.4824, 0.4863, 0.4863,1)]
		,["Linear View", Color.white,Color(0.4824, 0.4863, 0.4863,1)]]

)
.font_(Font("nil", 12))
.action_(


				{

					arg obj;
	if(obj.value == 1,
						{


					h.freqMode_(0);
					~composite.bounds_(Rect(320+90,105,500,300));
					p.visible = false;

						},{h.freqMode_(1); ~composite.bounds_(Rect(320,105,500,300));}
			)});



	//Button to reset harmonic intensities
~reset = Button(w, Rect(110,110,35,20))
.states_([
	["Reset
intensities", Color.white,Color(0.4824, 0.4863, 0.4863,1)]
])
.font_(Font("nil", 6))
.action_({
		~volslider.valueAction_(0.2.value.linlin(0,1,0,1));
		~f1slider.valueAction_(1.value.linlin(0.0,2,0,1));
		~f2slider.valueAction_(1.value.linlin(0.0,2,0,1));
		~f3slider.valueAction_(1.value.linlin(0.0,2,0,1));
		~f4slider.valueAction_(1.value.linlin(0.0,2,0,1));
		~f5slider.valueAction_(1.value.linlin(0.0,2,0,1));
		~f6slider.valueAction_(1.value.linlin(0.0,2,0,1));
		~f7slider.valueAction_(1.value.linlin(0.0,2,0,1));
		~f8slider.valueAction_(1.value.linlin(0.0,2,0,1));
		~f9slider.valueAction_(1.value.linlin(0.0,2,0,1));
		~f10slider.valueAction_(1.value.linlin(0.0,2,0,1));
		~f11slider.valueAction_(1.value.linlin(0.0,2,0,1));
		~f12slider.valueAction_(1.value.linlin(0.0,2,0,1));
		~f13slider.valueAction_(1.value.linlin(0.0,2,0,1));
		~f14slider.valueAction_(1.value.linlin(0.0,2,0,1));
		~f15slider.valueAction_(1.value.linlin(0.0,2,0,1));
		~f16slider.valueAction_(1.value.linlin(0.0,2,0,1));

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

//True note value
	~note_name = StaticText(w,Rect(200,112.5,27,15))
	.string_("A0").align_(\center)
	.font_(Font("nil", 11));

w.onClose_({s.quit}); //not working, rerouted to back button
})
 //ends server when quit
)
// ~d.cycle_(501)//can only go to 0 decimals anyways, rounds up at 5th-ish decimal
// 300.99999
// (~d.cycle).postln