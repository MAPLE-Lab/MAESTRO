//To open the MAPLE Lab application, highlight the code below (line 3) and press the keys Command and Return/Enter at the same on your keyboard.

(thisProcess.nowExecutingPath.asString.dirname +/+ "programs/splashscreen.scd").loadPaths;



// If this error message appears:
"input and output sample rates do not match. 44100 != 48000
could not initialize audio."
//Press the keys Command and Return/Enter on the line of code below (line 11-12)
(s.options.sampleRate = 48000; s.reboot;)