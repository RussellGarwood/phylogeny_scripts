# A script by Russell Garwood, modified from one by Alan Spencer, for plotting time-scaled phylogenies in R
# To run use:
# Change directory to folder, e.g. setwd("/home/russell/Desktop/R_Plotting");
# source("Garwood_Dunlop_geoscale_script.r")
# If not installed, need install.packages(c("geoscale", "strap"), dependencies=TRUE)

# Load libraries
# note: we need to use our custom geoscale package v2.1 with ICS2018 included.
library(strap)

# Import tree data and taxa ages
matrix.ages <-read.csv("Garwood_Dunlop_chelicerate_dates_2020_Proschizomus_dates.csv", row.names=1)
#For bayesian analyses, to include poterior probabilities as node labels, the tree from MrBayes which needs to be importanted is the simple consensus (see pg 35 of manual)
##Eg sumt conformat=simple
##Change extension from .tre to .nex
##Remove that of the two trees you don't want (i.e. that without branch)
matrix.strict.tree <- read.nexus("Final_Bayes/simple_topology_run.con.nex")
matrix.ts.strict.tree <- DatePhylo(matrix.strict.tree,matrix.ages,rlen=1,method="equal")

pdf("R_tree_Bayesian.pdf")
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
		# Offset labels
		label.offset = 0.7,
		# Make non-talic
		font =1,
		#Remove quarternary labels
		quat.rm = TRUE,
		#Stretch X axis so taxon names are not cut off
		x.lim=c(500,-150)
		)

#Add node labels if required
nodelabels(matrix.ts.strict.tree$node.label, adj = c(-0.2, 0.5), frame = "none", cex=0.4)
dev.off()


#Now parsimony - export from tnt needs to be run through fig tree to get a taxon block and allow it to load
#This could actually be just the support values - no matter what, these do not seem to load - probably quickest to do them by hand. 
matrix.parsimony.ages <-read.csv("Garwood_Dunlop_chelicerate_dates_2020_Proschizomus_dates_parsimony.csv", row.names=1)
matrix.parsimony.tree <- read.nexus("Final_support_no_bremmer/Equal_weights_with_supports_figtree.nex")
matrix.ts.parsimony.tree <- DatePhylo(matrix.parsimony.tree,matrix.parsimony.ages,rlen=1,method="equal")

pdf("R_tree_parsimony.pdf")
#plot
geoscalePhylo(matrix.ts.parsimony.tree,ages=matrix.parsimony.ages,
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
              # Offset labels
              label.offset = 0.7,
              # Make non-talic
              font =1,
              #Remove quarternary labels
              quat.rm = TRUE,
              #Stretch X axis so taxon names are not cut off
              x.lim=c(500,-150)
)

#Add node labels if required
#nodelabels(matrix.ts.strict.tree$node.label, adj = c(-0.2, 0.5), frame = "none", cex=0.4)

dev.off()

#clean up
rm(matrix.ages)
rm(matrix.strict.tree)
rm(matrix.ts.strict.tree)
rm(matrix.parsimony.ages)
rm(matrix.parsimony.tree)
rm(matrix.ts.parsimony.tree)
