rm(list = ls())

library(ggplot2)
library(dplyr)
library(readr)
library(reshape2)


#DfE
dfe_publications <- read_csv("Data/dfe_publicationsMonth.csv") %>%
  mutate(Year = substring(Date,1,4)) 
dfe <- dfe_publications[c(1,3,2)] %>% arrange(Date) %>% mutate(Month_number = 0)

#fill in week numbers for each year 
dfe$Month_number <- sequence(rle(dfe$Year)$length)

x <- seq(0,12, by = 1)
y <- seq(0,20, by = 5)

ggplot(dfe, aes(Month_number, number)) + 
  geom_line(color = "steelblue4", size = 1) + 
  facet_wrap(~Year) +
  coord_cartesian(ylim = c(0,20)) +
  scale_y_continuous(breaks = y) +
  scale_x_continuous(breaks = x) +
  xlab("Month Number") +
  ylab("Number of publications") +
  ggtitle("DfE Publications on www.gov.uk/government/publications by week")+
  theme_minimal()

#ALL DEPARTMENTS
all_publications <- read_csv("Data/all_publications.csv")
all_from2010 <- filter(all_publications, Date > '2010-01-03') %>%
  mutate(Year = substring(Date,1,4)) 
all <- all_from2010[c(1,3,2)] %>% arrange(Date) %>% mutate(Week_num = 0)

#fill in week numbers for each year
all$Week_num <- sequence(rle(all$Year)$length)

y <- seq(0,80, by = 10)

ggplot(all, aes(Week_num, number)) + 
  geom_line(color = "tomato", size = 1) + 
  facet_wrap(~Year) +
  coord_cartesian(ylim = c(0,80)) +
  scale_y_continuous(breaks = y) +
  xlab("Week number") +
  ylab("Number of publications")+
  ggtitle("All UK publications on www.gov.uk/government/publications by week") +
  theme_minimal()

rm(list = ls())

