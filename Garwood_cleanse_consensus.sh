#A script by Russell Garwood which modifies the consensus trees from MrBayes to allow them to be loaded in R
sed 's/_GG/-GG/g' -i ./Garwood_Dunlop_chelicerate_matrix_development_consensus.nex
sed 's/ //g' -i ./Garwood_Dunlop_chelicerate_matrix_development_consensus.nex
sed 's/begintrees;/begin trees;/g' -i ./Garwood_Dunlop_chelicerate_matrix_development_consensus.nex
sed 's/treetnt_1=[&U]/tree tnt_1 = [&U];/g' -i ./Garwood_Dunlop_chelicerate_matrix_development_consensus.nex

