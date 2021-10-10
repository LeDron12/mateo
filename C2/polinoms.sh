#!/bin/bash

i=0
x=0
res=0
if [[ -z "$1" ]]
then
	echo "You have to give input file"
	exit 1
fi
while read el
do
	if [[ i -gt 0 ]]
	then
		res=$((res + el * x ** (i - 1)))
	fi
	if [[ i -eq 0 ]]
	then
		x=$((el + 0))
	fi
	i=$((i + 1))
done < $1
if [[ i -gt 1 ]]
then
	res=$(($res % (10**9 + 7)))
	echo "result = $res" 
	echo "$res" > output.txt
else
	echo "Not enough input parameters"
fi
