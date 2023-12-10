# So far my worst day :,)

use warnings; use strict;
use Data::Dumper;

# Results
my ($result_part_1, $result_part_2) = (0.5, 0); # Results
# Define variables for directions
my ($N, $S, $W, $E) = (0, 1, 2, 3);

# Maze matrix
my @maze;

# useful variables for computation
my ($current_line, $currentX, $currentY, $orientation) = (0, 0, 0, $S);
my ($initX, $initY);
# Store the visited indeces of the elements in each row
my @visited = () x scalar @maze;

# Parse input
while (<>) {
  chomp;
  ($currentY, $currentX) = ($current_line+1, length($1)) if (m/^(.*)S/);
  ($initY, $initX) = ($current_line, length($1)) if(m/^(.*)S/);
  push @maze, [ split // ]; $current_line++;
}

# Until the maze is solved, traverse it until S is found
while($maze[$currentY][$currentX] ne 'S'){

  # Incremente the result and set the cell as visited
  $result_part_1 += 0.5; push(@{$visited[$currentY]}, $currentX);

  # Possibilities while traversing the maze
  if(   $maze[$currentY][$currentX] eq '|' and $orientation == $S) { $currentY++, $orientation = $S; }
  elsif($maze[$currentY][$currentX] eq '|' and $orientation == $N) { $currentY--, $orientation = $N; }
  elsif($maze[$currentY][$currentX] eq '-' and $orientation == $W) { $currentX--, $orientation = $W; }
  elsif($maze[$currentY][$currentX] eq '-' and $orientation == $E) { $currentX++, $orientation = $E; }
  elsif($maze[$currentY][$currentX] eq '7' and $orientation == $E) { $currentY++, $orientation = $S; }
  elsif($maze[$currentY][$currentX] eq '7' and $orientation == $N) { $currentX--, $orientation = $W; }
  elsif($maze[$currentY][$currentX] eq 'F' and $orientation == $W) { $currentY++, $orientation = $S; }
  elsif($maze[$currentY][$currentX] eq 'F' and $orientation == $N) { $currentX++, $orientation = $E; }
  elsif($maze[$currentY][$currentX] eq 'L' and $orientation == $S) { $currentX++, $orientation = $E; }
  elsif($maze[$currentY][$currentX] eq 'L' and $orientation == $W) { $currentY--, $orientation = $N; }
  elsif($maze[$currentY][$currentX] eq 'J' and $orientation == $S) { $currentX--, $orientation = $W; }
  elsif($maze[$currentY][$currentX] eq 'J' and $orientation == $E) { $currentY--, $orientation = $N; }
}

# Substitute the starting point with the correct pipe (hardcoded sigh)
$maze[$initY][$initX] = '|';
push(@{$visited[$initY]}, $initX);

# For each row
for(my $i = 0; $i < scalar @maze; $i++){
  # For each element
  for(my $j = 0, my $counter = 0; $j < scalar @{$maze[0]}; $j++){
    # If it's a point
    next if($maze[$i][$j] ne '.');

    # Check the number of traversals with the maze
    for(my $k = 0; $k < $j; $k++){
      next if(!($k ~~ @{$visited[$i]}));
      $counter++ if($maze[$i][$k] eq 'J' or $maze[$i][$k] eq '|' or $maze[$i][$k] eq 'L');
    }

    # Possibly update result if the number of traversals is odd
    $result_part_2++ if($counter % 2 == 1);
  }
}

print "Part 1: $result_part_1\nPart 2: $result_part_2\n"