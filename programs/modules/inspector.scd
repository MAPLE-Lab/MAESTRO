(
d = Window.new(
	"Inspector",
	Rect(
		/*Window.screenBounds.width/2-150*/0,
		/*Window.screenBounds.height/2-150*/0,
		300,
		70)).front;

~internalText = StaticText(d,Rect(10,10,280,280))
	.string_("

WIP Version 2017-05-12-1130
Towards: Pre-release v0.1.3-beta

")
.font_(Font("Helvetica", 12, false))
.align_(\topLeft)
.background_(Color(1,1,1,0))
.stringColor_(Color(0.2510,0.2510,0.2510,1));

~internalText = StaticText(d,Rect(10,10,280,280))
.string_("Inspector")
.font_(Font("Helvetica", 12, true))
.align_(\topLeft)
.background_(Color(1,1,1,0))
.stringColor_(Color(0.2510,0.2510,0.2510,1));
)