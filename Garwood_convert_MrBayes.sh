sed 's/[/(/g' -i ./Garwood_Dunlop_chelicerate_matrix_development_bayes.nex
sed 's/]/)/g' -i ./Garwood_Dunlop_chelicerate_matrix_development_bayes.nex
sed 's/nstates nogaps;/#NEXUS/g' -i ./Garwood_Dunlop_chelicerate_matrix_development_bayes.nex
sed 's/xread/BEGIN DATA;\nDIMENSIONS NTAX=XXX NCHAR=XXX;\nFormat datatype=standard interleave=no GAP=- MISSING=? ;\n\nMATRIX\n/g' -i ./Garwood_Dunlop_chelicerate_matrix_development_bayes.nex
sed 's/ccode [-.;/END;/g' -i ./Garwood_Dunlop_chelicerate_matrix_development_bayes.nex
