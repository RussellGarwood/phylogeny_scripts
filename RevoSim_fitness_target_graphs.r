#An R script by Russell Garwood which takes a modified output from peak counting in REvoSim and graphs the number of organisms with peak fitness for all potential fitness targets.

#Set working directory as required

#Libraries for graphing
library(ggthemes)
library(ggplot2)
#Library for string manipulation
library(stringr)

##Input

#List files
listoffiles<-list.files(getwd())

#Make a list of paths
mypaths<-str_c(getwd(),'/',listoffiles)

#Create list in which to put fitnesses
fitness_list<-list()

#Assemble list from CSVs, second column
for (i in 1:length(mypaths))
{
        file<-read.csv(mypaths[i])
        #Add to a temporary data frame so the target can be added easily as a column - this is useful for the graphig later
        temp_data_frame<-rbind(i,file[2])
        #Add to list
        fitness_list[i]<-temp_data_frame
}

#Throw this into a dataframe - bind as rows so ultimately #of organisms of fitness f form columns
fitness_dataframe<-do.call("rbind",fitness_list)

#For easer of graphing need to label columns. Doing this straight as character strings throws an error.
# FOund that to Label columns as numbers first then allows them to be renamed.
colnames(fitness_dataframe) <- c(1:17)

#Then modify these to full string - this can’t be done without above step
#First column ois fitness target
colnames(fitness_dataframe)[1] <-paste("Target")
#Next are fitnesses from 0 --> 15 (note this is 16 here because of C numbering)
for (i in 2:17) colnames(fitness_dataframe)[i] <-paste("Fitness",i-1)

#As en exmaple, to isolate Fitness of 16:
#fitness_dataframe[,"Fitness 16"]

#For some reason need to put into a new dataframe for plotting
fitness_dataframe_plot<-data.frame(fitness_dataframe)

## Plotting this data is now possible

#FIrst highlight default target to allow it to be plottedf separately
fitness_dataframe_plot$target <- "False"
fitness_dataframe_plot[66,]$target <- "True"

#Plot with points using default colours
ggplot(fitness_dataframe_plot) + geom_point(aes(x=Target, y=Fitness.16, colour=target)) + ylab("Genomes at peak fitness")
#Save as PDF in working directory
ggsave("Target_graph_default_colours.pdf")

#Then use custom colours and shaopes
ggplot(fitness_dataframe_plot,aes(x=Target, y=Fitness.16)) + geom_point(data=fitness_dataframe_plot[fitness_dataframe_plot$target == "False",], colour="black") + geom_point(data=fitness_dataframe_plot[fitness_dataframe_plot$target == "True",],color="darkred",shape=8, size=3) + ylab("Genomes at peak fitness")
ggsave("Target_graph_custom_colours.pdf")

#Done
