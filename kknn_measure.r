
rm(list=ls()) #removes objects from the environment

#Reads IBM_Attrition_v3.csv file and creates dataframe in ibm
ibm <- read.csv("IBM_Attrition_v3.csv", na.strings="?")

View(ibm) #Spreadsheet data view of the .csv file

IBM_Attrition <- na.omit(ibm)
View(IBM_Attrition)

index <- sample(nrow(IBM_Attrition), size=0.30*(nrow(IBM_Attrition)),replace = FALSE, prob = NULL)
index

testdata <-IBM_Attrition[index,]
testdata
#30% of 134 rows is 40 row items. To check run the View function
View(testdata)

trainingdata <-IBM_Attrition[-index,]
trainingdata
#70% of 134 rows is 94 row items. To check run the View function
View(trainingdata)

library(kknn)

predict_k5 <- kknn(formula= Attrition~.,trainingdata, testdata, k=5, kernel = "rectangular")
predict_k5

fit <- fitted(predict_k5)
table(testdata$Attrition, fit)

#Attrition Rate when k=5
measure <- testdata$Attrition!=fit
sum(measure)/length(measure)
