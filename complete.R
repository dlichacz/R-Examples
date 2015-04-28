complete <- function(id = 1:332) {
  
 # 'id' is an integer vector indicating the monitor ID numbers for which
 # the number of complete cases will be returned. 
  
 # The function will return a data frame with columns 'id', the monitor ID number, and 
 # 'nobs', the number of complete cases for that monitor. If no 'id' is specified, it will return
 # the number of complete cases for all 332 monitors.
  
 # Define the data frame that will be returned by the function.
 CompleteObservations <- data.frame(id = 0, nobs = 0)
 # Initialize a counter that will be used to determine the row of the data frame.
 RowNumber <- 0 
 # Initialize a counter that will count the number of invalid IDs.
 InvalidIDs <- 0 

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
     # Add 1 to invalid ID counter and move to next ID.
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
  # Increase row number counter by 1.
  RowNumber <- RowNumber + 1
  # Build filename where data for ID number is stored.
  filename <- paste(getwd(), "/specdata/", ThreeDigitID, ".csv", sep = "")
  # Read data into data frame.
  IDData <- read.csv(filename, header = TRUE, sep= ",")
  # Calculate the number of complete cases and add row to the data frame.
  CompleteObservations[RowNumber,1] <- i
  CompleteObservations[RowNumber,2] <- sum(complete.cases(IDData))
  }
  # Abort function if no valid IDs were entered. 
  if (InvalidIDs == length(UniqueIDs)) {
    stop("You did not enter a valid ID number.  Please try again.")
  }
  # Warn user about invalid ID numbers, but return data for remaining IDs.
  else if (InvalidIDs > 0 && InvalidIDs < length(UniqueIDs)) { 
    warning("You entered at least one invalid ID number. Data is shown for valid IDs.")
  }
   # Return the data frame.
   CompleteObservations
}