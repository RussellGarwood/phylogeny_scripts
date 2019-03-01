for d in $(find ./ -maxdepth 1 -type d)
do
    wd=$(pwd)
    if [[ -d $d/TREvoSim_output/ ]];
    then
        echo -e "Entered folder: "
        cd $d/TREvoSim_output/
        pwd

        echo "Making tnt folder and placing modified batch script in it."
        mkdir tnt
        echo -e "mxram 1500\nmacro =;" >> ./tnt/TREvoSim_batch_modified.run
        cat ./TREvoSim_batch.tnt >> ./tnt/TREvoSim_batch_modified.run
        echo -e "\n\nmacro -;\n\nz" >> ./tnt/TREvoSim_batch_modified.run

        echo "Moving into tnt folder and running parsimony searches."
        cd tnt
        /home/russell/Desktop/Work/tnt64-no-tax-limit/tnt p ./tnt/TREvoSim_batch_modified.run

        echo "Done TNT searches"
    fi    
    cd $wd
done
