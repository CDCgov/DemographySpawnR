# create seed dataset (~1000 rows) that selects INTEGERS uniformly from 1 to 100
#                     numbers from 0 to 1
#                     bunch of random strings
#                     something with small number of categories 3-5
#                     something with large number of categories 15+
#                   

# THEN
# Use that to generate multiple new random datasets that increase in size exponentially 
# merge them in microbe trace
#     want to see how long that merge takes


library(stringi)
n = 1000
seedData = data.frame(randomInt = floor(runif(n, min = 1, max = 100)), 
                      random01 = runif(n, min = 0, max = 1), 
                      randomString = stri_rand_strings(n, sample(1:10, n, replace=TRUE)), 
                      randomCatsSmall = sample(c("cat1", "cat2", "cat3", "cat4"), n, replace=TRUE), 
                      randomCatsLarge = sample( LETTERS[1:20], n, replace=TRUE)
)



library(devtools)
install_github("cdcgov/DemographySpawnR", force = T)
library(DemographySpawnR)

sampleUnivariate(seedData, 100)
