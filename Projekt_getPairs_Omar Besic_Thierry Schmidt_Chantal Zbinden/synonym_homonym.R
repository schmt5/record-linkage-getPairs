#####
# Synonym Homonym
#####

library(RecordLinkage)

# load data
data(RLdata500)
testdata <- RLdata500


# create record pairs
?RLBigDataDedup
# data <- RLBigDataDedup(testdata, identity = identity.RLdata500,
#                         blockfld=list(1,3,5:7))

# damit man is_Match verwenden kann, muss man mit RLBigDataDedup arbeiten
data <- RLBigDataDedup(testdata, identity = identity.RLdata500,
                       blockfld=list(1,3,5:7),
                       strcmp = c(2,3,4),
                       strcmpfun = "levenshtein")

# mit compare.dedup gibt es Variabel "is_match" nicht darum kann man es so nicht machen
# man kann mit epiClassified schauen, ob sie Link oder Non-Link sind,
# jedoch weiss man nicht, ob es einen match ist oder nicht
# data <- compare.dedup(testdata, identity = identity.RLdata500,
#                       blockfld=list(1,3,5:7),
#                       strcmp = c(2,3,4),
#                       strcmpfun = levenshteinSim)


# calculate epilink weights
data <- epiWeights(data)

# show all record pairs with weights between 0.5 and 0.6
#head(getPairs(data, min.weight=0.5, max.weight=0.6))
# show only matches with weight <= 0.5
#head(getPairs(data, max.weight=0.5, filter.match="match"))

# classify with one threshold.upper
# classified record pairs in link, non-link or possible-link based on their weight
result <- epiClassify(data, 0.5)


# show all links, do not show classification in the output
head(getPairs(result, filter.link="link", withClass = TRUE))
tail(getPairs(result, filter.link="link", withClass = TRUE))


# false non-match = synonym
# Bsp: Handy und Mobiltelefon
# Bsp. für Person: Martin und Mäddä (gleiche Person ist gemeint)
# Haben keinen Link, sind aber trotzdem Sinnverwandt (gleiches Objekt gemeint)
# c in Vierfeldertafel
getFalseNeg(result)


# false match = homonym
# Bsp: Bank (Sitzbank) und Bank (Geldinstitut)
# Bsp. für Person: Jan und Jan (zwei unterschiedliche Personen)
# ==> Class: Link, is_match: FAlSE
# Haben einen Match, da beide gleich sind, jedoch zwei unterschiedliche Objekte
# b in Vierfeldertafel
getFalsePos(result) # von wo weiss R das es FalsePos ist?

#######
# Fragestellung in der Aufgabe:
# do we have any ways to calculate their confidence levels related?
#######

?optimalThreshold
#  If no further arguments are given,
# a threshold which minimizes the absolute number of misclassified record pairs is returned.
optimalThreshold(data)

#optimalThreshold(data, my=0.6) # wir akzeptieren viele Falsch-Pos (False-matches)

?getParetoThreshold
# mean residual life withit you can define the threshold
getParetoThreshold(data, quantil = 0.95)


?getPairs
# filter after match, link, non-link
length(getPairs(result, filter.match="match", filter.link="link")$id)
length(getPairs(result, filter.match="match", filter.link="nonlink", single.rows=TRUE)$id.1)


