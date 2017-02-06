(
d = Window.new("Technical Details", Rect(Window.screenBounds.width/2-150,
				Window.screenBounds.height/2-150,300,300)).front;

~internalText = StaticText(d,Rect(10,10,280,280))
	.string_("Technical Details

Software: SuperCollider (3.8dev)
Audio recordings from:
Funded by: ")
.font_(Font("Helvetica", 12, false))
.align_(\topLeft)
.background_(Color(1,1,1,0))
		.stringColor_(Color(0.2510));



)