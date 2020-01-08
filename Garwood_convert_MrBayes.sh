#A script by Russell Garwood that uses sed to convert data in TNT format to a format which can be run in MrBayes. 
sed 's/\[/(/g' -i ./"Garwood_Dunlop_chelicerate_matrix_development - Matrix - Jul 19.txt"
sed 's/]/)/g' -i ./"Garwood_Dunlop_chelicerate_matrix_development - Matrix - Jul 19.txt"
sed 's/nstates nogaps;/#NEXUS/g' -i ./"Garwood_Dunlop_chelicerate_matrix_development - Matrix - Jul 19.txt"
sed 's/xread/BEGIN DATA;\nDIMENSIONS NTAX=XXX NCHAR=XXX;\nFormat datatype=standard interleave=no GAP=- MISSING=? ;\n\nMATRIX\n/g' -i ./"Garwood_Dunlop_chelicerate_matrix_development - Matrix - Jul 19.txt"
sed 's/ccode (-.;/END;/g' -i ./"Garwood_Dunlop_chelicerate_matrix_development - Matrix - Jul 19.txt"
