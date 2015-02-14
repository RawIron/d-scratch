#!/usr/bin/rdmd

import std.conv : to;
import std.stdio, std.cstream, std.algorithm;
import std.array;


int pairs(in int[] that) pure
{
  int twoCombinations(in int r) {
    return r * (r-1);
  }

  int pairs = 0;
  int[int] counts;

  foreach (i; 0..that.length) {
    counts[that[i]] += 1;
  }

  foreach (key, value; counts) {
    if (value > 1) {
      pairs += twoCombinations(value);
    }
  }

  return pairs;
}


int main()
{
  int numberOfEntries = 1;
  //numberOfEntries = to!int(din.readLine());

  int[] population;
  //population = splitter(din.readLine().strip(' ')).map!(to!int).array;
  population = splitter("3 5 3 2 8 3".strip(' ')).map!(to!int).array;

  int solution = pairs(population);

  writeln(solution);

  return 0;
}

