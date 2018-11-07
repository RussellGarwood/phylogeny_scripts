#To run in R source("Sam_character_number_script.r")

#Check for stringr
#if(!require(stringr)){install.packages("stringr")
#  library(stringr
#Originally included for:
#str_replace(currentLine,"1024 ",characterNumberChar);

#Set up file for writing
outFile<-file("_batch_modified.tnt","a");
#Read file in vector
textLines <- readLines("_batch.tnt");

characterNumberChar <- readline(prompt="How many characters would you like?");
characterNumberInt <- as.numeric(characterNumberChar);
#Loop through vector

count = 0;
for (currentLine in textLines)
{

  # Fix character line
  if (startsWith(currentLine, ("1024 ")))
  {
    count <- count+1;
    #gsub("1024",characterNumberChar,currentLine);
    currentLine=paste(characterNumberChar,"32");
    print(paste("Currently processing dataset:",count));
  }
  #Fix data line
  if (startsWith(currentLine, ("Species_")))
  {
    position <- regexpr(" 0", currentLine);
    if (position<0)position <- regexpr(" 1", currentLine);
    currentLine = substr(currentLine, 1, (position+characterNumberInt));
  }

  #Write line to new file
  writeLines(currentLine,outFile)
}
close(outFile)
