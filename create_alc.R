#Otto Ylostalo 12.11.2018
#Data set approach student achievement in secondary education of two Portuguese schools based on 
#grades, demographic, social and school related features.
#Referred to https://archive.ics.uci.edu/ml/datasets/Student+Performance by 12.11.2018

#Read both student-mat.csv and student-por.csv into R 
math <- read.csv("C:/Users/Pyrinto/Documents/GitHub/IODS-project/student-mat.csv", sep=";", header = TRUE)
por <- read.csv("C:/Users/Pyrinto/Documents/GitHub/IODS-project/student-por.csv", sep=";",header =TRUE)

#explore the structure and dimensions of the data
str(math)
dim(math)
str(por)
dim(por)

# access the dplyr library
library(dplyr)

# common columns to use as identifiers
join_by <- c("school","sex","age","address","famsize","Pstatus","Medu","Fedu","Mjob","Fjob","reason",
             "nursery","internet")

# join the two datasets by the selected identifiers
math_por <- inner_join(math, por, by = join_by, suffix = c(".math", ".por"))

# see the new column names
colnames(math_por)

# glimpse at the data
glimpse(math_por)


# dplyr, math_por, join_by are available

# print out the column names of 'math_por'


# create a new data frame with only the joined columns
alc <- select(math_por, one_of(join_by))

# the columns in the datasets which were not used for joining the data
notjoined_columns <- colnames(math)[!colnames(math) %in% join_by]


# print out the columns not used for joining
column_name<-notjoined_columns

# for every column name not used for joining...
for(column_name in notjoined_columns) {
  # select two columns from 'math_por' with the same original name
  two_columns <- select(math_por, starts_with(column_name))
  # select the first column vector of those two columns
  first_column <- select(two_columns, 1)[[1]]
  
  # if that first column vector is numeric...
  if(is.numeric(first_column)) {
    # take a rounded average of each row of the two columns and
    # add the resulting vector to the alc data frame
    alc[column_name] <- round(rowMeans(two_columns))
  } else { # else if it's not numeric...
    # add the first column vector to the alc data frame
    alc[column_name] <- first_column
  }
}

# glimpse at the new combined data
glimpse(alc)

#Take the average of the answers related to weekday and weekend alcohol consumption to create 
#a new column 'alc_use' to the joined data. Then use 'alc_use' to create a new logical column 
#'high_use' which is TRUE for students for which 'alc_use' is greater than 2 (and FALSE otherwise).
alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)
# define a new logical column 'high_use'
alc <- mutate(alc, high_use = alc_use > 2)

#Glimpse at the joined and modified data to make sure everything is in order. The joined data should 
#now have 382 observations of 35 variables. Save the joined and modified data set to the ÅedataÅf folder, 
#using for example write.csv() or write.table() functions. 
write.csv(alc,"C:/Users/Pyrinto/Documents/GitHub/IODS-project/alc.csv",row.names = FALSE)

