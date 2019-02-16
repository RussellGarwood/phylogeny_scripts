# R script to calculate distances of simulated vs estimated trees. Written by J. Keating 2018.

library(phangorn)
library(stringr)

# Create blank data frame

distances <- data.frame("Tree" = 0, "RF_distance" = 0, "Partitions" = 0, "Correct_partitions" = 0, "Incorrect_partitions" = 0)
end = "Distances calculated!"
Pro = "Processing: Tree"
wd <- getwd()
wd_TNT <- paste(wd, "/TNT", sep = "")

# Begin forloop for 999 replicates

for(i in 0:999)
{
	pad<-str_pad(i, 6, pad = "0")
	cat(Pro, (sprintf("%d", i)))
	cat("\n")

	# read nexus tree files
    readSim <- paste("_TNTMB_", pad, ".nex", sep = "")
  	Sim_tre <- read.nexus(readSim) #  iterate over every sim tree, read nexus

  	setwd(wd_TNT)
  	readTNT <- paste("treesim_", i,"_POUT.nex", sep = "")
    TNT_list <- read.nexus(readTNT) # iterate over every mb tree, read nexus


    # unroot trees + remove singletons
	TNT_list <- unroot(TNT_list)
	Sim_tre <- unroot(Sim_tre)

	# produce 50% maj-rule consensus trees for EW parsimony trees

	con_TNT <- consensus(TNT_list, p= 0.5)

	# Calculate RF distances between the simulated (true) tree and the 50% majority rule conensus of TNT trees

	RF_dist <- RF.dist(Sim_tre, con_TNT)

	# Calculate the nuber of partitions of the 50% majority rule conensus tree

	Np_TNT <- (Ntip(con_TNT)-3) - ((Ntip(con_TNT)- 2) - Nnode(con_TNT))

	# Calculate the nuber of partitions of the simulated tree

	Np_sim <- (Ntip(Sim_tre)-3) - ((Ntip(Sim_tre)- 2) - Nnode(Sim_tre))

	# Calculate RFmax

	RF_max <- Np_TNT + Np_sim

    # Calculate the nuber of correct partitions in the 50% majority rule conensus tree

    correct_p <- 0.5*(RF_max - RF_dist)

    # Calculate the nuber of incorrect partitions in the 50% majority rule conensus tree

    incorrect_p <- Np_TNT - correct_p

    newrow <- data.frame("Tree" = pad, "RF_distance" = RF_dist, "Partitions" = Np_TNT, "Correct_partitions" = correct_p, "Incorrect_partitions" = incorrect_p)

    distances <- (rbind (distances, newrow))
    setwd(wd)

    cat("...\n")
	}
distances <- distances[-c(1), ]
rownames(distances) <- seq(length=nrow(distances))
write.csv(distances, file = "distances.csv")
cat(end)
