#!/bin/bash
yandexText=`cat input.txt | sed 's/google/yandex/g'`

for line in $yandexText
do

shema=""
host="" 
port=""
unset array_keys
unset array_values

if [[ $line == *"://"* ]]; then
httpTmp=$(echo $line | cut -d':' -f1);
shema="Scheme: "$httpTmp"://";
lineWithoutShema=`echo $line |cut -d':' -f2- | cut -c 3-`
  else
  lineWithoutShema=$line
fi

if [[ $lineWithoutShema == *":"* ]]; then
hostTmp=$(echo $lineWithoutShema | cut -d':' -f1);
host="Host: "$hostTmp
lineWithoutShemaAndHost=`echo $lineWithoutShema |cut -d':' -f2-`
elif [[ $lineWithoutShema == *"/"* ]]; then
hostTmp=$(echo $lineWithoutShema | cut -d'/' -f1);
host="Host: "$hostTmp
lineWithoutShemaAndHost=`echo $lineWithoutShema |cut -d'/' -f2-`
else host="Host: "$lineWithoutShema
fi

if [[ $lineWithoutShemaAndHost =~ ^[0-9] ]]; then
portValue=`echo $lineWithoutShemaAndHost |grep -o '[0-9]*' | head -1`
fi
if [ -n "$portValue" ]; then
port="Port: "$portValue
fi

if [[ $line == *"?"* ]]; then
params=$(echo $line | cut -d'?' -f2 | sed 's/&/ /g');

index=0
for param in $params
do
array_keys[index]="Key: "$(echo $param | cut -d'=' -f1)
key="Key: "$(echo $param | cut -d'=' -f1)
array_values[index]="Value: "$(echo $param | cut -d'=' -f2)
index=$((index+1))
done
fi

length=${#array_keys[@]}

if [ -n "$shema" ]; then
echo $shema >> "output.txt"
fi

echo $host >> "output.txt"

if [ -n "$port" ]; then
echo $port >> "output.txt"
fi

if [ $length -gt 0 ]; then
echo "Args:" >> "output.txt"
for (( i=0; i < ${length}; i++ ))
do
 echo "  "${array_keys[$i]}"; "${array_values[$i]} >> "output.txt"
done
fi

echo >> "output.txt"

done 

