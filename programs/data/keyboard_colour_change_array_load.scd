// The following function pulls the necessary data from the R-generated file so that the keyboard keys can change coloru as needed
// Input: harm
// To call this function, use:
//~keyNoteColorChangeFunction_dataLoad.value(instrument:"???")
// "???" can be: "horn-fix", "flute", "cello", "clarinet", "trumpet"

~keyNoteColorChangeFunction_dataLoad = {
	arg instrument;

	~harmonicsDataArray = TabFileReader.readInterpret
	(~trace +/+ "data/synth_GUI/harmonicMatrixScaled-" ++ instrument ++ ".txt");
	// ~trace is loaded by the main module (i.e. SPECTRA)

	~timeInterval = ~harmonicsDataArray[0][0];
	("Keyboard GUI synth data for" + instrument + "loaded.").asString.postln;
};

//~keyNoteColorChangeFunction_dataLoad.value(instrument:"test")


~keyNoteColorChangeFunctionMeans_dataLoad = {
	arg instrument;

	~harmonicsMeansDataArray = TabFileReader.readInterpret
	(~trace +/+ "data/synth_GUI/harmonicMatrixScaledMeans-" ++ instrument ++ ".txt");
	// ~trace is loaded by the main module (i.e. SPECTRA)

	~timeInterval = ~harmonicsMeansDataArray[0][0];
	("Keyboard GUI synth data for" + instrument + "loaded.").asString.postln;
}

//~keyNoteColorChangeFunctionMeans_dataLoad.value(instrument:"violin")
//~harmonicsMeansDataArray[1].drop(1)

