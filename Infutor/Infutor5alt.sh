#!/bin/bash
#Currently 1 hour for 1mil so maybe 45 min for a loop of 250? 2019-09-04
rm -f explodedFiles.txt
rm -f cURL_log.txt
rm -f scrubtimes.txt
FRONT="curl  --insecure -X POST \
 https://104.152.217.28/api/services/CheckFTPFile \
  -H 'Content-Type: application/json' \
  -H 'Postman-Token: 1c9b6794-180f-4dc8-8079-81ed0c8eedaf' \
  -H 'cache-control: no-cache' \
  -d '{\
    \"Token\": \"Z1JHIf6CqMpEa1VMS34LHGCzvcQlQgjXs5XAE74x+2g+hojnXW5v+MoGkMQZvoGwNcYnWhbUnFwCWGFNYMI/eQ==\",\
  \"Options\":\
[\
\"Scrub_BotClickers\",\
\"Scrub_Bounces\",\
\"Scrub_Complainers\",\
\"Scrub_DepartmentalEmails\",\
\"Scrub_Disposables\",\
\"Scrub_DomainBlackList\",\
\"Scrub_ForeignDomains\",\
\"Scrub_Lashback\",\
\"Scrub_Litigators\",\
\"Scrub_ProofPoint\",\
\"Scrub_RealTraps\",\
\"Scrub_Seeds\",\
\"Scrub_ThreatEndings\",\
\"Scrub_ThreatString\",\
\"Scrub_Legacy2006\",\


    ],\
\"FileName\": \"OVERHAUL_"
MIDDLE="-"
END=".csv\",\
    \"HasHeader\": true,\
    \"IsMultiColumn\": false,\
}'"
MINI="OVERHAUL_"
MINI_END=".csv"
MAGIC_NUM=0
#!/bin/bash
proceed=false
printf "___________________________________________________________\n"
printf "Welcome to Infutor cURL processing!\n" 
printf "This program was written by Dave Babler dababler(a)outlook\n"
printf '%s\n' "-----------------------------------------------------------"
printf "Before proceeding verify that the following are done:\n"
printf "    1. The files are downloaded\n"
printf "    2. The files have been split into chunks of 5\n"
printf "    3. You are running this program from the directory holding the split files.\n"
printf "If those are done you may proceed\n"
printf "___________________________________________________________\n"
printf "\n"
printf "We need the smallest & largest numbers of the original Infutor files sent.\n"
printf "For example if they gave us OVERHAUL701 through OVERHAUL793:\n"
printf "    You would enter in for the smallest: 701\n"
printf "    for the largest: 793.\n"
printf "Note we are not using the split file numbers. Original file numbers only!\n"
printf "\n"
printf "\n"
printf "\n"
printf "\n"
printf "Please enter in that smallest number now.\n"
read -e smallest
printf "You have entered in $smallest as the smallest file number.\n"
printf "Please enter in the largest number now.\n"
read -e largest
printf "You have entered in $largest as the largest file number.\n"
let startNumber=$smallest
printf "starting number is $startNumber \n"
let loopStopper=$largest+1
printf "loopStopper is $loopStopper \n"
unzip \*.zip
VAR_FRONT="OVERHAUL_"
#VAR_CHANGE="_low"
VAR_END=".csv"
for (( i = $smallest; i < $loopStopper ; i++ ));
do
	#statements
	FULL="$VAR_FRONT$i$VAR_END" 
	#FINAL="$VAR_FRONT$i$VAR_CHANGE$VAR_END"
if [ -f "$FULL" ]
	then
		tr '[A-Z]' '[a-z]' < "$FULL" | sponge "$FULL"
		echo $FULL >> explodedFiles.txt
fi
done
for f in OVERHAUL_*.csv
do
    split -d -a1 -l500000 --additional-suffix=.csv "$f" "${f%.csv}-"
    rm "$f"
done
printf "___________________________________________________________\n"
printf "___________________________________________________________\n"
printf "___________________________________________________________\n"
printf "___________________________________________________________\n"
printf "___________________________________________________________\n"
printf "___________________________________________________________\n"
printf "STOP! UPLOAD EVERYTHING TO THE DIRTY FOLDER IN EHYGENICS\n"
printf "PLEASE PRESS Y TO CONTINUE \n"
while [ $proceed=false ]
do
read -r -p "Have you uploaded the files? [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]
then
	printf "\n"
	printf "cURL processing will begin shortly!\n"
    proceed=true
    break
else
	printf "\n"
	printf "Upload the files, or press ctrl+z to quit. \n"
	printf "If you quit besure to delete any unpacked csv files before running this program again!"
	printf "\n"
    proceed=false
fi
done
printf "___________________________________________________________\n"
sleep 1m

# for (( i = 0; i < 10; i++ )); do
# 	#statements
# 	FULL="$FRONT$i$END" 
# 	eval $FULL
# 	echo $FULL >> dat.text
# done

# printf "I am going to sleep for exactly 1 minute to prepare myself for curl Processing!\n"
# sleep 1m
# printf "done sleeping!\n"

let j=5  

for (( i = $startNumber; i < $loopStopper; i++ )); do

	SOMETHING="$MINI$i$MIDDLE$MAGIC_NUM$MINI_END"
	now=$(date +"%r")
	echo $SOMETHING
	echo "$SOMETHING began scrub $now" >> scrubtimes.txt
			#q to 2 because this is only a half split file instead of quarter or penta split
		for (( q = 0; q < 2; q++ )); do
			FULL="$FRONT$i$MIDDLE$q$END" 
			eval $FULL
			echo $FULL >> cURL_log.txt		
		done
		remainder=`expr $i % $j`
		if [ "$remainder" -eq "0" ]
		 then 
		 	printf "I am going to rest for 45 minutes"
			 sleep 60m
			echo "done sleeping!"
		fi
done
echo "successfull completion of program"
$SHELL
