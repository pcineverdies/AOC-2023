use warnings; use strict;
use Class::Struct;

# Hash for part 1 order
my %order_letters_part_1 = (
  'A' => 12, 'K' => 11, 'Q' => 10, 'J' => 9, 'T' => 8,  '9' => 7,  '8' => 6,  '7' => 5, '6' => 4,  '5' => 3,  '4' => 2,  '3' => 1, '2' => 0,
);

# Hash for part 2 order
my %order_letters_part_2 = (
  'A' => 12, 'K' => 11, 'Q' => 10, 'T' => 8,  '9' => 7,  '8' => 6,  '7' => 5, '6' => 4,  '5' => 3,  '4' => 2,  '3' => 1, '2' => 0, 'J' => -1
);

# Get the points of one hand, possibly considering the amount of jokers inside
sub get_hand_points {

  # Count the numbers of J if J is considered as joker
  my $countJ = ($_[1]) ? () = $_[0] =~ /J/g : 0;

  # Hash to conut the occurrances of each character
  my %counter = ();

  # Count the characters in the string
  foreach my $char (split //, $_[0]) {
    next if($char eq 'J' and $_[1]);
    $counter{$char} = defined $counter{$char} ? $counter{$char} + 1 : 1;
  }

  # Order the characters by value and extract the ordered value (descending)
  my @vals = @counter{sort { $counter{$b} <=> $counter{$a} } keys(%counter)};

  return 6 if($countJ == 5 and $_[1]); # Five of a kind if all the cards are joker
  return 6 if($vals[0] + $countJ == 5); # Five of a kind 
  return 5 if($vals[0] + $countJ == 4); # Four of a kind
  return 4 if($vals[0] + $countJ == 3 and $vals[1] == 2); # Full house
  return 3 if($vals[0] + $countJ == 3 and $vals[1] != 2); # Three of a kind
  return 2 if($vals[0] + $countJ == 2 and $vals[1] == 2); # Two pairs
  return 1 if($vals[0] + $countJ == 2 and $vals[1] != 2); # One pair
  return 0;                                               # High card
}

# Get which card has more value considering the order of characters wrt to the argument hash
sub order_cards {

  for(my $i = 0; $i < length($_[0]); $i++){
    return -1 if($_[2]->{substr($_[0], $i, 1)} < $_[2]->{substr($_[1], $i, 1)});
    return  1 if($_[2]->{substr($_[0], $i, 1)} > $_[2]->{substr($_[1], $i, 1)});
  }

  return 0;
}

# Compare function
sub compare_cards {

  # Get points for each hand depending on the conditions specified (which hash, if joker or not)
  my ($points1, $points2) = (get_hand_points($_[0]->cards, $_[2]), get_hand_points($_[1]->cards, $_[2]));

  # Return the expected value for the sorting
  return ($points1 < $points2) ? -1 : ($points1 > $points2) ? 1 : order_cards($_[0]->cards, $_[1]->cards, $_[3]);
}

# Struct to store hands
struct( hand => { cards => '$', bid => '$', });

my ($result_part_1, $result_part_2) = (0, 0); # Results

my @hands = ();

# Get all the hands
while(<>){
  my @line = split ' ';
  my $current_hand = hand->new;
  $current_hand->cards($line[0]), $current_hand->bid($line[1]);
  push(@hands, $current_hand);
}

# Order hands according to the two criteria
my @hands_part_1 = sort { compare_cards($a, $b, 0, \%order_letters_part_1)} @hands;
my @hands_part_2 = sort { compare_cards($a, $b, 1, \%order_letters_part_2)} @hands;

# Compute results
$result_part_1 += (($_+1) * $hands_part_1[$_]->bid) for(0..$#hands_part_1);
$result_part_2 += (($_+1) * $hands_part_2[$_]->bid) for(0..$#hands_part_2);

print "Part 1: $result_part_1\nPart 2: $result_part_2\n"