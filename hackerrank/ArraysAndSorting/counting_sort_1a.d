#!/usr/bin/rdmd

import std.conv : to;
import std.stdio, std.cstream, std.algorithm;
import std.array;


void print(in int[] that)
{
  foreach (value; that) {
    write(to!string(value), " ");
  }
  writeln;
}


int[] count(in int[] that)
{
  int[100] counts = 0;

  foreach (entry; that) {
    counts[entry] += 1;
  }

  return counts.array;
}


int main()
{
  int numberOfEntries = 0;
  int[] population = new int[numberOfEntries];

  //numberOfEntries = to!int(din.readLine());
  //population = splitter(din.readLine().strip(' ')).map!(to!int).array;

  population = splitter("3 5 3 2 8".strip(' ')).map!(to!int).array;

  int[] counts = count(population);

  print(counts);

  return 0;
}

