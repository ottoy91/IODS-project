# read the data into memory and access dplyr
library(dplyr)
lrn14 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)

#explore the structure str() and dimension dim() of the data
str(lrn14)
#the structure of the data is integers for all variables except the gender, which is a factor of "F" or "M"
dim(lrn14)
#the dimension of the data is 183 observations of 60 variables


# questions related to deep, surface and strategic learning are put under 
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
deep_columns <- select(lrn14, one_of(deep_questions))
lrn14$deep <- rowMeans(deep_columns)

strategic_questions <- c("ST01","ST04","ST09","ST12","ST17","ST20","ST25","ST28")
stra_columns <- select(lrn14, one_of(strategic_questions))
lrn14$stra <- rowMeans(stra_columns)
surf_questions <- c("SU02","SU05","SU08","SU10","SU13","SU16","SU18","SU21","SU24","SU26","SU29","SU32")
surf_columns <- select(lrn14,one_of(surf_questions))
lrn14$surf <- rowMeans(surf_columns)

#choose the columns that will be kept for the analysis
keep_columns <- c("gender","Age","Attitude", "deep", "stra", "surf", "Points")

#creating new dataset of 7 variables and 183 observations
learning2014 <- select(lrn14, one_of(keep_columns))

#excluding observations with Points = 0 leaving 166 observations
learning2014 <- filter(learning2014, Points > 0)

#saving the dataset as csv-file in IODS-project
write.csv(learning2014,"C:/Users/Pyrintö/Documents/GitHub/IODS-project/learning2014.csv",row.names = FALSE)
