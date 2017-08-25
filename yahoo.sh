#! /bin/bash

rm -rf "yahoo.csv"
rm -rf "SPY.csv"
python get-yahoo-quotes.py SPY
awk -F"," 'BEGIN { OFS = "," } {$1="'SPY', "$1; print}' SPY.csv >> yahoo.csv
rm -rf "SPY.csv"


  FILE="stocks.csv"

  exec 0<"$FILE"
  n=0
  while read -r symbol
  do
    echo "${symbol}"
    rm -rf "{symbol}.csv"
python get-yahoo-quotes.py $symbol
sed '1d' -i $symbol.csv
awk -F"," 'BEGIN { OFS = "," } {$1="'$symbol', "$1; print}' $symbol.csv >> yahoo.csv
echo 'BEGIN { OFS = "," } {$1='$symbol'", "$1; print}'

   rm -rf "${symbol}.csv"
  done
