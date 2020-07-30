
library(ggplot2, quietly = T)
library(ggthemes, quietly = T)

### Different plots to show what a distribution is
dat = read.table("C:/Users/yhd8/Desktop/Data/gender-height.txt", sep = ",", header = T)

# hist(dat$Weight)



## Histogram of heights overall

overallHist = ggplot(dat, aes(x = Height)) +
  geom_histogram(fill = "white", color = "darkred", alpha = 0.5, position = "identity", binwidth = 1)+
  ggtitle("Overall Histogram of Height")



## Histogram of heights by gender -- males generally higher than females

histByGender = ggplot(dat, aes(x=Height, color=Gender)) +
  geom_histogram(fill="white", alpha=0.5, position="identity", binwidth = 1) +
  theme(legend.position = c(0.9 ,0.8),
        legend.text=element_text(size=8)) +
  ggtitle("Histograms of Heights by Gender")

## Plotting overall and split on 1 screen

Rmisc::multiplot(overallHist, histByGender)


## Density plots because why not
ggplot(data = dat, aes(x = Height, color = Gender)) + 
  geom_density()


## Plot of height vs weight by gender because why not
ggplot(data = dat, aes(x = Height, y = Weight, color = Gender)) + 
  geom_point(alpha = 0.2)
