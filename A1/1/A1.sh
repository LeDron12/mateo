#!/bin/bash

way="input.txt"
char=0

wc $way > list
read lines words characters < list
lines=$lines 
words=$words

while read y; do
alpabet=`echo $y | grep -o '[a-zA-Z]' | wc -l`
char=$(($char + $alpabet))
done <<<$(cat $way)

echo -e "Input file contains: \n$char letters \n$words words \n$lines lines" >> output.txt

  #!/bin/bash
  #printf "Input file contains" >> file1.txt
  #var1 = (wc -l /file.txt) // количество строк в файле
  #var2 = (wc -w /file.txt) // количeство слов в файле
  #var 3 = cut file.txt |tr -d " "| wc -m // количество символов в файле
  #echo "$_Var1 $_var2 $_var3" >> ./file1.txt