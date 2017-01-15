(
var basePath = thisProcess.nowExecutingPath.asString.dirname; //http://new-supercollider-mailing-lists-forums-use-these.2681727.n2.nabble.com/Generalizing-a-files-path-td7616651.html
s.waitForBoot({ //Ensures it only opens once the server is working completely, and automatically opens server
	(
    i = Image.new(thisProcess.nowExecutingPath.asString.dirname +/+ "images/splash-small.png"); //make sure this can work when not on my computer

    t = Window.new("MAPLE Lab Auditory Exploration Suite", Rect(
	Window.screenBounds.width/2-400,
	Window.screenBounds.height/2-50,
		800,500), false)
		.background_(Color.white)
		.front
		.userCanClose_(false); //To close must use the Quit button - avoids the issue where the window closing breaks the following software opening without a server
    t.onClose_({ i.free }); // free the image when the window is closed
    t.drawFunc_({
			i.drawInRect(Rect(0,0,1160,874), Rect(0,0,1160,874), 2, 1.0); // only a section
    });

		// ~w2 = Window.new();

//Ensures that the oscilloscope closes from Spectra
		// ~w2.close; //still not functioning

////VERSION:
~versioncode = StaticText(t,Rect((400-400),430,800,80))
	.string_("Beta Version 0.1.0")
.font_(Font("Helvetica", 10, false))
.align_(\top)
.background_(Color(0,0,0,0))
		.stringColor_(Color(0.2510));




//Title
~title = StaticText(t,Rect((400-400),65,800,80))
	.string_("Auditory Exploration Suite")
.font_(Font("Helvetica", 24, false))
.align_(\top)
.background_(Color(0,0,0,0))
		.stringColor_(Color(0.2510));

		//Buttons
b = Button.new(t, Rect((400-220-50), 180, 100, 40))
	.states_([["Tuning", Color.white, Color(0.7569,0.1373,0.1725,1)]])
	.font_(Font("nil", 18))
	.mouseDownAction_({

			(basePath +/+  "MAPLE_Tuning_Demonstration.scd").loadPaths;
			t.close;
		});

u = Button.new(t, Rect((400+220-50), 180, 100, 40))
	.states_([["Spectra", Color.white, Color(0.7569,0.1373,0.1725,1)]])
	.font_(Font("nil", 18))
	.mouseDownAction_({
			(basePath +/+  "MAPLE_Spectra_Demonstration.scd").loadPaths;
			t.close;
		});

q = Button.new(t, Rect((400-50), 340, 100, 30))
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