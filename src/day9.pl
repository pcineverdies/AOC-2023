use warnings; use strict;
use List::Util qw(all);

my ($result_part_1, $result_part_2) = (0, 0); # Results

while(<>){
  # Extract all the numbers in line (considering negatives!!!!)
  my @line = ($_ =~ /-?\d+/g); my @current = @line;

  while(1){
    # Accumulate current last value in the row
    $result_part_1 += $current[-1];

    # Compute new line
    my @new_line = ();
    push(@new_line, $current[$_+1] - $current[$_]) for(0..scalar @current - 2);

    # End if new line is all zeros
    last if (all { $_ == 0 } @new_line); @current = @new_line;
  }

  # Utilities for second part: list of first elements, line and temporary result
  my @first_row = (); @current = @line; my $extrap = 0;

  while(1){
    # Store current first value in the row
    push(@first_row, $current[0]);

    # Compute new line
    my @new_line = ();
    for(my $i = scalar @current - 1; $i >= 1; $i--) { unshift(@new_line, $current[$i] - $current[$i-1]); }

    # End if new line is all zeros
    last if (all { $_ == 0 } @new_line); @current = @new_line;
  }

  # Compute extrapolated value for the current line and accumulate it to result
  for(my $i = scalar @first_row - 1; $i >= 0; $i --) { $extrap = $first_row[$i] - $extrap; }
  $result_part_2 += $extrap; 
}

print "Part 1: $result_part_1\nPart 2: $result_part_2\n"