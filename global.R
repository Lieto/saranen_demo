library(dplyr)

source('./renderChart3.R')

# Data loading, cleaning and processing
galton <- read.csv("http://blog.yhathq.com/static/misc/galton.csv",
                   header = TRUE, stringsAsFactors = FALSE)
# Convert inches to centimeters
galton <- galton %>% mutate(child = child * 2.54)
galton <- galton %>% mutate(parent = parent * 2.54)

#Linear model
lmGalton <- lm(child ~parent, data = galton)
