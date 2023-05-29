#import csv data
data = read.csv('airline_passenger_satisfaction.csv', header = TRUE, sep = ",")
str(data)
sapply(data, class)
#Check for missing values:
#install.packages("tidyverse")
library(tidyverse)
library(dplyr)
library(ggplot2)

print("Position of missing values - Column wise")
sapply(data, function(x) which(is.na(x)))

print("Count of missing values - Column wise")
sapply(data, function(x) sum(is.na(x)))

#Arrival Delay has 393 missing values
summary(data)
#We are deleting the 393 rows and keeping only the complete cases 
#from the 130000 observation data set.
data = data[complete.cases(data),]

#Remove ID column:
data = data[,-1]

#Replace 'Neutral / Dissatisfied' with 0 and 'Satisfied' with 1:
data$Satisfaction[data$Satisfaction == 'Satisfied'] = '1'
data$Satisfaction[data$Satisfaction == 'Neutral or Dissatisfied'] = '0'

#converting multiple int and chr columns to factor:
data$Satisfaction %<>% factor
str(data)

#Plots
library(ggplot2)
library(dplyr)

customer_type = ggplot(data, aes(x=`Customer.Type`))+
  geom_bar(stat= "count",fill = 'yellow3', alpha = 0.8, width = 0.5)+
  labs(x = 'Customer Type', y = 'Count', title = 'Count of Customer Type')+
  theme(text = element_text(family = "Times New Roman"))

class_customer = ggplot(data, aes(x=Class))+  geom_bar(stat= "count",fill = 'yellowgreen', alpha = 0.8, width = 0.5)+
  labs(x = 'Type of Customer Class', y = 'Count', title = 'Count of Customer Class')+
  theme(text = element_text(family = 'Times New Roman'))

travel_type = ggplot(data, aes(x= Type.of.Travel))+  geom_bar(stat= "count",fill = 'seagreen', alpha = 0.8, width = 0.5)+
  labs(x = 'Type of Trip', y = 'Count', title = 'Count of Trip Type')+
  theme(text = element_text(family = 'Times New Roman'))

gender = ggplot(data, aes(x= Gender))+  geom_bar(stat= "count",fill = 'springgreen3', alpha = 0.8, width = 0.5)+
  labs(x = 'Gender', y = 'Count', title = 'Gender Count')+
  theme(text = element_text(family = 'Times New Roman'))

#install.packages('gridExtra')
library(gridExtra)
grid.arrange(gender, customer_type, class_customer, travel_type, layout_matrix=rbind(c(1,2),c(3,4)))

#Logistic Regression:
#install.packages("caTools")
#install.packages("ROCR")
library(caTools)
library(ROCR)

#Split data into train and test:
set.seed(1234)
split = sample.split(data, SplitRatio = 0.70)
head(split)  
train_reg = subset(data, split == "TRUE")
test_reg = subset(data, split == "FALSE")  
prop.table(table(train_reg$Satisfaction))
prop.table(table(test_reg$Satisfaction))
#Target variable in both train and test sets is balanced

#Training model
logmodel = glm(train_reg$Satisfaction ~ ., data = train_reg, family = "binomial" )  
summary(logmodel)  
library(car)
vif(logmodel)
#Drop 'Departure Delay' and 'Arrival delay' from test and train data due to high VIF
str(test_reg)
train_reg = train_reg[,-c(7,8)]
test_reg = test_reg[,-c(7,8)]

#After dropping the high-VIF variables:
logmodel_1 = glm(train_reg$Satisfaction ~ ., data = train_reg, family = "binomial" )  
summary(logmodel_1)
vif(logmodel_1)
#VIF regulated.

#Predictions:
predmodel_1 = predict(logmodel_1, newdata = test_reg, type = "response")
head(predmodel_1) 
#Changing Probabilities: IF greater than 0.5, then label it as 1. Otherwise, '0'.
predmodel_1 = ifelse(predmodel_1 > 0.5, 1, 0)

#Confusion Matrix for evaluating accuracy:
confusion_matrix = table(test_reg$Satisfaction, predmodel_1)
confusion_matrix

#Metrics:
#Recall: TP/(TP+FN)
recall = 14402/(14402+2817)
#Precision: TP/(TP+FP)
precision = 14402/(14402+2093)
#Accuracy: TP+TN/(T+N)
accuracy = (14402+20098)/(39410)
#F-measure: 2RP/(R+P)
fmeasure = 2*recall*precision/(recall+precision)


#ROC-AUC Curve
ROCPred <- prediction(predmodel_1, test_reg$Satisfaction) 
ROCPerf <- performance(ROCPred, measure = "tpr", x.measure = "fpr")

auc <- performance(ROCPred, measure = "auc")
auc <- auc@y.values[[1]]

#Plotting curve
library(pROC)
roc_curve = roc(test_reg$Satisfaction, predmodel_1)
plot(roc_curve, main = "ROC Curve - Binary Logit Model", 
     col = 'orange', type = 's',
     font.main = 1, cex.main = 0.85, cex.lab = 0.75, cex.axis = 0.6)

auc <- round(auc, 4)
legend(0.15,0.8, auc, title = "Area Under the Curve", cex = 0.7)

#Results:
#1.	About 77% of the passengers were 'Returning' type of passengers. From 1.3L passengers, 46% were 'Business Class' travellers, 42% were 'Economy Class' travellers and the remaining were 'Economy Plus Class' travellers. 
#2.	'Departure Delay' and 'Arrival Delay' had extremely high VIF values (close to 14) and hence, were dropped. The logit model after dropping these variables had a significantly higher AIC value.
#3.	Improving the ease of online boarding, their check-in services, on-board services and their in-flight WiFi service results in an 80%, 37%, 35% and 50% increase in the odds of customers feeling 'Satisfied'.  
#4.	Cleanliness only led to a 24% increase in getting a 'Satisfied' feedback and the 'Personal' type of travel led to 93% decrease in the odds of receiving a positive customer feedback. This can also be corroborated with the fact that majority of the passengers from this data were traveling for Business.
#5.	Some surprisingly insignificant factors in determining the overall satisfaction of passengers were gate's location, food and drink services, and the distance covered by the flight.
