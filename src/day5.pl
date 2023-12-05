use warnings; use strict;
use Data::Dumper;
use List::Util qw( min );

my ($result_part_1, $result_part_2) = (0, ~0); # Results

# Store the intervals in the current section in the format [dst, src, size]
my @current_section_intervals = ();

# Store values for part 1
my @numbers = ();
my @converted = ();

# Store ranges for part 2
my @ranges = ();
my @converted_ranges = ();

while(<>){  

  # Initialize the numbers and the ranges for part 1 and 2
  if($_ =~ /seeds/){
    # Add all the numbers
    @numbers = ($_ =~ /(\d+)/g);

    # Generate all the ranges ans [begin, end)
    for(my $i = 0; $i < (scalar @numbers); $i+=2)
    { my @newrange = ($numbers[$i], $numbers[$i] + $numbers[$i+1]); push(@ranges, \@newrange); }

    next;
  }

  # If the current line contains numbers, than section intervals must be updated;
  if($_ =~ /(\d)/){
    my @newinterval = $_ =~ /(\d+)/g; push(@current_section_intervals, \@newinterval);
  }

  # If the current line is \n or eof(), then we convert the numbers and the ranges
  if($_ eq "\n" || eof()){

    # --- PART 1 ---

    # For each number available
    for my $num (@numbers){

      # Try to convert it considering all the available ranges in that section
      my $converted_value = $num; 

      foreach my $current_interval (@current_section_intervals){
        my ($dst_start, $src_start, $size) = @$current_interval;
        # If conversion is possible, update $converted_value
        if($num >= $src_start && $num < $src_start + $size)
          { $converted_value = $num - $src_start + $dst_start; last; }
      }

      # Push new values into @converted
      push(@converted, $converted_value);
    }

    # Update numbers and reset converted
    @numbers = @converted; @converted = ();

    # --- PART 2 ---

    # For each range still available
    while(scalar @ranges > 0){
      # Extract one range from the array
      my $range = pop(@ranges);
      # Stores if a conversion has been done (if not, the whole range remains the same)
      my $conversion_happened = 0;
      # Get begin and end of current range;
      my ($range_start, $range_end) = @$range;

      # For each interval in the section
      for my $current_interval (@current_section_intervals){
        # Extract content and compute the end of the interval
        my ($dst_start, $src_start, $size) = @$current_interval;
        my $src_end = $src_start + $size;

        # Compute the position of the beginning of the overlap
        my $overlap_start = ($range_start > $src_start) ? $range_start : $src_start;
        # Compute the position of the end of the overlap
        my $overlap_end = ($range_end < $src_end) ? $range_end : $src_end;

        # If there is an overlap
        if($overlap_start < $overlap_end){
          # The region [overlap_start, overlap_end] must be converted
          my @newrange = ($overlap_start - $src_start + $dst_start, $overlap_end - $src_start + $dst_start);
          push(@converted_ranges, \@newrange);

          # If one initial region is out of the interval, than add it back to ranges
          if($overlap_start > $range_start)
            { my @newrange = ($range_start, $overlap_start); push(@ranges, \@newrange); }

          # If one final region is out of the interval, than add it back to ranges
          if($range_end > $overlap_end)
            { my @newrange = ($overlap_end, $range_end); push(@ranges, \@newrange); }

          # Conversion has been done
          $conversion_happened = 1;
          last;
        }

      }

      # If no conversion has been done, then the whole range enters as it is
      if(not $conversion_happened)
        { my @newrange = ($range_start, $range_end); push(@converted_ranges, \@newrange); }

    }

    # Update ranges and reset converted ranges
    @ranges = @converted_ranges;
    @converted_ranges = ();

    # Reset ranges for the section
    @current_section_intervals = ();
  }
}

# Compute minimum of numbers as result for part 1
$result_part_1 = min @numbers;

# Compute minimum of fist elements of each range as result for part 2
foreach my $range (@ranges)
  { $result_part_2 = $$range[0] if ($$range[0] < $result_part_2); }

print "Part 1: $result_part_1\nPart 2: $result_part_2\n"