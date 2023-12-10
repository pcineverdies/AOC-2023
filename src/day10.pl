use warnings; use strict;
use Data::Dumper;

my ($result_part_1, $result_part_2) = (0.5, 0); # Results
my ($N, $S, $W, $E) = (0, 1, 2, 3);

my @maze;

my ($current_line, $currentX, $currentY, $orientation) = (0, 0, 0, $S);

while (<>) {
  chomp;
  ($currentY, $currentX) = ($current_line+1, length($1)) if (m/^(.*)S/);
  push @maze, [ split // ]; $current_line++;
}

while($maze[$currentY][$currentX] ne 'S'){

  push(@{$vertical_lines[$currentY]}, $currentX) if($maze[$currentY][$currentX] ne '-');

  if(   $maze[$currentY][$currentX] eq '|' and $orientation == $S) { $currentY++, $orientation = $S; }
  elsif($maze[$currentY][$currentX] eq '|' and $orientation == $N) { $currentY--, $orientation = $N; }
  elsif($maze[$currentY][$currentX] eq '-' and $orientation == $W) { $currentX--, $orientation = $W; }
  elsif($maze[$currentY][$currentX] eq '-' and $orientation == $E) { $currentX++, $orientation = $E; }
  elsif($maze[$currentY][$currentX] eq '7' and $orientation == $E) { $currentY++, $orientation = $S; }
  elsif($maze[$currentY][$currentX] eq '7' and $orientation == $N) { $currentX--, $orientation = $W; }
  elsif($maze[$currentY][$currentX] eq 'F' and $orientation == $W) { $currentY++, $orientation = $S; }
  elsif($maze[$currentY][$currentX] eq 'F' and $orientation == $N) { $currentX++, $orientation = $E; }
  elsif($maze[$currentY][$currentX] eq 'L' and $orientation == $S) { $currentX++, $orientation = $E; }
  elsif($maze[$currentY][$currentX] eq 'L' and $orientation == $W) { $currentY--, $orientation = $N; }
  elsif($maze[$currentY][$currentX] eq 'J' and $orientation == $S) { $currentX--, $orientation = $W; }
  elsif($maze[$currentY][$currentX] eq 'J' and $orientation == $E) { $currentY--, $orientation = $N; }

  $result_part_1 += 0.5;
}

print "Part 1: $result_part_1\nPart 2: $result_part_2\n"