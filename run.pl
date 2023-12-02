use strict;
use warnings;
use Scalar::Util qw(looks_like_number);

my $input_day = $ARGV[0];
my ($current_year, $current_month, $current_day) = (`date +%Y`, `date +%m`, `date +%d`);

if (not defined $ARGV[0]){
  print("ERROR: no input provided!\n");
  exit;
}

if ($input_day > 25 || $input_day == 0){
  print("ERROR: day $input_day is not valid!\n");
  exit;
}

if ($current_year == 2023 && $current_month == 12 && $current_day < $input_day){
  print("ERROR: day $input_day not available yet!\n");
  exit;
}

if (not looks_like_number($input_day)) {
  print("ERROR: $input_day is not a number");
  exit;
}


system("perl src/day$input_day.pl < inputs/day$input_day.in");