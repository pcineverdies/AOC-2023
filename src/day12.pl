# !!! Thanks to HyperNeutrino for the help! Check his video out! :)

use warnings; use strict;
use Data::Dumper;

my ($result_part_1, $result_part_2) = (0, 0); # Results

# Count how many valid configurations exist given a current spring
# and the current functional spring positions
sub count_valid { 

  my ($current_spring, @positions) = @_;

  # Case in which there are no more working springs: 1 if the string is empty
  return ($#positions == -1) ? 1 : 0 if(length($current_spring) == 0);

  # Case in which the string is empty: one if no more pounds are present
  return (index($current_spring, '#') == -1) ? 1 : 0 if($#positions == -1);

  my $counter = 0;
 
  # First spring
  my $top_character = substr($current_spring, 0, 1);

  # Case in which ? is considered .
  $counter += count_valid(substr($current_spring, 1), @positions) 
    if ($top_character eq '.' or $top_character eq '?');
  
  # Case in which ? is considered #
  if ($top_character eq '?' or $top_character eq '#'){
    # There exist more spring than the current number of values
    if($positions[0] <= length($current_spring)){
      # The following character is not a .
      if(index(substr($current_spring, 0, $positions[0]), '.') == -1){
        my $top = shift @positions;
        if($top == length($current_spring) or '#' ne substr($current_spring, $top, 1)){
          $counter += count_valid(substr($current_spring, ($top == length($current_spring) ? $top : $top + 1)), @positions);
        }
      }
    }
  }

  return $counter;
}

my $counter = 0;

while(<>){
  chomp;
  print("$counter\n");
  my ($springs, $positions_s) = split / /;

  # Inputs for part 1
  my @positions = split(/,/, $positions_s);
  $springs =~ s/(\.)+/\./g;
  
  # Inputs for part 2
  my @positions_ext = (); push @positions_ext, @positions foreach (1..5);
  my $springs_ext = $springs . '?' . $springs . '?' . $springs .'?' . $springs .'?' . $springs; # What the hell am I dong with my life...

  # Final results
  $result_part_1 += count_valid($springs, @positions);
  $result_part_2 += count_valid($springs_ext, @positions_ext);

  $counter++;
}

print "Part 1: $result_part_1\nPart 2: $result_part_2\n";


