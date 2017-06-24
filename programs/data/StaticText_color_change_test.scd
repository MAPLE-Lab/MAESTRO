AppClock

(
AppClock.sched(0.0,{ arg time;
    ["AppClock has been playing for ",time].postln;
    1;
});
)

(
SystemClock.sched(0.0,{ arg time;
    time.postln;
    1; // Updates ever 1 sec
});
)

var basePath = thisProcess.nowExecutingPath.asString.dirname;

		~harmonicsDataArray = TabFileReader.readInterpret(basePath.dirname +/+ "R/R_working_files/harmonicMatrixScaled.txt").postcs; // Imports the tab delimited data file from the R export

~timeInterval = ~harmonicsDataArray[1,0].drop(1)

[0].interpret; // Needs the .interpret to work in Env

		//Loop to create envelopes
		~number_of_harmonics = Array.fill(16, { arg i; i+1 });
		~number_of_harmonics.do({ arg item, i;
		(
		"~envelope" ++ item ++ "= ~harmonicsDataArray[" ++ item ++ ",0].drop(1);
~harmonic" ++ item ++ "Env = Env.new(~envelope" ++ item ++ ", ~timeInterval);
~harmonic" ++ item ++ "Env.plot;" // Uncomment the line to plot the envelopes
			).postln.interpret;
		});
