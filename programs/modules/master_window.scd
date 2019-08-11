//Creates the master window
w = Window.new("MAPLE Lab Overtone 'Popout' Demonstration", Rect.new(
	~master_window_bounds_array[0],
	~master_window_bounds_array[1],
	~master_window_bounds_array[2],
	~master_window_bounds_array[3]
),
TabFileReader.read(~trace +/+  "admin/access.txt").[4].[2].interpret) //Cannot be resized by user without admin permission.
.background_(Color.white)
.userCanClose_(false)
.front
.acceptsMouseOver_(true);

//Opening paragraph for the module
~para = StaticText(w,Rect(10,10,~master_window_bounds_array[2]-20,80))
.string_(
"If you see these words, an error has occured."
	)
.font_(Font("nil", 12))
.align_(\topLeft)
.background_(Color(0,0,0,0))
.stringColor_(Color.clear); // Now seen in inspector window

//Displays name of the fundamental note
	~note_name = StaticText(w,Rect(
	~note_name_bounds_array[0],
	~note_name_bounds_array[1],
	~note_name_bounds_array[2],
	~note_name_bounds_array[3]
))
.string_("A4").align_(\center)
.font_(Font("nil", 11));
