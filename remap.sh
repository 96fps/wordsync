#!/bin/bash
mydir=$(mktemp -d "${TMPDIR:-/tmp/}$(basename $0).XXXXXXXXXXXX")


if test "$#" -lt 2; then
    echo "Illegal number of parameters"
    echo "expected a .wav file and .csv mapping"

else
output="out.wav"
if test "$#" = 3; then
    echo "outputing to file: $3"
  output="$3"

fi
word=0
dur=0
pe1=0
pe2=0
while IFS=, read -r col1 s1 e1 s2 e2
do
  ((word=word+1))


  n="$(printf "%04d\n" $word )"

if (( $(echo "$pe1 > $s1" | bc -l) ))
then
  s1=$pe1
fi

if (( $(echo "$pe2 > $s2" | bc -l) ))
then
  s2=$pe2
fi

  d1="$(echo  "0 - $s1 + $e1"  | bc)"
  d2="$(echo  "0 - $s2 + $e2"  | bc)"


  #gap since end of last sound
  pad1="$(echo  "0 - $pe1 + $s1"  | bc)"
  pad2="$(echo  "$s2-$pe2"  | bc)"
  
  
  de1="$(echo  "$d1 * 1.5"  | bc)"
  de2="$(echo  "$d2 * 1.5"  | bc)"

  tempo="$(echo  "$d1 / $d2"  | bc -l)"

pad=$(printf '%0.1s' " "{1..60})
  # printf "%02d %s" $word $col1 

#   printf " %s" $col1 
# printf '%*.*s' 0 $((8 - ${#col1} )) "$pad"
#  printf " +%.2f :%.2f×\n" $pad2 $tempo

printf "."
  sox $1 -p trim $s1 $de1 \
  | sox - -p tempo -s $tempo \
  | sox - -p trim 0 $d2 \
  | sox - "$mydir/part_$n.wav" pad $pad2



#update previous entry
  pe1="$e1"
  pe2="$e2"
  

done < $2
 # "$mydir/mapi.csv"

printf "\n"
echo "Merging clips"
sox "$mydir/part_*.wav" $output
echo "Completed! see $output"
fi