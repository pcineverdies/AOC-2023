use warnings; use strict;

# Check if the provided position in the matrix is a valid symbol
sub is_symbol {
  # Get argumetns
  my ($y, $x, $current_number, $gears, @matrix) = @_;
  # Get size of matrix
  my ($n_rows, $n_cols) = (scalar @matrix, scalar @{$matrix[0]});

  # Return false if out of matrix boundaries
  if ($x < 0 || $x >= $n_rows || $y < 0 || $y >= $n_cols) {return 0;}

  # Return false if the character is either a number of a dot
  if ($matrix[$y][$x] =~ /[\d|.|]/i) { return 0; }

  # In case we have a gear
  if($matrix[$y][$x] eq "*"){

    # Update the hash of the gears adding the current number of the list;
    # Gears are identified in the hash using their flattened index in the matrix.
    my $gear_index = $y * $n_cols + $x;

    # Possibly create the array of numbers for the gear, than push teh value
    if(not defined $gears->{$gear_index}){ $gears->{$gear_index} = []; }
    push(@{ $gears->{$gear_index} }, $current_number);
  }

  return 1
}

my ($sum_values_part_1, $sum_values_part_2) = (0, 0);
my @matrix = ();        # Matrix to store the inputs
my %gears = ();         # Hash to store the numbers close to each gear.
                        # Each * is represented in the hash using its positions row * N_COLS + col;
                        # It contains an array of close numbers; if at the end this array has size 2, 
                        # then it is a gear
my $current_line = 0;   # Current line in matrix exploration

# Save each line as an array of the matrix, removing newlines (chomp)
while(<>){ chomp; push(@matrix, [split('')]); }

# For each line of the matrix
foreach my $line (@matrix) {
  # Get a string out of each row
  my $string_line = join('',  @$line);

  # Find all the numbers in the row
  while ($string_line =~ /(\d+)/g) {
    # Extract number and positions
    my ($current_number, $init_pos, $last_pos, $found_match) = ($1, $-[0], $+[0], 0);

    # For each character in the number, check the values of neighbor cells
    for(my $i =$init_pos; $i < $last_pos; $i += 1){
      if(is_symbol($current_line + 1, $i,     $current_number, \%gears, @matrix)){$found_match = 1; last; } # Down
      if(is_symbol($current_line + 1, $i + 1, $current_number, \%gears, @matrix)){$found_match = 1; last; } # Down Right
      if(is_symbol($current_line + 1, $i - 1, $current_number, \%gears, @matrix)){$found_match = 1; last; } # Down Left
      if(is_symbol($current_line    , $i + 1, $current_number, \%gears, @matrix)){$found_match = 1; last; } # Right
      if(is_symbol($current_line    , $i - 1, $current_number, \%gears, @matrix)){$found_match = 1; last; } # Left
      if(is_symbol($current_line - 1, $i    , $current_number, \%gears, @matrix)){$found_match = 1; last; } # Up
      if(is_symbol($current_line - 1, $i + 1, $current_number, \%gears, @matrix)){$found_match = 1; last; } # Up Right
      if(is_symbol($current_line - 1, $i - 1, $current_number, \%gears, @matrix)){$found_match = 1; last; } # Up Left
    }
    # If a symbol is found close to the number, then update result of part 1
    $sum_values_part_1 += ($found_match) ? $current_number : 0;
  }
  $current_line += 1;
}

# For each * found, check if its a gear and update the result for part 2
while(my($key_to_search, $value) = each %gears){
  $sum_values_part_2 += (scalar @{$value} == 2) ? (@{$value}[0] * @{$value}[1]) : 0;
}

print "------- RESULT PART 1 -------\n$sum_values_part_1\n";
print "------- RESULT PART 2 -------\n$sum_values_part_2\n";
