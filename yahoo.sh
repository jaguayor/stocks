#! /bin/bash

rm -rf "temp.csv"
curl -o temp.csv "http://real-chart.finance.yahoo.com/table.csv?a=02&b=13&c=1986&d=01&e=26&f=2015&g=m&ignore=.csv&s=SPY"
awk -F"," 'BEGIN { OFS = "," } {$1="'SPY', "$1; print}' temp.csv >> yahoo.csv


  FILE="sp500.csv"

  exec 0<"$FILE"
  n=0
  while read -r symbol
  do
    echo "${symbol}"
    rm -rf "temp.csv"
    curl -o temp.csv "http://real-chart.finance.yahoo.com/table.csv?a=02&b=13&c=1986&d=01&e=26&f=2015&g=m&ignore=.csv&s=${symbol}"
sed '1d' -i temp.csv
awk -F"," 'BEGIN { OFS = "," } {$1="'$symbol', "$1; print}' temp.csv >> yahoo.csv
echo 'BEGIN { OFS = "," } {$1='$symbol'", "$1; print}'

   rm -rf temp.csv
  done
