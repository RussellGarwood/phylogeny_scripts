#Script to extract steppiness of TreeSim curves
#Set the following lines and then select everything and run it in RStudio (control-enter)
#This will then output a plot of the data (the same name as the data file, but with suffix _plot.pdf) and a tab delimited file with the steppiness data (suffix _steps.tsv)
#adjust the following line to the the path to the data file
path <- "~/Dropbox (The University of Manchester)/knightmareDocs/oddments/treeSim/TreeSim_species_curve_batch.txt"
#if you don't want a saved version of the plot, set this to FALSE (will always plot within R)
pic <- TRUE
#if you don't want a saved version of the steppiness etc., set this to FALSE
fileSave <- TRUE

#leave everything beyond here as it is, just highlight it all and run (control-enter)
############
stpness <- function(path, pic = TRUE, fileSave = TRUE){
if(!require(dplyr)){install.packages("dplyr")
  library(dplyr)}
if(!require(tidyr)){install.packages("tidyr")
  library(tidyr)}
if(!require(ggplot2)){install.packages("ggplot2")
  library(ggplot2)}
if(!require(purrr)){install.packages("purrr")
  library(purrr)}
if(!require(readr)){install.packages("readr")
  library(readr)}
if(!require(stringr)){install.packages("stringr")
  library(stringr)}

datafile <- str_split(path, "/") %>% unlist() %>% tail(1)
workingDir <- str_replace(path,datafile,"")

setwd(workingDir)
dl <- readLines(datafile)

#in principle can recognise things by colons, but for the timebeing its hard coded lines
d <- as_data_frame(do.call(rbind, strsplit(dl[4:length(dl)],split="\t")))
names(d) <- make.names(unlist(strsplit(dl[3],"\t")))

#deal with parameters, currently have a stray underscore which needs removing explicitly:
dp0 <- str_split(dl[1], pattern = ": ")[[1]][2] %>%
  str_replace("species_difference_", "species_difference ") %>%
  str_split(pattern = " ") %>%
  unlist()
#can't work out how to pipe this through - end up without a column name, which then becomes problematic for spreading
dp <- data_frame(dp=dp0) %>%
  mutate(header = rep(c("variable", "value"), length.out=n()),
         pair = rep(1:(n()/2), each = 2)) %>%
  spread(key = header,value = dp) %>%
  select(variable, value) %>% #stop at this point if one wants a nice table
  spread(key = variable, value = value) %>%
  mutate(dummy =1)

#pull together data, not yet including parameters
ds <- d %>%
  mutate(run = 1:n()) %>%
  gather(key = "species", value = "iteration", - run) %>%
  mutate(species_no = species %>% str_replace("X", "") %>% as.numeric(),
         iteration = iteration %>% as.numeric())

# Plot out
p <- ggplot(ds, aes(x=iteration, y= species_no, colour=factor(run)))

p + 
  geom_line() +
  scale_y_continuous("Species count") +
  scale_color_discrete(guide=FALSE) +
  theme_classic()
outPic <- str_split(datafile, "\\.") %>% 
  map_chr(1) %>%
  paste("_plot.pdf", sep = "")
if(pic) ggsave(outPic, width=7, height = 7) 

#define functions to fit linear models and pull out relevant statistics from those models
model <- function(dat) {lm(iteration ~ species_no-1, data=dat)} #fit the line through the origin the 'wrong' way round - time as a function of species count
sar <- function(ag){sum(abs(ag$.resid))} #in this case, the sum of absolute residuals should be the area between the curve and the steppy line
r2 <- function(gl){ gl$r.squared} # A more traditional measure of 'steppiness' the proportion of variance explained by a straight line
slp <- function(td){td$estimate}#in case the slope is of interest

#create a new data frame with one row per wiggly line, but with all the data for that line in a single cell of that row, a fitted model in another column and the vital statistics of that model in some more columns, coming down to single numbers for the ones of interest
dg <- ds %>%
  group_by(run) %>%
  nest(.key = data) %>%
  mutate(mod = data %>% map(model),
         glance= mod %>% map(broom::glance),
         tidy= mod %>% map(broom::tidy),
         augment = mod %>% map(broom::augment),
         r2 = glance %>% map_dbl(r2),
         steppiness = 1-r2,
         # steppinessB = 1/r2,
         # sar = augment %>% map_dbl(sar),
         speed = tidy %>% map_dbl(slp) %>% map_dbl(function(x) 1/x),
         dummy = 1
  ) %>%
  left_join(dp) %>%
  select(-c(dummy, data, mod, glance, tidy, augment, r2))

#write out table
outNm <- str_split(datafile, "\\.") %>% 
  map_chr(1) %>%
  paste("_steps.tsv", sep = "")

if(fileSave) write_tsv(dg,outNm)

#other plots one might consider
# ggpairs(dg, columns = match(c("r2", "steppinessA", "steppinessB", "sar", "slowness"), names(dg)))

# p2 <- ggplot(dg, aes(x= speed, y= steppiness))
# 
# p2 +
#   geom_point() +
#   theme_classic()
}
########
stpness(path = path, pic = pic, fileSave = fileSave)


