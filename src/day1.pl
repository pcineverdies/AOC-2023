use warnings;
use strict;

my $sum_values_part_1 = 0;
my $sum_values_part_2 = 0;

my %values_to_search = (
  "one" => 1,   1 => 1, "two" => 2,   2 => 2, "three" => 3, 3 => 3,
  "four" => 4,  4 => 4, "five" => 5,  5 => 5, "six" => 6,   6 => 6, 
  "seven" => 7, 7 => 7, "eight" => 8, 8 => 8, "nine" => 9,  9 => 9,
);

while(<>){

  # Part 1 solution

  # Extract first number in the string
  my ($number_in_string) = $_ =~ /^.*?(\d+)/;
  # Get most significant digit of the number
  my $number = (substr "$number_in_string", 0, 1) * 10; 
  # Extract last number in the string
  ($number_in_string) = $_ =~ /(\d+)\D*$/;
  # Gest least significant digit in the number
  $number = (substr "$number_in_string", -1, 1) + $number; 
  # Accumulate the number
  $sum_values_part_1 += $number;

  # Part 2 solution

  my $max_position = -1;
  my $min_position = 999;
  my $max_value = 0;
  my $min_value = 0;

  # Find the occurrances of each key of the map inside the string
  while(my($key_to_search, $value) = each %values_to_search){
    # left-most occurrence
    my $left_index = index $_, "$key_to_search";
    # right-most occurrence
    my $right_index = rindex $_, "$key_to_search";

    # Skip if not found
    if ($left_index == -1) {
      next;
    }

    # Possibly update the first position
    $min_value = ($left_index < $min_position) ? $value : $min_value;
    $min_position = ($left_index < $min_position) ? $left_index : $min_position;

    # Possibly update the last position
    $max_value = ($right_index > $max_position) ? $value : $max_value;
    $max_position = ($right_index > $max_position) ? $right_index : $max_position;

  }

  $sum_values_part_2 += ($min_value * 10 + $max_value);
}

print "------- RESULT PART 1 -------\n";
print "$sum_values_part_1\n";

print "------- RESULT PART 2 -------\n";
print "$sum_values_part_2\n";

