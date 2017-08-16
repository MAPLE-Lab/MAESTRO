~calculateCents = {
	var harmonicFrequency, harmonicMIDI;
//~fslider.value.linlin(0,1,21,108); // Fundamental MIDI
//((2**((-69+~fslider.value.linlin(0,1,21,108))/12))*440); // Fundamental freq

//~freqslider.value.linlin(0,1,-1,1); // % to the harmonic
harmonicFrequency = ((2**((-69+~fslider.value.linlin(0,1,21,108))/12))*440)*(~menu2.value+~freqslider.value.linlin(0,1,-1,1)); // Frequency of harmonic

harmonicMIDI = (log2(harmonicFrequency/440)*12)+69; // MIDI of harmonic

//harmonicMIDI - ~fslider.value.linlin(0,1,21,108); // Difference in MIDI

	harmonicMIDI.postln;
	((harmonicMIDI-~fslider.value.linlin(0,1,21,108)-~current_harmonic_MIDINN)).postln;
	~centsBox.value_((harmonicMIDI - ~fslider.value.linlin(0,1,21,108)-~current_harmonic_MIDINN)*100); // Difference in cents
};

// Interesting side effect - shows how the actual frequency differs from the keyboard

//~deviant_maximum // MIDI count to next harmonic

~fund