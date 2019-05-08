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

summary(data)

### calculate weight
# es gibt zusätzlich variabel:
# Wdata mit den weights
?epiWeights
data <- epiWeights(data)
head(data$Wdata)


### get paris
?getPairs

rpairs <- getPairs(data, single.rows=FALSE)
length(rpairs$id)
rpairs

# show all record pairs with weights between 0.5 and 0.6
getPairs(data, min.weight=0.5, max.weight=0.6)


### make classify
?epiClassify
# es gibt zusätzlich variabel:
# prediction und threshold
cldata <- epiClassify(data, 0.5)

# nun kann man mit show filtern
getPairs(cldata, show="links", single.rows=FALSE)
