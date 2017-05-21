~record = Button.new(w, Rect(
	~record_button_bounds_array[0],
	~record_button_bounds_array[1],
	~record_button_bounds_array[2],
	~record_button_bounds_array[3]
))
	.states_
	([
		["Start Recording", Color.white,Color(0.4824, 0.4863, 0.4863,1)],
		["Stop Recording", Color.white, Color.grey(0.251)]
	])
	.font_(Font("nil", 10))
	.action_({
	arg obj;
	if(obj.value == 1,
		{s.record;},
		{s.stopRecording;}
		);
	});