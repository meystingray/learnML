#file:///U:/GitHub/rstudio-conf-2019/Materials/Part_5_Classification.html#1
# These data contains several types of fields:

#a number of open text essays related to interests and personal descriptions
#single choice type fields, such as profession, diet, gender, body type, etc.
#multiple choice data, including languages spoken, etc.
#We will try to predict whether someone has a profession in the STEM fields 
# (science, technology, engineering, and math) using a random sample of the overall dataset.

rm(list = ls())
load("U:/GitHub/rstudio-conf-2019/Materials/Data/okc.RData")
summary(okc_test)

table(okc_train$Class)

# class is too imbalanced - need to resample to avoid overfitting
