# This R code file contains all the functions used in the "envelope_generator.R" code file.
# It acts as a source file, which is called at the beginning of "envelope_generator.R".
# Inputs and outputs are commented before each function.
# Note: <<- assigns as GLOBAL variable


# STEP 1 - PACKAGES
# Load required packages
loadPackages <- function(){
  library(lazyeval)
  library(seewave)
  library(tuneR)
  library(ggplot2)
  library(fftw)
  library(rgl)
  library(audio)
  library(plotly) # Keep as last to use it as most recent
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

timeParameters <- function(soundfileActiveRead) { # Input argument: soundfileActiveRead
  soundfileDuration <<- (length(soundfileActiveRead@left)/soundfileActiveRead@samp.rate) # The sound should be mono so @left and @right should not matter
  approxtimeBinWidth <<- (2.98/64)/(1024/numberOfFreqBins) # ERROR: SOMETIMES NEEDS TO BE x2 THIS VALUE, UNKNOWN CAUSE AS OF June 11, 2017
  numberOfTimeBins <<- round(soundfileDuration/approxtimeBinWidth-0.5) # The -0.5 rounds the number down, as the later functions will do (it seems).
  timeBinWidth <<- soundfileDuration/numberOfTimeBins # This new version calculates based on reasonable/logical statistics, unlike previous version above (now approxtimeBinWidth); however this still needs to exist to give the numberOfTimeBins a value
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
  
  harmonicColSeq <- seq(from = startingBin, to = startingBin*numberOfHarmonics, by = (fundamentalFreq / freqBinWidth)) # Based on horn and cello values
  
  soundMatrixThresholdNamedTransposed <- t(soundMatrixThresholdNamed)
  
  harmonicMatrix <- soundMatrixThresholdNamedTransposed[,harmonicColSeq[1:numberOfHarmonics]]
  
  maximumValue <<- max(harmonicMatrix, na.rm = TRUE)
  scaleFunction <- (function(x) x/maximumValue)
  harmonicMatrixScaled <- harmonicMatrix # Creates a duplicate matrix
  harmonicMatrixScaled[] <- vapply(harmonicMatrix, scaleFunction, numeric(1)) # Scales all values to be between 0-1.
  
  harmonicMatrixScaled <<- harmonicMatrixScaled
}

# STEP 8 - PLOT
# Uses PLOTLY

# Create data frame with all harmonic data for use in plot_ly
plotMAESTRO.3d <- function(zoom = 0.68,
                           view.x = -2, view.y = -1, view.z = 1, 
                           length.x = 1, length.y = 1, length.z = 1, 
                           showTime = TRUE, titleTime = "Time (s)") {
  # List the length of the harmonicMatrixScaled to allow the name to be repeated
  harmonicDataframeLengthSeq = seq(1:nrow(harmonicMatrixScaled))
  
  # FOR Loop to process all harmonics, creates data frame of the form:
  # "time"  "intensity" "harmonic"
  # Output: Data tables where the name of files are of the form "plotsHarmonicData.i" where i = 1:numberOfHarmonics
  for(i in 1:numberOfHarmonics) {
    #print(i)
    
    temp_plot_dataframe <- data.frame(
      intensity=c(harmonicMatrixScaled[,i])
    )
    
    temp_name_list <- rep(as.character(i), length(harmonicDataframeLengthSeq)) # plot_ly does not work if the names are not CHARACTERS
    
    #print(temp_name_list)
    
    temp_time_intensity_harmonic <- cbind(rownames(harmonicMatrixScaled), temp_plot_dataframe, temp_name_list)
    
    colnames(temp_time_intensity_harmonic) <- c("time", "intensity", "harmonic")
    
    temp_plot_dataframe_name <- paste("plotsHarmonicData", i, sep = ".")
    
    assign(temp_plot_dataframe_name, temp_time_intensity_harmonic)
  }
  
  # Combine all the data
  for(i in 2:numberOfHarmonics) {
    
    #plotsHarmonicData.1 # Known at minimum there is the 1st harmonic used
    
    temp_lister_name <- paste0("plotsHarmonicData.", i)
    
    if(i == 2) {
      temp_total_names <- paste("plotsHarmonicData.1,",temp_lister_name)   # Clears any old data automatically as well
    } else {
      #print(i)
      #print(temp_total_names)
      temp_total_names <- paste(temp_total_names, temp_lister_name, sep = ", ")
      #print(temp_total_names)
      #print("Next step:")
    }
    
  }
  
  #test_bind <- rbind(plotsHarmonicData.1, plotsHarmonicData.2, plotsHarmonicData.3, plotsHarmonicData.4, plotsHarmonicData.5, plotsHarmonicData.6, plotsHarmonicData.7, plotsHarmonicData.8, plotsHarmonicData.9, plotsHarmonicData.10)
  test_bind <<- eval(parse(text=paste0("rbind(", temp_total_names, ")")))

  # Use the combined data for the plot
  #p <- plot_ly(test_bind, x = ~time, y = ~harmonic, z = ~intensity, type = 'scatter3d', mode = 'lines', color = ~harmonic, opacity = 1, text = "TEXT") # group_by(); color = I("black")
  
  test_bind_subset = test_bind[1:(numberOfTimeBins+(numberOfHarmonics-1)*numberOfTimeBins),]
  test_bind_subset_blank <- test_bind_subset # Creates a duplicate matrix
  test_bind_subset_blank[,"intensity"] <- 0
  mesh3d_data_points = rbind(test_bind_subset,test_bind_subset_blank)
  
  n = numberOfTimeBins*numberOfHarmonics
  
  name <-substr(soundfile,nchar(getwd())+nchar("audio/"),nchar(soundfile)-4) # Create instrument name from the .wav file selected
  title <- paste(toupper(substr(name, 1, 1)), substr(name, 2, nchar(name)), sep="") # Convert title to title case
  
  plot_ly(
   #width = 1187, height = 656
  ) %>% add_trace(type = 'mesh3d',
                  x = mesh3d_data_points[,"time"],
                  y = mesh3d_data_points[,"harmonic"],
                  z = mesh3d_data_points[,"intensity"],
                  
                  i = c(((1:(n-1))-1),
                        (((n+1):(2*n-1))-1)),
                  j = c(((2:n)-1),
                        ((2:n)-1)),
                  k = c((((n+1):(2*n-1))-1),
                        (((n+1):(2*n-1)))),
                  
                  delaunayaxis = "z", # The axis on which the surface is 'projected' onto, if i,j,k are not provided
                  intensity = 0, colors = 'white', opacity = 0.7,
                  showscale = FALSE,
                  lightposition = list(x = 0, y = 0, z = 0),
                  lighting = list(specular = 0, fresnel = 0, ambient = 1), flatshading = FALSE # flatshading TRUE causes artifacts to appear
                  #scene = list(xaxis = list(visible = FALSE))
                  ) %>% add_trace(
                    data = test_bind, x = ~time, y = ~harmonic, z = ~intensity, 
                    type = 'scatter3d', 
                    mode = "lines", color = ~harmonic, opacity = 1, # This opacity sets the opacity of the fillcolor as well, though not used as a separate set of mesh3ds are used
                    showlegend = FALSE,
                    #projection = list(x = list(show = TRUE, scale = 0.5)),
                    line = list(width = 3, color = "black")
                    #marker = list(symbol = "circle-open", size = 0.01)
                  ) %>% layout(
                    font = list(family = "Arial", color = "black"),
                    title = paste(title, "analysis, H1 = ", fundamentalFreq, "Hz"),
                      #"MAESTRO Sound Analysis",
                    # categoryorder = "array", categoryarray = colnames(harmonicMatrixScaled), # Is not valid for 3D
                    scene = list(
                      camera = list(
                        eye = list(x=view.x*zoom,y=view.y*zoom,z=view.z*zoom)
                          ),
                      aspectmode = "manual", aspectratio = list(x=length.x,y=length.y,z=length.z),# Can be modified using aspectratio
                      
                      xaxis = list(title = titleTime, visible = TRUE, range = c(0,soundfileDuration), 
                                   #showline = TRUE, 
                                   titlefont = list(size = 14), tickfont = list(size = 12),
                                   showticklabels = showTime,
                                   linewidth = 2, # gridwidth = 5, gridcolor = "rgb(204, 204, 204)"
                                   showgrid = FALSE,
                                   showbackground = TRUE, backgroundcolor = "rgba(240, 240, 240,0)"
                                   ),
                      yaxis = list(title = "Harmonic", visible = TRUE, 
                                   #tickmode = 'linear', dtick = 4, tick0 = 5, tickangle = 0,
                                   titlefont = list(size = 14), tickfont = list(size = 12),
                                   ticks = "", tickmode = 'array', tickvals = c(1:16), ticktext = c("1", "", "3", "", "5", "", "7", "", "9", "", "11", "", "13", "", "15", ""), tickangle = 0, # ticklen = 50, tickwidth = 5,
                                   type = "category",
                                   categoryorder = "array", categoryarray = rev(c("1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16")), #colnames(harmonicMatrixScaled) #Cannot understand the names as the data is not given with these names
                                   linewidth = 2, 
                                   gridwidth = 3, gridcolor = "rgb(225, 225, 225)",
                                  #showgrid = FALSE,  #gridwidth = 2, gridcolor = "rgb(50, 50, 50)"
                                   showbackground = TRUE, backgroundcolor = "rgba(240, 240, 240,0)"
                                   ), # Does not seem to work if in reverse direction (i.e. 16,0) #range = c(0,16), mirror = TRUE
                      zaxis = list(title = "Intensity", range = c(0,1), 
                                   titlefont = list(size = 14), tickfont = list(size = 12),
                                   #dtick = 0.5
                                   tickmode = 'array', tickvals = c(0,0.5,1), ticktext = c("", "", ""), ticklen = 0, tickwidth = 2, ticks = "",
                                   linewidth = 2, gridwidth = 3, gridcolor = "rgb(225, 225, 225)",
                                   showbackground = TRUE, backgroundcolor = "rgba(240, 240, 240,0)"
                                   )
                    )
                    )
  
  #plotted
  
  #export(plotted, file = "test_plot.png")
  
}

plotMAESTRO.bars <- function() {
  
  name <-substr(soundfile,nchar(getwd())+nchar("audio/"),nchar(soundfile)-4) # Create instrument name from the .wav file selected
  title <- paste(toupper(substr(name, 1, 1)), substr(name, 2, nchar(name)), sep="") # Convert title to title case
  
  plot_ly() %>% add_bars(
    data = harmonicMatrixScaled, 
    x = format(round(as.numeric(colnames(harmonicMatrixScaled)), 0), nsmall = 0), # Reduces x-axis labels to 2 decimal points
    y = colMeans(harmonicMatrixScaled),
    color = I("black"),
    width = 0.2,
    orientation = "v"
  ) %>% layout(
    title = title,
    xaxis = list(
      categoryorder = "array", categoryarray = colnames(harmonicMatrixScaled),
      title = "Frequency (Hz)",
      tickfont = list(family = "Arial", size = 8), # A sans-serif font is easier to read small
      tickangle = 45
    ),
    yaxis = list(
      title = "Intensity"
    )
  )
}



plotMAESTRO.2d <- function(zoom = 0.7) {
  
  name <-substr(soundfile,nchar(getwd())+nchar("audio/"),nchar(soundfile)-4) # Create instrument name from the .wav file selected
  title <- paste(toupper(substr(name, 1, 1)), substr(name, 2, nchar(name)), sep="") # Convert title to title case
  
  
  for(i in 2:16) {
    
    dataset_means <- c(colMeans(harmonicMatrixScaled)/max(colMeans(harmonicMatrixScaled)))
    
    temp_lister_name <- paste("0", dataset_means[i],"0", sep = ",")
    
    if(i == 2) {
      temp_total_names <- paste0("0,",dataset_means[1],",","0,",temp_lister_name, ",")   # Clears any old data automatically as well
    } else {
      temp_total_names <- paste0(temp_total_names, temp_lister_name, sep = ",")
    }
    
  }

  intensityDataArray <- c(unlist(strsplit(substr(temp_total_names,0,nchar(temp_total_names)-1), split=","))) # Easier to remove artifacts from the recursion algorithm above than to make the recursion more complex
  
  dataset_flat_time <- rep(c(0,0.5,1),16)
  
  dataset_flat_intensity <- intensityDataArray
  
  dataset_flat_harmonic <- rep(1:16, each=3)
  
  dataset_flat_new <- data.frame(dataset_flat_time,dataset_flat_intensity,dataset_flat_harmonic)
  
  colnames(dataset_flat_new) <- c("time", "intensity", "harmonic")
  
  plot_ly(
    #width = 1328, height = 656
  ) %>% add_trace(
    data = dataset_flat_new, x = ~time, y = ~harmonic, z = ~intensity, 
    type = 'scatter3d', 
    mode = "lines", color = dataset_flat_new["harmonic"], opacity = 1, # This opacity sets the opacity of the fillcolor as well, though not used as a separate set of mesh3ds are used
    showlegend = FALSE,
    #projection = list(x = list(show = TRUE, scale = 0.5)),
    line = list(width = 5, color = "black")
    #marker = list(symbol = "circle-open", size = 0.01)
  ) %>% layout(
    font = list(family = "Arial", color = "black"),
    title = paste(title, "analysis, H1 = ", fundamentalFreq, "Hz"),
    #"MAESTRO Sound Analysis",
    # categoryorder = "array", categoryarray = colnames(harmonicMatrixScaled), # Is not valid for 3D
    scene = list(
      camera = list(
        eye = list(x=-2.7*zoom,y=0.001*zoom,z=0*zoom)
      ),
      aspectmode = "manual", aspectratio = list(x=0.00001,y=1,z=1),# Can be modified using aspectratio
      
      xaxis = list(title = " ", visible = TRUE, range = c(0,1), 
                   #showline = TRUE, 
                   titlefont = list(size = 14), tickfont = list(size = 12),
                   showticklabels = FALSE,
                   linewidth = 3, # gridwidth = 5, gridcolor = "rgb(204, 204, 204)"
                   showgrid = FALSE,
                   showbackground = TRUE, backgroundcolor = "rgba(240, 240, 240,0)"
      ),
      yaxis = list(title = "Harmonic", visible = TRUE, 
                   #tickmode = 'linear', dtick = 4, tick0 = 5, tickangle = 0,
                   titlefont = list(size = 14), tickfont = list(size = 12),
                   ticks = "", tickmode = 'array', tickvals = c(1:16), ticktext = c("", "2", "", "4", "", "6", "", "8", "", "10", "", "12", "", "14", "", "16"), tickangle = 0, # ticklen = 50, tickwidth = 5,
                   type = "category",
                   categoryorder = "array", categoryarray = rev(c("1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16")), #colnames(harmonicMatrixScaled) #Cannot understand the names as the data is not given with these names
                   linewidth = 5, 
                   gridwidth = 3, gridcolor = "rgb(225, 225, 225)",
                   # showgrid = FALSE  #gridwidth = 2, gridcolor = "rgb(50, 50, 50)"
                   showbackground = TRUE, backgroundcolor = "rgba(240, 240, 240,0)"
      ), # Does not seem to work if in reverse direction (i.e. 16,0) #range = c(0,16), mirror = TRUE
      zaxis = list(title = "Intensity", visible = TRUE,
                   range = c(0,1), 
                   titlefont = list(size = 14), tickfont = list(size = 12),
                   #dtick = 0.5
                   tickmode = 'array', tickvals = c(0,0.5,1), ticktext = c("", "", ""), ticklen = 5, tickwidth = 2, ticks = "",
                   linewidth = 2, gridwidth = 3, gridcolor = "rgb(225, 225, 225)",
                   showbackground = TRUE, backgroundcolor = "rgba(240, 240, 240,0)"
      )
    )
  )
  
  
}



# STEP 9 - EXPORT files
# This function is no longer needed as SuperCollider takes the first time value name from the exported table and uses it to calculate the time array
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
  #dataFileName_timeArray <- paste0(filePathPrint, "/timeArray.txt")
  
  write.table(t(harmonicMatrixScaled), file = dataFileName_harmonicMatrixScaled, sep="\t")
  #write.table(timeRawArray, file = dataFileName_timeRawArray)
  
  #write(timeArrayPrint, file = dataFileName_timeArray) # NOTE: Ideally won't need in future if SC can read the time (row) names, or just generate based of some values of time interval

  dataFileName_harmonicMatrixScaledMeans <- paste0(filePathPrint, "/harmonicMatrixScaledMeans.txt")
  
  dataset_means <- c(colMeans(harmonicMatrixScaled)/max(colMeans(harmonicMatrixScaled)))
  
  write.table(t(dataset_means), file = dataFileName_harmonicMatrixScaledMeans, sep="\t")
  }

# If this source file of functions ("functions_R.R") has finished loading into the "envelope_generator.R", print the follow line
print("Source functions loaded from 'functions_R.R'.")
