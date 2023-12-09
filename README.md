# Advent of Code 2023 in Perl

## Usage

To run a (valid) day `n` use

```bash
perl run.pl n
```

## Fish trick

As I use `fish` I set the following variable, alias and function

```
set -U AOC_FOLDER ~/Path/To/AOC/
alias --save advent_of_code "cd $AOC_FOLDER; perl run.pl"
alias --save advent_of_code_init "cd $AOC_FOLDER; touch"

function advent_of_code_init
  cd $AOC_FOLDER; touch inputs/day_$argv.in
  cp template.pl src/day_$argv.pl
  code $AOC_FOLDER
  code inputs/day_$argv.in
  code src/day_$argv.pl
end
```
