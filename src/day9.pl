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
    push(@new_line, $current[$_+1] - $current[$_]) for(0..$#current - 1);

    # End if new line is all zeros
    last if (all { $_ == 0 } @new_line); @current = @new_line;
  }

  # Reset row for part 2
  @current = @line; my $iteration = 0;

  while(1){
    # Compute result by adding in case of even iteration, substructing otherwise
    $result_part_2 += ($iteration++ % 2 == 0) ? $current[0] : -$current[0]; 

    # Compute new line
    my @new_line = ();
    for(my $i = $#current; $i >= 1; $i--) { unshift(@new_line, $current[$i] - $current[$i-1]); }

    # End if new line is all zeros
    last if (all { $_ == 0 } @new_line); @current = @new_line;
  }
}

print "Part 1: $result_part_1\nPart 2: $result_part_2\n"