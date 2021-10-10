#!/bin/bash

INPUT="./input.txt"
OUTPUT="./output.txt"

if [ ! -f $INPUT ];
then
  echo "No input.txt file found"
  exit 0
fi

while IFS= read -r line
do
  LINK="$(echo $line | sed -e 's/google/yandex/')"
  SCHEME="$(echo $LINK | grep :// | sed -e's,^\(.*://\).*,\1,g')"
  URL="$(echo ${LINK/$SCHEME/})"
  HOST="$(echo ${URL} | cut -d/ -f1 | sed -e 's,:.*,,g')"
  PORT="$(echo ${URL} | cut -d/ -f1 | sed -e 's,^.*:,:,g' -e 's,.*:\([0-9]*\).*,\1,g' -e 's,[^0-9],,g')"
  QUERY_STRING="$(echo $URL | grep / |cut -d/ -f2- | sed -e 's/^?//')"
  PARAMS=(${QUERY_STRING//[=&]/ })
  if [ ! -z "$SCHEME" ]
  then echo "Scheme: $SCHEME" >> $OUTPUT
  fi
  if [ ! -z "$HOST" ]
  then echo "Host: $HOST" >> $OUTPUT
  fi
  if [ ! -z "$PORT" ]
  then echo "Port: $PORT" >> $OUTPUT
  fi
  if [ ! -z "$PARAMS" ]
  then
      echo "Args:" >> $OUTPUT
      for (( index=0; index<${#PARAMS[@]}; index+=2 ));
      do
        echo "  Key: ${PARAMS[index]}; Value: ${PARAMS[index+1]}" >> $OUTPUT
      done
  fi

  echo "" >> $OUTPUT
done < "$INPUT"
