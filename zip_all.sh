#A shell script for zipping all folders within a directory at the first level into individual .zips
for i in */; do zip -r "${i%/}.zip" "$i"; done
