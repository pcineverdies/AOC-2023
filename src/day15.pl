use warnings; use strict;
use Data::Dumper;

my ($result_part_1, $result_part_2) = (0, 0); # Results

# Compute hash of a string
sub compute {
  my ($s) = @_; my $ans = 0;

  # Perofrm the required steps
  $ans += ord($_), $ans *= 17, $ans = ($ans % 256) foreach (split //, $s);

  return $ans;
}

# Read all the strings in the input
my @values = ();
while(<>){ @values = split /,/; }

# Compute the result for part 1
$result_part_1 += compute($_) foreach (@values);

# Create te boxes
my @boxes = map { [] } 1..256;

# For each of the strings
foreach my $current (@values){

  # Extract the label, the lens and compute box number
  my ($label) = ($current =~ /[a-z]+/g)[0]; my $lens = ($current =~ /[1-9]/g)[0]; my $box_number = compute($label);

  # Find index of element in the correspondant box
  my $index = -1;
  for(my $i = 0; $i < scalar @{$boxes[$box_number]}; $i++){
    $index = $i, last if($boxes[$box_number][$i][0] eq $label)
  }

  # If the command is to remove, then look for the correct element and possibly remove it
  if(index($current, '-') != -1){
    splice(@{$boxes[$box_number]}, $index, 1) if ($index != -1);
  }
  else{
    # Modify the element
    if($index != -1){ $boxes[$box_number][$index][1] = $lens; }
    # Add the element
    else { my @new_set = ($label, $lens); push @{$boxes[$box_number]}, \@new_set; }
  }
}

# Compute the result for part 2
for(my $i = 0; $i < 256; $i++){
  for(my $j = 0; $j < scalar @{$boxes[$i]}; $j++){
    $result_part_2 += ($i + 1) * ($j + 1) * $boxes[$i][$j][1];
  }
}

print "Part 1: $result_part_1\nPart 2: $result_part_2\n"