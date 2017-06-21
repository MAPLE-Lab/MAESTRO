# This R code file contains all the functions used in the "envelope_generator.R" code file.
# It acts as a source file, which is called at the beginning of "envelope_generator.R".
# Inputs and outputs are commented before each function.


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
  setwd(x) # Sets the working directory to the argument
  filePathPrint <- paste0(x, "/R_working_files") # Filepath string for the folder to print the files
}

# STEP 4 - SOUND CHECKING
soundfileStereoCheck <- function(x){
  soundfileRead <- readWave(x)
  if(soundfileRead@stereo) {
    soundfileMonoL <- mono(soundfileRead, "left") # To save the right channel instead, change "left" to "right"
    setwd(filePathPrint) # Temporarily setting the place to save the files
    savewav(soundfileMonoL)
    print(paste0("The selected sound file was a stereo sound. Currently only mono sounds are usable by this script. A WAVE file 'soundfileMonoL.wav' has been created in the directory '", getwd(), "'. The following computations will use this newly created mono-left sound version of the original sound file."))
    soundfileActive <- (paste0(getwd(), "/", "soundfileMonoL.wav"))
  } else {
    soundfileActive <- x
    print("The selected sound file was a mono sound. No changes necessary.")
  }
  soundfileActiveRead <- readWave(soundfileActive) 
}




#mult <- function(x,y) {
#  x*y
#}



# If this source file of functions ("functions_R.R") has finished loading into the "envelope_generator.R", print the follow line
print("Source functions loaded from 'functions_R.R'.")
