##### 
# GET PAIRS
####
library(RecordLinkage)

### load data
data(RLdata500)

### make pairs
# man bekommteine liste mit:
# "data", "pairs", "frequencies" und "type"
data <- compare.dedup(RLdata500,
                      blockfld = list(1, 5:7), # focusing of certain constraints
                      strcmp = c(2,3,4),
                      strcmpfun = levenshteinSim)

# overview of data rpairs
summary(data)

### calculate weight
# es gibt zusätzlich variabel:
# Wdata mit den weights
?epiWeights
data <- epiWeights(data)
length(data$pairs$id1)
length(data$Wdata)
data$pairs[1,]
data$data[1,]
data$data[174,]

# overview of data rpairs
head(data$Wdata)
?epiWeights

### get paris
?getPairs

# generate pairs of data.frame data
rpairs <- getPairs(data, single.rows=FALSE)
# not number of pairs, if single.row = FALSE, because 1 pairs use 3 rows
length(rpairs$id)

# overview of data rpairs
head(rpairs)

# show all record pairs with weights between 0.5 and 0.6
getPairs(data, min.weight=0.5, max.weight=0.6)

### make classify
?epiClassify
# es gibt zusätzlich variabel:
# prediction und threshold

# @required data
# @required treshold.upper = 0.5
# treshold.lower = threshold.upper, if not defined
cldata <- epiClassify(data, 0.5)

# possible prediction-levels: Not-linked and linked (No Possible's because only treshold.upper defined)
summary(cldata$prediction)

# threshold.upper = 0.6, threshold.lower = 0.4
cldata <- epiClassify(data, 0.6, 0.4)
summary(cldata$prediction)

# now we can filter , show= "links", "nonlinks", "possible" or "all".
getPairs(cldata, show="links", single.rows=FALSE)