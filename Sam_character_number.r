
#To run in R source("Sam_character_number_script.r")
#Set up file for writing
outFile<-file("_batch_modified.tnt","a")
#Read file in vector
textLines <- readLines("_batch.nex")
#Loop through vector
for (currentLine in textLines)
{
  if (!startsWith(currentLine, ("1024"))&!startsWith(currentLine, ("Species_")))writeLines(currentLine,outFile)
}
close(outFile)
