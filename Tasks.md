# A.E.S. Tasklist
_Updated 2016/01/04_

##**General**

_TO-DOs_



_COMPLETED_

* All must fit into 800x600 screen for class
* Get Audacity
* Put into the Interesting Resources the Wikisinger at end - and post in Acousitc spaces underneath the Media = COMPLETE
* Error to fix: input and output sample rates do not match. 48000 != 44100
	Find solutions
	May have been zombie scsynth (because 2 were open at the same time) http://supercollider.sourceforge.net/wiki/index.php/ERROR:_server_failed_to_start
	Otherwise: 
	s.options.sampleRate = 48000; //or the value necessary
	s.reboot; 
* Class is 3rd week (Jan 17th - 10:30am; Thursday Jan 19th - 9:30-11:20) - TSH 120
So need to know by the 16th to play around
If earlier 
* Recording buttons
* Poster at L.O.V.E. Conference 2017 uploaded to lab wiki


* * *
##**Splashscreen**

_TO-DOs_



_COMPLETED_

* Update splash with Dr. Schutz's image email
* Rename the Go Back to Home
* Version tags (0.1.#)
* Add Find us at the Website and Like us on Facebook
* Technical details button on all apps with details

* * *

##**Tuning Demonstration**

_TO-DOs_


</p>

* Variable: fade in rate

</p>

* Array? Dropdown - set the values of the [0,0,0,1,0,0,0,0] etc. - don't use Array for now; look into "x.seti" in future
*  currently just use direct approach to arguments of "\toggle" for each individual tone
* MasterVolume? arg toggle
* Toggle helps so later in the program 

</p>

* 2D slider for rate and delay (window of tolerance? thresholds?)
* Tone that moves come through a different - for science



_COMPLETED_

* splashscreen
* tonic frequency
* Move Slides OUT of Dropbox once all received
* Rename as "Overtone "popout""
* Add "Reset" button to put it back to correct tuning
* Overall volume slider
* Spectra - can the frequency axis be on the vertical axis (option to go back and forth)? = possibility using Pen, but requires different data collection: http://sccode.org/1-1HR
* Add axis if not possible
* Extend the Freq range of the spectra
* Number of harmonics active -> control the loops of harmonics
* When another option is chosen from the Dropdown menu, it automatically restarts
* Set the focus tone to go to ANY number and whatever it chooses ; not in absolute pitch but relative multiples - use the math (# + varSlider)
* Starts in the middle of the slider
* Dropdown menu for Focus tone (third/fourth/fifth/etc.)
* Add an IF statement so that the harmonic desired to manipulate cannot be manipulated/added by the LOOP
* Figure out how to get the setting of the harmonic to be edited to be automatically called = developped novel solution: "~menu2.value_([menu.value]); //this allows the key to stay and be called at the current one without changing
~menu2.valueAction_([menu.value]);},"
* Rename Select Variant Harmonic to Harmonic (mistuned)
* Rename Harmonic Deviation to Deviation
* Rename Other tones to Harmonics (tuned)
* Add a line between Volumes | Deviant | Other sections
* Reorder so that Deviant is below Others
* Make freq spectra log and set linlin->linexp


* * *

##**Spectra Demonstration**

_TO-DOs_

* Keyboard control (up/down) for Volume? // see Splashscreen


</p>

* Need to figure out Cello and Trumpet to sound better = noise? and precision?
* Find a better tuning fork sound (less noisy, add credit)
* Try to fix drift
* .plot the data of the harmonic spectra, and plots just the spectra - fake it beause of the time axis - more pedagogically valuable - currently use an image from grapher
* Make the sound buttons be 2 switch = done for first row (except for Big button sync)
* At the end of the sound the button springs back up
* Audacity slow-mo the .WAV to get better sample rate and check computer refresh rate and screen recorder rate
* Play button / Silence sounds button
* Auto-off setting
* Amadeus/Audacity can cut the .aiff
* Remove the Hold to Play thing from the InsRec to prove a point of the artificiality
* Add Triangle (math does not seem to be working so far)
* Fix so that the Big button also resets the tiny buttons


</p>

* Normalize volumes amongst audio tracks?
* Import and analyze sound? See how that spectrogram did it...
* Dr. Ballora recommends PVOC (may need extension/quark)
* Still need a way to analyze the harmonics for their time-varying values
* Add OSC Delay for x.free for preset activations = if necessary?
* For GraphClick, set 0db = 100u, -96=0u --> 0-100 on y, exported, points at top of bars - can there be more frames?
* Add ticks at the bottom / overtone lines that work with the tonic frequency =
* See Amadeus (in the lab licenses)
* See DropBox files with videos - use GraphClick to take from those
* Why doesn't Spectra when Win.closed not shut down the server
* Open for keyboard usage for picking fundamental (this should be possible) - needs discussion (see MAX/MSP tone generator online at www.maplelab.net/software)
* Shade/colour keys on piano in proportion to amount of freq in there (intensity?)
* Set Buttons as Global variables - funprogramming.org/134-etc....
* But save the Tuning Fork around


_COMPLETED_

* Under harmonics, give frequencies of each harmonic underneath the intensity value box
* Go up to harmonic 16
* Fix memory spectra allocation
* From error messages it is clear it is a Node tree allocation problem - just later add proper allocations at the start of the program//Remove artifact --> have it free at end..doneAction? or cheap box // BOXED TRIM
* But still issue present in Oscilloscope - so needs a true solution (because additively negative) = COMPLETE, the audio must go to 0 at end or else artifact
* Add oscilloscope button
* Move it over to the left side where it applies, and rename becasue the Power Spectra won't use it
* Rename to Fixed Spectra and Dynamic Spectra and Audio Recording
* Add Square waves and check that the Saw isn't just a Triangle and find the truth of the Sawtooth --> can check the lab wiki for information on the mathematics - /-Classifying+Sounds
* Tuning fork, Trumpet, Flute, Horn
* Put BETA on EVERYTHING
* Mathematically update the Sawtooth = setting phase as pi
* Call it Fundamental not Tonic for Frequency
* Comment out the Triangle and the plot function (still not working)
* Update the Trumpet
* Replace Tuning Fork with Cello and if time available then Clarinet
* Use the WAV files for Audio from the new new dropbox
* Two-switch toggle 
* Oscilloscope should auto-open at 440 = SuperCollider doesn't seem capable
* For now remove the harmonic line indicator sliders (maybe future use window tool)
* Reset button for the Harmonic intensities

* * *

##**Class Wiki**

_TO-DOs_


_COMPLETED_

* Add friendly image
* Add details on opening "SuperCollider.app" because that's still confusing
* And how to work with the new RelativePath version
* The video can introduce the app during lecture


* * *

##**Critical Bands**

* Lin vs Log freqs
* Critical bands highlights
* The 3D vid and audios side-by-side
* Add 
* 1-6 button, 10-16 harmonics
* Button to show critical

* * *

##**Envelopes**

* For research stimuli
* ADSR method?
* Custom numbers
* Have type saved in all versions for on-going research referencing specific coding versions of MAPLE


##Video animation

_TO-DOs_


_COMPLETED_

* Combine them in After Effects, different perspective
* Uploaded to wiki
