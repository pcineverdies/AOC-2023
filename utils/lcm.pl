# !!! The following code was not mine, but it was copied from
#     https://www.perlmonks.org/?node_id=56906

use strict;
use warnings;

sub gcf {
  my ($x, $y) = @_;
  ($x, $y) = ($y, $x % $y) while $y;
  return $x;
}

sub lcm {
  return($_[0] * $_[1] / gcf($_[0], $_[1]));
}

sub multigcf {
  my $x = shift;
  $x = gcf($x, shift) while @_;
  return $x;
}

sub multilcm {
  my $x = shift;
  $x = lcm($x, shift) while @_;
  return $x;
}

1;
