# This R code file contains all the functions used in the "envelope_generator.R" code file.
# It acts as a source file, which is called at the beginning of "envelope_generator.R".
# Inputs and outputs are commented before each function.
# Note: <<- assigns as GLOBAL variable


# STEP 1 - PACKAGES
# Load required packages
loadPackages <- function(){
  library(lazyeval)
  library(plotly)
  library(seewave)
  library(tuneR)
  library(ggplot2)
  library(fftw)
  library(rgl)
  library(audio)
  print("Packages loaded: lazyeval; plotly; seewave; tuneR; ggplot2; fftw; rgl; audio")
}

# STEP 2 - SET WORKING DIRECTORY
organizeDirectory <- function(x){
  #setwd(x) # Sets the working directory to the argument
  print(getwd())
  filePathPrint <<- paste0(x, "/R_working_files") # Filepath string for the folder to print the files
}

# STEP 4 - SOUND CHECKING
soundfileStereoCheck <- function(x) {
  soundfileRead <- readWave(x)
  if(soundfileRead@stereo) {
    soundfileMonoL <- mono(soundfileRead, "left") # To save the right channel instead, change "left" to "right"
    setwd(filePathPrint) # Temporarily setting the place to save the files
    savewav(soundfileMonoL)
    print(paste0("The selected sound file was a stereo sound. Currently only mono sounds are usable by this script. A WAVE file 'soundfileMonoL.wav' has been created in the directory '", getwd(), "'. The following computations will use this newly created mono-left sound version of the original sound file."))
    soundfileActive <<- (paste0(getwd(), "/", "soundfileMonoL.wav"))
  } else {
    soundfileActive <<- x
    print("The selected sound file was a mono sound. No changes necessary.")
  }
  soundfileActiveRead <<- readWave(soundfileActive) 
}


# STEP 5 - PARAMETER SETTING
freqParameters <- function(x) { # Input argument: 
  numberOfFreqBins <<- 256*x
  wlValue <<- numberOfFreqBins*2
  freqBinWidth <<- 22050/numberOfFreqBins
}

timeParameters <- function(x) { # Input argument: soundfileActiveRead
  soundfileDuration <<- (length(x@left)/x@samp.rate) # The sound should be mono so @left and @right should not matter
  timeBinWidth <<- (2.98/64)/(1024/numberOfFreqBins) # ERROR: SOMETIMES NEEDS TO BE x2 THIS VALUE, UNKNOWN CAUSE AS OF June 11, 2017
  numberOfTimeBins <<- round(soundfileDuration/timeBinWidth-0.5) # The -0.5 rounds the number down, as the later functions will do (it seems).
}

soundAnalysis <- function(file, wl, thresholdValue) { # Input arguments: file=soundfileActive, wl = wlValue, thresholdValue = thresholdValue)
  # Input: Previously calculated and designated values.
  # Output: Matrix with frequencies listed as rows and time listed as columns.
  soundMatrix <- stft.ext(file=soundfileActive, wl = wlValue) #, ovlp = 0.5)
  #thresholdValue = 1
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
  
  soundMatrixThresholdNamed <<- soundMatrixThresholdNamed # Saves to Global Environment
}

# STEP 7 - ISOLATE HARMONICS
isolateHarmonics <- function() {
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
  
  harmonicMatrixScaled <<- harmonicMatrixScaled
}

# STEP 8 - PLOT
# Uses PLOTLY




# STEP 9 - EXPORT files
timeArray <- function() {
  
  timeRawArray <- rep(timeBinWidth, each = (numberOfTimeBins-1))
  timeRawArrayPrint <<- paste(as.character(timeRawArray), collapse=",")
  timeArrayPrint <<- paste0("[", timeRawArrayPrint, "]")
  
}

exportMAESTRO <- function() { #CSV = FALSE, TAB = TRUE) { NOTE: In the future perhaps allow multiple versions of export
  #if(CSV = TRUE)
    
  #write.csv(harmonicMatrixScaled, file = "harmonicMatrixScaled.csv")
  #setwd(filePathPrint)
  dataFileName_harmonicMatrixScaled <- paste0(filePathPrint, "/harmonicMatrixScaled.txt")
  #dataFileName_timeRawArray <- paste0(filePathPrint, "/timeRawArray.txt")
  dataFileName_timeArray <- paste0(filePathPrint, "/timeArray.txt")
  
  write.table(t(harmonicMatrixScaled), file = dataFileName_harmonicMatrixScaled, sep="\t")
  #write.table(timeRawArray, file = dataFileName_timeRawArray)
  
  write(timeArrayPrint, file = dataFileName_timeArray) # NOTE: Ideally won't need in future if SC can read the time (row) names, or just generate based of some values of time interval
}

# If this source file of functions ("functions_R.R") has finished loading into the "envelope_generator.R", print the follow line
print("Source functions loaded from 'functions_R.R'.")
