# Create a harmonicMatrixScaled (used by the funcitons plotMAESTRO.bars and plotMAESTRO.3d) with a specified name
matrixAnalysisSingle <- function(outputName = "defaultName", filePath = "~/Dropbox/MAPLE-Lab-Auditory-Exploration-Suite/programs/R") {
  
  # Welcome to the R program to created data tables for MAESTRO (SuperCollider component)!
  
  # STEP 0 - SOURCE FUNCTIONS
  # This line loads all the functions from the "functions_R.R" R code file.
  # These functions are then called (with appropriate arguments) in all following code.
  
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
  numberOfHarmonics <<- 16 # This value can be changed as necessary.
  fundamentalFreq <<- 261.63 # In Hz. (261.63 ~ middle C (C4))
  
    harmonicSeq <- seq(from = fundamentalFreq, to = fundamentalFreq*numberOfHarmonics, by = fundamentalFreq)
    
    # Every row is the same frequency distance from the next = freqBinWidth
    startingBin <- as.integer(fundamentalFreq / freqBinWidth + 1) # +1 added to round up as it is needed for optimal results, based on trial and error
    
    harmonicColSeq <- seq(from = startingBin, to = startingBin*numberOfHarmonics, by = (fundamentalFreq / freqBinWidth)) # Based on horn and cello values
    
    soundMatrixThresholdNamedTransposed <- t(soundMatrixThresholdNamed)
    
    harmonicMatrix <- soundMatrixThresholdNamedTransposed[,harmonicColSeq[1:numberOfHarmonics]]
    
    maximumValue <<- max(harmonicMatrix, na.rm = TRUE)
    scaleFunction <- (function(x) x/maximumValue)
    harmonicMatrixScaled <- harmonicMatrix # Creates a duplicate matrix
    harmonicMatrixScaled[] <- vapply(harmonicMatrix, scaleFunction, numeric(1)) # Scales all values to be between 0-1.
    
    
    harmonicMatrixScaled <- harmonicMatrixScaled
    
    #outputName <<- assign(outputName, harmonicMatrixScaledNamed)
    
    temp_name <- paste(outputName)
    paste(temp_name)
    assign(temp_name, harmonicMatrixScaled, envir = .GlobalEnv)
    
  
}

# Example uses of the function
# Must manually select the file
# This only demonstrates the naming method
matrixAnalysisSingle(outputName = "trumpet")
matrixAnalysisSingle(outputName = "clarinet")

# Create a bar chart of the average spectrum values from the specified harmonicMatrixScaled data
plotMAESTRO.bars.specify <- function(harmonicMatrixScaled) {
  
  # Create title of plot using the argument
  print(deparse(substitute(harmonicMatrixScaled)))
  name <- deparse(substitute(harmonicMatrixScaled))
  
  # Create the bar chart
  plot_ly() %>% add_trace(
    type = 'bar',
    data = harmonicMatrixScaled, 
    x = (1:16), #format(round(as.numeric(colnames(harmonicMatrixScaled)), 0), nsmall = 0), # Reduces x-axis labels to 2 decimal points
    y = colMeans(harmonicMatrixScaled),
    color = I("black"),
    width = 0.2,
    orientation = "v"
  ) %>% layout(
    title = paste(toupper(substr(name, 1, 1)), substr(name, 2, nchar(name)), sep=""), # Convert title to title case
    xaxis = list(
      categoryorder = "array", categoryarray = colnames(harmonicMatrixScaled),
      title = "Harmonic Number",
      tickfont = list(family = "Arial", size = 12), # A sans-serif font is easier to read small
      tickangle = 0,
      showticklabels = TRUE,
      tick0 = 1, dtick = 1 # Shows all 16 x-axis tick values
    ),
    yaxis = list(
      title = "Intensity"
    )
  )
}

# Example uses of the function
# These files, trumpet and clarinet, must already exist to work
plotMAESTRO.bars.specify(harmonicMatrixScaled = trumpet)
plotMAESTRO.bars.specify(harmonicMatrixScaled = clarinet)


# Create a grouped bar chart with two harmonicMatrixScaled data objects
plotMAESTRO.bars.group <- function(harmonicMatrixScaled1, harmonicMatrixScaled2) {
  
  # Create title of plot using the argument
  print(deparse(substitute(harmonicMatrixScaled1)))
  print(deparse(substitute(harmonicMatrixScaled2)))
  name1 <- deparse(substitute(harmonicMatrixScaled1))
  name2 <- deparse(substitute(harmonicMatrixScaled2))
  
  title1 <- paste(toupper(substr(name1, 1, 1)), substr(name1, 2, nchar(name1)), sep="")
  title2 <- paste(toupper(substr(name2, 1, 1)), substr(name2, 2, nchar(name2)), sep="")
  
  # Create the bar chart
  plot_ly() %>% add_trace( # First data
    type = 'bar',
    data = harmonicMatrixScaled1, 
    x = (1:16),
    y = colMeans(harmonicMatrixScaled1),
    color = I("red"),
    width = 0.4,
    orientation = "v",
    name = title1
  ) %>% add_trace( # Second data
    type = 'bar',
    data = harmonicMatrixScaled2, 
    x = (1:16),
    y = colMeans(harmonicMatrixScaled2),
    #color = I("grey"),
    marker = list(color = 'rgb(80, 80, 80)'), # A dark grey
    width = 0.4,
    orientation = "v",
    name = title2
  ) %>% layout(
    title = paste(title1, "and", title2),
    xaxis = list(
      categoryorder = "array", categoryarray = colnames(harmonicMatrixScaled1),
      title = "Harmonic Number",
      tickfont = list(family = "Arial", size = 12), # A sans-serif font is easier to read small
      tickangle = 0,
      showticklabels = TRUE,
      tick0 = 1, dtick = 1 # Shows all 16 x-axis tick values
    ),
    yaxis = list(title = "Intensity"),
    barmode = 'group', bargap = 0.2
  )
}

plotMAESTRO.bars.group(trumpet, clarinet)
