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
names(hd)
names(hd) <- c("hd_rank","country","HDI","LE_at_birth","exp_edu_years","mean_edu_years","GNI_per_capita","GNI_rank")
names(hd)
names(gii)
names(gii) <- c("gii_rank","country","gii","mmr","abr","prp","eduF","eduM","labF","labM")
names(gii)

#4
gii <- mutate(gii, edu_ratio = eduF/eduM)
gii <- mutate(gii, lab_ratio = labF/labM)

#5
joined <- inner_join(hd, gii, by = "country", suffix = c(".hd", ".gii"))
summary(joined)
