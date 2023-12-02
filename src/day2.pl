use warnings;
use strict;

# Results
my ($sum_values_part_1, $sum_values_part_2) = (0, 0);

# Maximum number of cubes according to part 1
my ($max_red, $max_green, $max_blue) = (12, 13, 14);

# For each game
while(<>){

  # Extract into $game_number the id of the current game
  # Extract into $current_game all the info about the extraction
  my ($game_number, $current_game) = (split (/:/, $_, 2));
  $game_number = (split(" ", $game_number))[1];

  # Extract all the extractions, separated by a semicolon
  my @different_extractions = split(';', $current_game);

  # When set to 1, the game is impossible according to the requirements of part 1
  my $game_is_possible = 1;

  # Store for each game the maximum number of cubes of each color
  # which have been extracted simultaneously
  my ($max_possible_red, $max_possible_blue, $max_possible_green) = (0, 0, 0);

  # For each extraction in the game
  foreach (@different_extractions) {  

    # Obtain the information about each color
    my @extracted_cubes = split ',';
    
    # For each of the colors
    foreach (@extracted_cubes) {

      # Get both color and size
      my ($size, $color) = split ' ';

      # Consider the three possibilities and update both max_possible 
      # and find_impossible
      $max_possible_blue  = ($color eq "blue"  && $size > $max_possible_blue)  ? $size : $max_possible_blue;
      $game_is_possible   = ($color eq "blue"  && $size > $max_blue)           ? 0     : $game_is_possible;
      $max_possible_red   = ($color eq "red"   && $size > $max_possible_red)   ? $size : $max_possible_red;
      $game_is_possible   = ($color eq "red"   && $size > $max_red)            ? 0     : $game_is_possible;
      $max_possible_green = ($color eq "green" && $size > $max_possible_green) ? $size : $max_possible_green;
      $game_is_possible   = ($color eq "green" && $size > $max_green)          ? 0     : $game_is_possible;
    }
  }

  # If find_impossible is 0, then the game is correct according to part 1
  $sum_values_part_1 += $game_number * $game_is_possible;

  # Update the sum for part 2
  $sum_values_part_2 += ($max_possible_blue * $max_possible_green * $max_possible_red);
}

print "------- RESULT PART 1 -------\n";
print "$sum_values_part_1\n";

print "------- RESULT PART 2 -------\n";
print "$sum_values_part_2\n";