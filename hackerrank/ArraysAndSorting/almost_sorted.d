#!/usr/bin/rdmd

import std.conv : to;
import std.stdio, std.cstream, std.algorithm;
import std.array;
import std.random : uniform;


bool isAscending(in int[] that) pure
{
  if (countSlopeChanges(that) == 0) return true;
  else return false;
}

int[] takeSampleOf(in int[] that)
{
  long sampleSize = that.length / 8;
  int[] sample = new int[sampleSize];

  foreach (i; 0..sampleSize) {
    sample[i] = that[uniform(0, that.length)];
  }

  return sample;
}


enum Slope: int {up, down, flat, border, skip};

Slope slopeOf(const int first, const int second) pure
{
  if (first < second) return Slope.up;
  else if (first == second) return Slope.flat;
  else return Slope.down;
}


int[] countSlopePattern(in int[] that, in Slope[][] pattern)
{
  Slope currentSlope = Slope.flat;
  Slope previousSlope = Slope.flat;
  Slope[] match = new Slope[pattern[0].length];
  int[] patternCount = new int[pattern.length];

  void isNewMatchWith(const Slope s)
  {
    match.popFront;
    match ~= currentSlope;
    foreach (j; 0..pattern.length)
      if (match == pattern[j]) ++patternCount[j];
  }

  Slope decideOnSlopeUseFlatContinues(const Slope s)
  {
    if (s == Slope.flat) return previousSlope;
    else return s;
  }

  Slope decideOnSlopeUseFlatSkips(const Slope s)
  {
    if (s == Slope.flat) return Slope.skip;
    else return s;
  }

  fill(match, Slope.border);
  foreach (i; 1..that.length) {
    currentSlope = decideOnSlopeUseFlatSkips(slopeOf(that[i-1], that[i]));
    if (currentSlope != Slope.skip)
      isNewMatchWith(currentSlope);
  }

  return patternCount;
}


int countSlopeChanges(in int[] that) pure
{
  Slope currentSlope = Slope.border;
  Slope nextSlope = Slope.flat;
  int changeOfSlope = 0;
  int streak = 0;

  foreach (i; 1..that.length) {
    nextSlope = slopeOf(that[i-1], that[i]);
    if (nextSlope == Slope.flat || nextSlope == currentSlope) {
      ++streak;
    }
    else if (nextSlope != currentSlope) {
      ++changeOfSlope;
      currentSlope = nextSlope;
      streak = 0;
    }
  }

  return changeOfSlope;
}


enum SortOrder: int {ascending, descending};

bool oneSwapToSorted(in int[] that, SortOrder order)
{

  return false;
}

int isAlmostSorted(in int[] that)
{
  return 0;
}


unittest
{
  int[] that = [3, 5, 2, 8];
  assert(isAlmostSorted(that) == 2);
}

unittest
{
  int[] that = [8, 4, 10, 2, 1, 6, 7, 12];
  assert(isAlmostSorted(that) == 12);
}


const swapAsc = [[Slope.up, Slope.down, Slope.up]];
const swapDesc = [[Slope.down, Slope.up, Slope.down]];

int main() {
  //int numberOfEntries = to!int(din.readLine());

  //int[] population = splitter(din.readLine().strip(' ')).map!(to!int).array;
  //int[] population = splitter("3 5 2 8".strip(' ')).map!(to!int).array;
  int[] population = splitter("8 4 10 2 2 6 7 12".strip(' ')).map!(to!int).array;

  int[] solution = countSlopePattern(population, swapAsc);

  writeln(solution);

  return 0;
}

