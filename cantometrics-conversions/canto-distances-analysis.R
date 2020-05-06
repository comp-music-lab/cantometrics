setwd("~/Documents/Comp Music/Cantometrics/cantometrics/cantometrics-conversions")


#install packages

install.packages("vegan")

#load packages
library(vegan)

# load full csv files
canto_nominal <- as.dist(as.matrix(read.csv(file="./full-matrices/CantometricsDistNominal.csv",row.names=1,header=T)))
canto_ordinal <- as.dist(as.matrix(read.csv(file="./full-matrices/CantometricsDistOrdinal.csv",row.names=1,header=T)))
musly <- as.dist(as.matrix(read.csv(file="./full-matrices/musly.csv", header=F)))
panteli <- as.dist(as.matrix(read.csv(file="./full-matrices/panteli.csv", header=F)))


# load partial distance matrices
canto_nominal_partial <- as.dist(as.matrix(read.csv(file="./partial-matrices/canto_dist_nom_part.csv",row.names=1,header=T)))
canto_ordinal_partial <- as.dist(as.matrix(read.csv(file="./partial-matrices/canto_dist_ord_part.csv",row.names=1,header=T)))
pairwise_partial <- as.dist(as.matrix(read.csv(file="./partial-matrices/pairwise_partial.csv", header=F)))
musly_partial <- as.dist(as.matrix(read.csv(file="./partial-matrices/musly_partial.csv", header=F)))
panteli_partial <- as.dist(as.matrix(read.csv(file="./partial-matrices/panteli_partial.csv", header=F)))

# pre-processing of cantometrics distances
canto_nominal_partial <- 100 - canto_nominal_partial
canto_nominal_partial[canto_nominal_partial==100] <- NA

canto_ordinal_partial <- 100 - canto_ordinal_partial
canto_ordinal_partial[canto_ordinal_partial==100] <- NA

matrix_comparison <- function(a, b){
    result <- mantel(a,b,na.rm=TRUE,method="pearson")

    return(result) 
}

full_comparisons <- data.frame(matrix(NA, nrow=4, ncol=4))

result <- matrix_comparison(canto_nominal, canto_ordinal)
full_comparisons$X1[2] <- result$statistic 
full_comparisons$X2[1] <- result$signif

result <- matrix_comparison(canto_nominal, musly)
full_comparisons$X1[3] <- result$statistic 
full_comparisons$X3[1] <- result$signif

result <- matrix_comparison(canto_nominal, panteli)
full_comparisons$X1[4] <- result$statistic 
full_comparisons$X4[1] <- result$signif

result <- matrix_comparison(canto_ordinal, musly)
full_comparisons$X2[3] <- result$statistic 
full_comparisons$X3[2] <- result$signif

result <- matrix_comparison(canto_ordinal, panteli)
full_comparisons$X2[4] <- result$statistic 
full_comparisons$X4[2] <- result$signif

result <- matrix_comparison(musly, panteli)
full_comparisons$X3[4] <- result$statistic 
full_comparisons$X4[3] <- result$signif


full_comparisons[full_comparisons==NA] <- 0

write.csv(as.matrix(full_comparisons),"./results/full_comparisons.csv")


partial_comparisons <- data.frame(matrix(NA, nrow=5, ncol=5))

result <- matrix_comparison(canto_nominal_partial, canto_ordinal_partial)
partial_comparisons$X1[2] <- result$statistic 
partial_comparisons$X2[1] <- result$signif

result <- matrix_comparison(canto_nominal_partial, pairwise_partial)
partial_comparisons$X1[3] <- result$statistic 
partial_comparisons$X3[1] <- result$signif

result <- matrix_comparison(canto_nominal_partial, musly_partial)
partial_comparisons$X1[4] <- result$statistic 
partial_comparisons$X4[1] <- result$signif

result <- matrix_comparison(canto_nominal_partial, panteli_partial)
partial_comparisons$X1[5] <- result$statistic 
partial_comparisons$X5[1] <- result$signif

result <- matrix_comparison(canto_ordinal_partial, pairwise_partial)
partial_comparisons$X2[3] <- result$statistic 
partial_comparisons$X3[2] <- result$signif

result <- matrix_comparison(canto_ordinal_partial, musly_partial)
partial_comparisons$X2[4] <- result$statistic 
partial_comparisons$X4[2] <- result$signif

result <- matrix_comparison(canto_ordinal_partial, panteli_partial)
partial_comparisons$X2[5] <- result$statistic 
partial_comparisons$X5[2] <- result$signif

result <- matrix_comparison(pairwise_partial, musly_partial)
partial_comparisons$X3[4] <- result$statistic 
partial_comparisons$X4[3] <- result$signif

result <- matrix_comparison(pairwise_partial, panteli_partial)
partial_comparisons$X3[5] <- result$statistic 
partial_comparisons$X5[3] <- result$signif

result <- matrix_comparison(musly_partial, panteli_partial)
partial_comparisons$X4[5] <- result$statistic 
partial_comparisons$X5[4] <- result$signif


partial_comparisons[partial_comparisons==NA] <- 0
write.csv(as.matrix(partial_comparisons),"./results/partial_comparisons.csv")