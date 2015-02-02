#!/usr/bin/rdmd

import std.conv : to;
import std.stdio, std.cstream, std.algorithm;
import std.array, std.container;


void print(int[] sorted)
{
  foreach (entry; sorted) {
    writeln(entry);
  }
}


int[] quicksort(int[] that)
{
  Array!int left;
  Array!int right;

  int p = that[0];
  that = that[1..$];

  foreach (entry; that) {
    if (entry <= p)
      left.insertBack(entry);
    else
      right.insertBack(entry);
  }
  left.insertBack(p);

  return join(left, right);
}


int main()
{
  int numberOfEntries = 0;
  int[] population = new int[numberOfEntries];

  //numberOfEntries = to!int(din.readLine());
  //population = splitter(din.readLine().strip(' ')).map!(to!int).array;
  numberOfEntries = 4;
  population = splitter("3 5 2 8".strip(' ')).map!(to!int).array;

  auto sorted = quicksort(population);

  print(sorted);

  return 0;
}

