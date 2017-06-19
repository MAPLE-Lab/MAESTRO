# Mailing list: https://groups.google.com/forum/#!forum/seewave
# Documenation: http://rug.mnhn.fr/seewave/

# In this scripts page, use Cmd+Return to run each line individually
# Can we create an R script that asks the user which sound to import, and from there it generates the file necessary and passes it onto SC?

# At start load all the necessary packages
# Due to function masking, does the order matter? If so, perhaps use the :: to re-route functions to the correct package
library(lazyeval)
library(plotly)
library(seewave)
library(tuneR)
library(ggplot2)
library(fftw)
library(rgl)
library(audio)

# Find out where your are coming from
##getwd()

# If undesired directory, use: ## Doesn't work yet
##setwd("~/MAPLE-Lab-Auditory-Exploration-Suite/programs/R")

# Double-check now correct location
##getwd()

# Save the matrix as a variable so that it can later be exported as a CSV
# Time is in the x direction
  # What is the time bin? Can it be changed? I think it's 0.2 seconds (based on the duration of the audio file and the number of columns/Vs/time bins generated)
# Frequency (as bins) is in the y direction
# Raw code method would be: sound_matrix <- stft.ext(file="FILENAME.wav", wl = wl_value)
# But to make this a runable script:
SOUNDFILE <- file.choose()

# Check if SOUNDFILE is stereo
SOUNDFILE_read <- readWave(SOUNDFILE)


# If it's true, convert to mono (I suppose even if it's Mono, it wouldn't be affected? May need verification)
# Currently selects either Left or Right
# No process so far to merge both L & R into one channel
# Perhaps manually from the data in load.wave?
# Saves a new mono form of wave
if(SOUNDFILE_read@stereo) {
  SOUNDFILE_mono_L <- mono(SOUNDFILE_read, "left")
  savewav(SOUNDFILE_mono_L)
  print("Re-runs script now using the newly created mono sound")

  SOUNDFILE <- (paste0(getwd(), "/", "SOUNDFILE_mono_L.wav"))
  }

# Set a value for the frequency binning
# The number of bins = wl_value/2
# The range of frequency is 0-44kHz? (Need to find out the maximum frequency)
number_of_freq_bins <- 256*4
wl_value <- number_of_freq_bins*2
freq_bin_width <- 22050/number_of_freq_bins


# Based on an arbitrary sense of how fine the time should be

# Overview the sound with 512 and the currently used frequency bins
##acoustat(SOUNDFILE_read, wl = 512)
acoustat(SOUNDFILE_read, wl = wl_value)

# Analyze the audio in parts by breaking up the file and saving the breakups
# Based on the frequency bins, we display/calculate the time bins
# This calculation still needs refining it seems, doesn't seem to make sense yet
SOUNDFILE_duration <- (length(SOUNDFILE_read@left)/SOUNDFILE_read@samp.rate)
time_bin_width <- 2*(2.98/64)/(1024/number_of_freq_bins) 
number_of_time_bins <- round(SOUNDFILE_duration/time_bin_width+0.5)


## We want time bins of what duration (in seconds)?
#time_bin_intention <- 0.01
#time_multiplication <- time_bin_width/time_bin_intention
#number_of_sections <- round(time_multiplication+0.5, digits = 0) # The +0.5 ensures it rounds up (R rounds 0.5 down)

#total_seconds_round <- round(SOUNDFILE_duration+0.5, digits = 0)

## Make it a nice 0 decimal amount of seconds per cut
#time_tolerance <- total_seconds_round %% number_of_sections
#total_seconds_round_tolerance <- total_seconds_round + time_tolerance
#duration_per_section <- total_seconds_round_tolerance/number_of_sections

# Save the audio file cut sections
#for (i in 1:number_of_sections) {
 # time_from = (i-1)*duration_per_section
  #time_to = i*duration_per_section
  
  #print(time_from)
  #print(time_to)
#  
#  SOUNDFILE_section_name = paste("SOUNDFILE_section", i, "wav", sep = ".")
#  
#  print(SOUNDFILE_section_name)
#  
#  SOUNDFILE_section_wave <- readWave(SOUNDFILE, from = time_from, to = time_to, units = "seconds")
#  
#  savewav(SOUNDFILE_section_wave, filename = SOUNDFILE_section_name)
#}

# Calculate the FFT for each section
#for (i in 1:number_of_sections) {
#  
#  section_number = paste0(".",i)
#  section_name = paste0("SOUNDFILE_section", section_number, ".wav")
#  print(section_name)
#  SOUNDFILE <- paste(getwd(), section_name, sep = "/")
#  print(SOUNDFILE)
#  sound_matrix <- stft.ext(file=SOUNDFILE, wl = wl_value)
#  #acoustat(readWave(SOUNDFILE), wl = wl_value)
#  
#  sound_matrix_name <- paste0("sound_matrix", section_number)
#  print(sound_matrix_name)
#  
#  assign(sound_matrix_name, sound_matrix)
#  
#  #This is the matrix made
#  View(as.name(sound_matrix_name))
#}

sound_matrix <- stft.ext(file=SOUNDFILE, wl = wl_value)

#View(sound_matrix)

# To see it you can use
# sound_matrix[rownum1:rownum2,colnum1:colnum2]
# For example:
# sound_matrix[1:256,1:30]

# Transpose the sound_matrix so that Time is y, Frequency is x
#sound_matrix_transposed <- t(sound_matrix)

# Optional: everything (when using dB = TRUE) below -90 gets set to -90:
# UNTESTED / Hasn't worked so far
# Probably better to use a version with just intensity (so if < 0.1 or so)
#{
#for(j in 1:ncol(sound_matrix_transposed))
#{
#  if (sound_matrix_transposed[i,j] < -90)
#    sound_matrix_transposed[i,j] <- -90
#}
#}

# This version is for just intensity
threshold_value = 1
threshold_function <- (function(x) if(x < threshold_value) {x = 0} else x - threshold_value)
sound_matrix_threshold <- sound_matrix
sound_matrix_threshold[] <- vapply(sound_matrix, threshold_function, numeric(1))
#sound_matrix_transposed_threshold <- sound_matrix_transposed
#sound_matrix_transposed_threshold[] <- vapply(sound_matrix_transposed, threshold_function, numeric(1))
#flatten_function <- (function(x) x-threshold_value)
#sound_matrix_transposed_threshold[] <- vapply(sound_matrix_transposed_threshold, flatten_function, numeric(1))

# Naming
sound_matrix_threshold_named <- sound_matrix_threshold

# Renaming columns
col_seq = 1:ncol(sound_matrix_threshold_named)

# Renaming rows
row_seq = 1:nrow(sound_matrix_threshold_named)

# Name the X axis for frequency bins
# Need to add names to start before replacing them
colnames(sound_matrix_threshold_named) <- c(paste(col_seq))
for (i in col_seq) {colnames(sound_matrix_threshold_named)[i] <- paste(
  i*time_bin_width
  )}

# Name the Y axis for time bins
# Need to add names to start before replacing them
rownames(sound_matrix_threshold_named) <- c(paste(row_seq))
for (i in row_seq) {rownames(sound_matrix_threshold_named)[i] <- paste(
  i*freq_bin_width
  )}

# Is it possible to then cut the matrix to just the rows/columns needed?


# Remove rows above a frequency
##freq_threshold <- 11000
##bin_threshold = as.integer(1+(freq_threshold/171)) #Cuts right below this, so keeps the one before the freq_threshold
##sound_matrix_threshold_named <- sound_matrix_threshold_named[-c(bin_threshold:nrow(sound_matrix_threshold_named)), ] 

# Transpose
sound_matrix_threshold_named_transposed <- t(sound_matrix_threshold_named)

# Only add rows if necessary (time bins is less than frequency bins):
##if(nrow(sound_matrix_threshold_named_transposed) > nrow(sound_matrix_threshold_named)) {x <- 5} else {x <- 2}

# Add sufficient rows so that the time column can be re-added back in

# If the number of freq bins is LESS than the number of time bins
if (nrow(sound_matrix_threshold_named_transposed) > nrow(sound_matrix_threshold_named)) {
temprow <- matrix(c(rep.int(NA,length(sound_matrix_threshold_named))),
                  # How many rows to add (diff)
                  nrow=(nrow(sound_matrix_threshold_named_transposed)-nrow(sound_matrix_threshold_named)),
                  # How many columns
                  ncol=ncol(sound_matrix_threshold_named))
}


# If the number of freq bins is MORE than the number of time bins
if (nrow(sound_matrix_threshold_named_transposed) < nrow(sound_matrix_threshold_named)) {
temprow <- matrix(c(rep.int(NA,length(sound_matrix_threshold_named_transposed))),
                  # How many rows to add (diff)
                  nrow=(nrow(sound_matrix_threshold_named)-nrow(sound_matrix_threshold_named_transposed)),
                  # How many columns
                  ncol=ncol(sound_matrix_threshold_named_transposed)
                  )
}


# Turn it into a data.frame
newrow <- data.frame(temprow)

# Give common names so it can rbind correctly
##colnames(newrow) <- colnames(sound_matrix_threshold_named)
###colnames(newrow) <- colnames(sound_matrix_threshold_named_transposed)

# rbind
##sound_matrix_threshold_named_r_extended <- rbind(sound_matrix_threshold_named,newrow)
###sound_matrix_threshold_named_transposed_r_extended <- rbind(sound_matrix_threshold_named_transposed,newrow)

# Rename all the new uneeded time slots now to NA

# Create time column
##time_table <- data.frame(time=colnames(sound_matrix_threshold_named_r_extended)[1:ncol(sound_matrix_threshold_named_r_extended)])
diff = (nrow(sound_matrix_threshold_named)-nrow(sound_matrix_threshold_named_transposed))
time_table <- data.frame(time=colnames(sound_matrix_threshold_named)[1:(ncol(sound_matrix_threshold_named)+diff)])

# Add time column
#sound_matrix_threshold_named_r_extended$time <- NA
##sound_matrix_threshold_named_r_extended_time <- cbind(time_table, sound_matrix_threshold_named_r_extended)
sound_matrix_threshold_named_r_extended_time <- cbind(time_table, sound_matrix_threshold_named)

# Export the matrix as a CSV
# write.csv(sound_matrix, "sound_matrix.csv")
# write.csv(sound_matrix_transposed, "sound_matrix_transposed.csv")
# write.csv(sound_matrix_threshold, "sound_matrix_transposed_threshold.csv")
write.csv(sound_matrix_threshold_named_r_extended_time, "sound_matrix_final.csv")

# Within R, add all the formatting that will be needed for the SuperCollider Envelope function
# Adding the commas and 0s
# The export the .csv
# Can SuperCollider read CSV?

# Integration with SuperCollider Envelope function:
# Intensities
comma_intensity_array <- paste(as.character(sound_matrix_threshold[13,]), collapse=",")
intensity_array_bounded <- paste0("[", comma_intensity_array, "]*0.1")

# Times
raw_time_array <- rep(time_bin_width, each = (number_of_time_bins-1)) # 1 less than the number of intensity values
comma_time_array <- paste(as.character(raw_time_array), collapse=",") 
time_array_bounded <- paste0("[", comma_time_array, "]")

# Finalize for one harmonic
env_harmonic1 <- paste0("~envelope1 = Env.new(", intensity_array_bounded, ",", time_array_bounded, ");")

# Save the file that can then be used by SC
write(env_harmonic1, file = "env_harmonic1")
print("Script completed, switch to SuperCollider now.")
