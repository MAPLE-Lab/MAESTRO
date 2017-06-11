//To open the MAPLE Lab (Beta) application, highlight the code below (line 3) and press the keys Command and Return/Enter at the same on your keyboard.

(thisProcess.nowExecutingPath.asString.dirname +/+ "programs/splashscreen.scd").loadPaths;


// Troubleshooting:
// If this error message appears:
"input and output sample rates do not match. 44100 != 48000
could not initialize audio."
//Press the keys Command and Return/Enter on the line of code below (line 11)
(s.options.sampleRate = 48000; s.reboot;)

// If this error message appears:
"Exception in World_New: No space left on device
RESULT = 0
ERROR: server failed to start
For advice: [http://supercollider.github.io/tutorials/server-failed-to-start]"
// Check that you have more than 500 MB of hard drive space on your computer. If not, try to clear files and retry the code at line 3.