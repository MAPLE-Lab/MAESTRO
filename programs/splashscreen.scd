(
var basePath = thisProcess.nowExecutingPath.asString.dirname; //http://new-supercollider-mailing-lists-forums-use-these.2681727.n2.nabble.com/Generalizing-a-files-path-td7616651.html
~trace = basePath;
s.waitForBoot({ //Ensures it only opens once the server is working completely, and automatically opens server
	(
    i = Image.new(thisProcess.nowExecutingPath.asString.dirname +/+ "images/splash-small.png"); //make sure this can work when not on my computer
    j = Image.new(thisProcess.nowExecutingPath.asString.dirname +/+ "images/background_from_website.png");
		t = Window.new("MAPLE Lab Auditory Exploration Suite (Beta)", Rect(
	Window.screenBounds.width/2-400,
	Window.screenBounds.height/2-100,
		800,500), false)
		.background_(Color.white)
		.front
		.userCanClose_(false); //To close must use the Quit button - avoids the issue where the window closing breaks the following software opening without a server
    t.onClose_({ i.free }); // free the image when the window is closed
    t.drawFunc_({
			j.drawInRect(Rect(0,0,1160,874), Rect(200,0,1160,874), 2, 1.0); // only a section
			i.drawInRect(Rect(0,0,1160,874), Rect(0,0,1160,874), 2, 1.0); // only a section

		    // CIRCLE
			// Pen.fillOval(Rect(705, 415, 20, 20));
			//	// Pen.fillAxialGradient(0,10,Color(0.4824, 0.4863, 0.4863), Color(0.2510,0.2510,0.2510))
			// Pen.fillRadialGradient(10,20, 5, 10, Color(0.4824, 0.4863, 0.4863), Color(0.4824, 0.4863, 0.4863)); // just gray for now
		});


		// ~w2 = Window.new();

//Ensures that the oscilloscope closes from Spectra
		// ~w2.close; //still not functioning

////VERSION:
~versioncode = StaticText(t,Rect((400-400),430+10,800,80))
	.string_((basePath +/+  "data/version_code.scd").loadPaths) //Updated post-LOVE 2017
.font_(Font("Helvetica", 10, false))
.align_(\top)
.background_(Color(0,0,0,0))
		.stringColor_(Color(0.2510));

t.view.keyDownAction = { arg view, char, modifiers, unicode, keycode;
	[char, modifiers, unicode, keycode].postln;
};

/*
		//Keyboard controls temp holding:
(
{ SinOsc.ar([100,100], 0, KeyState.kr(125, 0, 0.1)) }.play;
{ SinOsc.ar([200, 200], 0, KeyState.kr(126, 0, 0.1)) }.play;
);
*/

//Title
~title = StaticText(t,Rect((400-400),413,800,80))
	.string_("Auditory Exploration Suite")
.font_(Font("Helvetica", 22, true))
.align_(\top)
.background_(Color(0,0,0,0))
		.stringColor_(Color(0.2510));


		//Buttons
~adminAccessArray = Array.fill(4, {arg i;
	if(TabFileReader.read(~trace +/+  "admin/access.txt").[i].[2] == "true",
		{1},{0});});

		// Height of all buttons together:	(140+(50*~adminAccessArray[0..3].sum)-50)
		// Center line for the buttons (140+290)/2

			~splashButtonWidth = 150;

		if(TabFileReader.read(~trace +/+  "admin/access.txt").[0].[2] == "true", {
~tuningButton = Button.new(t, Rect((400-220-50), ((140+290)/2)-(((50*~adminAccessArray[0..3].sum)-50)/2)
+(~adminAccessArray[0..0].sum*50)-50, ~splashButtonWidth, 40))
	.states_([["Tuning", Color.white, Color(0.7569,0.1373,0.1725,1)]])
	.font_(Font("nil", 18))
	.mouseDownAction_({

			(basePath +/+  "MAPLE_Tuning_Demonstration.scd").loadPaths;
			t.close;
		});
		});

		if(TabFileReader.read(~trace +/+  "admin/access.txt").[1].[2] == "true", {
~spectraButton = Button.new(t, Rect((400-220-50), ((140+290)/2)-(((50*~adminAccessArray[0..3].sum)-50)/2)
+(~adminAccessArray[0..1].sum*50)-50, ~splashButtonWidth, 40))
	.states_([["Spectra", Color.white, Color(0.7569,0.1373,0.1725,1)]])
	.font_(Font("nil", 18))
	.mouseDownAction_({
			(basePath +/+  "MAPLE_Spectra_Demonstration.scd").loadPaths;
			t.close;
		});
		});

		if(TabFileReader.read(~trace +/+  "admin/access.txt").[2].[2] == "true", {
		~tonesButton = Button.new(t, Rect((400-220-50), ((140+290)/2)-(((50*~adminAccessArray[0..3].sum)-50)/2)
+(~adminAccessArray[0..2].sum*50)-50, ~splashButtonWidth, 40))
	.states_([["Diff. Tones", Color.white, Color(0.7569,0.1373,0.1725,1)]])
	.font_(Font("nil", 18))
	.mouseDownAction_({
			(basePath +/+  "MAPLE_Difference_Tones.scd").loadPaths;
			t.close;
		});
		});

		if(TabFileReader.read(~trace +/+  "admin/access.txt").[3].[2] == "true", {
		~synthesizerButton = Button.new(t, Rect((400-220-50), ((140+290)/2)-(((50*~adminAccessArray[0..3].sum)-50)/2)
+(~adminAccessArray[0..3].sum*50)-50, ~splashButtonWidth, 40))
	.states_([["Tone Designer", Color.white, Color(0.7569,0.1373,0.1725,1)]])
	.font_(Font("nil", 18))
	.mouseDownAction_({
			(basePath +/+  "MAPLE_Synthesizer.scd").loadPaths;
			t.close;
		});
		});

q = Button.new(t, Rect((400-50), 340, 100, 30))
	.states_([["Quit", Color.white, Color(0.2510,0.2510,0.2510,1)]])
	.font_(Font("nil", 18))
	.mouseDownAction_({s.quit; t.close; Window.closeAll;
		});

~link1 = Button.new(t, Rect((400-50)+235, 340-50-50+40-60, 100-30, 30))
	.states_([["Like us on
Facebook", Color.white, Color(0.2353,0.3529,0.5882,1)]])
	.font_(Font("nil", 10))
	.mouseDownAction_({"open https://www.facebook.com/maplelab.mcmaster".unixCmd
		});

		~link2 = Button.new(t, Rect((400-50)+235, 340-50-50-60, 100-30, 30))
	.states_([["Visit our
website", Color.white, Color(0.4824, 0.4863, 0.4863,1)]])
	.font_(Font("nil", 10))
	.mouseDownAction_({"open https://maplelab.net".unixCmd
		});

		~link3 = Button.new(t, Rect((400-50)+235, 340-50+40-50+40-60, 100-30, 30))
	.states_([["Follow us
on Twitter", Color.white, Color(0.1647, 0.6392, 0.9373,1)]])
	.font_(Font("nil", 10))
	.mouseDownAction_({"open https://twitter.com/maple_lab".unixCmd
		});




//TECHNICAL DETAILS
		~tech = Button.new(t, Rect(707, 415, 20, 20))
	.states_([["?", Color.white, Color.gray]])
	.font_(Font("nil", 10))
	.mouseDownAction_({
(basePath +/+  "modules/technical_details.scd").loadPaths; //This line allows all contact buttons to be updated automatically

		});



);
});
)


///MAPLE Colour palette:
//Red: Color(0.7569,0.1373,0.1725,1)
//White
//Black: Color(0.0118,0.0118,0.0118,1) = 0.0118 across RGB
//Leaf grey: Color(0.4824, 0.4863, 0.4863)
//Headphone grey: Color(0.2510,0.2510,0.2510)= 0.2510 across RGB