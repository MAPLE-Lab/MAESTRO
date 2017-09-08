~calculateCents = {
	var harmonicFrequency, harmonicMIDI;
//~fslider.value.linlin(0,1,21,108); // Fundamental MIDI
//((2**((-69+~fslider.value.linlin(0,1,21,108))/12))*440); // Fundamental freq

//~freqslider.value.linlin(0,1,-1,1); // % to the harmonic
harmonicFrequency = ((2**((-69+~fslider.value.linlin(0,1,21,108))/12))*440)*(~menu2.value+~freqslider.value.linlin(0,1,-1,1)); // Frequency of harmonic

harmonicFrequency.postln;
harmonicMIDI = (log2(harmonicFrequency/440)*12)+69; // MIDI of created harmonic frequency (not as represented on the keyboard)
	(["MIDI", harmonicMIDI]).postln;
//harmonicMIDI - ~fslider.value.linlin(0,1,21,108); // Difference in MIDI

	(~fslider.value.linlin(0,1,21,108)-~current_harmonic_MIDINN).postln;

	((harmonicMIDI-~fslider.value.linlin(0,1,21,108)-~current_harmonic_MIDINN)).postln;

	if(and(~menu2.item == "1", ~freqslider.value <= 0.5), {~centsBoxCover.string_("NaN").background_(Color.white); "Not applicable.".postln;
	},{
		~centsBoxCover.string_(" ").background_(Color.clear);
	~centsBox.value_((harmonicMIDI - ~fslider.value.linlin(0,1,21,108)-~current_harmonic_MIDINN)*100); // Difference in cents
	});
};

// Interesting side effect - shows how the actual frequency differs from the keyboard

//~deviant_maximum // MIDI count to next harmonic


// ~fund
/*
log2(36)

(log2(1760/440)*12)+69*/


// (log2((((2**((-69+~fslider.value.linlin(0,1,21,108))/12))*440)*(~menu2.value+~freqslider.value.linlin(0,1,-1,1)))/440)*12)+69; // MIDI of deviated harmonic frequency (not as represented on the keyboard)
//
// (log2((((2**((-69+~fslider.value.linlin(0,1,21,108))/12))*440)*(~menu2.value))/440)*12)+69; // MIDI of non-deviated harmonic frequency (not as represented on the keyboard)

~calculateCents2 = {
		var harmonicFrequencyDeviant, harmonicMIDIDeviant, harmonicFrequency, harmonicMIDI;

	harmonicFrequencyDeviant = ((2**((-69+~fslider.value.linlin(0,1,21,108))/12))*440)*(~menu2.value+~freqslider.value.linlin(0,1,-1,1)); // Frequency of harmonic

	harmonicMIDIDeviant = (log2(harmonicFrequencyDeviant/440)*12)+69; // MIDI of deviated harmonic frequency (not as represented on the keyboard)

	harmonicFrequency = ((2**((-69+~fslider.value.linlin(0,1,21,108))/12))*440)*(~menu2.value); // Frequency of harmonic

	harmonicMIDI = (log2(harmonicFrequency/440)*12)+69; // MIDI of deviated harmonic frequency (not as represented on the keyboard)


	((harmonicMIDIDeviant-harmonicMIDI)*100).postln;
	~centsBox.value_((harmonicMIDIDeviant-harmonicMIDI)*100); // Difference in cents
};

~calculateCents3 = {
	// ~current_harmonic_MIDINN

	/*~deviant_maximum*~freqslider.value.linlin(0,1,-1,1)*100*/

		if(and(~menu2.item == "1", ~freqslider.value <= 0.5), {~centsBoxCover.string_("NaN").background_(Color.white); "Not applicable.".postln;
	},{
		~centsBoxCover.string_(" ").background_(Color.clear);
	~centsBox.value_(~deviant_maximum*~freqslider.value.linlin(0,1,-1,1)*100);
	});
};