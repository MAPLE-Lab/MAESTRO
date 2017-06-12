# Welcome to the R program to created data tables for MAESTRO (SuperCollider component)!

# STEP 1 - PACKAGES
# Load required packages
library(lazyeval)
library(plotly)
library(seewave)
library(tuneR)
library(ggplot2)
library(fftw)
library(rgl)
library(audio)

# STEP 2 - SET WORKING DIRECTORY
# Set path to the source file
# Currently does not work automatically
# Change the path to your desired working directory
# All files in this program will be saved there
setwd("~/MAPLE-Lab-Auditory-Exploration-Suite/programs/R")

# STEP 3 - SELECT SOUND
# Select the sound file to be analyzed
# Usage: Opens pop-up window for the user to select the sound file they want to analyze
# Input: WAVE/WAV file (i.e. .wav)
# Output: path to the sound file, saved as "soundfile" in R
soundfile <- file.choose()

# STEP 4 - STEREO CHECK
# Check if the sound file is stereo
# The later functions can only use mono sounds
# Therefore, if the sound is stereo, a message will appear and a new sound file will be generated saving only the LEFT channel
# Input: The soundfile path
# Output: If soundfile is mono, soundfileActive is the same file. If soundfile is stereo, a new WAVE file is generated, saved as soundfileMonoL.wav, to which soundActive is saved to.
soundfileRead <- readWave(soundfile)
if(soundfileRead@stereo) {
  soundfileMonoL <- mono(soundfileRead, "left") # To save the right channel instead, change "left" to "right"
  savewav(soundfileMonoL)
  print("Re-runs script now using the newly created mono sound")
  soundfileActive <- (paste0(getwd(), "/", "soundfileMonoL.wav"))
} else {
  soundfileActive <- soundfile
}
soundfileActiveRead <- readWave(soundfileActive)

# STEP 5 - ANALYSIS PARAMETERS
# Here the resolution of ferquency in the analysis can be changed.
# The more frequency bins used, the greater the resolution.
# HOWEVER, the more frequency bins used, the less time bins used (i.e. worsened resolution in the time domain).
# 256*4 (1024) frequency bins appears to be a good number for general use.

# Input: In the line "numberOfFreqBins <- 256*4", change the multiplier (i.e. 4) to the desired amount.
# Output: wlValue will be used in following functions. freqBinWidth gives the frequency range of each bin.
numberOfFreqBins <- 256*4
wlValue <- numberOfFreqBins*2
freqBinWidth <- 22050/numberOfFreqBins

# Input: Nothing on the user's end. All values are generated from the previous functions.
# Output: soundfileDuration gives the duration of the sound file in seconds. timeBinWidth gives the width of each time bin in seconds. numberOfTimeBins gives the number of time bins that will be created by the software.
soundfileDuration <- (length(soundfileRead@left)/soundfileRead@samp.rate)
timeBinWidth <- (2.98/64)/(1024/numberOfFreqBins) # ERROR: SOMETIMES NEEDS TO BE x2 THIS VALUE, UNKNOWN CAUSE AS OF June 11, 2017
numberOfTimeBins <- round(soundfileDuration/timeBinWidth-0.5) # The -0.5 rounds the number down, as the later functions will do (it seems).

# Input: The wlValue calculated previously and the active soundfile path (designated in STEP 4).
# Output: A visual overview of the time envelope and frequency spectrum of the soundfileActive.
acoustat(soundfileActiveRead, wl = wlValue)

# STEP 6 - EXTRACT DATA
# The following function will create the data table that shows the changing intensity values of frequencies over time.
# Everything below the threshold value will be erased to reduce noise.

# Input: Previously calculated and designated values.
# Output: Matrix with frequencies listed as rows and time listed as columns.
soundMatrix <- stft.ext(file=soundfileActive, wl = wlValue) #, ovlp = 0.5)
thresholdValue = 1
thresholdFunction <- (function(x) if(x < thresholdValue) {x = 0} else x)
soundMatrixThreshold <- soundMatrix # Creates a duplicate matrix
soundMatrixThreshold[] <- vapply(soundMatrix, thresholdFunction, numeric(1)) # Applies the function to the duplicate

# Input: The previous soundMatrixThreshold.
# Output: A version with proper Hz and second values as row and column names, respectively.
soundMatrixThresholdNamed <- soundMatrixThreshold

# Give columns and rows a value that can later be converted into a name.
# Creates sequences of the necessary length.
col_seq = 1:ncol(soundMatrixThresholdNamed) 
row_seq = 1:nrow(soundMatrixThresholdNamed)

# Applies the values as names to the matrix
colnames(soundMatrixThresholdNamed) <- c(paste(col_seq))
rownames(soundMatrixThresholdNamed) <- c(paste(row_seq))

# Name the X axis for frequency bins (the value is equal to the upper limit of each bin)
colnames(soundMatrixThresholdNamed) <- c(paste(col_seq))
for (i in col_seq) {colnames(soundMatrixThresholdNamed)[i] <- paste(
  i*timeBinWidth
)}

# Name the Y axis for time bins (the value is equal to the upper limit of each bin)
for (i in row_seq) {rownames(soundMatrixThresholdNamed)[i] <- paste(
  i*freqBinWidth
)}

# STEP 7 - ISOLATE HARMONICS
# Only the 16 (or specified) number of harmonics are required.
# Input: The numberOfHarmonics and the fundamentalFreq values.
# Outpit: A data table with only the rows of the desired harmonics.
numberOfHarmonics <- 16 # This value can be changed as necessary.
fundamentalFreq <- 261.63 # In Hz.

harmonicSeq <- seq(from = fundamentalFreq, to = fundamentalFreq*numberOfHarmonics, by = fundamentalFreq)

# Every row is the same frequency distance from the next = freqBinWidth
startingBin <- as.integer(fundamentalFreq / freqBinWidth + 1) # +1 added to round up as it is needed for optimal results, based on trial and error

harmonicColSeq <- seq(from = startingBin, to = startingBin*numberOfHarmonics, by = 12.2) # Based on horn and cello values

soundMatrixThresholdNamedTransposed <- t(soundMatrixThresholdNamed)

harmonicMatrix <- soundMatrixThresholdNamedTransposed[,harmonicColSeq[1:numberOfHarmonics]]

maximumValue <- max(harmonicMatrix, na.rm = TRUE)
scaleFunction <- (function(x) x/maximumValue)
harmonicMatrixScaled <- harmonicMatrix # Creates a duplicate matrix
harmonicMatrixScaled[] <- vapply(harmonicMatrix, scaleFunction, numeric(1)) # Scales all values to be between 0-1.

# This creates all 16 harmonic arrays
for(i in 1:numberOfHarmonics) {
  temp_harmonicMatrixScaled_name = paste("harmonicMatrixScaled", i, "array", sep = ".")

  temp_harmonicMatrixScaled_values <- paste(as.character(harmonicMatrixScaled[,i]), collapse=",")
  
  assign(temp_harmonicMatrixScaled_name, temp_harmonicMatrixScaled_values)
}

# The time array
timeRawArray <- rep(timeBinWidth, each = (numberOfTimeBins-1))
timeRawArray.print <- paste(as.character(timeRawArray), collapse=",")
timeArray.print <- paste0("[", timeRawArray.print, "]")

# STEP 8 - EXPORT files
# Input: All precalculated by previous functions.
# Output: The exported CSV and TEXT files will be used by MAESTRO (SuperCollider component) to generate the synthesized sound.
write.csv(harmonicMatrixScaled, file = "harmonicMatrixScaled.csv")

for(i in 1:numberOfHarmonics) {
  temp_harmonicMatrixScaled_print_name = paste("harmonicMatrixScaled", i, "array.print.txt", sep = ".")

  temp_harmonicMatrixScaled_array_value <- paste("harmonicMatrixScaled", i, "array", sep = ".")

  temp_harmonicMatrixScaled_values <- paste(as.character(harmonicMatrixScaled[,i]), collapse=",")
  
  temp_harmonicMatrixScaled_array_value <- temp_harmonicMatrixScaled_values
  
  temp_harmonicMatrixScaled_array_value_bounded <- paste0("[", temp_harmonicMatrixScaled_array_value, "]")
  
  write(temp_harmonicMatrixScaled_array_value_bounded, file = temp_harmonicMatrixScaled_print_name)
}

write(timeArray.print, file = "timeRawArray.print.txt")

print("Script completed, switch to SuperCollider now.")
