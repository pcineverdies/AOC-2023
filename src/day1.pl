use warnings;
use strict;
use Scalar::Util qw(looks_like_number);

# Answer variables
my ($sum_values_part_1, $sum_values_part_2) = (0, 0);

# Hash to search in part 2
my %values_to_search = (
  "one" => 1,   1 => 1, "two" => 2,   2 => 2, "three" => 3, 3 => 3,
  "four" => 4,  4 => 4, "five" => 5,  5 => 5, "six" => 6,   6 => 6, 
  "seven" => 7, 7 => 7, "eight" => 8, 8 => 8, "nine" => 9,  9 => 9,
);

while(<>){

  my $current_string = $_;

  # Get first and last digit of the string
  my $first_number = ($_ =~ /(\d)/g)[0];
  my $last_number  = ($_ =~ /(\d)/g)[-1];

  # Add correct value for part 1
  $sum_values_part_1 += ($first_number * 10 + $last_number);

  # Initialize variables to detect position of each element in the hash
  my ($max_pos, $max_val, $min_pos, $min_val) = (-1, 0, ~0, 0);

  # Find the occurrances of each key of the map inside the string
  while(my($key_to_search, $value) = each %values_to_search){

    my ($left_index, $right_index) = ((index $_, $key_to_search), (rindex $_, $key_to_search));

    # Skip if not found
    if ($left_index == -1) { next; }

    # Possibly update the first element in the string
    ($min_val, $min_pos) = ($left_index < $min_pos) ? ($value, $left_index) : ($min_val, $min_pos);

    # Possibly update the last element in the string
    ($max_val, $max_pos) = ($right_index > $max_pos) ? ($value, $right_index) : ($max_val, $max_pos);

  }

  # Add correct value for part 2
  $sum_values_part_2 += ($min_val * 10 + $max_val);
}

print "------- RESULT PART 1 -------\n$sum_values_part_1\n";
print "------- RESULT PART 2 -------\n$sum_values_part_2\n";
