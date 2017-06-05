(
		if(~inspectorExists == 1, {
	~inspectorHarmonicsPanel.bounds_(Rect(10, 60, 280, 70));

	//~slider_hover = (~f1slider).asString.drop(1) Not usable yet

	~harmonic_in_effect = ("~f"++~slider_hover++"slider").asString;

	~inspectorHarmonicsPanel_harmonic_number.value_(~slider_hover);

	~inspectorHarmonicsPanel_pitch_number.string_(~note_name.string);

	~inspectorHarmonicsPanel_frequency_number.value_(~fundamental_freq.value*~slider_hover);

	~inspectorHarmonicsPanel_intensity_number.value_(~harmonic_in_effect.interpret.value);

};
		);
	);