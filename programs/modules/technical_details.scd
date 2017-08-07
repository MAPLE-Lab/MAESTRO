(
d = Window.new(
	"Technical Details",
	Rect(
		Window.screenBounds.width/2-150,
		Window.screenBounds.height/2-150,
		300,
		165)).front;

~internalText = StaticText(d,Rect(10,10,280,280))
	.string_("

Software: SuperCollider (3.8dev).

Instrument audio recordings from: University of Iowa Electronic Music Studios (http://theremin.music.uiowa.edu/MIS.html).
Vocal audio recordings from: Catherine Lee.

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