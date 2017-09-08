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
	var timer;

	if(obj.value == 1,
		{
			(// Find record value
		~nextRecordingSlotAvailable = 1;
		while ( {File.exists(~trace +/+  "recordings/recording" ++ ~nextRecordingSlotAvailable ++ ".aiff") == true }, // Checks if the file exists
			{ [~nextRecordingSlotAvailable, "exists"].postln; ~nextRecordingSlotAvailable = ~nextRecordingSlotAvailable + 1;  }); // If it does, it posts and increases the count. If it does not, ~nextRecordingSlotAvailable is the next available value for creating a recording
	);
			s.record(path:~trace +/+  "recordings/recording" ++ ~nextRecordingSlotAvailable ++ ".aiff");


			// Auto-turn off if left on for the duration of recording.txt "maxRecordingTime" variable

(
				("Maximum recording time: " ++ TabFileReader.read(~trace +/+  "admin/recording.txt").[0].[2] ++ " seconds.").postln;

				~recordTimer = 0;

				~recordTimerAppClock = AppClock.sched(0, {arg time;
					["Tick 1 second", ~recordTimer].postln;

					~recordTimer = ~recordTimer + 1;

					1});

			AppClock.sched(TabFileReader.read(~trace +/+  "admin/recording.txt").[0].[2].interpret.value,
					{ if(and(~recordTimer > 0, ~record.value == 1), {
						~record.valueAction_(0); // Stop the recording by turning off the button
						~recordTimerAppClock.clear; // Stop the counter
					}, {
						"Record button not pressed.".postln;
						~recordTimerAppClock.clear; // Stop the counter
					}
					); };
				);
			)

		},
		{s.stopRecording;
			if(~inspectorExists == 1, {
				~inspectorText.string_("Audio recording saved to: " ++ ~trace +/+  "recordings/recording" ++ ~nextRecordingSlotAvailable ++ ".aiff");
			});
		("Audio recording saved to: " ++ ~trace +/+  "recordings/recording" ++ ~nextRecordingSlotAvailable ++ ".aiff").postln;
		}
		);
	});