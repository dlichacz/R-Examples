R Examples
===================
This repository contains examples using R.  Individual examples are described in detail below.

#### <i class="icon-folder-open"></i> Data Files
- **specdata.zip**: Contains 332 .csv files containing pollution monitoring data for fine particulate matter (PM) air pollution at 332 locations in the US.  Each file contains data from a single monitor and the ID number for each monitor is contained in the file name.  Each file contains three variables:
	- Date: the date of the observation in YYYY-MM-DD format.
	- sulfate: the level of sulfate PM in the air on that date (measured in micrograms per cubic meter)
	- nitrate: the level of nitrate PM in the air on that date (measured in micrograms per cubic meter)


pollutantmean.R
-------------

pollutantmean.R uses the data specdata.zip and assumes that the file has been unzipped into the working directory.  It is a function that calculates the mean of a pollutant (sulfate or nitrate) across a specified list of monitors, ignoring any missing values coded as NA.

The function contains the following features:
- Accepts only 'sulfate' and 'nitrate' as possible pollutant names.
- Not case-sensitive
- Eliminates duplicate ID values
- Ignores invalid ID values, but calculates mean for remaining values, if any
