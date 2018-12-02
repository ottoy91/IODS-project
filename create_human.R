### 25.11.2018/Otto Ylöstalo/IODS-project Week 4 ###
library(dplyr)
#1
hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

#2
#structure, dimensions and summary of hd
str(hd)
dim(hd)
summary(hd)

#structure, dimensions and summary of gii
str(gii)
dim(gii)
summary(gii)

#3
names(hd) <- c("hd_rank","country","HDI","LE_at_birth","exp_edu_years","mean_edu_years","GNI","GNI_rank")

names(gii) <- c("gii_rank","country","gii","mmr","abr","prp","eduF","eduM","labF","labM")


#4
gii <- mutate(gii, edu_ratio = eduF/eduM)
gii <- mutate(gii, lab_ratio = labF/labM)

#5
human <- inner_join(hd, gii, by = "country", suffix = c(".hd", ".gii"))
#save file
write.csv(human,"human.csv",row.names = F)

##2.12.2018/Otto Ylöstalo/IODS-project Week 5
##Data contains different variables that are related to human development reports from different countries
##and how these and not the economic growth alone are a criteria for a countrys development.
##Soure:
##http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv
##http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv


str(human)
dim(human)

#dataset combines 19 indicators from 195 countries in the world related to HDI
library(stringr)
str(human$GNI)
#1
str_replace(human$GNI, pattern=",", replace =".") %>% as.numeric

#2
keep <- c("country", "edu_ratio", "lab_ratio", "LE_at_birth", "exp_edu_years", "GNI", "mmr", "abr", "prp")
human <- select(human, one_of(keep))

#3
complete.cases(human)
data.frame(human[-1], comp = complete.cases(human))
human <- filter(human, complete.cases(human))
complete.cases(human)

#4
print(human$country)
last <- nrow(human) - 7
human <- human[1:last, ]

#5
rownames(human) <- human$country
human <- human[,2:9]
write.csv(human,"human.csv",row.names = F)
