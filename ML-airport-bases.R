library(dplyr)

file.list <- list.files(pattern = '.csv')

test <- read.csv('12-2014.csv', header = TRUE)
head(test)

master <- data.frame()

for (i in file.list) {
  temp <- read.csv(i, header = TRUE)
  temp <- temp %>% filter(UNIQUE_CARRIER == 'UA')
  
  master <- bind_rows(master, temp)
}

write.csv(master, 'master.csv')
