pollutantmean <- function(pollutant, id = 1:332) {
  # 'pollutant' is a character vector of length 1 indicating the name of the pollutant
  # for which the mean will be calculated. The only possible values for 'pollutant' are
  # 'sulfate' and 'nitrate'.
  
  # 'id' is an integer vector indicating the monitor ID numbers to be used.
  
  # The function will return the mean of the pollutant across all monitors listed
  # in the 'id' vector (ignoring NA values).  If no 'id' is specified, it will return
  # the mean across all monitors.
  
  # Create a null numeric vector that will eventually store the data from all monitors.
  AllMonitors <- numeric(0)
  # Convert the value of pollutant to all lowercase to eliminate case-sensitivity.
  PollutantLower <- tolower(pollutant) 
  # Initialize a counter that will count invalid ID numbers entered.
  InvalidIDs <- 0
  
  # Abort the function if the value of 'pollutant' entered incorrectly.
  if ((PollutantLower != "sulfate" && PollutantLower != "nitrate") || (length(pollutant) > 1)) {    
    stop("The only possible values for 'pollutant' are \"sulfate\" & \"nitrate\". Please try again.")
  } 
  
  # Remove duplicate IDs.
  UniqueIDs <- unique(id)
  # Convert id vector to numeric.
  NumericIDs <- suppressWarnings(as.numeric(UniqueIDs))
  # Count IDs that could not be converted and add to invalid ID count.
  InvalidIDs <- InvalidIDs + sum(is.na(NumericIDs))
  # Remove all NA values leaving only numeric IDs.
  NumericIDsNoNAs <- NumericIDs[!is.na(NumericIDs)]
  
  for (i in NumericIDsNoNAs) {
    # Test for out-of-range or non-integer ID numbers.
    if (!(i >= 1 && i <= 332) || (i%%1 != 0)) {
      # Add 1 to counter and move to next ID.
      InvalidIDs <- InvalidIDs + 1
      next
    }
    # Since all filenames are three digits long, leading zeroes need to be added if 'id' value < 100.
    else if (i >= 1 && i <= 9) {
      ThreeDigitID <- paste("00", i, sep = "")
    }
    else if (i >= 10 && i <= 99) {
      ThreeDigitID <- paste("0", i, sep = "")
    }
    else {
      ThreeDigitID = i
    }
    # Build filename where data for ID number is stored.
    filename <- paste(getwd(), "/specdata/", ThreeDigitID, ".csv", sep = "")
    # Read data into data frame.
    IDData <- read.csv(filename, header = TRUE, sep= ",")
    # Create vector from appropriate column of data frame, removing all NA values.
    if (PollutantLower == "sulfate") {
      PollutantData <- IDData[[2]][!is.na(IDData[[2]])]
    }
    else if(PollutantLower == "nitrate") {
      PollutantData <- IDData[[3]][!is.na(IDData[[3]])]
    }
    # Concatenate pollutant values from all monitors into one vector.
    AllMonitors <- c(AllMonitors, PollutantData)
  }
  # Abort function if no valid IDs were entered. 
  if (InvalidIDs == length(UniqueIDs)) {
    stop("You did not enter a valid ID number.  Please try again.")
  }
  # Warn user about invalid ID numbers, but calculate mean with remaining IDs.
  else if (InvalidIDs > 0 && InvalidIDs < length(UniqueIDs)) { 
    warning("You entered at least one invalid ID number. Mean was calculated for valid IDs.")
  }
  # Calculate and print the mean.
  print(mean(AllMonitors))
}