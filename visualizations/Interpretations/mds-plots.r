setwd('./Documents/Comp Music/Cantometrics/ISMIR 2020/')

pairwise_partial_1 <- read.csv("./partial-distances/pairwise_partial_1.csv", header=FALSE)
pairwise_partial_2 <- read.csv("./partial-distances/pairwise_partial_2.csv", header=FALSE)
pairwise_partial_3 <- read.csv("./partial-distances/pairwise_partial_3.csv", header=FALSE)
pairwise_partial_4 <- read.csv("./partial-distances/pairwise_partial_4.csv", header=FALSE)
pairwise_partial_5 <- read.csv("./partial-distances/pairwise_partial_5.csv", header=FALSE)
pairwise_partial_6 <- read.csv("./partial-distances/pairwise_partial_6.csv", header=FALSE)

categories <- read.csv("Interpretations/categories.csv", header = FALSE)

group_main <- categories[,1]
instrumental_main <- categories[,2]

library(ggplot2) 

mds<-cmdscale(pairwise_partial_1, eig=TRUE, k=2)
x <- mds$points[,1]
y <- mds$points[,2]
df<- as.data.frame(mds$points)
instrumental <- instrumental_main[0:5]
group <- group_main[0:5]
labels <- c("1","2","3","4","5")
p <- ggplot(df, aes(x=x, y=y, group=group, label=labels))
p + geom_point(aes(color=group, shape=instrumental, size=3))+ guides(size=FALSE)+ labs(title="Group 1", x="Component 1", y="Component 2", shape="Style", color="Group vs. Solo")+ geom_text(hjust=-1, vjust=1)
ggsave('./figs/mds/group-1.png', width=5.5, height=4.5)

labels <- c("6","7","8","9","10")
instrumental <- instrumental_main[6:10]
group <- group_main[6:10]
mds<-cmdscale(pairwise_partial_2, eig=TRUE, k=2)
x <- mds$points[,1]
y <- mds$points[,2]
df<- as.data.frame(mds$points)
p <- ggplot(df, aes(x=x, y=y, group=group, label=labels))
p+ geom_point(aes(color=group, shape=instrumental, size=3))+guides(size=FALSE) + labs(title="Group 2", x="Component 1", y="Component 2", shape="Style", color="Group vs. Solo")+geom_text(hjust=-1, vjust=1)
ggsave('./figs/mds/group-2.png', width=5.5, height=4.5)

labels <- c("11","12","13","14","15")
instrumental <- instrumental_main[11:15]
group <- group_main[11:15]
mds<-cmdscale(pairwise_partial_3, eig=TRUE, k=2)
df<- as.data.frame(mds$points)
x <- mds$points[,1]
y <- mds$points[,2]
p <- ggplot(df, aes(x=x, y=y, group=group, label=labels))
p+ geom_point(aes(color=group, shape=instrumental, size=3))+guides(size=FALSE) + labs(title="Group 3", x="Component 1", y="Component 2",  shape="Style", color="Group vs. Solo")+geom_text(hjust=1, vjust=1)
ggsave('./figs/mds/group-3.png', width=5.5, height=4.5)


labels <- c("16","17","18","19","20")
instrumental <- instrumental_main[16:20]
group <- group_main[16:20]
mds<-cmdscale(pairwise_partial_4, eig=TRUE, k=2)
df<- as.data.frame(mds$points)
x <- mds$points[,1]
y <- mds$points[,2]
p <- ggplot(df, aes(x=x, y=y, group=group, label=labels))
p+ geom_point(aes(color=group, shape=instrumental, size=3))+guides(size=FALSE) + labs(title="Group 4", x="Component 1", y="Component 2", shape="Style", color="Group vs. Solo")+geom_text(hjust=1, vjust=1)
ggsave('./figs/mds/group-4.png', width=5.5, height=4.5)


labels <- c("21","22","23","24","25")
instrumental <- instrumental_main[21:25]
group <- group_main[21:25]
mds<-cmdscale(pairwise_partial_5, eig=TRUE, k=2)
df<- as.data.frame(mds$points)
x <- mds$points[,1]
y <- mds$points[,2]
p <- ggplot(df, aes(x=x, y=y, group=group, label=labels))
p+ geom_point(aes(color=group, shape=instrumental, size=3))+guides(size=FALSE) + labs(title="Group 5", x="Component 1", y="Component 2", shape="Style", color="Group vs. Solo")+geom_text(hjust=1, vjust=1)
ggsave('./figs/mds/group-5.png', width=5.5, height=4.5)


labels <- c("26","27","28","29","30")
instrumental <- instrumental_main[26:30]
group <- group_main[26:30]
mds<-cmdscale(pairwise_partial_6, eig=TRUE, k=2)
df<- as.data.frame(mds$points)
x <- mds$points[,1]
y <- mds$points[,2]
p <- ggplot(df, aes(x=x, y=y, group=group, label=labels))
p+ geom_point(aes(color=group, shape=instrumental, size=3))+guides(size=FALSE) + labs(title="Group 6", x="Component 1", y="Component 2", shape="Style", color="Group vs. Solo")+geom_text(hjust=1, vjust=1)
ggsave('./figs/mds/group-6.png', width=5.5, height=4.5)
