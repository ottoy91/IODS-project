#6.12.2018/Otto Ylöstalo/IODS project#

library(dplyr)
library(tidyr)
#1
BPRS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", sep  =" ", header = T)
rats <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", sep  ="\t", header = T)

names(BPRS)
str(BPRS)
summary(BPRS)
names(rats)
str(rats)
summary(rats)

#2
BPRS$treatment <- factor(BPRS$treatment)
BPRS$subject <- factor(BPRS$subject)
rats$ID <- factor(rats$ID)
rats$Group <- factor(rats$Group)

#3
BPRSL <-  BPRS %>% gather(key = weeks, value = bprs, -treatment, -subject)
ratsl <- rats %>% gather(key = time, value = weight, -ID, -Group )

#4
names(BPRSL)
summary(BPRSL)
glimpse(BPRSL)
glimpse(ratsl)
names(ratsl)
summary(ratsl)
#the long form dataset of rats contain a column where all the weights are reported and one column that 
#identifies the rat