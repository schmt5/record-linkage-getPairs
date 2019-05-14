#####
# Synonym Homonym
#####

library(RecordLinkage)

# load data
data(RLdata500)
testdata <- RLdata500


# create record pairs
?RLBigDataDedup
data <- RLBigDataDedup(testdata, identity = identity.RLdata500,
                         blockfld=list(1,3,5:7))

data <- RLBigDataDedup(testdata, identity = identity.RLdata500,
                       blockfld=list(1,3,5:7),
                       strcmp = c(2,3,4),
                       strcmpfun = "levenshtein")

# mit compare.dedup gibt es Variabel "is_match" nicht
# man kann mit epiClassified schauen, ob sie Link oder Non-Link sind,
# jedoch weiss man nicht, ob es einen match ist oder nicht
data <- compare.dedup(testdata, identity = identity.RLdata500,
                       blockfld=list(1,5:7),
                       strcmp = c(2,3,4),
                       strcmpfun = levenshteinSim)

# deleted 3
# calculate epilink weights
data <- epiWeights(data)

# show all record pairs with weights between 0.5 and 0.6
getPairs(data, min.weight=0.5, max.weight=0.6)

# show only matches with weight <= 0.5
getPairs(data, max.weight=0.5, filter.match="match")

# classify with one threshold.upper
# classified record pairs in link, non-link or possible-link based on their weight
result <- epiClassify(data, 0.5)


# show all links, do not show classification in the output
head(getPairs(result, filter.link="link", withClass = TRUE))


# false non-match = synonym
# Bsp: Handy und Mobiltelefon
# Bsp. für Person: Martin und Mäddä (gleiche Person ist gemeint)
# Haben keinen Match, sind aber trotzdem Sinnverwandt (gleiches Objekt gemeint)
# c in Vierfeldertafel
getFalseNeg(result)
?getFalsePos


# false match = homonym
# Bsp: Bank (Sitzbank) und Bank (Geldinstitut)
# Bsp. für Person: Jan und Jan (zwei unterschiedliche Personen)
# ==> Class: Link, is_match: FAlSE
# Haben einen Match, da beide gleich sind, jedoch zwei unterschiedliche Objekte
# b in Vierfeldertafel
getFalsePos(result) # von wo weiss R das es FalsePos ist?





# see wrongly classified pairs


