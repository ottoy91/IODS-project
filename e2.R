
#read data again and check str() and head()
lrn2014 <- read.csv("C:/Users/Pyrintö/Documents/GitHub/IODS-project/learning2014.csv")
str(lrn2014)
#deep, stra and surf are numeric but since nothing was mentioned about this they weren't changed to integers
head(lrn2014)

library(ggplot2)

# initialize plot with data and aesthetic mapping
p1 <- ggplot(lrn2014, aes(x = Attitude, y = Points))


# define the visualization type (points)
p2 <- p1 + geom_point()


# draw the plot
p2

# add a regression line
p3 <- p2 + geom_smooth(method = "lm")

# add a main title and draw the plot
p4 <- p3 + ggtitle("Student's attitude versus exam points")
p4

