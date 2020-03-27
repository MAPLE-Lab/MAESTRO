(
~technicalWindow = d = Window.new(
	"Technical Details",
	Rect(
		Window.screenBounds.width/2-150,
		(Window.screenBounds.height/2-150)-100,
		300,
		165-15),
	TabFileReader.read(~trace +/+  "admin/access.txt").[4].[2].interpret
).front;

~technicalWindow.onClose_({
	"Technical Details window closed.".postln;
~tech.value_(0);
}); //March 2020, v1.1: now if the window is closed by pressing the window x button rather than re-clicking the ? button on the splashscreen, the ? button will reset

~internalText = StaticText(d,Rect(10,10,280,280))
	.string_("

Software: SuperCollider (3.8dev to 3.11.0).

Instrument audio recordings from: University of Iowa Electronic Music Studios (http://theremin.music.uiowa.edu/MIS.html).

Funded by: Canada Foundation for Innovation, NSERC, and Early Researcher Award to Michael Schutz and NSERC USRA to Maxwell Ng.")
.font_(Font("Helvetica", 12, false))
.align_(\topLeft)
.background_(Color(1,1,1,0))
.stringColor_(Color(0.2510,0.2510,0.2510,1));

~internalText = StaticText(d,Rect(10,10,280,280))
.string_("Technical Details")
.font_(Font("Helvetica", 12, true))
.align_(\topLeft)
.background_(Color(1,1,1,0))
.stringColor_(Color(0.2510,0.2510,0.2510,1));
)
