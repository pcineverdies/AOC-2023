use warnings; use strict;

# Check if the provided position in the matrix is a valid symbol
sub is_symbol {

  # Get argumetns
  my ($y, $x, $current_number, $gears, @matrix) = @_;

  # Return false if out of matrix boundaries
  return 0 if ($x < 0 || $x >= (scalar @matrix) || $y < 0 || $y >= length($matrix[0]));

  # Return false if the character is either a number or a point
  return 0 if (substr($matrix[$y], $x, 1) =~ /[\d|.|]/i);

  # In case the close symbol is a *
  # !!! This method is valid with the assumption that each number has only one close symbol
  if(substr($matrix[$y], $x, 1) eq "*"){

    # Update the hash of the * adding the current number of the list;
    # * are identified in the hash using their flattened index in the matrix.
    my $gear_index = $y * length($matrix[0]) + $x;

    # Possibly create the array of numbers for the *, than push the value
    $gears->{$gear_index} = [] if(not defined $gears->{$gear_index});
    push(@{ $gears->{$gear_index} }, $current_number);
  }

  return 1;
}

my ($sum_values_part_1, $sum_values_part_2) = (0, 0);
my @matrix = ();        # Matrix to store the inputs as array of strings
my %gears = ();         # Hash to store the numbers close to each * in the matrix.
                        # Each * is represented in the hash using its position row * N_COLS + col;
                        # It contains an array of close numbers; gears have 2 as size

# Save each line as element in the matrix, removing newlines (chomp)
while(<>){ chomp; push(@matrix,$_); }

# For each line of the matrix
for(my $line = 0; $line < (scalar @matrix); $line +=1){

  # Find all the numbers in the row
  while ($matrix[$line] =~ /(\d+)/g) {

    # For each character in the number, check the values of neighbor cells
    CharLoop: foreach my $i ($-[0] .. $+[0]-1){
      foreach my $pos ([1, 1], [1, 0], [1, -1], [0, 1], [0, -1], [-1, 0], [-1, 1], [-1, -1]){
        # If a symbol is found close to the number, then update result of part 1
        if(is_symbol($line + @{$pos}[0], $i + @{$pos}[1], $1, \%gears, @matrix))
          {$sum_values_part_1 += $1; last CharLoop; }
      }
    }
  }
}

# For each * found, check if its a gear and update the result for part 2
while(my($key_to_search, $value) = each %gears){
  $sum_values_part_2 += (@{$value}[0] * @{$value}[1]) if (scalar @{$value} == 2);
}

print "------- RESULT PART 1 -------\n$sum_values_part_1\n";
print "------- RESULT PART 2 -------\n$sum_values_part_2\n";