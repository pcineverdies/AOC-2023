use warnings; use strict;
use List::Util qw(max);

# Results
my ($sum_values_part_1, $sum_values_part_2) = (0, 0);

# For each game
while(<>){

  # Find max value of extraction for each color
  my ($red_value_max, $blue_value_max, $green_value_max) = (max(/ (\d+) red/g), max(/ (\d+) blue/g), max(/ (\d+) green/g));

  # Update for part 1 if the game is compliant
  $sum_values_part_1 += ($_ =~ /(\d+)/g)[0] if($red_value_max <= 12 && $blue_value_max <= 14 && $green_value_max <= 13);

  # Update for part 2
  $sum_values_part_2 += ($red_value_max * $green_value_max * $blue_value_max);

}

print "------- RESULT PART 1 -------\n$sum_values_part_1\n";
print "------- RESULT PART 2 -------\n$sum_values_part_2\n";