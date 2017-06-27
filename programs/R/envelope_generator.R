# Welcome to the R program to created data tables for MAESTRO (SuperCollider component)!

# STEP 0 - SOURCE FUNCTIONS
# This line loads all the functions from the "functions_R.R" R code file.
# These functions are then called (with appropriate arguments) in all following code.
filePath <- "~/Dropbox/MAPLE-Lab-Auditory-Exploration-Suite/programs/R"
frequencyResolution <- 4 # 4 is a good value with a frequency resolution of ~20Hz. 5 increases frequency resolution to ~10Hz.
thresholdValue <- 0.1 # Set at 0 all noise is captured; however, in top-down analysis (where the user selects the harmonics), this is not a problem and improves audio synthesis
# STEP 3 - SELECT SOUND
# Select the sound file to be analyzed
# Usage: Opens pop-up window for the user to select the sound file they want to analyze
# Input: WAVE/WAV file (i.e. .wav)
# Output: path to the sound file, saved as "soundfile" in R
soundfile <- file.choose()

setwd(filePath)
source("functions_R.R")

# STEP 1 - PACKAGES
# Loads required packages
loadPackages()

# STEP 2 - SET WORKING DIRECTORY
# CHANGE the 'filePath' value to the directory appropriate to your computer.
# All files in this program will be saved in the folder "R_working_files" within this directory.
# "R_working_files" is a directory pre-made in MAESTRO.
organizeDirectory(filePath)


# STEP 4 - STEREO CHECK
# Check if the sound file is stereo
# The later functions can only use mono sounds
# Therefore, if the sound is stereo, a message will appear and a new sound file will be generated saving only the LEFT channel
# Input: The soundfile path
# Output: If soundfile is mono, soundfileActive is the same file. If soundfile is stereo, a new WAVE file is generated, saved as soundfileMonoL.wav, to which soundActive is saved to.
soundfileStereoCheck(soundfile)

# STEP 5 - ANALYSIS PARAMETERS
# Here the resolution of ferquency in the analysis can be changed.
# The more frequency bins used, the greater the resolution.
# HOWEVER, the more frequency bins used, the less time bins used (i.e. worsened resolution in the time domain).
# 256*4 (1024) frequency bins appears to be a good number for general use.

# Input: In the line "numberOfFreqBins <- 256*4", change the multiplier (i.e. 4) to the desired amount.
# Output: wlValue will be used in following functions. freqBinWidth gives the frequency range of each bin.
freqParameters(frequencyResolution)

# Input: Nothing on the user's end. All values are generated from the previous functions.
# Output: soundfileDuration gives the duration of the sound file in seconds. timeBinWidth gives the width of each time bin in seconds. numberOfTimeBins gives the number of time bins that will be created by the software.
timeParameters(soundfileActiveRead)

# Input: The wlValue calculated previously and the active soundfile path (designated in STEP 4).
# Output: A visual overview of the time envelope and frequency spectrum of the soundfileActive.
acoustat(soundfileActiveRead, wl = wlValue)

# STEP 6 - EXTRACT FREQUENCYxTIME DATA
# The following function will create the data table that shows the changing intensity values of frequencies over time.
# Everything below the threshold value will be erased to reduce noise.
soundAnalysis(file=soundfileActive, wl = wlValue, thresholdValue = thresholdValue)


# STEP 7 - ISOLATE HARMONICS
# Top-down method: User selects number of harmonics and the fundamental
# Only the 16 (or specified) number of harmonics are required.
# Input: The numberOfHarmonics and the fundamentalFreq values.
# Outpit: A data table with only the rows of the desired harmonics.
numberOfHarmonics <- 16 # This value can be changed as necessary.
fundamentalFreq <- 261.63 # In Hz.

isolateHarmonics() # Uses many arguments, so currently does not allow changes to arguments for simplicity of use
# Time Warning: This could take a minute or longer depending on the amount of data

# This creates all 16 harmonic arrays
#for(i in 1:numberOfHarmonics) {
#  temp_harmonicMatrixScaled_name = paste("harmonicMatrixScaled", i, "array", sep = ".")

#  temp_harmonicMatrixScaled_values <- paste(as.character(harmonicMatrixScaled[,i]), collapse=",")
  
#  assign(temp_harmonicMatrixScaled_name, temp_harmonicMatrixScaled_values)
#}

# STEP 8 - PLOT
plotMAESTRO() # Time Warning: This could take a minute or longer depending on the amount of data


# STEP 9 - EXPORT files
# Input: All precalculated by previous functions.
# Output: The exported TEXT files will be used by MAESTRO (SuperCollider component) to generate the synthesized sound.

# The time array
# timeArray()

# Full print of two files, the harmonics table and the time array:
exportMAESTRO()

print("Script completed, switch to SuperCollider now.")
