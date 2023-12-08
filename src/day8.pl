use warnings; use strict;
require "./utils/lcm.pl";

my ($result_part_1, $result_part_2) = (0, 0); # Results

# Set of instructions to move
my $instructions;

# Hash for the different directions
my %directions;

# Starting positions for part 2
my @starting_points = ();

while(<>){

  # Exclue newline
  next if($_ =~ /^\n/); chomp;

  # Seuquence of directions
  $instructions = $_, next if($_ !~ /=/);

  # Add the current line to the hash map
  my @line = ($_ =~ /\w+/g);
  my @dirs = ($line[1], $line[2]);
  $directions{$line[0]} = \@dirs;

  # Store curent element if it ends with 'A'
  push(@starting_points, $line[0]) if substr($line[0], 2, 1) eq 'A';
}

# Part 1: explore the hash until you find ZZZ
$_ = "AAA";
while($_ ne "ZZZ") {

  # Get next element to explore
  $_ = $directions{$_}[(substr($instructions, ($result_part_1 % length($instructions)), 1) eq "R")], $result_part_1 += 1;
}

# Part 2: for each element ending with 'A',. explore until you find an element ending with `Z`
foreach (@starting_points) {
  my $counter = 0;
  while(substr($_, 2, 1) ne 'Z'){

    # Get next element to explore
    $_ = $directions{$_}[(substr($instructions, ($counter % length($instructions)), 1) eq "R")], $counter += 1;
  }

  # Compute on the fly the new lcm. This solution works under the assumption that there is only
  # one element with ending letter 'Z' which can be reached starting from the current element
  $result_part_2 = ($result_part_2 == 0) ? $counter : lcm($result_part_2, $counter);
}


print "Part 1: $result_part_1\nPart 2: $result_part_2\n"