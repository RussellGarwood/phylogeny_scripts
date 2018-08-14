# To run use: 
# Change directory to folder, e.g. setwd("/home/russell/Desktop/R_Plotting");
# source("Garwood_Dunlop_geoscale_script.r")
#If not installed, need install.packages(c("geoscale", "strap"), dependencies=TRUE)

# Load libraries
# note: we need to use our custom geoscale package v2.1 with ICS2018 included.
library(strap)

# Import tree data and taxa ages
matrix.ages <-read.csv("Garwood_Dunlop_chelicerate_matrix_development_Dates.csv", row.names=1)
matrix.strict.tree <- read.nexus("Garwood_Dunlop_chelicerate_matrix_development_consensus.nex")
matrix.ts.strict.tree <- DatePhylo(matrix.strict.tree,matrix.ages,rlen=1,method="equal")


pdf("r_tree.pdf")
#plot
geoscalePhylo(matrix.ts.strict.tree,ages=matrix.ages,
		#Units for tree
		units=c("Period", "Epoch"),
		#Direction if needed
		#direction="upwards"
		#Include grey boxes
		boxes="Epoch", 
		#Frequency of tips
		tick.scale = "Epoch",
		#size of tip labels		
		cex.tip = 0.4, 
		#size of text on scale bar
		cex.age = 0.3, 
		#size on timescale
		cex.ts = 0.3,
		#Width of the edges (lines) of the phylogeny
		width = 0.8,
		label.offset = 0.7
		)
dev.off()
svg("r_tree.svg")
geoscalePhylo(matrix.ts.strict.tree,ages=matrix.ages,
		#Units for tree
		units=c("Period", "Epoch"),
		#Direction if needed
		#direction="upwards"
		#Include grey boxes
		boxes="Epoch", 
		#Frequency of tips
		tick.scale = "Epoch",
		#size of tip labels		
		cex.tip = 0.4, 
		#size of text on scale bar
		cex.age = 0.3, 
		#size on timescale
		cex.ts = 0.3,
		#Width of the edges (lines) of the phylogeny
		width = 0.8,
		label.offset = 0.7
		)
dev.off()

#clean up
rm(matrix.ages)
rm(matrix.strict.tree)
rm(matrix.ts.strict.tree)
