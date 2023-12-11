use strict;
use warnings;

my ($result_part_1, $result_part_2) = (0, 0); # Results

my @universe;     # matrix input
my @costX;        # Cost of each column
my @costY;        # Cost of each row
my @galaxies;     # All the galaxies

# Read input
my $current_line = 0;
while (<>) {
    chomp;
    my @line = split //;
    push @universe, \@line;
    # Set the cost of current row to 1 if there is a galaxy, zero otherwise
    push @costY, (m/#/ ? 1 : 2);
    # Add all the galaxies in the row
    for my $x (0..$#line) { push @galaxies, [$x, $current_line] if ($line[$x] eq '#'); }
    $current_line++;
}

# For each column in the matrix
for(my $i = 0; $i < scalar @{$universe[0]}; $i++){
  my $found_galaxy = 0;
  # Traverse the column and look for a galaxy
  for(my $j = 0; $j < scalar @universe; $j++){
    $found_galaxy = 1, last if ($universe[$j][$i] eq '#');
  }
  # Set the cost of current column either to 1 or 2
  push @costX, ($found_galaxy == 0 ? 2 : 1);
}

# For each pair ($i, $j) of galaxies
for(my $i = 0; $i < scalar @galaxies; $i++){
  for(my $j = $i+1; $j < scalar @galaxies; $j++){
    # Find coordinates and sort them so that $x1 <= $x2 and $y1 <= $y2
    my ($x1, $y1) = @{$galaxies[$i]}; my ($x2, $y2) = @{$galaxies[$j]};
    ($x1, $x2) = ($x2, $x1) if $x1 > $x2;
    ($y1, $y2) = ($y2, $y1) if $y1 > $y2;

    # For each traversed column from $i to $j, add the cost of the column
    for(my $k = $x1 + 1; $k <= $x2; $k++){
      $result_part_1 += $costX[$k];
      $result_part_2 += ($costX[$k] == 1) ? 1 : 1000000;
    }
    # For each traversed row from $i to $j, add the cost of the column
    for(my $k = $y1 + 1; $k <= $y2; $k++){
      $result_part_1 += $costY[$k];
      $result_part_2 += ($costY[$k] == 1) ? 1 : 1000000;
    }
  }
}

print "Part 1: $result_part_1\nPart 2: $result_part_2\n"