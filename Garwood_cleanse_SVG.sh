#A script by Russell Garwood whch cleans up SVGs from TNT and R for inclusion in papers 
sed 's/ RGJD//g' -i ./R_tree_cleaned.svg
sed 's/\.\.\./†/g' -i ./R_tree_cleaned.svg
