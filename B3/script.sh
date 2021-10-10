#!/bin/bash
inputFile=input.txt
outputFile=output.txt
[ -f "$inputFile" ] || { echo "$inputFile doesn't exist"; exit; }
[ -w `pwd` ] || { echo "NOT WRITABLE DIRECTORY"; exit; }
count=$(head -1 "$inputFile")
con=$(tail -1 "$inputFile")
if [ "$con" = "date" ]
then 
head -$(( $count+1 )) "$inputFile" | tail -$count | sort -k5,5 -k4,4 -k3,3 -k2,2 -k1,1 | awk '{printf "%s %s %s.%s.%s\n",$1, $2, $3, $4, $5}'>"$outputFile"
elif [ "$con" = "name" ]
then 
head -$(( $count+1 )) "$inputFile" | tail -$count | sort -k2,2 -k1,1 -k5,5 -k4,4 -k3,3 | awk '{printf "%s %s %s.%s.%s\n",$1, $2, $3, $4, $5}'>"$outputFile"
else 
echo "error"
fi
