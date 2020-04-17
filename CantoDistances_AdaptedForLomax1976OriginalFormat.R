#First, make sure to check spreadsheet for errors, save as .csv spreadsheet with first row=Song No. and rows 2-42= CantoCore variables no. 1-26 + Cantometrics Performance features (variables no. 5, 6, 23-26, 28, 30-37) 

#open R, change workspace to correct folder
setwd("/Users/pesavage/Documents/Research/Papers/Unpublished/Daikoku et al (2019:2020) ISMIR to submit")

#load packages
library(dplyr)

#import spreadsheet (multi-state):

data<-read.csv("ConsensusTapeCantometricsLomaxOnlyNACodingsIntact.csv",header=TRUE,row.names=1)
#data[,1:37]<-as.numeric(data[,1:37]) #no longer needed now that we're not importing using as.matrix

#First convert codings as given in 1976 to format of original Lomax & Grauer 1968 codebook (this is the format used in at http://theglobaljukebox.org)

#data[,1] <- ifelse(data[,1]<=2,data[,1],data[,1]+1) #Was going to do this because in the 1976 version Lomax condensed what were originally coded separately as 2 ("one singer") and 3("one singer with an audience") together as 2 ("one solo singer"). But realized this doesn't really matter as long as we're sure to normalize each column by its max value, not a fixed value

#remove redundant NA codings from columns 2, 4:9, 11:14, 22, and 27 
data[,c(2,4:9,11:14,22,27)] <- data[,c(2,4:9,11:14,22,27)] %>% dplyr::na_if(1)

nominal<-c(1:4,7,11:16,22) #for CantoCore/Cantometrics combined, set to:  nominal<-c(1:4,8:9,14,18,20,24:25)
ordinal<-c(5:6,9:10,17:21,23:37) #for CantoCore/Cantometrics combined, set to: ordinal<-c(5:7,10:13,15:17,19,21:23,26:41) #NB: line 8 is excluded because it was dropped from 1976 - was just here as a placeholder column

#convert nominal variables to letter codings
data[ , nominal ][ data[ ,nominal] == 1 ] <- "a"
data[ , nominal ][ data[ ,nominal] == 2 ] <- "b"
data[ , nominal ][ data[ , nominal] == 3 ] <- "c"
data[ , nominal ][ data[ , nominal] == 4 ] <- "d"
data[ , nominal ][ data[ , nominal] == 5 ] <- "e"
data[ , nominal ][ data[ , nominal] == 6 ] <- "f"
data[ , nominal ][ data[ , nominal] == 7 ] <- "g"
data[ , nominal ][ data[ , nominal] == 8 ] <- "h"
data[ , nominal ][ data[ , nominal] == 9 ] <- "i"
data[ , nominal ][ data[ , nominal] == 10 ] <- "j"
data[ , nominal ][ data[ , nominal] == 11 ] <- "k"
data[ , nominal ][ data[ , nominal] == 12 ] <- "l"
data[ , nominal ][ data[ , nominal] == 13 ] <- "m"

#manually add double-codings for variables that were originally double-coded without one coding underlined as clearly dominant - ONLY USE THIS SECTION SPECIFICALLY FOR ANALYZING THE 1976 CONSENSUS TAPE CODINGS, NOT FOR FUTURE GLOBAL JUKEBOX ANALYSES

data[19,1]<-"gl" 
data[6,2]<-"bd" 
data[15,2]<-"cf" 
data[18,4]<-"bd" 
data[6,7]<-"de" 
data[7,12]<-"cd" 
data[12,12]<-"bd" 
data[6,13]<-"be" 
data[8,13]<-"cd" 
data[16,13]<-"cd" 
data[1,15]<-"ac" 
data[3,15]<-"bc" 
data[5,15]<-"cd" 
data[9,15]<-"ac" 
data[10,15]<-"cd" 
data[13,15]<-"cd" 
data[14,15]<-"ac" 
data[15,15]<-"cd" 
data[19,15]<-"ad" 
data[13,16]<-"fk" 
data[12,16]<-"bk" 
data[1,16]<-"bi" 
data[19,22]<-"df" 
data[21,3]<-"eh" 
data[30,4]<-"bd"
data[26,11]<-"bd"
data[28,11]<-"ae"
data[24,12]<-"cd"
data[25,12]<-"ad"
data[27,12]<-"ef"
data[28,12]<-"cd"
data[21,13]<-"bf"
data[25,13]<-"de"
data[25,16]<-"ek"
data[30,22]<-"bd"

#then, normalize all numeric values to range between 0-1
normalize = function(x, ...) {(x - min(x, ...)) / (max(x, ...) - min(x, ...))}

data[, ordinal] <- lapply(data[, ordinal], normalize,na.rm=TRUE)

data<-as.matrix(data)


nominal.variables<-nominal
ordinal.variables<-ordinal

#add distance matrix algorithm
ordinal.fn<-function (x,y) {
if(is.na(x)|is.na(y))"NA" else
abs(x-y)}
weightedv6.dist<-function(d,ord,nom) {
d[d==""]<-NA
nominal<-cbind(d[,nom])
nominal.fields<-vector("list",length=length(nominal[1,]))
for (i in 1:length(nominal[1,])) {nominal.fields[[i]]<-matrix(nrow=length(nominal[,1]),ncol=13)}
for (i in 1:length(nominal[1,])) {rownames(nominal.fields[[i]])<-rownames(nominal)}
for (i in 1:length(nominal[1,])) {colnames(nominal.fields[[i]])<-c("a","b","c","d","e","f","g","h","i","j","k","l","m")}
for (j in 1:13){
for (k in 1:length(nominal[,1])){
for (i in 1:length(nominal[1,])){nominal.fields[[i]][k,j]<-(if(is.na(nominal[k,i]))"NA" else if(substr(nominal[k,i],1,1)==colnames(nominal.fields[[i]])[j] | substr(nominal[k,i],2,2)==colnames(nominal.fields[[i]])[j] |substr(nominal[k,i],3,3)==colnames(nominal.fields[[i]])[j] |substr(nominal[k,i],4,4)==colnames(nominal.fields[[i]])[j] |substr(nominal[k,i],5,5)==colnames(nominal.fields[[i]])[j] |substr(nominal[k,i],6,6)==colnames(nominal.fields[[i]])[j] |substr(nominal[k,i],7,7)==colnames(nominal.fields[[i]])[j] |substr(nominal[k,i],8,8)==colnames(nominal.fields[[i]])[j] |substr(nominal[k,i],9,9)==colnames(nominal.fields[[i]])[j] |substr(nominal[k,i],10,10)==colnames(nominal.fields[[i]])[j] |substr(nominal[k,i],11,11)==colnames(nominal.fields[[i]])[j] |substr(nominal[k,i],12,12)==colnames(nominal.fields[[i]])[j] |substr(nominal[k,i],13,13)==colnames(nominal.fields[[i]])[j])1 else 0) }}}
suppressWarnings(for (i in 1:length(nominal[1,])){storage.mode(nominal.fields[[i]])<-"numeric"})
nominal.dist<-vector("list",length=length(nominal[1,]))
for (i in 1:length(nominal[1,])) {nominal.dist[[i]]<-matrix(nrow=length(nominal[,1]),ncol=length(nominal[,1]))}
nominal.result<-matrix(nrow=length(d[,1]),ncol=length(d[,1]),c(rep(0,(length(d[,1])*length(d[,1])))))
ordinal<-cbind(d[,ord])
suppressWarnings(storage.mode(ordinal)<-"numeric")
ordinal.dist<-vector("list",length=length(ordinal[1,]))
for (i in 1:length(ordinal[1,])) {ordinal.dist[[i]]<-matrix(nrow=length(ordinal[,1]),ncol=length(ordinal[,1]))}
ordinal.result<-matrix(nrow=length(d[,1]),ncol=length(d[,1]),c(rep(0,(length(d[,1])*length(d[,1])))))
result<-matrix(nrow=length(d[,1]),ncol=length(d[,1]))
for (k in 1:length(nominal[,1])){
for (j in 1:length(nominal[,1])){
for (i in 1:length(nominal[1,])){nominal.dist[[i]][k,j]<-if(is.na(nominal.fields[[i]][k,1])|is.na(nominal.fields[[i]][j,1]))"NA" else ((if(nominal.fields[[i]][k,1]==nominal.fields[[i]][j,1])0 else 1)+(if(nominal.fields[[i]][k,2]==nominal.fields[[i]][j,2])0 else 1)+(if(nominal.fields[[i]][k,3]==nominal.fields[[i]][j,3])0 else 1)+(if(nominal.fields[[i]][k,4]==nominal.fields[[i]][j,4])0 else 1)+(if(nominal.fields[[i]][k,5]==nominal.fields[[i]][j,5])0 else 1)+(if(nominal.fields[[i]][k,6]==nominal.fields[[i]][j,6])0 else 1)+(if(nominal.fields[[i]][k,7]==nominal.fields[[i]][j,7])0 else 1)+(if(nominal.fields[[i]][k,8]==nominal.fields[[i]][j,8])0 else 1)+(if(nominal.fields[[i]][k,9]==nominal.fields[[i]][j,9])0 else 1)+(if(nominal.fields[[i]][k,10]==nominal.fields[[i]][j,10])0 else 1)+(if(nominal.fields[[i]][k,11]==nominal.fields[[i]][j,11])0 else 1)+(if(nominal.fields[[i]][k,12]==nominal.fields[[i]][j,12])0 else 1))/((if(nominal.fields[[i]][k,1]==1 | nominal.fields[[i]][[j,1]]==1)1 else 0)+(if(nominal.fields[[i]][k,2]==1 | nominal.fields[[i]][[j,2]]==1)1 else 0)+(if(nominal.fields[[i]][k,3]==1 | nominal.fields[[i]][[j,3]]==1)1 else 0)+(if(nominal.fields[[i]][k,4]==1 | nominal.fields[[i]][[j,4]]==1)1 else 0)+(if(nominal.fields[[i]][k,5]==1 | nominal.fields[[i]][[j,5]]==1)1 else 0)+(if(nominal.fields[[i]][k,6]==1 | nominal.fields[[i]][[j,6]]==1)1 else 0)+(if(nominal.fields[[i]][k,7]==1 | nominal.fields[[i]][[j,7]]==1)1 else 0)+(if(nominal.fields[[i]][k,8]==1 | nominal.fields[[i]][[j,8]]==1)1 else 0)+(if(nominal.fields[[i]][k,9]==1 | nominal.fields[[i]][[j,9]]==1)1 else 0)+(if(nominal.fields[[i]][k,10]==1 | nominal.fields[[i]][[j,10]]==1)1 else 0)+(if(nominal.fields[[i]][k,11]==1 | nominal.fields[[i]][[j,11]]==1)1 else 0)+(if(nominal.fields[[i]][k,12]==1 | nominal.fields[[i]][[j,12]]==1)1 else 0))}}}
suppressWarnings(for (i in 1:length(nominal[1,])){storage.mode(nominal.dist[[i]])<-"numeric"})
vnom<-vector(mode="numeric",length=length(nominal[1,]))
for (k in 1:length(nominal[,1])){
for (j in 1:length(nominal[,1])){
for (i in 1:length(nominal[1,])){
  vnom[i]<-nominal.dist[[i]][k,j]
  }
  nominal.result[k,j]<-mean(suppressWarnings(as.numeric(vnom)),na.rm=TRUE)
  }}
for (k in 1:length(ordinal[,1])){
for (j in 1:length(ordinal[,1])){
for (i in 1:length(ordinal[1,])){ordinal.dist[[i]][k,j]<-ordinal.fn(x=ordinal[k,i],y=ordinal[j,i]) }}}
suppressWarnings(for (i in 1:length(ordinal[1,])){storage.mode(ordinal.dist[[i]])<-"numeric"})
vord<-vector(mode="numeric",length=length(ordinal[1,]))
for (k in 1:length(ordinal[,1])){
for (j in 1:length(ordinal[,1])){
for (i in 1:length(ordinal[1,])){
  vord[i]<-ordinal.dist[[i]][k,j]
  }
  ordinal.result[k,j]<-mean(suppressWarnings(as.numeric(vord)),na.rm=TRUE)
  }}
for (k in 1:length(nominal[,1])){
for (j in 1:length(nominal[,1])){
result[k,j]<-if(is.na(nominal.result[k,j]))ordinal.result[k,j] else if(is.na(ordinal.result[k,j])) nominal.result[k,j] else (ordinal.result[k,j]*length(ord) + nominal.result[k,j]*length(nom))/(length(ord)+length(nom))
}}
row.names(result)<-row.names(d)
colnames(result)<-row.names(d)
as.dist(result)
}



#create distance matrix
dist<-weightedv6.dist(data, ordinal.variables, nominal.variables)
write.csv(as.matrix(dist),"CantometricsDist.csv")

#Plot Multidimensional scaling (MDS) [this code also includes code for k-means cluster analysis, but not necessarily useful here]

#K-means:
mds<-cmdscale(dist)
wss <- (nrow(mds)-1)*sum(apply(mds,2,var))
for (i in 2:25) wss[i] <- sum(kmeans(mds,centers=i)$withinss)

plot(1:25, wss, type="b", xlab="Number of Clusters",ylab="Within groups sum of squares")

#K=5
dev.new()
fit <- kmeans(mds, 5)
aggregate(mds,by=list(fit$cluster),FUN=mean)
japancol.MDS<- data.frame(mds, fit$cluster)
japancol.MDS$japancol.MDS[japancol.MDS$fit.cluster ==4]<- "gray0"
japancol.MDS$japancol.MDS[japancol.MDS$fit.cluster ==2]<- "gray25"
japancol.MDS$japancol.MDS[japancol.MDS$fit.cluster ==3]<- "gray50"
japancol.MDS$japancol.MDS[japancol.MDS$fit.cluster ==5]<- "gray75"
japancol.MDS$japancol.MDS[japancol.MDS$fit.cluster ==1]<- "gray100"
colnames(japancol.MDS)<-c("X1",  "X2", "fit.cluster", "col")
plot(japancol.MDS $X1, japancol.MDS $X2,xlab="Dimension 1", ylab="Dimension 2", main="K=5 Solution", pch=c(rep(21,60),rep(24,240),rep(22,380)),bg= japancol.MDS $col)