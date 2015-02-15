#!/usr/bin/rdmd

import std.conv : to;
import std.stdio, std.cstream, std.algorithm;
import std.array;


int isAlmostSorted(in int[] that) {
  enum Elevation: int {up, down, flat};
  Elevation currentElevation = Elevation.flat;
  Elevation nextElevation = Elevation.flat;
  int changeOfElevation = 0;
  int streak = 0;

  Elevation elevationOf(const int first, const int second) pure
  {
    if (first < second) return Elevation.up;
    else if (first == second) return Elevation.flat;
    else return Elevation.down;
  }

  foreach (i; 2..that.length) {
    nextElevation = elevationOf(that[i-1], that[i]);
    if (nextElevation == Elevation.flat || nextElevation == currentElevation) {
      ++streak;
    }
    else if (nextElevation != currentElevation) {
      ++changeOfElevation;
      streak = 0;
    }
  }

  return changeOfElevation;
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


int main() {
  //int numberOfEntries = to!int(din.readLine());

  //int[] population = splitter(din.readLine().strip(' ')).map!(to!int).array;
  //int[] population = splitter("3 5 2 8".strip(' ')).map!(to!int).array;
  int[] population = splitter("8 4 10 2 1 6 7 12".strip(' ')).map!(to!int).array;

  int solution = isAlmostSorted(population);

  writeln(solution);

  return 0;
}

