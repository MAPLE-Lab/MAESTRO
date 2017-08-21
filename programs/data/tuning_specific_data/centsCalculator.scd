~calculateCents = {
	var harmonicFrequency, harmonicMIDI;
//~fslider.value.linlin(0,1,21,108); // Fundamental MIDI
//((2**((-69+~fslider.value.linlin(0,1,21,108))/12))*440); // Fundamental freq

//~freqslider.value.linlin(0,1,-1,1); // % to the harmonic
harmonicFrequency = ((2**((-69+~fslider.value.linlin(0,1,21,108))/12))*440)*(~menu2.value+~freqslider.value.linlin(0,1,-1,1)); // Frequency of harmonic
<<<<<<< HEAD
harmonicFrequency.postln;
harmonicMIDI = (log2(harmonicFrequency/440)*12)+69; // MIDI of harmonic
	(["MIDI", harmonicMIDI]).postln;
//harmonicMIDI - ~fslider.value.linlin(0,1,21,108); // Difference in MIDI

	(~fslider.value.linlin(0,1,21,108)-~current_harmonic_MIDINN).postln;


=======

harmonicMIDI = (log2(harmonicFrequency/440)*12)+69; // MIDI of harmonic

//harmonicMIDI - ~fslider.value.linlin(0,1,21,108); // Difference in MIDI

	harmonicMIDI.postln;
>>>>>>> b65f3eb83bd1defa69283b8e359090cf0d25d1bf
	((harmonicMIDI-~fslider.value.linlin(0,1,21,108)-~current_harmonic_MIDINN)).postln;
	~centsBox.value_((harmonicMIDI - ~fslider.value.linlin(0,1,21,108)-~current_harmonic_MIDINN)*100); // Difference in cents
};

// Interesting side effect - shows how the actual frequency differs from the keyboard

//~deviant_maximum // MIDI count to next harmonic

<<<<<<< HEAD
// ~fund
/*
log2(36)

(log2(1760/440)*12)+69*/
=======
~fund
>>>>>>> b65f3eb83bd1defa69283b8e359090cf0d25d1bf
