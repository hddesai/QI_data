library(dplyr)
library(readxl)

#read in excel data
case_data <-read_xlsx(file.choose())


#what are the column names?
names(case_data)

#subset the data based on year and critical and non time critical cases
case_2015_2017 <- subset(case_data, birth_year<2016 | birth_year >=2017)
case_2015_2017.1 <- subset(case_2015_2017, time_critical == TRUE)
case_2015_2017.2 <- subset(case_2015_2017, time_critical == FALSE)

#divide the data into 2015 and 2017
sub_test<-case_2015_2017.1[which(case_2015_2017.1$birth_year==2015),]
sub_test.2<-case_2015_2017.1[which(case_2015_2017.1$birth_year==2017),]

#replace NULL with 0 to do statistical testing 
sub_test[sub_test == "NULL"] <- 0 
sub_test.2[sub_test.2 == "NULL"] <- 0 
sub_test$intervention_interval_days <-as.numeric(sub_test$intervention_interval_days)
sub_test.2$intervention_interval_days <-as.numeric(sub_test.2$intervention_interval_days)

#display some of the data in data frame 
head(sub_test);head(sub_test.2)

#two sample t test
t.test(sub_test$intervention_interval_days, sub_test.2$intervention_interval_days)

#did not work because | means or 
#test <- subset(case_data, case_data$birth_year<2016 | case_data$initial_specimen_collection_interval_hrs<7)
