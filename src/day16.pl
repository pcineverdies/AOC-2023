use warnings; use strict;
use Data::Dumper;

my ($result_part_1, $result_part_2) = (0, 0); # Results

# 0 -> left
# 1 -> up
# 2 -> right
# 3 -> down

sub count_energized {

  # Arguments: starting row, col, dir and matrix
  my ($row, $col, $dir, @matrix) = @_;

  # Next beams to analyze
  my @queue = ();
  # Visited with directions
  my @visited = ();
  # Visisted without directions
  my @tiles_visited = ();

  # Add first element to queue
  push @queue, ($row, $col, $dir);

  # Until the queue is not empty
  queue_loop: while(scalar @queue != 0){
    # Get the next beam
    my ($row, $col, $dir) = (shift @queue, shift @queue, shift @queue);

    # Update the beam according to new direction
    $col = ($dir == 0) ? $col - 1 : ($dir == 2) ? $col + 1 : $col;
    $row = ($dir == 1) ? $row - 1 : ($dir == 3) ? $row + 1 : $row;

    # Next if out of the grid
    next if($row < 0 || $row == scalar @matrix || $col < 0 || $col == scalar @{$matrix[0]});

    # Check if same tile with same direction has been covered (skip)
    for(my $i = 0; $i < scalar @visited; $i++){
      next queue_loop if($visited[$i][0] == $row && $visited[$i][1] == $col && $visited[$i][2] == $dir);
    }

    # Add current elem to visited
    my @new_visited = ($row, $col, $dir); push @visited, \@new_visited;

    # Compute beam position and possibly add it to @tiles_visited
    my $value = $row * (scalar @matrix) + $col; push @tiles_visited, $value if (!($value ~~ @tiles_visited));
    
    # Add same element to queue if current element is point
    if($matrix[$row][$col] eq '.'){ push @queue, ($row, $col, $dir); next; }
    
    # Add same element to queue if current element is - and going horizontally
    if($matrix[$row][$col] eq '-' && $dir % 2 == 0){ push @queue, ($row, $col, $dir); next; }
  
    # Add same element to queue if current element is | and going vertically
    if($matrix[$row][$col] eq '|' && $dir % 2 == 1){ push @queue, ($row, $col, $dir); next;  }

    if($matrix[$row][$col] eq '/'){
      # Modify direction and add to queue
      if   ($dir % 2 == 1) { $dir = ($dir + 1) % 4; }
      else                 { $dir = ($dir + 3) % 4; }
      push(@queue, ($row, $col, $dir)); next;
    }

    if($matrix[$row][$col] eq '\\'){
      # Modify direction and add to queue
      if($dir % 2 == 0) { $dir += 1; }
      else              { $dir -= 1; }
      push @queue, ($row, $col, $dir); next;
    }

    # In the last two cases, split the beams
    if($matrix[$row][$col] eq '|'){ push @queue, ($row, $col, 1); push @queue, ($row, $col, 3); next; }
    if($matrix[$row][$col] eq '-'){ push @queue, ($row, $col, 0); push @queue, ($row, $col, 2); next; }

  }
  
  # Return the number of visited tiles
  return scalar @tiles_visited;

}

# Get matrix from input
my @matrix = ();
while(<>){ chomp; my @new_line = split //; push @matrix, \@new_line; }

# Compute result for part 1
$result_part_1 = count_energized(0, -1, 2, @matrix);

# Check the max among all the rows, both from left and right
for(my $i = 0; $i < scalar @matrix; $i++){
  my ($value_left, $value_right) = (count_energized($i, -1, 2, @matrix), count_energized($i, scalar @{$matrix[0]}, 0, @matrix));
  $result_part_2 = ($value_left > $result_part_2) ? $value_left : $result_part_2;
  $result_part_2 = ($value_right > $result_part_2) ? $value_right : $result_part_2;
}

# Check the max among all the cols, both from up and down
for(my $i = 0; $i < scalar @{$matrix[0]}; $i++){
  my ($value_left, $value_right)  = (count_energized(-1, $i, 3, @matrix), count_energized(scalar @matrix, $i, 1, @matrix));
  $result_part_2 = ($value_left > $result_part_2) ? $value_left : $result_part_2;
  $result_part_2 = ($value_right > $result_part_2) ? $value_right : $result_part_2;
}

print "Part 1: $result_part_1\nPart 2: $result_part_2\n"