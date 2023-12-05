use warnings; use strict;
use List::Util qw( min );

my ($result_part_1, $result_part_2) = (0, ~0);  # Results
my @section_intervals = (); # Store the intervals in the current section as [dst, src, size]
my @numbers = (); my @converted_numbers = ();   # Store values for part 1
my @ranges = ();  my @converted_ranges = ();    # Store ranges for part 2

while(<>){  

  # Initialize the numbers and the ranges for part 1 and 2
  if($_ =~ /seeds/){

    # Add all the numbers
    @numbers = ($_ =~ /(\d+)/g); 

    # Generate all the ranges as [begin, end) in @ranges
    push(@ranges, ($numbers[$_*2], $numbers[$_*2+1] + $numbers[$_*2])) for(0..$#numbers/2);
    next;
  }

  # If the current line contains numbers, than section intervals must be updated; 
  push(@section_intervals, ($_ =~ /(\d+)/g)) if($_ =~ /(\d)/);

  # If the current line is \n or eof(), then we convert the numbers and the ranges
  if($_ eq "\n" || eof()){

    # --- PART 1 ---

    # For each number available
    for my $num (@numbers){

      # Try to convert it considering all the available intervals in that section
      my $converted_value = $num; 

      for(my $i = 0; $i < ($#section_intervals); $i+=3){
        
        my ($dst_start, $src_start, $size) = @section_intervals[$i .. $i+2];

        # If conversion is possible, update $converted_value
        if($num >= $src_start && $num < $src_start + $size)
          { $converted_value = $num - $src_start + $dst_start; last; }
      }

      # Push new values into @converted
      push(@converted_numbers, $converted_value);
    }

    # Update numbers and reset converted
    @numbers = @converted_numbers; @converted_numbers = ();

    # --- PART 2 ---

    # For each range still available
    while($#ranges > 0){

      # Extract starting and ending point of current range
      my ($range_end, $range_start) = (pop(@ranges), pop(@ranges));

      # Stores if a conversion has been done (if not, the whole range remains the same in next step)
      my $conversion_happened = 0;

      # For each interval in the section
      for(my $i = 0; $i < (scalar @section_intervals); $i+=3){

        # Extract interval and compute the end of the interval
        my ($dst_start, $src_start, $size) = @section_intervals[$i .. $i+2];
        my $src_end = $src_start + $size;

        # Compute the position of the beginning of the overlap
        my $overlap_start = ($range_start > $src_start) ? $range_start : $src_start;

        # Compute the position of the end of the overlap
        my $overlap_end = ($range_end < $src_end) ? $range_end : $src_end;

        # If there is an overlap
        if($overlap_start < $overlap_end){

          # The region [overlap_start, overlap_end] must be converted
          push(@converted_ranges, ($overlap_start - $src_start + $dst_start, $overlap_end - $src_start + $dst_start));

          # If one initial region is out of the interval, than add it back to ranges
          push(@ranges, ($range_start, $overlap_start)) if($overlap_start > $range_start);

          # If one final region is out of the interval, than add it back to ranges
          push(@ranges, ($overlap_end, $range_end)) if($range_end > $overlap_end);

          # Conversion has been done
          $conversion_happened = 1; last;
        }
      }

      # If no conversion has been done, then the whole range enters as it is
      push(@converted_ranges, ($range_start, $range_end)) if(not $conversion_happened);
    }

    # Update ranges and reset converted ranges
    @ranges = @converted_ranges; @converted_ranges = ();

    # Reset ranges for the section
    @section_intervals = ();
  }
}

# Compute minimum of numbers as result for part 1
$result_part_1 = min @numbers;

# Compute minimum of fist elements of each range as result for part 2
($ranges[$_*2] < $result_part_2) and $result_part_2 = $ranges[$_*2] for (0..$#ranges/2);


print "Part 1: $result_part_1\nPart 2: $result_part_2\n"