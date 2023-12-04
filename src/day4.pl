use warnings; use strict;
use POSIX;

my ($sum_values_part_1, $sum_values_part_2) = (0, 0); # Results
my @scratchcards = (1) x 204;                         # Array to store the number of scratchcards
                                                      # !!! Size is taken from the input and it may vary

while(<>){
  my ($current_line) = ($_ =~ /(\d+)/)[0]-1;      # Current line number 
  my ($my_numbers) = ($_ =~ /\|(.*)$/) ;          # List of available numbers
  my ($winning_numbers) = ($_ =~ /: (.*)\|/);     # List of winning numbers
  my $matches = 0;                                # Number of matches in card

  # If an available number is among the winning numbers, updated matches
  for my $num (split(' ', $my_numbers)){ $matches += 1 if (($winning_numbers =~ /\b$num\b/)); }

  # For each of the $matches cards following the current, update the number of cards
  $scratchcards[$_] += $scratchcards[$current_line] for ($current_line + 1 .. $current_line + $matches);
  
  # update results variable
  $sum_values_part_1 += pow(2, $matches - 1) if ($matches);
  $sum_values_part_2 += $scratchcards[$current_line];
}

print "------- RESULT PART 1 -------\n$sum_values_part_1\n";
print "------- RESULT PART 2 -------\n$sum_values_part_2\n";