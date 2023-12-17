use warnings; use strict;
use Data::Dumper;

my ($result_part_1, $result_part_2) = (0, 0); # Results

# Source : https://perlmaven.com/transpose-a-matrix
sub transpose {
  my (@M) = @_; my @result;
  for my $row (0..@M-1) { for my $col (0..@{$M[$row]}-1) { $result[$col][$row] = $M[$row][$col]; } }
  return @result;
}

sub elaborate {

  # Get arguments
  my (@matrix) = @_; my $result = 0;

  # Extract matrix information
  my ($num_rows, $num_cols) = (scalar @matrix, scalar @{$matrix[0]});

  # Variables to store data
  my ($ans_part_1, $ans_part_2) = (0, 0);

  # For each row
  for(my $r = 1; $r < scalar @matrix; $r++){

    # Compute $tr, the number of rows in the possible reflections
    my $N_down = $num_rows - $r;  my $tr = ($N_down < $r) ? $N_down : $r; 

    # Compute begin and ending point of the two intervals to compare
    my $start_1   = $r - $tr; my $end_1  = $start_1 + $tr - 1;
    my $start_2   = $end_1 + 1; my $end_2  = $start_2 + $tr - 1;

    # Extrac the two intervals
    my @top  = @matrix[$start_1..$end_1];
    my @down = @matrix[$start_2..$end_2];
    
    # Compute number of erros in the intervals; if it's 0, then it's good
    # for part1, if it's 1 then it's good for part 2
    my $number_errors = 0;
    row_loop: for(my $i = 0; $i < $tr; $i++){
      for(my $j = 0; $j < $num_cols; $j++){
          $number_errors++ if($top[$i][$j] ne $down[$tr - $i - 1][$j]);
      }
    }

    # Increase results
    $ans_part_1 += $r if($number_errors == 0);
    $ans_part_2 += $r if($number_errors == 1);
  }
  
  return $ans_part_1, $ans_part_2;
}

my @current_matrix = ();
while(<>){
  # Elaborate matrix
  if($_ eq "\n" or eof()){

    # To work on columns, we work on the rows of the transpose matrix
    my @current_matrix_transpose = transpose(@current_matrix);

    # Compute values for the two matrices
    my ($rows_part1, $rows_part2) = elaborate(@current_matrix);
    my ($cols_part1, $cols_part2) = elaborate(@current_matrix_transpose);

    # Update results
    $result_part_1 += ($rows_part1 * 100 + $cols_part1);
    $result_part_2 += ($rows_part2 * 100 + $cols_part2);

    # Reset matrix
    @current_matrix = ();
  }
  # Update the current matrix with the new row
  else{
    chomp; my @new_line = split //; push @current_matrix, \@new_line;
  }
}

print "Part 1: $result_part_1\nPart 2: $result_part_2\n"