//Update splash with Dr. Schutz's image email

(
s.waitForBoot({ //Ensures it only opens once the server is working completely, and automatically opens server
	(
    i = Image.new("/Users/max/Documents/SuperCollider/mapleICON.png"); //make sure this can work when not on my computer
    t = Window.new("MAPLE Lab Auditory Exploration Suite", Rect(
	Window.screenBounds.width/2-350,
	Window.screenBounds.height/2-50,
		700,700), false)
		.background_(Color.white)
		.front
		.userCanClose_(false); //To close must use the Quit button - avoids the issue where the window closing breaks the following software opening without a server
    t.onClose_({ i.free }); // free the image when the window is closed
    t.drawFunc_({
			i.drawInRect(Rect((350-261),((350-261)),512,512), Rect(0,0,512,512), 2, 1.0); // only a section
    });



//Title
~title = StaticText(t,Rect((350-400),20,800,80))
	.string_("MAPLE Lab
Auditory Exploration Tool")
.font_(Font("Helvetica", 24, true))
.align_(\top)
.background_(Color(0,0,0,0))
.stringColor_(Color.black);

		//Buttons
b = Button.new(t, Rect((350-110), 80, 100, 40))
	.states_([["Tuning", Color.white, Color(0.7569,0.1373,0.1725,1)]])
	.font_(Font("nil", 18))
	.mouseDownAction_({
			"/Users/max/Documents/SuperCollider/MAPLE_Tuning_Demonstration.scd".loadPaths;
			t.close;
		});

u = Button.new(t, Rect((350+10), 80, 100, 40))
	.states_([["Spectra", Color.white, Color(0.7569,0.1373,0.1725,1)]])
	.font_(Font("nil", 18))
	.mouseDownAction_({
			"/Users/max/Documents/SuperCollider/MAPLE_Spectra_Demonstration.scd".loadPaths;
			t.close;
		});

q = Button.new(t, Rect((350-50), 600, 100, 40))
	.states_([["Quit", Color.white, Color(0.2510,0.2510,0.2510,1)]])
	.font_(Font("nil", 18))
	.mouseDownAction_({s.quit; t.close;
		});

);
});
)


///MAPLE Colour palette:
//Red: Color(0.7569,0.1373,0.1725,1)
//White
//Black: 0.0118 across RGB
//Leaf grey: 0.4824, 0.4863, 0.4863
//Headphone grey: 0.2510 across RGB