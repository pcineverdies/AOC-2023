re='^[0-9]+$'
if ! [[ $1 =~ $re ]] ; then
   echo "error: Input is not a number " >&2; exit 1
fi

if (($1 > 25)) ; then
   echo "error: $1 is not a day in AOC" >&2; exit 1
fi

perl src/day$1.pl < inputs/day$1.in