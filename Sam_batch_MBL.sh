#A shell script which modified TREvoSim and TNT output files using GSED before loading an R script to calculate distances - by Russell Garwood 2018
#Place this in TREvoSim output folder
#Format trees so they can be loaded in R using ape
echo "Starting sed in"
pwd
sed -i $'s/S_0//g' _TNTMB_*
sed -i $'s/S_//g' _TNTMB_*
echo "Completed sed in root folder. Now moving into TNT."
#Move into TNT subfolder
cd TNT/
echo "Entered folder:"
pwd
echo "Renaming files:"
for f in *.tre; do
    mv -- "$f" "${f%.tre}.nex"
done
echo "Done renaming"
sed -i $'s/end ; /end;/g' *_POUT.nex
sed -i $'s/begin trees ;/begin trees;\\\ntranslate\\\n1 Species_0,\\\n2 Species_1,\\\n3 Species_2,\\\n4 Species_3,\\\n5 Species_4,\\\n6 Species_5,\\\n7 Species_6,\\\n8 Species_7,\\\n9 Species_8,\\\n10 Species_9,\\\n11 Species_10,\\\n12 Species_11,\\\n13 Species_12,\\\n14 Species_13,\\\n15 Species_14,\\\n16 Species_15,\\\n17 Species_16,\\\n18 Species_17,\\\n19 Species_18,\\\n20 Species_19,\\\n21 Species_20,\\\n22 Species_21,\\\n23 Species_22,\\\n24 Species_23,\\\n25 Species_24,\\\n26 Species_25,\\\n27 Species_26,\\\n28 Species_27,\\\n29 Species_28,\\\n30 Species_29,\\\n31 Species_30,\\\n32 Species_31;\\\n/g' *_POUT.nex
echo "Completed sed in TNT folder."
# Go up a folder then exectue r script
cd ..
echo "Back in root now executing R script."
Rscript Sam_script.r
echo "Done."
