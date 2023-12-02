use warnings;
use strict;
use List::Util qw(max);

# Results
my ($sum_values_part_1, $sum_values_part_2) = (0, 0);

# Maximum number of cubes according to part 1
my ($max_red_allowed, $max_green_allowed, $max_blue_allowed) = (12, 13, 14);

# For each game
while(<>){

  # Extract id of the game
  my ($game_number, $current_game) = (split (/:/, $_, 2));
  $game_number = (split(" ", $game_number))[1];

  # Find max value of extraction for each color
  my ($red_value_max, $blue_value_max, $green_value_max) = (max(/ (\d+) red/g), max(/ (\d+) blue/g), max(/ (\d+) green/g));

  # Update for part 1 if the game is compliant
  if($red_value_max <= $max_red_allowed && $blue_value_max <= $max_blue_allowed && $green_value_max <= $max_green_allowed){ 
    $sum_values_part_1 += $game_number;
  }

  # Update for part 2
  $sum_values_part_2 += ($red_value_max * $green_value_max * $blue_value_max);

}

print "------- RESULT PART 1 -------\n";
print "$sum_values_part_1\n";

print "------- RESULT PART 2 -------\n";
print "$sum_values_part_2\n";