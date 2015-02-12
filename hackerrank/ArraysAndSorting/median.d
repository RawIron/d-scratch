#!/usr/bin/rdmd

import std.conv : to;
import std.stdio, std.algorithm;
import std.array;

alias index = ulong;


int median(in int[] that)
{
  if (that.length == 1) return that[0];
  
  int part(in int[] partition, in index indexOfMedian)
  {
    int p = partition[0];
    int[] left;
    int[] right;

    foreach (entry; partition[1..$]) {
      if (entry <= p)
        left ~= entry;
      else
        right ~= entry;
    }

    if (left.length == indexOfMedian) return p;

    else if (left.length < indexOfMedian)
      return part(right, indexOfMedian - left.length);

    else
      return part(left, indexOfMedian);
  }

  return part(that, that.length / 2);
}


int main()
{
  int numberOfEntries = 0;
  //numberOfEntries = to!int(din.readLine());
  int[] population = new int[numberOfEntries];

  //population = splitter(din.readLine().strip(' ')).map!(to!int).array;
  population = splitter("5 8 1 3 7 9 2".strip(' ')).map!(to!int).array;

  int solution = median(population);

  writeln(solution);

  return 0;
}

