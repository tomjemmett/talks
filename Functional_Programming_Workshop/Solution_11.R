# Solution 11:

library(tidyverse)

x <- c(1:10, NA)

mean_na_rm <- partial(mean, na.rm = TRUE)

mean_na_rm(x)
