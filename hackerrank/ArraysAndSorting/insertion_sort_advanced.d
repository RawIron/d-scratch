#!/usr/bin/rdmd

import std.conv : to;
import std.stdio, std.cstream, std.algorithm;
import std.array;


void print(int[] that)
{
  foreach (entry; that) {
    write(to!string(entry) ~ " ");
  }
  writeln;
}


int calcShifts(int[] that) {
  int shifts = 0;

  foreach (i; 1..that.length) {
    if (that[i] - that[i-1] < 0) {
      shifts += i;
    }
  }

  return shifts;
}


int main() {
  int numberOfTests = 1;
  int numberOfEntries = 0;
  int shifts = 0;

  foreach (test; 0..numberOfTests) {
    //numberOfEntries = to!int(din.readLine());
    int[] population = new int[numberOfEntries];
    //population = splitter(din.readLine().strip(' ')).map!(to!int).array;
    numberOfEntries = 4;
    population = splitter("3 5 2 8".strip(' ')).map!(to!int).array;

    shifts = calcShifts(population);

    writeln(shifts);
  }

  return 0;
}

