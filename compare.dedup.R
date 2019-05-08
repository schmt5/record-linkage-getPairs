library(RecordLinkage, quietly = TRUE)

# dataframe of 500 persons with irstname, second firstname, 
# lastname, second lastname, birhtyear, birthmonth, birthday
data(RLdata500)

# Overview of the data
str(RLdata500)

# Overview of the columns and first five rows
head(RLdata500)

# using compare.dedup to generate the features
# blockfld aliviates the problem of n*(n-1)/2, 
# compare columns 1 or, 5 up to 7 for two records to  qualify to become a pair
# row 2 and 43 from RLdata500 = firstname similar (column 1 in nlockfld) 
# and bday similar (column 5:7 in nlockfld) 
# strcmp executes the levenshteinSim (strcmpfun) function on columns 2,3 and 4
?compare.dedup()
rec.pairs <- compare.dedup(RLdata500
                           ,blockfld = list(1, 5:7)
                           ,strcmp = c(2,3,4)
                           ,strcmpfun = levenshteinSim)

# Overview of the data
summary(rec.pairs)

# Overview of the data
str(rec.pairs)

# assign dataframe rec.pairs$pairs to matches 
matches <- rec.pairs$pairs

# give me the matches of all rows on which the restriction had be defined in blockfld for 
# 1 = same | 0  = not same
# gives the matches of all rowes in pairs because of rec.pairs$pairs
matches[c(1:1204), ]

#fname_c1 = same and bday = same
RLdata500[2,]
RLdata500[43,]

#fname_c1 = same and bday = not same
RLdata500[1,]
RLdata500[174,]
