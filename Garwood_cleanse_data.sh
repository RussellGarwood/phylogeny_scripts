#A script by Russell Garwood which removes certain taxa from his Arachnid phylogeny prior to analysis
#Currently Callum amlbypygids and Gonzalo living terminals, plus phalangiotarbids
sed '/_CMcL/d;/_GG/d;/Goniotarbus/d;/Bornatarbus/d' -i ./Garwood_Dunlop_chelicerate_matrix_development.tnt
sed '/_CMcL/d;/_GG/d;/Goniotarbus/d;/Bornatarbus/d' -i ./Garwood_Dunlop_chelicerate_matrix_development_Dates.csv
