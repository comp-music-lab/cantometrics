#open R, change workspace to correct folder
setwd("/Users/pesavage/Documents/Research/Papers/Unpublished/Daikoku et al (2019:2020) ISMIR to submit")

#load packages
library(dplyr)
library(varhandle)

#import codings:

data<-read.csv("CantometricsConsensusTapeCodingsLomax1976pp168-170.csv",header=TRUE,row.names=1)

#set nominal and ordinal variables
nominal<-c(8) #NB: line 8 is actually excluded because it was dropped from 1976 - it is just here as a placeholder column
ordinal<-c(1:7,9:37) 

#then, normalize all ordinal values to range between 0-1
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

#save distance matrix
write.csv(as.matrix(dist),"CantometricsDistOrdinal.csv")


###########
#Following code may not be necessary in final version





##Compare partial distance matrices 
#Import two distance matrices
d1<-as.dist(as.matrix(read.csv("CantometricsDistOrdinal.csv",row.names=1,header=T)))
d2<-as.dist(as.matrix(read.csv("average_pairwise_matrix.csv",header=F)))
d2<-100-d2 #convert from similarities to distances

#plot histogram
hist(d1)
hist(d2)

#convert into data frames
m1<-as.matrix(d1)
xy <- t(combn(colnames(m1), 2))
d1<-data.frame(xy, dist=m1[xy])
d1<-unfactor(d1) #fixes ID numbers being coded as factors rather than numbers

m2<-as.matrix(d2)
xy <- t(combn(colnames(m2), 2))
d2<-data.frame(xy, dist=m2[xy])
d2<-unfactor(d2) #fixes ID numbers being coded as factors rather than numbers
plot(d1$dist,d2$dist)

#remove empty values from partial distance matrices
d<-cbind(d2,d1)
d<-subset(d,dist!=100) #for real partial distance matrices
plot(d$dist,d$dist.1)
cor.test(d$dist,d$dist.1,alternative="greater")







########
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
