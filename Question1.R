#I have read and understood the sections of plagiarism in the College Policy on assessment offences and confirm that the work is my own, with the work of others clearly acknowledged.
#I give my permission to submit my work to the plagiarism testing database that the College is using and test it using plagiarism detection software, search engines or meta-searching software.
library(fpp3)
library(tidyverse)
library(tsibble)
library(fable)
library(feasts)       

#1)
#Loading the Question1Data.csv file.

data_Question1Data <- read_csv("Question1Data.csv")
print(data_Question1Data)


#2)
#Converting the column A into a Date type, hint review look at the help for ymd().
#To use ymd() function we need to add the 'lubridate' package. 
library(lubridate)
# function ymd()-Frequency: Daily.

data_converted <- data_Question1Data %>%
  mutate( date = ymd(A))

print(data_converted)

#3)
#Converting to a tsibble using the appropriate field as an index.
#The date column is the most suitable column for the index 
#because it shows the date in ymd format.
# using as_tsibble() to convert the 'date' column as an index.

tsibble_data <- data_converted %>%
  select(-A) %>%
  as_tsibble( index = date)

print(tsibble_data)

#4) Writing a script to determine which columns are white noise.
#If its value are independent, then this time series is considered white noise.
#"for white noise must lie within ±1.96/√T."
#To check if the time series is a White Noise, it is neccesary to do the ACF plot.

aB <- tsibble_data %>%
  ACF(B) %>%
  autoplot()

plot(aB)


aC <- tsibble_data %>%
  ACF(C) %>%
  autoplot()

plot(aC)


aD <- tsibble_data %>%
  ACF(D) %>%
  autoplot()

print(aD)


aE <- tsibble_data %>%
  ACF(E) %>%
  autoplot()

print(aE)

adate <- tsibble_data %>%
  ACF(date) %>%
  autoplot()

print(adate)



#5) Creating a copy of the tstibble and removing all the identified white noise columns.

#The B and E are identified the white noise columns. 

no_white_noise <- tsibble_data %>%
  select(-B , -E)

print(no_white_noise)

#6) Converting this copy to a weekly tsibble object.

weekly_tsibble <- no_white_noise %>%
  index_by(weekly_date = yearweek(date)) %>%
  summarise(
    C = sum(C),
    D = sum(D)
  )

plot(weekly_tsibble)


#7) Creating separates time series plots:

#a) Weekly Time Series for C column

time_series_C <- weekly_tsibble %>%
  autoplot(C) +
  labs( y="C Value", title= "C Weekly Time Series")

plot(time_series_C)

#b) Weekly Time Series for D column

time_series_D <- weekly_tsibble %>%
  autoplot(D) +
  labs( y="D Value", title= "D Weekly Time Series")

plot(time_series_D)




