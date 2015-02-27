#! /bin/bash

  FILE="sp500.csv"

  exec 0<"$FILE"
  n=0
  while read -r symbol
  do
    echo "${symbol}"
    rm -rf "temp.csv"
    curl -o temp.csv "http://financials.morningstar.com/ajax/exportKR2CSV.html?t=${symbol}"

sed '1d 
2d 
19d 
20d 
21d 
31d 
32d 
41,65d
 72d
 73d
 74d
 95d
 96d
 101d 
102d 
103d' -i temp.csv

awk -F"," 'BEGIN { OFS = "," } {$1="'$symbol', "$1; print}' temp.csv >> morn.csv
echo 'BEGIN { OFS = "," } {$1='$symbol'", "$1; print}'

   rm -rf temp.csv
  done
