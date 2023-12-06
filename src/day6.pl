use warnings; use strict;
use POSIX;

my ($result_part_1, $result_part_2) = (1, 0); # Results

my @time = (); my @distance = ();

while(<>){

  # Store time and distance from the input file
  @time     = $_ =~ (/(\d+)/g) if($_ =~ /Time/);
  @distance = $_ =~ (/(\d+)/g) if($_ =~ /Distance/);

  if(eof()){

    # Push at the end of each array the join of all the elements for part 2
    push(@time, join('', @time)); push(@distance, join('', @distance));

    # For each pair $time[i], $distance[$i], compute the number of possibilities
    for(my $i = 0; $i < scalar @time; $i += 1){

      my $min = ceil(($time[$i] - sqrt($time[$i] * $time[$i] - 4 * $distance[$i]))/2 + 0.0001);
      my $max = floor(($time[$i] + sqrt($time[$i] * $time[$i] - 4 * $distance[$i]))/2 - 0.0001);

      # Multiplied to previous value for part 1
      $result_part_1 *= ($max - $min + 1) if($i != (scalar @time) - 1);

      # The result of the last iteration corresponds to the result for part 2
      $result_part_2  = ($max - $min + 1) if($i == (scalar @time) - 1);
    }
  }
}

print "Part 1: $result_part_1\nPart 2: $result_part_2\n"