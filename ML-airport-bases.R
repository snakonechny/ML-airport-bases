library(dplyr)

file.list <- as.list(list.files(pattern = '.csv'))

test <- read.csv('12-2014.csv', header = TRUE)
head(test)

master <- data.frame()

system.time(for (i in file.list) {
  temp <- read.csv(i, header = TRUE)
  temp <- temp %>% filter(UNIQUE_CARRIER == 'UA')
  
  master <- bind_rows(master, temp)
})

loader <- function(i) {
  temp <- read.csv(i, header = TRUE)
  temp <- temp %>% filter(UNIQUE_CARRIER == 'UA')
  master <- bind_rows(master, temp)
  return(master)
}

proc.time(lapply(X = file.list, FUN = loader))

write.csv(master, 'master.csv')
