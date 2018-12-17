#Converts the outputs of the fitnesss peak count in REvoSim to a CSV to be read by R
sed "s/Fitness .*/Fitness,Cnt/g" -i ./*.txt
sed '/REvoSim/d;/=/d' -i ./*.txt
sed -r '/^\s*$/d' -i ./*.txt

