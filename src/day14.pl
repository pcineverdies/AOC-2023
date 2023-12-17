use warnings; use strict;
use List::Util qw(first);

my ($result_part_1, $result_part_2) = (0, 0); # Results

# Subroutine to rotate a matrix clockwise
sub rotate_clockwise {
    my (@matrix) = @_; my @res;
    my $num_rows = scalar(@matrix); my $num_cols = scalar(@{$matrix[0]});
    for my $col (0 .. $num_cols - 1) { for my $row (0 .. $num_rows - 1) { $res[$col][$num_rows - $row - 1] = $matrix[$row][$col]; } }
    return @res;
}

# Get a string by concatenating all the rows of a matrix
sub get_hash {
  my (@matrix ) = @_; my $res = "";
  foreach my $row (@matrix){ foreach my $char (@{$row}){ $res = $res . $char }}
  return $res;
}

# Modify the matrix as if the platform is tilted north
sub step {
  my (@matrix) = @_;
  for(my $i = 0; $i < scalar @matrix; $i++){
    for( my $j = 0; $j < scalar @{$matrix[0]}; $j++){
      # Try to move the the current O element as north as possible
      for(my $k = $i; $k > 0; $k--){
        if($matrix[$k][$j] eq 'O' && $matrix[$k - 1][$j] eq '.'){ $matrix[$k - 1][$j] = 'O', $matrix[$k][$j] = '.'; }
        else{ last; }
      }
    }
  }
  return @matrix;
}

# Compute the laod on the north support
sub compute {
  my (@matrix) = @_; my $ans = 0;

  for(my $i = 0; $i < scalar @matrix; $i++){
    for(my $j = 0; $j < scalar @{$matrix[0]}; $j++){
      $ans += ((scalar @matrix) - $i) if ($matrix[$i][$j] eq 'O');
    }
  }
  
  return $ans;
}

# Current matrix, already seen matrices for part 2, loads associated to each matrix
my @matrix = (); my @seen = (); my @values = ();

# Read input
while(<>){ chomp; my @new_line = split //; push @matrix, \@new_line; }

# Compute part 1
step(@matrix); $result_part_1 = compute(@matrix);

cycle_moves: foreach(my $it = 0; $it <= 1000000000; $it++){

  # Perform the operation 4 times
  foreach my $i (0..3){
    # Tilt the matrix north
    @matrix = step(@matrix);
    # rotate it clock-wise
    @matrix = rotate_clockwise(@matrix);
  }

  # Compute curent load
  $result_part_2 = compute(@matrix);
  
  # Get hash of the current matrix
  my $str_matrix = get_hash(@matrix);
  
  # Find the matrix in the already seen ones
  for(my $i = 0; $i < scalar @seen; $i++){
    # If seen
    if($str_matrix ~~ $seen[$i]){
      # Period of the cycle
      my $period = $it - $i;
      # How many remaining iterations
      my $remaining = 1000000000 - $it;
      # Result and termiante
      $result_part_2 = $values[$i + $remaining % $period - 1]; last cycle_moves;
    }
  }

  # If not seen, then push the current values
  push @seen, $str_matrix; push @values, $result_part_2;
}


print "Part 1: $result_part_1\nPart 2: $result_part_2\n"