library(readxl)
dat = data.frame(read.csv("C:/Users/yhd8/Desktop/Data/Pretend/listings.csv", na.strings = ""))
dat2 = dat[c(1:20),]
dat2[dat2 == ""] <- NA


wcgs = data.frame(read_xls("C:/Users/yhd8/Desktop/Data/Pretend/wcgs.xls"))
wcgs = wcgs[1560:1620,]

corrVars = data.frame(read_xlsx("C:/Users/yhd8/Desktop/Data/Pretend/listVars.xlsx"))



newdat =  data.frame(read.csv("C:/Users/yhd8/Desktop/Data/Pretend/Demo_outbreak_NodeList.csv"))
newdat$subtype[50:86] = factor(2)
newdat$subtype = sample(c("c", "b"), replace = T, prob = c(.5, .5) )
newdat$cluster[30:60] = 1









dates = as.data.frame(c(20141212,
 20160228,
  20161231,
  20160618,
  20170123,
  20151124,
 20141212,
 20160228,
 20161231,
 20160618,
 20170123,
 20151124,
 20141212,
 20160228,
 20161231,
 20160618,
 20170123,
 20151124,
 20170123,
 20151124))

try = cbind(dat2, dates)
names(try)[ncol(try)] = "dates"




# temp = try[c(1:6, 23),]
# temp = try[c(1:6), c(1:6,23)]


something = as.data.frame(cbind(try$arcus, try$chd69, try$smoke, try$typchd69))

a <- c(1,2,3,4)
b <- c("kk","km","ll","k3")
time <- c(2001,2001,2002,2003)
df <- data.frame(a,b,time)
myvalues <- c(2001,2002,2003)

for (i in 1:3) {
  assign(paste0("y",i), df[df$time==myvalues[i],])
}
